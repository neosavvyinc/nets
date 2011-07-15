package com.neosavvy.user.model {
    import com.neosavvy.user.ProxyConstants;
    import com.neosavvy.user.dto.companyManagement.UserDTO;
    import com.neosavvy.user.dto.project.ExpenseReport;
    import com.neosavvy.user.dto.project.ExpenseReportStatus;
    import com.neosavvy.user.dto.project.Project;

    import fineline.focal.common.types.v1.StorageServiceFileRef;

    import mx.collections.ArrayCollection;
    import mx.collections.ListCollectionView;
    import mx.logging.ILogger;
    import mx.logging.Log;
    import mx.rpc.IResponder;
    import mx.rpc.remoting.mxml.RemoteObject;

    public class ExpenseReportServiceProxy extends AbstractRemoteObjectProxy {
        public static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.model.ExpenseReportServiceProxy");

        public static var NAME:String = "expenseReportServiceProxy";

        public function ExpenseReportServiceProxy()
        {
            super(NAME, null, ProxyConstants.expenseContextRoot);
        }

        private var _activeExpenseReport:ExpenseReport;
        private var _paymentMethods:ArrayCollection             = null;
        private var _expenseTypes:ArrayCollection               = null;
        private var _projectTypes:ArrayCollection               = null;
        private var _openExpenseReports:ArrayCollection         = null;
        private var _submittedExpenseReports:ArrayCollection    = null;
        private var _activeExpenseReportItems:ListCollectionView = null;
        private var _awaitingExpenseReportItems:ArrayCollection = null;

        public function get paymentMethods():ArrayCollection {
            return _paymentMethods;
        }

        public function set paymentMethods(value:ArrayCollection):void {
            _paymentMethods = value;
        }

        public function get expenseTypes():ArrayCollection {
            return _expenseTypes;
        }

        public function set expenseTypes(value:ArrayCollection):void {
            _expenseTypes = value;
        }

        public function get projectTypes():ArrayCollection {
            return _projectTypes;
        }

        public function set projectTypes(value:ArrayCollection):void {
            _projectTypes = value;
        }

        public function get activeExpenseReport():ExpenseReport {
            return _activeExpenseReport;
        }

        public function set activeExpenseReport(value:ExpenseReport):void {
            _activeExpenseReport = value;
        }

        public function get openExpenseReports():ArrayCollection {
            return _openExpenseReports;
        }

        public function set openExpenseReports(value:ArrayCollection):void {
            _openExpenseReports = value;
        }

        public function get submittedExpenseReports():ArrayCollection {
            return _submittedExpenseReports;
        }

        public function set submittedExpenseReports(value:ArrayCollection):void {
            _submittedExpenseReports = value;
        }

        public function get activeExpenseReportItems():ListCollectionView {
            return _activeExpenseReportItems;
        }

        public function set activeExpenseReportItems(value:ListCollectionView):void {
            _activeExpenseReportItems = value;
        }

        public function get awaitingExpenseReportItems():ArrayCollection {
            return _awaitingExpenseReportItems;
        }

        public function set awaitingExpenseReportItems(value:ArrayCollection):void {
            _awaitingExpenseReportItems = value;
        }

        public function saveReceiptToExpenseReport( report : ExpenseReport, fileRef : StorageServiceFileRef, responder : IResponder ) : void
        {
            var service : RemoteObject = getService(ProxyConstants.expenseServiceDestination);
            addCallbackHandler(service, responder);
            service.saveReceiptToExpenseReport( report, fileRef );
        }

        public function saveExpenseReport(p:Project, report:ExpenseReport , expenseItems:ArrayCollection, responder:IResponder):void {
            var service:RemoteObject = getService(ProxyConstants.expenseServiceDestination);
            addCallbackHandler(service, responder);
            report.project = p;
            service.saveExpenseReport(report, expenseItems);
        }

        public function findExpenseReportById(id:Number, responder:IResponder):void {
            var service:RemoteObject = getService(ProxyConstants.expenseServiceDestination);
            addCallbackHandler(service, responder);
            service.findExpenseReportById(id);
        }

        public function deleteExpenseReport( report:ExpenseReport , responder:IResponder ) : void {
            var service:RemoteObject = getService(ProxyConstants.expenseServiceDestination);
            addCallbackHandler(service, responder);
            service.deleteExpenseReport(report);
        }

        public function findOpenExpenseReportsForUser( user : UserDTO , responder:IResponder ) : void {
            var service:RemoteObject = getService(ProxyConstants.expenseServiceDestination);
            addCallbackHandler(service, responder);
            service.findExpenseReportsByStatuses( user, [ExpenseReportStatus.OPEN, ExpenseReportStatus.DECLINED] );
        }

        public function findSubmittedReportsForUser( user : UserDTO , responder:IResponder ) : void {
            var service:RemoteObject = getService(ProxyConstants.expenseServiceDestination);
            addCallbackHandler(service, responder);
            service.findExpenseReportsByStatuses( user, [ExpenseReportStatus.SUBMITTED,ExpenseReportStatus.APPROVING,ExpenseReportStatus.APPROVED,ExpenseReportStatus.REIMBURSEMENT_SENT]);
        }

        public function findReimbursedReportsForUser( user : UserDTO , responder:IResponder ) : void {
            var service:RemoteObject = getService(ProxyConstants.expenseServiceDestination);
            addCallbackHandler(service, responder);
            service.findExpenseReportsByStatus( user, ExpenseReportStatus.REIMBURSEMENT_RECEIVED);
        }

        public function findPaymentMethods( responder:IResponder ) : void {
            var service:RemoteObject = getService(ProxyConstants.expenseServiceDestination);
            addCallbackHandler(service, responder);
            service.findPaymentMethods();
        }

        public function findExpenseItemTypes( responder:IResponder ) : void {
            var service:RemoteObject = getService(ProxyConstants.expenseServiceDestination);
            addCallbackHandler(service, responder);
            service.findExpenseItemTypes();
        }

        public function findProjectTypes( responder:IResponder ) : void {
            var service:RemoteObject = getService(ProxyConstants.expenseServiceDestination);
            addCallbackHandler(service, responder);
            service.findProjectTypes();
        }

        public function getExpenseItems( expenseReportId:Number, responder:IResponder ) : void {
            var service:RemoteObject = getService(ProxyConstants.expenseServiceDestination);
            addCallbackHandler(service, responder);
            service.getExpenseItems(expenseReportId);
        }

        public function findExpenseReportsAwaitingApproval(user:UserDTO, responder:IResponder):void {
            var service:RemoteObject = getService(ProxyConstants.expenseServiceDestination);
            addCallbackHandler(service, responder);
            service.findExpenseReportsByStatuses( user, [ExpenseReportStatus.APPROVING, ExpenseReportStatus.SUBMITTED]);
        }

        public function submitExpenseReportForApproval( expenseReport:ExpenseReport, comment:String, responder:IResponder ) : void
        {
            var service:RemoteObject = getService(ProxyConstants.expenseServiceDestination);
            addCallbackHandler(service, responder);
            service.submitExpenseReportForApproval(expenseReport, comment);
        }

        public function reopenExpenseReportForApproval( expenseReport:ExpenseReport, comment:String, responder:IResponder ) : void
        {
            var service:RemoteObject = getService(ProxyConstants.expenseServiceDestination);
            addCallbackHandler(service, responder);
            service.reopenExpenseReportForApproval(expenseReport, comment);
        }


        public function approveExpenseReport( expenseReport:ExpenseReport, comment:String, responder:IResponder ) : void
        {
            var service:RemoteObject = getService(ProxyConstants.expenseServiceDestination);
            addCallbackHandler(service, responder);
            service.approveExpenseReport(expenseReport, comment);
        }

        public function declineExpenseReport( expenseReport:ExpenseReport, comment:String, responder:IResponder) : void
        {
            var service:RemoteObject = getService(ProxyConstants.expenseServiceDestination);
            addCallbackHandler(service, responder);
            service.declineExpenseReport(expenseReport, comment);
        }

    }
}