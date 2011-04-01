/*************************************************************************
 *
 * NEOSAVVY CONFIDENTIAL
 * __________________
 *
 *  Copyright 2008 - 2009 Neosavvy Incorporated
 *  All Rights Reserved.
 *
 * NOTICE:  All information contained herein is, and remains
 * the property of Neosavvy Incorporated and its suppliers,
 * if any.  The intellectual and technical concepts contained
 * herein are proprietary to Neosavvy Incorporated
 * and its suppliers and may be covered by U.S. and Foreign Patents,
 * patents in process, and are protected by trade secret or copyright law.
 * Dissemination of this information or reproduction of this material
 * is strictly forbidden unless prior written permission is obtained
 * from Neosavvy Incorporated.
 **************************************************************************/

/**
 * Created by IntelliJ IDEA.
 * User: adamparrish
 * Date: 11/15/10
 * Time: 10:03 PM
 */
package com.neosavvy.user.view.secured.receipts {
    import com.neosavvy.user.dto.project.ExpenseReport;

    import fineline.focal.common.types.v1.StorageServiceFileRef;

    import flash.events.Event;

    public class CreateExpenseReportAndAddRecentEvent extends Event{
        public static const TYPE:String = "createExpenseReportAndAddReceiptEvent";

        private var _expenseReport:ExpenseReport;
        private var _fileRef:StorageServiceFileRef;

        public function CreateExpenseReportAndAddRecentEvent( expenseReport : ExpenseReport, fileRef : StorageServiceFileRef)
        {
            super(TYPE, true, false);

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

        public override function toString():String {
            return super.toString() + "{_expenseReport=" + String(_expenseReport) + ",_fileRef=" + String(_fileRef) + "}";
        }
    }
}
