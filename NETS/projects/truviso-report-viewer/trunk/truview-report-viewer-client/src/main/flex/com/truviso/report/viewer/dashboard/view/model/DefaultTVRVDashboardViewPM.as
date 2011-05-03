
/**
 * Created by IntelliJ IDEA.
 * User: adamparrish
 * Date: 5/2/11
 * Time: 3:45 PM
 */
package com.truviso.report.viewer.dashboard.view.model {
    import com.truviso.report.viewer.control.GetDomainPerformanceDataCommand;
    import com.truviso.report.viewer.dashboard.control.DomainPerformanceSelectedSignal;
    import com.truviso.report.viewer.dashboard.control.VisitorSegmentationSelectedSignal;
    import com.truviso.report.viewer.dashboard.view.*;

    import flash.events.Event;

    import mx.collections.ArrayCollection;

    import org.robotlegs.mvcs.Actor;

    public class DefaultTVRVDashboardViewPM implements ITVRVDashboardViewPM {

        [Inject]
        public var navigateToDomainPerformance : DomainPerformanceSelectedSignal;

        [Inject]
        public var navigateToVisitorSegmentation : VisitorSegmentationSelectedSignal;

        public function DefaultTVRVDashboardViewPM()
        {
            super();
        }

        private var _domainsDashboardData : ArrayCollection = new ArrayCollection();


        public function get domainsDashboardData():ArrayCollection {

            if( _domainsDashboardData.length == 0 )
            {
                _domainsDashboardData.addItem({contentVolume:"stuff",impressions:"stuff",domain:"stuff",coldata4:"stuff"});
            }

            return _domainsDashboardData;
        }

        [Bindable]
        public function set domainsDashboardData(value:ArrayCollection):void {
            _domainsDashboardData = value;
        }

        public function onDomainPerformanceClicked():void {
            navigateToDomainPerformance.dispatch();
        }

        public function onVisitorSegmentsClicked():void {
            navigateToVisitorSegmentation.dispatch();
        }
    }
}
