package com.neosavvy.user.controller.expenses.report.save {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.controller.base.ResponderAsyncCommand;

    import com.neosavvy.user.dto.project.ExpenseReport;
    import com.neosavvy.user.dto.project.Project;
    import com.neosavvy.user.model.ExpenseReportServiceProxy;

    import com.neosavvy.user.util.RemoteObjectUtils;

    import flash.errors.IllegalOperationError;

    import mx.collections.ArrayCollection;
    import mx.rpc.events.FaultEvent;

    import mx.rpc.events.ResultEvent;

    import org.puremvc.as3.multicore.interfaces.INotification;

    public class FindExpenseReport extends ResponderAsyncCommand {

        override public function execute(notification:INotification):void {
            super.execute(notification);
            var expenseReportProxy:ExpenseReportServiceProxy = facade.retrieveProxy(ExpenseReportServiceProxy.NAME) as ExpenseReportServiceProxy;
            var expenseReportId:Number     = notification.getBody() as Number;
            expenseReportProxy.findExpenseReportById(expenseReportId, this);
        }

        override protected function resultHandler(resultEvent:ResultEvent):void {
            var expenseReportProxy:ExpenseReportServiceProxy = facade.retrieveProxy(ExpenseReportServiceProxy.NAME) as ExpenseReportServiceProxy;
            expenseReportProxy.activeExpenseReport = resultEvent.result as ExpenseReport;
            sendNotification(ApplicationFacade.FIND_EXPENSE_REPORT_SUCCESS);
        }

        override protected function faultHandler(faultEvent:FaultEvent):void {
            RemoteObjectUtils.logRemoteServiceFault(faultEvent, LOGGER);
            sendNotification(ApplicationFacade.FIND_EXPENSE_REPORT_FAILURE);
        }

    }
}