/**
 * Created by IntelliJ IDEA.
 * User: adamparrish
 * Date: 5/1/11
 * Time: 5:33 PM
 */
package com.truviso.report.viewer.dashboard.view.model {
    import mx.collections.ArrayCollection;

    public interface ITVRVDashboardViewPM {

        function get domainsDashboardData() : ArrayCollection;
        function set domainsDashboardData( value : ArrayCollection ) : void;
        
    }
}
