package com.neosavvy.user.view.secured.receipts {
    import com.adobe.serialization.json.JSON;
    import com.neosavvy.user.ApplicationFacade;
    import com.neosavvy.user.ProxyConstants;
    import com.neosavvy.user.dto.companyManagement.SecurityWrapperDTO;
    import com.neosavvy.user.dto.companyManagement.UserDTO;
    import com.neosavvy.user.dto.project.ExpenseItem;
    import com.neosavvy.user.dto.project.ExpenseReport;
    import com.neosavvy.user.model.ExpenseReportServiceProxy;
    import com.neosavvy.user.model.ProjectServiceProxy;
    import com.neosavvy.user.model.SecurityProxy;

    import com.neosavvy.user.util.StringUtils;

    import com.neosavvy.user.view.secured.expenses.report.popup.ReceiptView;

    import fineline.focal.common.types.v1.StorageServiceFileRef;

    import flash.display.DisplayObject;
    import flash.events.DataEvent;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.events.MouseEvent;

    import flash.net.FileReference;

    import flash.net.URLRequest;
    import flash.net.URLRequestHeader;

    import flash.net.URLRequestMethod;

    import mx.collections.ArrayCollection;
    import mx.controls.Button;
    import mx.controls.TileList;
    import mx.core.Application;
    import mx.core.IFlexDisplayObject;
    import mx.logging.ILogger;
    import mx.logging.Log;
    import mx.managers.PopUpManager;
    import mx.messaging.ChannelSet;
    import mx.messaging.channels.AMFChannel;
    import mx.rpc.Responder;
    import mx.rpc.events.FaultEvent;
    import mx.rpc.events.ResultEvent;

    import mx.rpc.remoting.mxml.RemoteObject;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.mediator.Mediator;

    public class ReceiptManagerMediator extends Mediator {

        private static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.view.secured.receipts.ReceiptManagerMediator");

        public static const NAME:String = "receiptManagerMediator";

        private var securityProxy : SecurityProxy
        private var _expenseReportProxy:ExpenseReportServiceProxy
        private var _projectProxy:ProjectServiceProxy;
        private var reference:FileReference;


        public function ReceiptManagerMediator( viewComponent : Object ) {
            super(NAME, viewComponent);
        }


        override public function listNotificationInterests():Array {
            return [
                ApplicationFacade.NAVIGATE_TO_MANAGE_RECEIPTS
                ,"receiptsRefreshed"
                ,ApplicationFacade.FIND_OPEN_EXPENSE_REPORTS_FOR_USER_SUCCESS
                ,ApplicationFacade.ADD_RECEIPT_TO_EXPENSE_REPORT_SUCCESS
                ,ApplicationFacade.GET_PROJECTS_FOR_USER_SUCCESS
            ];
        }

        public function get receiptManager():ReceiptManager
        {
            return viewComponent as ReceiptManager;
        }

        public function get receiptViewer():TileList
        {
            return receiptManager.receiptViewer;
        }

        public function get refreshButton():Button
        {
            return receiptManager.refreshReceipts;
        }

        public function get uploadReceiptButton():Button
        {
            return receiptManager.uploadReceipt;
        }

        override public function onRegister():void {
            super.onRegister();

            securityProxy = ApplicationFacade.getSecurityProxy();
            _expenseReportProxy = facade.retrieveProxy(ExpenseReportServiceProxy.NAME) as ExpenseReportServiceProxy;
            _projectProxy = facade.retrieveProxy(ProjectServiceProxy.NAME) as ProjectServiceProxy;

            receiptViewer.addEventListener( "reloadReceiptData", handleReloadReceiptData );
            refreshButton.addEventListener( MouseEvent.CLICK, handleReceiptRefresh );
            uploadReceiptButton.addEventListener( MouseEvent.CLICK, handleUploadReceipt );

            receiptViewer.addEventListener( AddReceiptToExpenseReportEvent.TYPE, onAddReceiptToExpenseReportEvent );
            receiptViewer.addEventListener( CreateExpenseReportAndAddRecentEvent.TYPE, onCreateExpenseReportAndAddReceiptEvent );
        }

        private function onCreateExpenseReportAndAddReceiptEvent(event:CreateExpenseReportAndAddRecentEvent):void {

            var newExpenseReportPanel:IFlexDisplayObject = PopUpManager.createPopUp( receiptManager, NewExpenseReportPanel, true );
            PopUpManager.centerPopUp( newExpenseReportPanel );
            var newExpenseReport:NewExpenseReportPanel = (newExpenseReportPanel as NewExpenseReportPanel);
            newExpenseReport.fileRef = event.fileRef;
            newExpenseReport.expenseReport = event.expenseReport;
            newExpenseReport.projects = _projectProxy.projects;;
            newExpenseReportPanel.addEventListener( AddReceiptToExpenseReportEvent.TYPE, onAddReceiptToExpenseReportEvent );
            
        }

        private function onAddReceiptToExpenseReportEvent(event:AddReceiptToExpenseReportEvent):void {

            sendNotification( ApplicationFacade.ADD_RECEIPT_TO_EXPENSE_REPORT_REQUEST, event );

        }

        private function handleReceiptRefresh(event:MouseEvent):void
        {
            refreshReceipts();
        }

        private function handleUploadReceipt(event:MouseEvent):void
        {
            reference = new FileReference();
            reference.addEventListener(Event.SELECT, selectHandler);
            reference.addEventListener(DataEvent.UPLOAD_COMPLETE_DATA, completeHandler);
            //reference.addEventListener(IOErrorEvent.IO_ERROR, ioErrorHandler);
            reference.browse();
        }

        private function selectHandler(event:Event):void {
            var instance:ApplicationFacade = ApplicationFacade.getInstance(ApplicationFacade.defaultApplicationKey);
            var securityProxy:SecurityProxy = instance.retrieveProxy(SecurityProxy.NAME) as SecurityProxy;
            var uploadUrl:String = ProxyConstants.getUrlForEnvironment() + "/nets/storage/file/receipts/?rabbitHole=" + securityProxy.sessionId;
            trace("Uploading to: " + uploadUrl);
            var request:URLRequest = new URLRequest(uploadUrl);
            request.method = URLRequestMethod.POST;
            request.requestHeaders = [new URLRequestHeader("ACCEPT", "text/xml")];

            reference.upload(request);
        }

        private function completeHandler(event:DataEvent):void {

            reference = null;
            var rawData:String = String(event.data);
            var storageFileRef : StorageServiceFileRef = createStorageServiceFileRef((JSON.decode(rawData)));
            var url:String = ProxyConstants.getUrlForEnvironment();
            var userService : RemoteObject = new RemoteObject("userService");
            var channelSet : ChannelSet = new ChannelSet();
            var channel:AMFChannel = new AMFChannel("user-amf");
            channel.url = url + ProxyConstants.expenseContextRoot + "/messagebroker/amf";
            channelSet.addChannel(channel);

            userService.channelSet = channelSet;
            userService.addEventListener(ResultEvent.RESULT, handleAssociationComplete );
            userService.addEventListener(FaultEvent.FAULT, handleAssociationFault );
            userService.associateReceiptUploadWithUser( securityProxy.activeUser , storageFileRef );

        }

        protected function handleAssociationComplete(event:ResultEvent):void
        {
            trace("Associated the receipt with a user...");
            refreshReceipts();
        }


        protected function handleAssociationFault(event:FaultEvent):void
        {
            trace("Failed to associate the receipt with a user...");
        }

        protected function createStorageServiceFileRef(parsedJsonObject:Object):StorageServiceFileRef {
            var fileRef:StorageServiceFileRef = new StorageServiceFileRef();
            fileRef.id = parsedJsonObject.id;
            fileRef.bucket = parsedJsonObject.bucket;
            fileRef.key = parsedJsonObject.key;
            fileRef.fileName = parsedJsonObject.fileName;
            fileRef.location = parsedJsonObject.location;
            fileRef.fileSize = parsedJsonObject["@fileSize"];
            fileRef.owner = parsedJsonObject.owner;
            fileRef.lastModifiedDate = StringUtils.parseXmlDateTime(parsedJsonObject["@lastModifiedDate"]);
            return fileRef;
        }



        private function refreshReceipts():void {
            var securityProxy:SecurityProxy = facade.retrieveProxy(SecurityProxy.NAME) as SecurityProxy;

            securityProxy.checkUserLoggedIn(new Responder(
                    function(result:ResultEvent):void {
                        securityProxy.setData(result.result as SecurityWrapperDTO);
                        sendNotification("receiptsRefreshed", securityProxy.user);
                    },
                    function (faultEvent:FaultEvent):void {
                        LOGGER.debug("refresh failed: " + faultEvent.fault.faultString);
                    }
                    ));
        }

        private function handleReloadReceiptData( event : Event ):void {

            refreshReceipts();

        }

        override public function onRemove():void {
            super.onRemove();

            securityProxy = null;
        }

        override public function handleNotification(notification:INotification):void {
            switch( notification.getName() )
            {
                case ApplicationFacade.ADD_RECEIPT_TO_EXPENSE_REPORT_SUCCESS:
                    refreshReceipts();
                    break;
                case "receiptsRefreshed":
                case ApplicationFacade.NAVIGATE_TO_MANAGE_RECEIPTS:
                    var activeUser : UserDTO = securityProxy.activeUser;
                    receiptViewer.dataProvider = activeUser.uncategorizedReceipts;
                    sendNotification(ApplicationFacade.FIND_OPEN_EXPENSE_REPORTS_FOR_USER_REQUEST, activeUser);
                    sendNotification(ApplicationFacade.GET_PROJECTS_FOR_USER_REQUEST, activeUser);
                    break;
                case ApplicationFacade.FIND_OPEN_EXPENSE_REPORTS_FOR_USER_SUCCESS:
                    var openExpenseReports:ArrayCollection = _expenseReportProxy.openExpenseReports;
                    var cloneOfOpenExpenseReport:ArrayCollection = new ArrayCollection();

                    for each ( var oer : ExpenseReport in openExpenseReports )
                    {
                        cloneOfOpenExpenseReport.addItem(oer);
                    }

                    var newExpenseReport : ExpenseReport = new ExpenseReport();
                    newExpenseReport.displayStringOverride = "Add To New...";
                    cloneOfOpenExpenseReport.addItemAt(newExpenseReport,0);
                    receiptManager.openExenseReports = cloneOfOpenExpenseReport;
                    receiptManager.receiptViewer.invalidateProperties();
                    break;
                case ApplicationFacade.GET_PROJECTS_FOR_USER_SUCCESS:
                    break;
            }
        }
    }
}