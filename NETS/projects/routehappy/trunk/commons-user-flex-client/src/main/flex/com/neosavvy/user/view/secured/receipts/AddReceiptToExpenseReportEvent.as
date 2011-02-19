/**
 * Created by IntelliJ IDEA.
 * User: adamparrish
 * Date: 11/14/10
 * Time: 8:02 PM
 *
 */
package com.neosavvy.user.view.secured.receipts {
    import com.neosavvy.user.dto.project.ExpenseReport;

    import fineline.focal.common.types.v1.StorageServiceFileRef;

    import flash.events.Event;

    public class AddReceiptToExpenseReportEvent extends Event{
        public static const TYPE:String = "addReceiptToExpenseReportEvent";

        private var _expenseReport : ExpenseReport;
        private var _fileRef : StorageServiceFileRef;

        public function AddReceiptToExpenseReportEvent( expenseReport : ExpenseReport, fileRef : StorageServiceFileRef ) {
            super( TYPE, true, false );

            _expenseReport = expenseReport;
            _fileRef = fileRef;
        }

        public function get expenseReport():ExpenseReport {
            return _expenseReport;
        }

        public function set expenseReport(value:ExpenseReport):void {
            _expenseReport = value;
        }

        public function get fileRef():StorageServiceFileRef {
            return _fileRef;
        }

        public function set fileRef(value:StorageServiceFileRef):void {
            _fileRef = value;
        }
    }
}
