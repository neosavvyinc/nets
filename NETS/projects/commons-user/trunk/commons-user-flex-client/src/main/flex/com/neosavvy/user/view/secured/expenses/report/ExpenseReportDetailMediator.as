package com.neosavvy.user.view.secured.expenses.report {
    import com.neosavvy.user.view.secured.expenses.approved.*;
    import com.neosavvy.user.view.secured.projectManagement.assignments.*;
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.dto.project.Project;
    import com.neosavvy.user.model.CompanyServiceProxy;
    import com.neosavvy.user.model.ProjectServiceProxy;
    import com.neosavvy.user.view.secured.projectManagement.*;

    import flash.events.MouseEvent;

    import mx.collections.ArrayCollection;
    import mx.containers.Form;
    import mx.controls.AdvancedDataGrid;
    import mx.controls.Button;
    import mx.controls.ComboBox;
    import mx.controls.List;
    import mx.logging.ILogger;
    import mx.logging.Log;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.mediator.Mediator;

    public class ExpenseReportDetailMediator extends Mediator {
        private static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.view.secured.expenses.report.ExpenseReportDetail");

        public static const NAME:String = "expenseReportDetailMediator";

        private var _projectProxy:ProjectServiceProxy;

        public function ExpenseReportDetailMediator(viewComponent:Object) {
            super(NAME, viewComponent);
        }

        override public function onRegister():void {
            _projectProxy = facade.retrieveProxy(ProjectServiceProxy.NAME) as ProjectServiceProxy;
        }

        override public function onRemove():void {
            _projectProxy = null;
        }

        public function get expenseReportDetail():ExpenseReportDetail {
            return viewComponent as ExpenseReportDetail;
        }

        public function get expenseReportSummaryForm():Form {
            return expenseReportDetail.expenseReportSummaryForm;
        }

        public function get expenseItemGrid():AdvancedDataGrid {
            return expenseReportDetail.expenseReportGrid;
        }

        public function get expenseItemEntryForm():Form {
            return expenseReportDetail.expenseItemEntryForm;
        }

        override public function listNotificationInterests():Array {
            return [
                ApplicationFacade.NAVIGATE_TO_CREATE_EXPENSE_REPORT
                ,ApplicationFacade.GET_PROJECTS_FOR_USER_SUCCESS
            ];
        }

        override public function handleNotification(notification:INotification):void {
            switch(notification.getName()) {
                case ApplicationFacade.NAVIGATE_TO_CREATE_EXPENSE_REPORT:
                    sendNotification(ApplicationFacade.INITIALIZE_EXPENSE_REPORT_VIEW);
                    break;
                case ApplicationFacade.GET_PROJECTS_FOR_USER_SUCCESS:
                    expenseReportDetail.availableProjectsCmb.dataProvider = _projectProxy.projects;
                    break;
            }
        }

    }
}