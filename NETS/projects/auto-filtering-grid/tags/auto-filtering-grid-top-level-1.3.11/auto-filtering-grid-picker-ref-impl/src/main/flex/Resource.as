package {
    import mx.collections.ArrayCollection;

    public class Resource {

        private var _id:Number;
        private var _firstName:String;
        private var _lastName:String;
        private var _status:Status;
        private var _type:Type;
        private var _skills:ArrayCollection;


        public function get id():Number {
            return _id;
        }

        public function set id(value:Number):void {
            _id = value;
        }

        public function get firstName():String {
            return _firstName;
        }

        public function set firstName(value:String):void {
            _firstName = value;
        }

        public function get lastName():String {
            return _lastName;
        }

        public function set lastName(value:String):void {
            _lastName = value;
        }

        public function get status():Status {
            return _status;
        }

        public function set status(value:Status):void {
            _status = value;
        }

        public function get skills():ArrayCollection {
            return _skills;
        }

        public function set skills(value:ArrayCollection):void {
            _skills = value;
        }


        public function Resource(id:Number, firstName:String, lastName:String, status:Status, skills:ArrayCollection) {
            _id = id;
            _firstName = firstName;
            _lastName = lastName;
            _status = status;
            _skills = skills;
        }


        public function toString():String {
            return "Resource{_id=" + String(_id) + ",_firstName=" + String(_firstName) + ",_lastName=" + String(_lastName) + ",_status=" + String(_status) + ",_type=" + String(_type) + ",_skills=" + String(_skills) + "}";
        }
    }
}