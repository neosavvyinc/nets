
package com.neosavvy.user.controller {
    import mx.events.ModuleEvent;
    import mx.modules.ModuleLoader;

    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

    public class LoadGraphicalAssets extends SimpleCommand {

        private static var loader:ModuleLoader;

        override public function execute(notification:INotification):void {

            loader = new ModuleLoader();
            loader.url = "./CommonsUserAssets.swf"
            loader.addEventListener(ModuleEvent.READY, handleModuleReady);
            loader.addEventListener(ModuleEvent.ERROR, handleModuleError);

            loader.loadModule();

            super.execute(notification);
        }

        private function handleModuleError(event:ModuleEvent):void {
            throw new Error("Failed to load graphical assets" + event.toString());
        }

        private function handleModuleReady(event:ModuleEvent):void {
            CommonsUserAssetsManager.assets = ICommonsUserAssets(event.module.factory.create());
        }
    }
}