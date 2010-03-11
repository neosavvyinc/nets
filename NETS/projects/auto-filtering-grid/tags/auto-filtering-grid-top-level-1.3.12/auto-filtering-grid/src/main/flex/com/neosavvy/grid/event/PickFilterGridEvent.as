package com.neosavvy.grid.event {
    import com.neosavvy.grid.PickFilterRow;

    import flash.events.Event;

    public class PickFilterGridEvent extends Event {

        public static const ITEM_SELECTED:String = "itemSelected";

        private var _pickFilterRow:PickFilterRow;

        public function PickFilterGridEvent(type:String, pickFilterRow:PickFilterRow = null) {
            super(type, true);
            _pickFilterRow = pickFilterRow;
        }


        public function get pickFilterRow():PickFilterRow {
            return _pickFilterRow;
        }

        public function set pickFilterRow(value:PickFilterRow):void {
            _pickFilterRow = value;
        }
    }
}