/**
 * Created by IntelliJ IDEA.
 * User: adamparrish
 * Date: 5/1/11
 * Time: 5:31 PM
 */
package {
    import com.truviso.report.viewer.control.GetDomainPerformanceDataCommand;
    import com.truviso.report.viewer.control.GetVisitorSegmentationDataCommand;
    import com.truviso.report.viewer.dashboard.control.DomainPerformanceSelectedSignal;
    import com.truviso.report.viewer.dashboard.control.VisitorSegmentationSelectedSignal;
    import com.truviso.report.viewer.dashboard.view.model.DefaultTVRVDashboardViewPM;
    import com.truviso.report.viewer.dashboard.view.model.ITVRVDashboardViewPM;

    import com.truviso.report.viewer.dashboard.view.model.TVRVDasboardViewMediator;
    import com.truviso.report.viewer.dashboard.view.TVRVDashboardView;

    import org.robotlegs.mvcs.Context;
    import org.robotlegs.mvcs.SignalContext;

    public class TVReportViewerContext extends SignalContext {

        override public function startup():void {
            super.startup();

            signalCommandMap.mapSignalClass(DomainPerformanceSelectedSignal, GetDomainPerformanceDataCommand);
            signalCommandMap.mapSignalClass(VisitorSegmentationSelectedSignal, GetVisitorSegmentationDataCommand);

            injector.mapSingletonOf(ITVRVDashboardViewPM, DefaultTVRVDashboardViewPM, "defaultTVRVDashboardViewPM");

            viewMap.mapPackage( "com.truviso.report.viewer.dashboard.view" );


        }
        
    }
}
