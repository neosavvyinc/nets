package com.neosavvy.user.controller {
    import com.neosavvy.user.ApplicationMediator;

    import com.neosavvy.user.controller.security.CheckLoggedIn;

    import mx.logging.Log;

    import mx.logging.LogEventLevel;

    import mx.logging.targets.TraceTarget;

    import org.puremvc.as3.multicore.interfaces.ICommand;
    import org.puremvc.as3.multicore.interfaces.INotification;
    import org.puremvc.as3.multicore.patterns.command.MacroCommand;
    import org.puremvc.as3.multicore.patterns.command.SimpleCommand;

    public class CommonsUserStartupCommand extends MacroCommand implements ICommand {

        override protected function initializeMacroCommand():void {
            initLogging();
            addSubCommand( ModelPrepCommand );
			addSubCommand( ViewPrepCommand );
        }

        private function initLogging():void {
            // Create a target.
            var logTarget:TraceTarget = new TraceTarget();

            // Log only messages for the classes in the mx.rpc.* and
            // mx.messaging packages.
            logTarget.filters=["*"];

            // Log all log levels.
            logTarget.level = LogEventLevel.DEBUG;

            // Add date, time, category, and log level to the output.
            logTarget.includeDate = true;
            logTarget.includeTime = true;
            logTarget.includeCategory = true;
            logTarget.includeLevel = true;

            // Begin logging.
            Log.addTarget(logTarget);
        }
    }
}