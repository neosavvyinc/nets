package com.neosavvy.user.controller.base {
    import com.neosavvy.user.controller.base.popup.GenericErrorPopup;

    import flash.display.DisplayObject;

    import mx.core.Application;
    import mx.core.IFlexDisplayObject;
    import mx.managers.PopUpManager;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

    public class DisplayErrorCommand extends SimpleCommand {

        override public function execute(notification:INotification):void {
            var errorPopup : IFlexDisplayObject =
                    PopUpManager.createPopUp(Application.application as DisplayObject, GenericErrorPopup, true);
            PopUpManager.centerPopUp( errorPopup );
        }
    }
}