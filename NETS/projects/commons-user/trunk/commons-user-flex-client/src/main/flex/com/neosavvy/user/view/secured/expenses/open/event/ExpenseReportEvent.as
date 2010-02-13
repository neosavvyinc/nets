package com.neosavvy.user.view.secured.expenses.open.event {
    import com.neosavvy.user.dto.project.ExpenseReport;

    import flash.events.Event;

    public class ExpenseReportEvent extends Event {
        public static const TYPE:String = "expenseReportEvent";

        public static const ACTION_DELETE:String = "delete";
        public static const ACTION_EDIT:String = "edit";

        private var _expenseReport:ExpenseReport;
        private var _action:String;

        public function ExpenseReportEvent(action:String, object:ExpenseReport = null) {
            super(TYPE, true, false);
            _expenseReport = object;
            _action = action;
        }


        public function get expenseReport():ExpenseReport {
            return _expenseReport;
        }

        public function get action():String {
            return _action;
        }

    }
}