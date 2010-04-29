package com.neosavvy.user.view.secured.progress {
    import com.neosavvy.user.ApplicationFacade;

    import flash.display.DisplayObject;

    import mx.controls.ProgressBar;
    import mx.controls.ProgressBarMode;
    import mx.core.Application;
    import mx.logging.ILogger;
    import mx.logging.Log;
    import mx.managers.PopUpManager;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.mediator.Mediator;

    public class ProgressBarMediator extends Mediator {

        private static var LOGGER:ILogger = Log.getLogger("com.neosavvy.user.view.secured.progress.ProgressBarMediator");

        public static const NAME:String = "progressBarMediator";


        public function ProgressBarMediator(viewComponent:Object) {
            super(NAME, viewComponent);
        }

        public function get progressBar():ProgressBar {
            return viewComponent as ProgressBar;
        }

        public function set progressBar(value:ProgressBar):void {
            this.viewComponent = value;
        }

        private function showLoading():void
        {
            if( _progressBar == null ) {
                var _progressBar:ProgressBar = new ProgressBar();
                _progressBar.width = 200;
                _progressBar.indeterminate = true;
                _progressBar.labelPlacement = 'center';
                //                progressBar.setStyle("removedEffect", fade);
                //                progressBar.setStyle("addedEffect", fade);
                _progressBar.label = "";
                _progressBar.mode = ProgressBarMode.MANUAL;
                this.progressBar = _progressBar;
                PopUpManager.addPopUp(_progressBar, Application.application as DisplayObject, true);
                PopUpManager.centerPopUp(_progressBar);
                _progressBar.setProgress(0, 0);
            }
        }

        private function hideLoading():void {

            PopUpManager.removePopUp(progressBar);
            this.progressBar = null;

        }


        override public function listNotificationInterests():Array {
            return [
                ApplicationFacade.SHOW_PROGRESS_INDICATOR
                ,ApplicationFacade.UPDATE_PROGRESS_INDICATOR
                ,ApplicationFacade.HIDE_PROGRESS_INDICATOR

            ];
        }

        override public function handleNotification(notification:INotification):void {
            switch (notification.getName()) {
                case ApplicationFacade.SHOW_PROGRESS_INDICATOR:
                    showLoading();
                    break;
                case ApplicationFacade.HIDE_PROGRESS_INDICATOR:
                    hideLoading();
                    break;
            }
        }


    }
}