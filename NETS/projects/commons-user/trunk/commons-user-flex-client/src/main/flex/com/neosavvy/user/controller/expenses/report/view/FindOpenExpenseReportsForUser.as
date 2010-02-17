package com.neosavvy.user.controller.expenses.report.view {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.controller.base.ResponderAsyncCommand;

    import com.neosavvy.user.dto.companyManagement.UserDTO;
    import com.neosavvy.user.model.ExpenseReportServiceProxy;

    import com.neosavvy.user.util.RemoteObjectUtils;

    import mx.collections.ArrayCollection;
    import mx.rpc.events.FaultEvent;

    import mx.rpc.events.ResultEvent;

    import org.puremvc.as3.multicore.interfaces.INotification;

    public class FindOpenExpenseReportsForUser extends ResponderAsyncCommand {

        override public function execute(notification:INotification):void {
            super.execute(notification);
            var expenseReportProxy:ExpenseReportServiceProxy = facade.retrieveProxy(ExpenseReportServiceProxy.NAME) as ExpenseReportServiceProxy;
            var user:UserDTO = notification.getBody() as UserDTO;
            expenseReportProxy.findOpenExpenseReportsForUser(user, this);
        }

        override protected function resultHandler(resultEvent:ResultEvent):void {
            var expenseReportProxy:ExpenseReportServiceProxy = facade.retrieveProxy(ExpenseReportServiceProxy.NAME) as ExpenseReportServiceProxy;
            expenseReportProxy.openExpenseReports = resultEvent.result as ArrayCollection;
            sendNotification(ApplicationFacade.FIND_OPEN_EXPENSE_REPORTS_FOR_USER_SUCCESS);
        }

        override protected function faultHandler(faultEvent:FaultEvent):void {
            RemoteObjectUtils.logRemoteServiceFault(faultEvent, LOGGER);
            sendNotification(ApplicationFacade.FIND_OPEN_EXPENSE_REPORTS_FOR_USER_FAILURE);
        }

    }
}