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
 * @author adamparrish
 */
package com.neosavvy.user.controller.expenses.report.workflow {
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.controller.base.ResponderAsyncCommand;
    import com.neosavvy.user.model.ExpenseReportServiceProxy;
    import com.neosavvy.user.util.RemoteObjectUtils;

    import com.neosavvy.user.view.secured.receipts.AddReceiptToExpenseReportEvent;

    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;

    import org.puremvc.as3.multicore.interfaces.INotification;

    public class AddReceiptToExpenseReport extends ResponderAsyncCommand {

        override public function execute(notification:INotification):void {
            super.execute(notification);

            trace("adding receipt to expense report...");

            var event : AddReceiptToExpenseReportEvent = notification.getBody() as AddReceiptToExpenseReportEvent;

            sendNotification(ApplicationFacade.SHOW_PROGRESS_INDICATOR);

            var expenseReportProxy:ExpenseReportServiceProxy = facade.retrieveProxy(ExpenseReportServiceProxy.NAME) as ExpenseReportServiceProxy;

            expenseReportProxy.saveReceiptToExpenseReport( event.expenseReport, event.fileRef, this );
        }

        override protected function resultHandler(resultEvent:ResultEvent):void {
            sendNotification(ApplicationFacade.HIDE_PROGRESS_INDICATOR);
            sendNotification(ApplicationFacade.ADD_RECEIPT_TO_EXPENSE_REPORT_SUCCESS);
        }


        override protected function faultHandler(faultEvent:FaultEvent):void {
            RemoteObjectUtils.logRemoteServiceFault(faultEvent, LOGGER);
            sendNotification(ApplicationFacade.HIDE_PROGRESS_INDICATOR);
            sendNotification(ApplicationFacade.ADD_RECEIPT_TO_EXPENSE_REPORT_FAILED);
        }
    }
}
