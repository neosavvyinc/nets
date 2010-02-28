package com.neosavvy.user.controller.expenses.report.view {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.controller.base.ResponderAsyncCommand;
    import com.neosavvy.user.dto.project.ExpenseReport;
    import com.neosavvy.user.model.ExpenseReportServiceProxy;
    import com.neosavvy.user.util.RemoteObjectUtils;

    import mx.collections.ListCollectionView;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;

    import org.puremvc.as3.multicore.interfaces.INotification;

    public class GetExpenseReportItems extends ResponderAsyncCommand {
        override public function execute(notification:INotification):void {
            super.execute(notification);
            var expenseReportProxy:ExpenseReportServiceProxy = facade.retrieveProxy(ExpenseReportServiceProxy.NAME) as ExpenseReportServiceProxy;
            var id:Number = notification.getBody() as Number;
            expenseReportProxy.getExpenseItems(id, this);
        }

        override protected function resultHandler(resultEvent:ResultEvent):void {
            var expenseReportProxy:ExpenseReportServiceProxy = facade.retrieveProxy(ExpenseReportServiceProxy.NAME) as ExpenseReportServiceProxy;
            expenseReportProxy.activeExpenseReportItems = resultEvent.result as ListCollectionView;
            sendNotification(ApplicationFacade.GET_EXPENSE_ITEMS_SUCCESS);
        }

        override protected function faultHandler(faultEvent:FaultEvent):void {
            RemoteObjectUtils.logRemoteServiceFault(faultEvent, LOGGER);
            sendNotification(ApplicationFacade.GET_EXPENSE_ITEMS_FAILURE);
        }
    }
}