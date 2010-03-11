package com.neosavvy.user.controller.expenses.report.save {
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

    public class SaveExpenseReport extends ResponderAsyncCommand {

        override public function execute(notification:INotification):void {
            super.execute(notification);
            var expenseReportProxy:ExpenseReportServiceProxy = facade.retrieveProxy(ExpenseReportServiceProxy.NAME) as ExpenseReportServiceProxy;

            if (notification.getBody() is Array && (notification.getBody() as Array).length == 3) {
                var project:Project                 = notification.getBody()[0];
                var expenseReport:ExpenseReport     = notification.getBody()[1];
                var items:ArrayCollection           = notification.getBody()[2];
                expenseReportProxy.saveExpenseReport(project, expenseReport, items, this);
            } else {
                throw IllegalOperationError("Parameters to SaveExpenseReport must be project:Project,expenseReport:ExpenseReport,items:ArrayCollection")
            }

            sendNotification(ApplicationFacade.SHOW_PROGRESS_INDICATOR);

        }

        override protected function resultHandler(resultEvent:ResultEvent):void {
            var expenseReportProxy:ExpenseReportServiceProxy = facade.retrieveProxy(ExpenseReportServiceProxy.NAME) as ExpenseReportServiceProxy;
            expenseReportProxy.activeExpenseReport = resultEvent.result as ExpenseReport;
            sendNotification(ApplicationFacade.HIDE_PROGRESS_INDICATOR);
            sendNotification(ApplicationFacade.SAVE_EXPENSE_REPORT_SUCCESS);
        }


        override protected function faultHandler(faultEvent:FaultEvent):void {
            RemoteObjectUtils.logRemoteServiceFault(faultEvent, LOGGER);
            sendNotification(ApplicationFacade.HIDE_PROGRESS_INDICATOR);
            sendNotification(ApplicationFacade.SAVE_EXPENSE_REPORT_FAILURE);
        }

    }
}