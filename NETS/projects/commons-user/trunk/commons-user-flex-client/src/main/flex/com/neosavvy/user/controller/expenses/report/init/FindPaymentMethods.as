package com.neosavvy.user.controller.expenses.report.init {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.controller.base.ResponderAsyncCommand;

    import com.neosavvy.user.dto.project.CompanyPaymentMethod;
    import com.neosavvy.user.dto.project.ExpenseReport;
    import com.neosavvy.user.dto.project.Project;
    import com.neosavvy.user.dto.project.ProjectPaymentMethod;
    import com.neosavvy.user.dto.project.StandardPaymentMethod;
    import com.neosavvy.user.model.ExpenseReportServiceProxy;

    import com.neosavvy.user.util.RemoteObjectUtils;

    import flash.errors.IllegalOperationError;

    import mx.collections.ArrayCollection;
    import mx.rpc.events.FaultEvent;

    import mx.rpc.events.ResultEvent;

    import org.puremvc.as3.multicore.interfaces.INotification;

    public class FindPaymentMethods extends ResponderAsyncCommand {

        private var stdPaymentMethod:StandardPaymentMethod;
        private var cmpPaymentMethod:CompanyPaymentMethod;
        private var prjPaymentMethod:ProjectPaymentMethod;

        override public function execute(notification:INotification):void {
            super.execute(notification);
            var expenseReportProxy:ExpenseReportServiceProxy = facade.retrieveProxy(ExpenseReportServiceProxy.NAME) as ExpenseReportServiceProxy;
            expenseReportProxy.findPaymentMethods(this);
        }

        override protected function resultHandler(resultEvent:ResultEvent):void {
            var expenseReportProxy:ExpenseReportServiceProxy = facade.retrieveProxy(ExpenseReportServiceProxy.NAME) as ExpenseReportServiceProxy;
            expenseReportProxy.paymentMethods = resultEvent.result as ArrayCollection;
            sendNotification(ApplicationFacade.FIND_PAYMENT_METHODS_SUCCESS);
        }

        override protected function faultHandler(faultEvent:FaultEvent):void {
            RemoteObjectUtils.logRemoteServiceFault(faultEvent, LOGGER);
            sendNotification(ApplicationFacade.FIND_PAYMENT_METHODS_FAILURE);
        }

    }
}