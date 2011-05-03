/**
 * Created by IntelliJ IDEA.
 * User: adamparrish
 * Date: 5/3/11
 * Time: 4:16 PM
 */
package com.truviso.report.viewer.control {
    import org.robotlegs.mvcs.Command;

    public class GetVisitorSegmentationDataCommand extends Command {

        override public function execute():void {
            trace("visitor");
        }
    }
}
