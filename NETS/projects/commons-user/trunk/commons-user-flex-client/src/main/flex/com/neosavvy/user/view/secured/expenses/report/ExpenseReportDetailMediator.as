package com.neosavvy.user.view.secured.expenses.report {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.dto.project.ExpenseItem;
    import com.neosavvy.user.dto.project.ExpenseItemType;
    import com.neosavvy.user.dto.project.ExpenseReport;
    import com.neosavvy.user.dto.project.PaymentMethod;
    import com.neosavvy.user.dto.project.Project;
    import com.neosavvy.user.dto.project.ProjectType;
    import com.neosavvy.user.model.ExpenseReportServiceProxy;
    import com.neosavvy.user.model.ProjectServiceProxy;

    import flash.events.MouseEvent;

    import mx.collections.ArrayCollection;
    import mx.collections.ListCollectionView;
    import mx.containers.Form;
    import mx.controls.AdvancedDataGrid;
    import mx.logging.ILogger;
    import mx.logging.Log;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.mediator.Mediator;

    public class ExpenseReportDetailMediator extends Mediator {
        private static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.view.secured.expenses.report.ExpenseReportDetail");

        public static const NAME:String = "expenseReportDetailMediator";

        private var _projectProxy:ProjectServiceProxy;
        private var _expenseReportProxy:ExpenseReportServiceProxy;

        private var _expenseItems:ArrayCollection = new ArrayCollection();

        public function ExpenseReportDetailMediator(viewComponent:Object) {
            super(NAME, viewComponent);
        }

        override public function onRegister():void {
            _projectProxy = facade.retrieveProxy(ProjectServiceProxy.NAME) as ProjectServiceProxy;
            _expenseReportProxy = facade.retrieveProxy(ExpenseReportServiceProxy.NAME) as ExpenseReportServiceProxy;

            expenseReportDetail.saveButton.addEventListener(MouseEvent.CLICK, handleSaveButtonClicked);
            expenseReportDetail.refreshButton.addEventListener(MouseEvent.CLICK, handleRefreshButtonClicked);
            expenseReportDetail.deleteButton.addEventListener(MouseEvent.CLICK, handleDeleteButtonClicked);

            expenseReportDetail.addExpenseItemButton.addEventListener(MouseEvent.CLICK, handleAddExpenseItemButtonClicked);
        }

        override public function onRemove():void {
            _projectProxy = null;
            _expenseReportProxy = null;

            expenseReportDetail.saveButton.removeEventListener(MouseEvent.CLICK, handleSaveButtonClicked);
            expenseReportDetail.refreshButton.removeEventListener(MouseEvent.CLICK, handleRefreshButtonClicked);
            expenseReportDetail.deleteButton.removeEventListener(MouseEvent.CLICK, handleDeleteButtonClicked);
        }

        public function get expenseReportDetail():ExpenseReportDetail {
            return viewComponent as ExpenseReportDetail;
        }

        public function get expenseReportSummaryForm():Form {
            return expenseReportDetail.expenseReportSummaryForm;
        }

        public function get expenseItemGrid():AdvancedDataGrid {
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
            ];
        }

        override public function handleNotification(notification:INotification):void {
            switch(notification.getName()) {
                case ApplicationFacade.NAVIGATE_TO_CREATE_EXPENSE_REPORT:
                    sendNotification(ApplicationFacade.INITIALIZE_EXPENSE_REPORT_VIEW);
                    break;
                case ApplicationFacade.NAVIGATE_TO_EDIT_EXPENSE_REPORT:

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
            }
        }

        private function handleLoadActiveExpenseReport(activeExpenseReport:ExpenseReport):void {

            setProject( activeExpenseReport.project );
            setExpenseReport( activeExpenseReport );
            setExpenseReportItems( activeExpenseReport.expenseItems );

        }

        private function handleSaveButtonClicked(event:MouseEvent):void {
            var params:Array = new Array();
            params[0] = getProject();
            params[1] = getExpenseReport();
            params[2] = getExpenseReportItems();
            sendNotification(ApplicationFacade.SAVE_EXPENSE_REPORT_REQUEST, params);
        }

        private function handleDeleteButtonClicked(event:MouseEvent):void {
        }

        private function handleRefreshButtonClicked(event:MouseEvent):void {
            var activeExpenseReportId:Number = _expenseReportProxy.activeExpenseReportId;
            sendNotification(ApplicationFacade.FIND_EXPENSE_REPORT_REQUEST, activeExpenseReportId);
        }

        private function handleAddExpenseItemButtonClicked(event:MouseEvent):void {
            var expenseItem:ExpenseItem = getExpenseReportItem();
            _expenseItems.addItem(expenseItem);
            expenseReportDetail.expenseReportGrid.dataProvider = _expenseItems;
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
            var expenseReport:ExpenseReport = new ExpenseReport();
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

        private function getExpenseReportItem():ExpenseItem {
            var expenseItem:ExpenseItem = new ExpenseItem();

            expenseItem.amount = expenseReportDetail.amountInput.text;
            expenseItem.expenseDate = expenseReportDetail.expenseDatePicker.selectedDate;
            expenseItem.expenseItemType = expenseReportDetail.expenseTypeCmb.selectedItem as ExpenseItemType;
            expenseItem.paymentMethod = expenseReportDetail.paymentMethodCmb.selectedItem as PaymentMethod;
            expenseItem.projectType = expenseReportDetail.projectTypeCmb.selectedItem as ProjectType;

            return expenseItem;
        }





    }
}