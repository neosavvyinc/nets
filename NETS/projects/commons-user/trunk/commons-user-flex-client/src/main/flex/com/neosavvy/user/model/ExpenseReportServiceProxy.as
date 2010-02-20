package com.neosavvy.user.model {
    import com.neosavvy.user.ProxyConstants;

    import com.neosavvy.user.dto.companyManagement.UserDTO;
    import com.neosavvy.user.dto.project.ExpenseReport;
    import com.neosavvy.user.dto.project.Project;

    import mx.collections.ArrayCollection;
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
        private var _activeExpenseReportId:Number;
        private var _paymentMethods:ArrayCollection             = null;
        private var _expenseTypes:ArrayCollection               = null;
        private var _projectTypes:ArrayCollection               = null;
        private var _openExpenseReports:ArrayCollection         = null;
        private var _submittedExpenseReports:ArrayCollection    = null;

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

        public function set activeExpenseReportId(activeExpenseReportId:Number):void {
            _activeExpenseReportId = activeExpenseReportId;
        }

        public function get activeExpenseReportId():Number {
            return _activeExpenseReportId;
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
            service.findOpenExpenseReportsForUser( user );
        }

        public function findSubmittedReportsForUser( user : UserDTO , responder:IResponder ) : void {
            var service:RemoteObject = getService(ProxyConstants.expenseServiceDestination);
            addCallbackHandler(service, responder);
            service.findSubmittedReportsForUser( user );
        }

        public function findReimbursedReportsForUser( user : UserDTO , responder:IResponder ) : void {
            var service:RemoteObject = getService(ProxyConstants.expenseServiceDestination);
            addCallbackHandler(service, responder);
            service.findReimbursedReportsForUser( user );
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
    }
}