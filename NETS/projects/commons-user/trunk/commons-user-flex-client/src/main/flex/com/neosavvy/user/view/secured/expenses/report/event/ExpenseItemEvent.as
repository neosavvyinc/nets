package com.neosavvy.user.view.secured.expenses.report.event {
    import com.neosavvy.user.dto.project.ExpenseItem;

    import flash.events.Event;

    public class ExpenseItemEvent extends Event {
        public static const TYPE:String = "expenseItemEvent";

        public static const ACTION_DELETE:String = "delete";
        public static const ACTION_EDIT:String = "edit";

        private var _expenseItem:ExpenseItem;
        private var _action:String;

        public function ExpenseItemEvent(action:String, object:ExpenseItem) {
            super(TYPE, true, false);
            _expenseItem = object;
            _action = action;
        }


        public function get expenseItem():ExpenseItem {
            return _expenseItem;
        }

        public function get action():String {
            return _action;
        }

    }
}