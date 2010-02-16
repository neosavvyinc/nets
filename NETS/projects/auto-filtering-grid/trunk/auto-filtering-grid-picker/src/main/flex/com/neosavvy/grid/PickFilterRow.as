package com.neosavvy.grid {
    import flash.utils.describeType;

    public dynamic class PickFilterRow {

        private var _selected:Boolean = false;

        public function PickFilterRow( selected:Boolean , wrappedObject:Object, forceDescribeType:Boolean = false ) {

            _selected = selected;

            var accessorNames:Array = getNonstaticAccessors(wrappedObject);
            for each ( var accessorName:String in accessorNames ) {
                var accessorValue:Object = wrappedObject[accessorName];
                this[accessorName] = accessorValue;
            }

        }

        public function get selected():Boolean {
            return _selected;
        }

        public function set selected(value:Boolean):void {
            _selected = value;
        }

        public static function getNonstaticAccessors(classOfInterest:Object):Array {
            var xmlDescriptionOfClass:XML = describeType(classOfInterest);
            var nonstaticAccessorsXML:XMLList = xmlDescriptionOfClass.accessor;

            var accessors:Array = [];
            for each (var accessorXML:XML in nonstaticAccessorsXML) {
                accessors.push(accessorXML.@name.toString());
            }
            return accessors;
        }
        
    }
}