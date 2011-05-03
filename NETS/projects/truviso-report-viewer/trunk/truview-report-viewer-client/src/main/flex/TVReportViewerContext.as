/**
 * Created by IntelliJ IDEA.
 * User: adamparrish
 * Date: 5/1/11
 * Time: 5:31 PM
 */
package {
    import com.truviso.report.viewer.dashboard.view.model.DefaultTVRVDashboardViewPM;
    import com.truviso.report.viewer.dashboard.view.model.ITVRVDashboardViewPM;

    import com.truviso.report.viewer.dashboard.view.model.TVRVDasboardViewMediator;
    import com.truviso.report.viewer.dashboard.view.TVRVDashboardView;

    import org.robotlegs.mvcs.Context;

    public class TVReportViewerContext extends Context {

        override public function startup():void {
            super.startup();

            injector.mapSingletonOf(ITVRVDashboardViewPM, DefaultTVRVDashboardViewPM, "defaultTVRVDashboardViewPM");

            viewMap.mapPackage( "com.truviso.report.viewer.dashboard.view" );

        }
        
    }
}
