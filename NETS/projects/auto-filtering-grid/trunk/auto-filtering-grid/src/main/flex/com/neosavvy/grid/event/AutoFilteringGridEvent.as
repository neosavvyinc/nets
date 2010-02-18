package com.neosavvy.grid.event
{
    import flash.events.Event;

    public class AutoFilteringGridEvent extends Event
    {

        public static var HEADER_DROPDOWN_BUTTON_CLICKED:String = "headerButtonClicked";
        public static var COLUMNS_CHANGED:String = "autoFilterColumnsChanged";
        public static const FILTER_CHANGED:String = "autoFilterChanged";
        public static const RESET_FILTERS:String = "resetFilters";

        private var _filterItemAffected:String;

        public function AutoFilteringGridEvent(type:String, bubbles:Boolean = true, cancelable:Boolean = true)
        {
            super(type, bubbles, cancelable);
        }


        public function get filterItemAffected():String {
            return _filterItemAffected;
        }

        public function set filterItemAffected(value:String):void {
            _filterItemAffected = value;
        }
    }
}