package com.neosavvy.user.view.secured.receipts {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.dto.companyManagement.SecurityWrapperDTO;
    import com.neosavvy.user.dto.companyManagement.UserDTO;
    import com.neosavvy.user.dto.project.ExpenseReport;
    import com.neosavvy.user.model.ExpenseReportServiceProxy;
    import com.neosavvy.user.model.ProjectServiceProxy;
    import com.neosavvy.user.model.SecurityProxy;

    import flash.events.Event;
    import flash.events.MouseEvent;

    import mx.collections.ArrayCollection;
    import mx.controls.Button;
    import mx.controls.TileList;
    import mx.core.IFlexDisplayObject;
    import mx.logging.ILogger;
    import mx.logging.Log;
    import mx.managers.PopUpManager;
    import mx.rpc.Responder;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.mediator.Mediator;

    public class ReceiptManagerMediator extends Mediator {

        private static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.view.secured.receipts.ReceiptManagerMediator");

        public static const NAME:String = "receiptManagerMediator";

        private var securityProxy : SecurityProxy
        private var _expenseReportProxy:ExpenseReportServiceProxy
        private var _projectProxy:ProjectServiceProxy;


        public function ReceiptManagerMediator( viewComponent : Object ) {
            super(NAME, viewComponent);
        }


        override public function listNotificationInterests():Array {
            return [
                ApplicationFacade.NAVIGATE_TO_MANAGE_RECEIPTS
                ,"receiptsRefreshed"
                ,ApplicationFacade.FIND_OPEN_EXPENSE_REPORTS_FOR_USER_SUCCESS
                ,ApplicationFacade.ADD_RECEIPT_TO_EXPENSE_REPORT_SUCCESS
                ,ApplicationFacade.GET_PROJECTS_FOR_USER_SUCCESS
            ];
        }

        public function get receiptManager():ReceiptManager
        {
            return viewComponent as ReceiptManager;
        }

        public function get receiptViewer():TileList
        {
            return receiptManager.receiptViewer;
        }

        public function get refreshButton():Button
        {
            return receiptManager.refreshReceipts;
        }

        override public function onRegister():void {
            super.onRegister();

            securityProxy = ApplicationFacade.getSecurityProxy();
            _expenseReportProxy = facade.retrieveProxy(ExpenseReportServiceProxy.NAME) as ExpenseReportServiceProxy;
            _projectProxy = facade.retrieveProxy(ProjectServiceProxy.NAME) as ProjectServiceProxy;

            receiptViewer.addEventListener( "reloadReceiptData", handleReloadReceiptData );
            refreshButton.addEventListener( MouseEvent.CLICK, handleReceiptRefresh );

            receiptViewer.addEventListener( AddReceiptToExpenseReportEvent.TYPE, onAddReceiptToExpenseReportEvent );
            receiptViewer.addEventListener( CreateExpenseReportAndAddRecentEvent.TYPE, onCreateExpenseReportAndAddReceiptEvent );
        }

        private function onCreateExpenseReportAndAddReceiptEvent(event:CreateExpenseReportAndAddRecentEvent):void {

            var newExpenseReportPanel:IFlexDisplayObject = PopUpManager.createPopUp( receiptManager, NewExpenseReportPanel, true );
            PopUpManager.centerPopUp( newExpenseReportPanel );
            var newExpenseReport:NewExpenseReportPanel = (newExpenseReportPanel as NewExpenseReportPanel);
            newExpenseReport.fileRef = event.fileRef;
            newExpenseReport.expenseReport = event.expenseReport;
            newExpenseReport.projects = _projectProxy.projects;;
            newExpenseReportPanel.addEventListener( AddReceiptToExpenseReportEvent.TYPE, onAddReceiptToExpenseReportEvent );
            
        }

        private function onAddReceiptToExpenseReportEvent(event:AddReceiptToExpenseReportEvent):void {

            sendNotification( ApplicationFacade.ADD_RECEIPT_TO_EXPENSE_REPORT_REQUEST, event );

        }

        private function handleReceiptRefresh(event:MouseEvent):void
        {
            refreshReceipts();
        }

        private function refreshReceipts():void {
            var securityProxy:SecurityProxy = facade.retrieveProxy(SecurityProxy.NAME) as SecurityProxy;

            securityProxy.checkUserLoggedIn(new Responder(
                    function(result:ResultEvent):void {
                        securityProxy.setData(result.result as SecurityWrapperDTO);
                        sendNotification("receiptsRefreshed", securityProxy.user);
                    },
                    function (faultEvent:FaultEvent):void {
                        LOGGER.debug("refresh failed: " + faultEvent.fault.faultString);
                    }
                    ));
        }

        private function handleReloadReceiptData( event : Event ):void {

            refreshReceipts();

        }

        override public function onRemove():void {
            super.onRemove();

            securityProxy = null;
        }

        override public function handleNotification(notification:INotification):void {
            switch( notification.getName() )
            {
                case ApplicationFacade.ADD_RECEIPT_TO_EXPENSE_REPORT_SUCCESS:
                    refreshReceipts();
                    break;
                case "receiptsRefreshed":
                case ApplicationFacade.NAVIGATE_TO_MANAGE_RECEIPTS:
                    var activeUser : UserDTO = securityProxy.activeUser;
                    receiptViewer.dataProvider = activeUser.uncategorizedReceipts;
                    sendNotification(ApplicationFacade.FIND_OPEN_EXPENSE_REPORTS_FOR_USER_REQUEST, activeUser);
                    sendNotification(ApplicationFacade.GET_PROJECTS_FOR_USER_REQUEST, activeUser);
                    break;
                case ApplicationFacade.FIND_OPEN_EXPENSE_REPORTS_FOR_USER_SUCCESS:
                    var openExpenseReports:ArrayCollection = _expenseReportProxy.openExpenseReports;
                    var newExpenseReport : ExpenseReport = new ExpenseReport();
                    newExpenseReport.displayStringOverride = "Add To New...";
                    openExpenseReports.addItemAt(newExpenseReport,0);
                    receiptManager.openExenseReports = openExpenseReports;
                    receiptManager.receiptViewer.invalidateProperties();
                    break;
                case ApplicationFacade.GET_PROJECTS_FOR_USER_SUCCESS:
                    break;
            }
        }
    }
}