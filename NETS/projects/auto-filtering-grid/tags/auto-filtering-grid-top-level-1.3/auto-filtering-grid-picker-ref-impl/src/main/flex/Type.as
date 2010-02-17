package {
    public class Type {
        public static const EMPLOYEE:Status = new Status("Employee");
        public static const CONTRACTOR:Status = new Status("Contractor");

        private var _value:String;

        function Type(value:String = "unset") {
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

        public function equals(other:Type):Boolean {
            return value == other.value;
        }

        protected function getConstants():Array {
            return constants;
        }

        public static function get constants():Array {
            return [EMPLOYEE, CONTRACTOR];
        }
    }
}