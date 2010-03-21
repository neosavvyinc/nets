package com.neosavvy.user.controller.expenses.report.workflow {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.controller.base.ResponderAsyncCommand;

    import com.neosavvy.user.controller.progress.ShowProgressBarCommand;
    import com.neosavvy.user.dto.project.ExpenseReport;
    import com.neosavvy.user.dto.project.Project;
    import com.neosavvy.user.model.ExpenseReportServiceProxy;

    import com.neosavvy.user.util.RemoteObjectUtils;

    import flash.errors.IllegalOperationError;

    import mx.collections.ArrayCollection;
    import mx.rpc.events.FaultEvent;

    import mx.rpc.events.ResultEvent;

    import org.puremvc.as3.multicore.interfaces.INotification;

    public class DeclineExpenseReport extends ResponderAsyncCommand {

        override public function execute(notification:INotification):void {
            super.execute(notification);
            var expenseReportProxy:ExpenseReportServiceProxy = facade.retrieveProxy(ExpenseReportServiceProxy.NAME) as ExpenseReportServiceProxy;

            if (notification.getBody() is Array && (notification.getBody() as Array).length == 2) {
                var expenseReport:ExpenseReport     = notification.getBody()[0];
                var comment:String                  = notification.getBody()[1];
                expenseReportProxy.declineExpenseReport( expenseReport, comment, this);
            } else {
                throw IllegalOperationError("Parameters to DeclineExpenseReport must be expenseReport:ExpenseReport,comment:String")
            }

            sendNotification(ApplicationFacade.SHOW_PROGRESS_INDICATOR);

        }

        override protected function resultHandler(resultEvent:ResultEvent):void {
            var expenseReportProxy:ExpenseReportServiceProxy = facade.retrieveProxy(ExpenseReportServiceProxy.NAME) as ExpenseReportServiceProxy;
            expenseReportProxy.activeExpenseReport = resultEvent.result as ExpenseReport;
            sendNotification(ApplicationFacade.HIDE_PROGRESS_INDICATOR);
            sendNotification(ApplicationFacade.DECLINE_EXPENSE_REPORT_SUCCESS);
        }


        override protected function faultHandler(faultEvent:FaultEvent):void {
            RemoteObjectUtils.logRemoteServiceFault(faultEvent, LOGGER);
            sendNotification(ApplicationFacade.HIDE_PROGRESS_INDICATOR);
            sendNotification(ApplicationFacade.DECLINE_EXPENSE_REPORT_FAILURE);
        }

    }
}