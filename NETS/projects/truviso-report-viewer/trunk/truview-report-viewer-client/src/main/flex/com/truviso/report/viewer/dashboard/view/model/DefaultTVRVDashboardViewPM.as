
/**
 * Created by IntelliJ IDEA.
 * User: adamparrish
 * Date: 5/2/11
 * Time: 3:45 PM
 */
package com.truviso.report.viewer.dashboard.view.model {
    import com.truviso.report.viewer.dashboard.view.*;
    import mx.collections.ArrayCollection;

    public class DefaultTVRVDashboardViewPM implements ITVRVDashboardViewPM {

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
            trace("onDomainPerformanceClicked()");
        }

        public function onVisitorSegmentsClicked():void {
            trace("onVisitorSegmentsClicked()");
        }
    }
}
