package com.neosavvy.grid{
    public class AsyncDataDTO {
        public function AsyncDataDTO() {
        }

        private var _requestingAsync:Boolean = false;

        private var _asyncRespColumn1:String = "data1";
        private var _asyncRespColumn2:String = "data2";
        private var _asyncRespColumn3:String = "data3";
        private var _asyncRespColumn4:String = "data4";
        private var _asyncRespColumn5:String = "data5";
        private var _asyncRespColumn6:String = "data6";
        private var _asyncRespColumn7:String = "data7";
        private var _asyncRespColumn8:String = "data8";
        private var _asyncRespColumn9:String = "data9";

        private var _asyncTrigger:String = "Click here to trigger";

        public function get requestingAsync():Boolean {
            return _requestingAsync;
        }

        public function set requestingAsync(value:Boolean):void {
            _requestingAsync = value;
        }

        public function get asyncRespColumn1():String {
            return _asyncRespColumn1;
        }

        public function set asyncRespColumn1(value:String):void {
            _asyncRespColumn1 = value;
        }

        public function get asyncRespColumn2():String {
            return _asyncRespColumn2;
        }

        public function set asyncRespColumn2(value:String):void {
            _asyncRespColumn2 = value;
        }

        public function get asyncRespColumn3():String {
            return _asyncRespColumn3;
        }

        public function set asyncRespColumn3(value:String):void {
            _asyncRespColumn3 = value;
        }

        public function get asyncRespColumn4():String {
            return _asyncRespColumn4;
        }

        public function set asyncRespColumn4(value:String):void {
            _asyncRespColumn4 = value;
        }

        public function get asyncRespColumn5():String {
            return _asyncRespColumn5;
        }

        public function set asyncRespColumn5(value:String):void {
            _asyncRespColumn5 = value;
        }

        public function get asyncRespColumn6():String {
            return _asyncRespColumn6;
        }

        public function set asyncRespColumn6(value:String):void {
            _asyncRespColumn6 = value;
        }

        public function get asyncRespColumn7():String {
            return _asyncRespColumn7;
        }

        public function set asyncRespColumn7(value:String):void {
            _asyncRespColumn7 = value;
        }

        public function get asyncRespColumn8():String {
            return _asyncRespColumn8;
        }

        public function set asyncRespColumn8(value:String):void {
            _asyncRespColumn8 = value;
        }

        public function get asyncRespColumn9():String {
            return _asyncRespColumn9;
        }

        public function set asyncRespColumn9(value:String):void {
            _asyncRespColumn9 = value;
        }

        public function get asyncTrigger():String {
            return _asyncTrigger;
        }

        public function set asyncTrigger(value:String):void {
            _asyncTrigger = value;
        }
    }
}