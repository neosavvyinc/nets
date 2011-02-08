package com.neosavvy.user.view.secured.expenses.approving.event {
    import com.neosavvy.user.dto.project.ExpenseReport;

    import flash.events.Event;

    public class ExpenseReportApproveEvent extends Event {
        public static const TYPE:String = "expenseItemEvent";

        public static const ACTION_VIEW:String = "view";
        public static const ACTION_DECLINE_REQUEST:String = "declineRequest";
        public static const ACTION_APPROVE_REQUEST:String = "approveRequest";

        public static const ACTION_DECLINE_CONFIRM:String = "declineConfirmed";
        public static const ACTION_APPROVE_CONFIRM:String = "approveConfirmed";

        private var _expenseReport:ExpenseReport;
        private var _action:String;
        private var _note:String;

        public function ExpenseReportApproveEvent(action:String, report:ExpenseReport, note:String = null) {
            super(TYPE, true, false);

            _expenseReport = report;
            _action = action;
            _note = note;
        }

        public function get expenseReport():ExpenseReport {
            return _expenseReport;
        }

        public function get action():String {
            return _action;
        }

        public function get note():String {
            return _note;
        }
    }
}