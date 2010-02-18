package {
    public class Skill {

        private var _id:Number;
        private var _name:String;

        public function get id():Number {
            return _id;
        }

        public function set id(value:Number):void {
            _id = value;
        }

        public function get name():String {
            return _name;
        }

        public function set name(value:String):void {
            _name = value;
        }


        public function Skill(id:Number, name:String) {
            _id = id;
            _name = name;
        }

        public function toString():String {
            return String(_name);
        }
    }
}