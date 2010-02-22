package
{
    public class State
    {
        private var _name:String;
        private var _abbreviation:String;
        private var _postalCode:String;
        private var _capital:String;
        private var _timeZone:String;
        private var _nullString:String;

        public function State(name:String, abbreviation:String, postalCode:String, capital:String, timeZone:String)
        {

            _name = name;
            _abbreviation = abbreviation;
            _capital = capital;
            _postalCode = postalCode;
            _timeZone = timeZone;
        }

        public function get name():String {
            return _name;
        }

        public function get abbreviation():String {
            return _abbreviation;
        }

        public function get capital():String {
            return _capital;
        }

        public function get postalCode():String {
            return _postalCode;
        }

        public function get timeZone():String {
            return _timeZone;
        }

        public function get nullString():String {
            return _nullString;
        }
    }
}