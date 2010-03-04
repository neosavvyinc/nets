package {
    public class County {

        private var _name:String;
        private var _population:Number;

        public function County(name:String, population:Number = 0) {

            _name = name;
            _population = population;
            
        }


        public function get name():String {
            return _name;
        }

        public function set name(value:String):void {
            _name = value;
        }

        public function get population():Number {
            return _population;
        }

        public function set population(value:Number):void {
            _population = value;
        }
    }


}