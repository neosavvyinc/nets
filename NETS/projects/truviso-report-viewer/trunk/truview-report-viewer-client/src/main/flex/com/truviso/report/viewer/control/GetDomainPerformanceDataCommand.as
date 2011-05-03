/**
 * Created by IntelliJ IDEA.
 * User: adamparrish
 * Date: 5/3/11
 * Time: 3:08 PM
 */
package com.truviso.report.viewer.control {
    import org.robotlegs.mvcs.Command;

    public class GetDomainPerformanceDataCommand extends Command {

        override public function execute():void {
            trace("executing signal");
        }
        
    }
}
