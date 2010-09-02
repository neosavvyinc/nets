package com.neosavvy.user.view.secured.expenses.report {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.dto.project.ExpenseItem;
    import com.neosavvy.user.dto.project.ExpenseItemDescriptor;
    import com.neosavvy.user.dto.project.ExpenseItemType;
    import com.neosavvy.user.dto.project.ExpenseItemValue;
    import com.neosavvy.user.dto.project.ExpenseReport;
    import com.neosavvy.user.dto.project.ExpenseReportStatus;
    import com.neosavvy.user.dto.project.PaymentMethod;
    import com.neosavvy.user.dto.project.Project;
    import com.neosavvy.user.dto.project.ProjectType;
    import com.neosavvy.user.model.ExpenseReportServiceProxy;
    import com.neosavvy.user.model.ProjectServiceProxy;
    import com.neosavvy.user.model.UserServiceProxy;
    import com.neosavvy.user.util.StringUtils;
    import com.neosavvy.user.view.secured.expenses.open.event.ExpenseReportEvent;
    import com.neosavvy.user.view.secured.expenses.report.popup.DeleteConfirmationPanel;

    import flash.display.DisplayObject;
    import flash.events.Event;
    import flash.events.MouseEvent;

    import mx.collections.ArrayCollection;
    import mx.collections.ListCollectionView;
    import mx.collections.Sort;
    import mx.containers.Form;
    import mx.controls.AdvancedDataGrid;
    import mx.controls.DataGrid;
    import mx.core.Application;
    import mx.core.IFlexDisplayObject;
    import mx.logging.ILogger;
    import mx.logging.Log;
    import mx.managers.PopUpManager;
    import mx.utils.ObjectUtil;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.mediator.Mediator;

    public class ExpenseReportDetailMediator extends Mediator {
        private static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.view.secured.expenses.report.ExpenseReportDetail");

        public static const NAME:String = "expenseReportDetailMediator";

        private var _projectProxy:ProjectServiceProxy;
        private var _expenseReportProxy:ExpenseReportServiceProxy;
        private var _activeExpenseItem:ExpenseItem;
        private var _expenseItems:ArrayCollection = new ArrayCollection();

        public function ExpenseReportDetailMediator(viewComponent:Object) {
            super(NAME, viewComponent);
        }

        override public function onRegister():void {
            _projectProxy = facade.retrieveProxy(ProjectServiceProxy.NAME) as ProjectServiceProxy;
            _expenseReportProxy = facade.retrieveProxy(ExpenseReportServiceProxy.NAME) as ExpenseReportServiceProxy;

            expenseReportDetail.saveButton.addEventListener(MouseEvent.CLICK, handleSaveButtonClicked);
            expenseReportDetail.refreshButton.addEventListener(MouseEvent.CLICK, handleRefreshButtonClicked);
            expenseReportDetail.deleteButton.addEventListener(MouseEvent.CLICK, handleDeleteExpenseReportButtonClicked);

            expenseReportDetail.newExpenseItemButton.addEventListener(MouseEvent.CLICK, handleNewExpenseItemButtonClicked);
            expenseReportDetail.editExpenseItemButton.addEventListener(MouseEvent.CLICK, handleEditExpenseItemButtonClicked);
            expenseReportDetail.deleteExpenseItemButton.addEventListener(MouseEvent.CLICK, handleDeleteExpenseItemButtonClicked);
            expenseReportDetail.saveExpenseItemButton.addEventListener(MouseEvent.CLICK, handleSaveExpenseItemButtonClicked);
            expenseReportDetail.cancelExpenseItemButton.addEventListener(MouseEvent.CLICK, handleCancelExpenseItemButtonClicked);

            expenseReportDetail.expenseTypeCmb.addEventListener(Event.CHANGE, handleExpenseItemTypeChange);
            expenseReportDetail.expenseReportGrid.addEventListener(Event.CHANGE, handleExpenseItemSelectionChanged);
        }

        override public function onRemove():void {
            _projectProxy = null;
            _expenseReportProxy = null;

            expenseReportDetail.saveButton.removeEventListener(MouseEvent.CLICK, handleSaveButtonClicked);
            expenseReportDetail.refreshButton.removeEventListener(MouseEvent.CLICK, handleRefreshButtonClicked);
            expenseReportDetail.deleteButton.removeEventListener(MouseEvent.CLICK, handleDeleteExpenseReportButtonClicked);
        }

        public function get expenseReportDetail():ExpenseReportDetail {
            return viewComponent as ExpenseReportDetail;
        }

        public function get expenseReportSummaryForm():Form {
            return expenseReportDetail.expenseReportSummaryForm;
        }

        public function get expenseItemGrid():DataGrid {
            return expenseReportDetail.expenseReportGrid;
        }

        public function get expenseItemEntryForm():Form {
            return expenseReportDetail.expenseItemEntryForm;
        }

        override public function listNotificationInterests():Array {
            return [
                ApplicationFacade.NAVIGATE_TO_CREATE_EXPENSE_REPORT
                ,ApplicationFacade.NAVIGATE_TO_EDIT_EXPENSE_REPORT
                ,ApplicationFacade.GET_PROJECTS_FOR_USER_SUCCESS
                ,ApplicationFacade.FIND_EXPENSE_REPORT_SUCCESS
                ,ApplicationFacade.FIND_PAYMENT_METHODS_SUCCESS
                ,ApplicationFacade.FIND_EXPENSE_ITEM_TYPES_SUCCESS
                ,ApplicationFacade.FIND_PROJECT_TYPES_SUCCESS

                ,ApplicationFacade.FIND_EXPENSE_REPORT_BY_ID_SUCCESS
                ,ApplicationFacade.DELETE_ACTIVE_EXPENSE_REPORT_SUCCESS
                ,ApplicationFacade.GET_EXPENSE_ITEMS_SUCCESS
            ];
        }

        override public function handleNotification(notification:INotification):void {
            switch(notification.getName()) {
                case ApplicationFacade.NAVIGATE_TO_CREATE_EXPENSE_REPORT:
                    resetForm();
                    sendNotification(ApplicationFacade.INITIALIZE_EXPENSE_REPORT_VIEW);
                    _expenseReportProxy.activeExpenseReport = null;
                    break;
                case ApplicationFacade.NAVIGATE_TO_EDIT_EXPENSE_REPORT:
                    resetForm();
                    break;
                case ApplicationFacade.GET_PROJECTS_FOR_USER_SUCCESS:
                    expenseReportDetail.availableProjectsCmb.dataProvider = _projectProxy.projects;
                    break;
                case ApplicationFacade.FIND_EXPENSE_REPORT_SUCCESS:
                    expenseReportDetail.locationTextInput.text = _expenseReportProxy.activeExpenseReport.location;
                    expenseReportDetail.purposeTextInput.text = _expenseReportProxy.activeExpenseReport.purpose;
                    expenseItemGrid.dataProvider = _expenseItems = _expenseReportProxy.activeExpenseReport.expenseItems as ArrayCollection;
                    break;
                case ApplicationFacade.FIND_PAYMENT_METHODS_SUCCESS:
                    expenseReportDetail.paymentMethodCmb.dataProvider = _expenseReportProxy.paymentMethods;
                    break;
                case ApplicationFacade.FIND_EXPENSE_ITEM_TYPES_SUCCESS:
                    expenseReportDetail.expenseTypeCmb.dataProvider = _expenseReportProxy.expenseTypes;
                    break;
                case ApplicationFacade.FIND_PROJECT_TYPES_SUCCESS:
                    expenseReportDetail.projectTypeCmb.dataProvider = _expenseReportProxy.projectTypes;
                    break;
                case ApplicationFacade.FIND_EXPENSE_REPORT_BY_ID_SUCCESS:
                    handleLoadActiveExpenseReport(_expenseReportProxy.activeExpenseReport);
                    break;
                case ApplicationFacade.DELETE_ACTIVE_EXPENSE_REPORT_SUCCESS:
                    resetForm();
                    break;
                case ApplicationFacade.GET_EXPENSE_ITEMS_SUCCESS:
                    setExpenseReportItems(_expenseReportProxy.activeExpenseReportItems);
                    break;
            }
        }

        private function resetForm():void {

            expenseReportDetail.availableProjectsCmb.selectedIndex = -1;
            expenseReportDetail.locationTextInput.text = null;
            expenseReportDetail.purposeTextInput.text = null;
            _expenseItems = new ArrayCollection();
            expenseReportDetail.expenseReportGrid.dataProvider = _expenseItems;

            resetExpenseItemForm();            

        }

        private function resetExpenseItemForm():void {

            if (_activeExpenseItem != null) {
                expenseReportDetail.amountInput.text = (_activeExpenseItem.amount == null ? '' : _activeExpenseItem.amountNumber.toFixed(2));
                expenseReportDetail.expenseDatePicker.selectedDate = _activeExpenseItem.expenseDate;
                expenseReportDetail.expenseTypeCmb.selectedIndex = findIndexForExpenseItemType( _activeExpenseItem.expenseItemType );
                expenseReportDetail.paymentMethodCmb.selectedIndex = findIndexForPaymentMethod( _activeExpenseItem.paymentMethod );
                expenseReportDetail.projectTypeCmb.selectedIndex = findIndexForProjectType( _activeExpenseItem.projectType );
            }
            else {
                expenseReportDetail.amountInput.text = '';
                expenseReportDetail.expenseDatePicker.selectedDate = null;
                expenseReportDetail.expenseTypeCmb.selectedIndex = -1;
                expenseReportDetail.paymentMethodCmb.selectedIndex = -1;
                expenseReportDetail.projectTypeCmb.selectedIndex = -1;
            }
            
            handleExpenseItemTypeChange(null);

            expenseReportDetail.expenseDatePicker.enabled = (_activeExpenseItem != null);
            expenseReportDetail.expenseTypeCmb.enabled = (_activeExpenseItem != null);
            expenseReportDetail.amountInput.enabled = (_activeExpenseItem != null);
            expenseReportDetail.paymentMethodCmb.enabled = (_activeExpenseItem != null);
            expenseReportDetail.projectTypeCmb.enabled = (_activeExpenseItem != null);
            expenseReportDetail.saveExpenseItemButton.enabled = (_activeExpenseItem != null);
            expenseReportDetail.cancelExpenseItemButton.enabled = (_activeExpenseItem != null);
        }

        private function handleLoadActiveExpenseReport(activeExpenseReport:ExpenseReport):void {

            setProject( activeExpenseReport.project );
            setExpenseReport( activeExpenseReport );
        }

        private function handleSaveButtonClicked(event:MouseEvent):void {
            var params:Array = new Array();
            params[0] = getProject();
            params[1] = getExpenseReport();
            params[2] = getExpenseReportItems();
            sendNotification(ApplicationFacade.SAVE_EXPENSE_REPORT_REQUEST, params);
        }

        private function handleExpenseItemSelectionChanged(event:Event):void {
            expenseReportDetail.editExpenseItemButton.enabled = (selectedExpenseItem != null);
            expenseReportDetail.deleteExpenseItemButton.enabled = (selectedExpenseItem != null);
        }

        var deleteExpenseReportPopup:IFlexDisplayObject;
        private function handleDeleteExpenseReportButtonClicked(event:MouseEvent):void {

            deleteExpenseReportPopup = PopUpManager.createPopUp(Application.application as DisplayObject, DeleteConfirmationPanel, true);
            PopUpManager.centerPopUp( deleteExpenseReportPopup );
            deleteExpenseReportPopup.addEventListener(ExpenseReportEvent.TYPE, handleDeleteConfirmedEvent);

        }

        private function handleDeleteConfirmedEvent(event:ExpenseReportEvent):void {
            deleteExpenseReportPopup.removeEventListener(ExpenseReportEvent.TYPE, handleDeleteConfirmedEvent);
            sendNotification(ApplicationFacade.DELETE_ACTIVE_EXPENSE_REPORT_REQUEST);
        }

        private function handleRefreshButtonClicked(event:MouseEvent):void {
            if (_expenseReportProxy.activeExpenseReport) {                
                var activeExpenseReportId:Number = _expenseReportProxy.activeExpenseReport.idNumber;
                sendNotification(ApplicationFacade.FIND_EXPENSE_REPORT_REQUEST, activeExpenseReportId);
            }
        }

        private function handleNewExpenseItemButtonClicked(event:MouseEvent):void {
            _activeExpenseItem = new ExpenseItem();
            resetExpenseItemForm();
        }

        private function handleEditExpenseItemButtonClicked(event:MouseEvent):void {
            _activeExpenseItem = new ExpenseItem();
            _activeExpenseItem.amountNumber = selectedExpenseItem.amountNumber;
            _activeExpenseItem.comment = selectedExpenseItem.comment;
            _activeExpenseItem.expenseDate = selectedExpenseItem.expenseDate;
            _activeExpenseItem.expenseItemType = selectedExpenseItem.expenseItemType;
            _activeExpenseItem.idNumber = selectedExpenseItem.idNumber;
            _activeExpenseItem.paymentMethod = selectedExpenseItem.paymentMethod;
            _activeExpenseItem.projectType = selectedExpenseItem.projectType;
            _activeExpenseItem.expenseItemValues = new ArrayCollection();

            if (selectedExpenseItem.expenseItemValues != null) {
                for each (var value:ExpenseItemValue in selectedExpenseItem.expenseItemValues) {
                    var newValue:ExpenseItemValue = new ExpenseItemValue();
                    newValue.expenseItem = _activeExpenseItem;
                    newValue.idNumber = value.idNumber;
                    newValue.descriptor = value.descriptor;
                    newValue.enumValue = value.enumValue;
                    newValue.stringValue = value.stringValue;
                    newValue.partitionDate = value.partitionDate;

                    _activeExpenseItem.expenseItemValues.addItem(newValue);
                }
            }

            resetExpenseItemForm();
        }

        private function handleDeleteExpenseItemButtonClicked(event:MouseEvent):void {
            var idx:int = _expenseItems.getItemIndex(selectedExpenseItem);
            _expenseItems.removeItemAt(idx);
            expenseReportDetail.expenseReportGrid.dataProvider.refresh();
        }

        private function updateExpenseItem(item:ExpenseItem):void {
            for each (var existingItem:ExpenseItem in expenseReportDetail.expenseReportGrid.dataProvider) {
                if (existingItem.idNumber == item.idNumber) {
                    existingItem.amount = item.amount;
                    existingItem.comment = item.comment;
                    existingItem.expenseDate = item.expenseDate;
                    existingItem.expenseItemType = item.expenseItemType;
                    existingItem.projectType = item.projectType;
                    existingItem.paymentMethod = item.paymentMethod;
                    existingItem.expenseItemValues = item.expenseItemValues;

                    break;
                }
            }
        }

        private function setExpenseItemValues():void {
            _activeExpenseItem.amount = expenseReportDetail.amountInput.text;
            _activeExpenseItem.expenseDate = expenseReportDetail.expenseDatePicker.selectedDate;
            _activeExpenseItem.expenseItemType = expenseReportDetail.expenseTypeCmb.selectedItem as ExpenseItemType;
            _activeExpenseItem.paymentMethod = expenseReportDetail.paymentMethodCmb.selectedItem as PaymentMethod;
            _activeExpenseItem.projectType = expenseReportDetail.projectTypeCmb.selectedItem as ProjectType;
            _activeExpenseItem.expenseItemValues = new ArrayCollection();

            for each (var field:AttributeField in expenseReportDetail.expenseItemAttribute) {
                field.updateAttributeValue();
                var value:ExpenseItemValue = field.attribute as ExpenseItemValue;

                if (value.enumValue != null || !StringUtils.isEmpty(value.stringValue)) {
                    _activeExpenseItem.expenseItemValues.addItem(value);
                }
            }
        }

        private function handleSaveExpenseItemButtonClicked(event:MouseEvent):void {
            setExpenseItemValues();
            if (_activeExpenseItem.id != null) {
                updateExpenseItem(_activeExpenseItem);
            }
            else {
                _expenseItems.addItem(_activeExpenseItem);
                expenseReportDetail.expenseReportGrid.dataProvider.refresh();
            }

            _activeExpenseItem = null;
            resetExpenseItemForm();
        }

        private function handleCancelExpenseItemButtonClicked(event:MouseEvent):void {
            _activeExpenseItem = null;
            resetExpenseItemForm();
        }

        private function expenseItemValueSort(a:Object, b:Object, fields:Array = null):int {
            if (a is ExpenseItemValue && b is ExpenseItemValue) {
                return ObjectUtil.numericCompare(ExpenseItemValue(a).descriptor.sortOrder, ExpenseItemValue(b).descriptor.sortOrder);
            }

            return 0;
        }

        private function handleExpenseItemTypeChange(event:Event):void {
            var values:ListCollectionView = new ArrayCollection();

            if (_activeExpenseItem != null && expenseReportDetail.expenseTypeCmb.selectedItem != null) {
                var descriptors:ListCollectionView = new ArrayCollection();
                descriptors.addAll(expenseReportDetail.expenseTypeCmb.selectedItem.descriptors);

                // first, we iterate over the existing values (if any) and add those
                // and remove the descriptor from the descriptor list
                if (_activeExpenseItem != null && _activeExpenseItem.expenseItemValues != null) {
                    for each (var value:ExpenseItemValue in _activeExpenseItem.expenseItemValues) {
                        if (ExpenseItemDescriptor(value.descriptor).expenseItemType.idNumber == _activeExpenseItem.expenseItemType.idNumber) {

                            for (var i:int = 0; i < descriptors.length; i++) {
                                var descriptor:ExpenseItemDescriptor = descriptors.getItemAt(i) as ExpenseItemDescriptor;

                                if (descriptor.idNumber == value.descriptor.idNumber) {
                                    descriptors.removeItemAt(i);
                                    break;
                                }
                            }
                            values.addItem(value);
                        }
                    }
                }

                // next, we iterate over the remaining descriptors (if any) and create empty
                // item values for them so that they show up in the UI
                for each (var descriptor:ExpenseItemDescriptor in descriptors) {
                    var value:ExpenseItemValue = new ExpenseItemValue();
                    value.descriptor = descriptor;
                    values.addItem(value);
                }
            }

            values.sort = new Sort();
            values.sort.compareFunction = expenseItemValueSort;
            values.refresh();
            
            expenseReportDetail.expenseItemValuesRepeater.dataProvider = values;
        }

        private function setProject(project:Project):void {
            var expenseDetailDP:ArrayCollection = expenseReportDetail.availableProjectsCmb.dataProvider as ArrayCollection;
            for (var i:int = 0 ; i < expenseDetailDP.length; i++) {
                if( (expenseDetailDP.getItemAt(i) as Project ).id == project.id ) {
                    expenseReportDetail.availableProjectsCmb.selectedIndex = i;
                    break;
                }
            }
        }

        private function getProject():Project {
            var project:Project = expenseReportDetail.availableProjectsCmb.selectedItem as Project;
            return project;
        }


        private function setExpenseReport(activeExpenseReport:ExpenseReport):void {
            expenseReportDetail.purposeTextInput.text = activeExpenseReport.purpose;
            expenseReportDetail.locationTextInput.text = activeExpenseReport.location;
        }

        private function getExpenseReport():ExpenseReport {
            var expenseReport:ExpenseReport = _expenseReportProxy.activeExpenseReport;

            if (expenseReport == null) {
                expenseReport = new ExpenseReport();
                expenseReport.status = ExpenseReportStatus.OPEN;
                expenseReport.owner = userServiceProxy.activeUser; 
            }
            expenseReport.purpose = expenseReportDetail.purposeTextInput.text;
            expenseReport.location = expenseReportDetail.locationTextInput.text;
            return expenseReport;
        }


        private function setExpenseReportItems(expenseItems:ListCollectionView):void {
            _expenseItems = expenseItems as ArrayCollection;
            expenseReportDetail.expenseReportGrid.dataProvider = _expenseItems;
        }

        private function getExpenseReportItems():ArrayCollection {
            return _expenseItems;
        }
       
        private function findIndexForProjectType(projectType:ProjectType):int {
            for ( var i:int = 0 ; i < _expenseReportProxy.projectTypes.length ; i++ ) {
                if ( projectType != null && projectType.type == _expenseReportProxy.projectTypes[i].type ) {
                    return i;
                }
            }
            return -1;
        }

        private function findIndexForPaymentMethod(paymentMethod:PaymentMethod):int {
            for ( var i:int = 0 ; i < _expenseReportProxy.paymentMethods.length ; i++ ) {
                if ( paymentMethod != null && paymentMethod.name == _expenseReportProxy.paymentMethods[i].name ) {
                    return i;
                }
            }
            return -1;
        }

        private function findIndexForExpenseItemType(expenseItemType:ExpenseItemType):int {
            for ( var i:int = 0 ; i < _expenseReportProxy.expenseTypes.length ; i++ ) {
                if ( expenseItemType != null && expenseItemType.name == _expenseReportProxy.expenseTypes[i].name ) {
                    return i;
                }
            }
            return -1;
        }

        private function get userServiceProxy():UserServiceProxy {
            return facade.retrieveProxy(UserServiceProxy.NAME) as UserServiceProxy;
        }

        private function get selectedExpenseItem():ExpenseItem {
            return expenseReportDetail.expenseReportGrid.selectedItem as ExpenseItem;
        }
    }
}