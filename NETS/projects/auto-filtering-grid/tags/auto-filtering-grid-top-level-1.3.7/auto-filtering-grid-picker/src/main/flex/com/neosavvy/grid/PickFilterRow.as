package com.neosavvy.grid {
    import flash.utils.describeType;

    import mx.collections.ListCollectionView;

    public dynamic class PickFilterRow {

        private var _selected:Boolean = false;

        private var _wrappedObject:Object;

        public function PickFilterRow( selected:Boolean , wrappedObject:Object, forceDescribeType:Boolean = false ) {

            _selected = selected;
            _wrappedObject = wrappedObject;

            proxyWrappedObject(wrappedObject);
        }

        public function get selected():Boolean {
            return _selected;
        }

        public function set selected(value:Boolean):void {
            _selected = value;
        }

        public function get wrappedObject():Object {
            return _wrappedObject;
        }

        protected static function getNonstaticAccessors(classOfInterest:Object):Array {
            var xmlDescriptionOfClass:XML = describeType(classOfInterest);
            var nonstaticAccessorsXML:XMLList = xmlDescriptionOfClass.accessor;

            var accessors:Array = [];
            for each (var accessorXML:XML in nonstaticAccessorsXML) {
                accessors.push(accessorXML.@name.toString());
            }
            return accessors;
        }

        protected function proxyWrappedObject(wrappedObject:Object):void {
            var accessorNames:Array = getNonstaticAccessors(wrappedObject);
            for each (var accessorName:String in accessorNames) {
                var accessorValue:Object = wrappedObject[accessorName];
//
//                if( accessorValue is ListCollectionView) {
//                    for each ( var value:Object in accessorValue ) {
//
//                    }
//                } else if ( accessorValue is Array ) {
//
//                } else {
                    this[accessorName] = accessorValue;
//                }
            }
        }
        
    }
}