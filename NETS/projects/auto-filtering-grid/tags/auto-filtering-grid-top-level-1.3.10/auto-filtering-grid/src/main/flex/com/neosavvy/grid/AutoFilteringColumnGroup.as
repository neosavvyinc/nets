package com.neosavvy.grid {
    import mx.controls.advancedDataGridClasses.AdvancedDataGridColumnGroup;

    public class AutoFilteringColumnGroup extends AdvancedDataGridColumnGroup{

        private var _removable:Boolean = true;

        private var _enabledByDefault:Boolean = false;

        private var _enabled:Boolean = false;

        public function get removable():Boolean {
            return _removable;
        }

        public function set removable(value:Boolean):void {
            _enabledByDefault = true;
            _removable = value;
        }

        public function get enabledByDefault():Boolean {
            if (!removable) {
                _enabledByDefault = true;
            }
            return _enabledByDefault;
        }

        public function set enabledByDefault(value:Boolean):void {
            _enabledByDefault = value;
        }

        public function get enabled():Boolean {
            return _enabled;
        }

        public function set enabled(value:Boolean):void {
            _enabled = value;
        }
    }
}