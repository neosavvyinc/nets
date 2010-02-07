package com.neosavvy.user.controller.expenses.report.init {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.controller.base.ResponderAsyncCommand;

    import com.neosavvy.user.dto.project.CompanyPaymentMethod;
    import com.neosavvy.user.dto.project.ExpenseReport;
    import com.neosavvy.user.dto.project.Project;
    import com.neosavvy.user.dto.project.ProjectPaymentMethod;
    import com.neosavvy.user.dto.project.ProjectType;
    import com.neosavvy.user.dto.project.StandardPaymentMethod;
    import com.neosavvy.user.model.ExpenseReportServiceProxy;

    import com.neosavvy.user.util.RemoteObjectUtils;

    import flash.errors.IllegalOperationError;

    import mx.collections.ArrayCollection;
    import mx.rpc.events.FaultEvent;

    import mx.rpc.events.ResultEvent;

    import org.puremvc.as3.multicore.interfaces.INotification;

    public class FindProjectTypes extends ResponderAsyncCommand {

        private var projectType:ProjectType;

        override public function execute(notification:INotification):void {
            super.execute(notification);
            var expenseReportProxy:ExpenseReportServiceProxy = facade.retrieveProxy(ExpenseReportServiceProxy.NAME) as ExpenseReportServiceProxy;
            expenseReportProxy.findProjectTypes(this);
        }

        override protected function resultHandler(resultEvent:ResultEvent):void {
            var expenseReportProxy:ExpenseReportServiceProxy = facade.retrieveProxy(ExpenseReportServiceProxy.NAME) as ExpenseReportServiceProxy;
            expenseReportProxy.projectTypes = resultEvent.result as ArrayCollection;
            sendNotification(ApplicationFacade.FIND_PROJECT_TYPES_SUCCESS);
        }

        override protected function faultHandler(faultEvent:FaultEvent):void {
            RemoteObjectUtils.logRemoteServiceFault(faultEvent, LOGGER);
            sendNotification(ApplicationFacade.FIND_PROJECT_TYPES_FAILURE);
        }

    }
}