package {
    public class Status {

        public static const ACTIVE:Status = new Status("Active");
        public static const INACTIVE:Status = new Status("Inactive");
        public static const NEW:Status = new Status("New");

        private var _value:String;

        function Status(value:String = "unset") {
            _value = value;
        }

        public function set value(value:String):void {
            _value = value;
        }

        public function get value():String {
            return _value;
        }

        public function toString():String {
            return value;
        }

        public function equals(other:Status):Boolean {
            return value == other.value;
        }

        protected function getConstants():Array {
            return constants;
        }

        public static function get constants():Array {
            return [ACTIVE, INACTIVE, NEW];
        }
    }
}