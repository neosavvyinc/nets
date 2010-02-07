package com.neosavvy.user.controller.expenses.report.init {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.controller.base.ResponderAsyncCommand;

    import com.neosavvy.user.dto.project.CompanyExpenseItemType;
    import com.neosavvy.user.dto.project.ExpenseItemType;
    import com.neosavvy.user.dto.project.ExpenseReport;
    import com.neosavvy.user.dto.project.Project;
    import com.neosavvy.user.dto.project.ProjectType;
    import com.neosavvy.user.dto.project.StandardExpenseItemType;
    import com.neosavvy.user.model.ExpenseReportServiceProxy;

    import com.neosavvy.user.util.RemoteObjectUtils;

    import flash.errors.IllegalOperationError;

    import mx.collections.ArrayCollection;
    import mx.rpc.events.FaultEvent;

    import mx.rpc.events.ResultEvent;

    import org.puremvc.as3.multicore.interfaces.INotification;

    public class FindExpenseTypes extends ResponderAsyncCommand {

        var expenseType:ExpenseItemType;
        var stdType:StandardExpenseItemType;
        var cmpType:CompanyExpenseItemType;

        override public function execute(notification:INotification):void {
            super.execute(notification);
            var expenseReportProxy:ExpenseReportServiceProxy = facade.retrieveProxy(ExpenseReportServiceProxy.NAME) as ExpenseReportServiceProxy;
            expenseReportProxy.findExpenseItemTypes(this);
        }

        override protected function resultHandler(resultEvent:ResultEvent):void {
            var expenseReportProxy:ExpenseReportServiceProxy = facade.retrieveProxy(ExpenseReportServiceProxy.NAME) as ExpenseReportServiceProxy;
            expenseReportProxy.expenseTypes = resultEvent.result as ArrayCollection;
            sendNotification(ApplicationFacade.FIND_EXPENSE_ITEM_TYPES_SUCCESS);
        }

        override protected function faultHandler(faultEvent:FaultEvent):void {
            RemoteObjectUtils.logRemoteServiceFault(faultEvent, LOGGER);
            sendNotification(ApplicationFacade.FIND_EXPENSE_ITEM_TYPES_FAILURE);
        }

    }
}