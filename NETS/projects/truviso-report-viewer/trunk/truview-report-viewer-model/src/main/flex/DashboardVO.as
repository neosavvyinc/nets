
/**
 * Created by IntelliJ IDEA.
 * User: adamparrish
 * Date: 5/1/11
 * Time: 6:31 PM
 */
package {
    [Bindable]
    public class DashboardVO {

        private var _id : Number;

        private var _domain : String;

        private var _impressions : Number;

        private var _contentVolumn : Number;

        public function get id():Number {
            return _id;
        }

        public function set id(value:Number):void {
            _id = value;
        }

        public function get domain():String {
            return _domain;
        }

        public function set domain(value:String):void {
            _domain = value;
        }

        public function get impressions():Number {
            return _impressions;
        }

        public function set impressions(value:Number):void {
            _impressions = value;
        }

        public function get contentVolumn():Number {
            return _contentVolumn;
        }

        public function set contentVolumn(value:Number):void {
            _contentVolumn = value;
        }

        public function toString():String {
            return "DashboardVO{_id=" + String(_id)
                    + ",_domain=" + String(_domain)
                    + ",_impressions=" + String(_impressions)
                    + ",_contentVolumn=" + String(_contentVolumn) + "}";
        }
    }
}
