package com.neosavvy.grid {
    import flash.events.Event;

    import mx.controls.dataGridClasses.DataGridListData;

    public class AsyncRowEvent extends Event {

        public static const TYPE:String = "asyncRow";

        private var _data:Object;
        private var _listData:DataGridListData;

        public function AsyncRowEvent( data:Object, listData:DataGridListData ) {
            super(TYPE, true, false);
            _data = data;
            _listData = listData;
        }


        public function get data():Object {
            return _data;
        }

        public function set data(value:Object):void {
            _data = value;
        }

        public function get listData():DataGridListData {
            return _listData;
        }

        public function set listData(value:DataGridListData):void {
            _listData = value;
        }


    }
}