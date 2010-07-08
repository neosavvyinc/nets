package com.neosavvy.grid {
    import flash.errors.IllegalOperationError;

    import flash.events.EventDispatcher;

    import flash.events.IEventDispatcher;

    import mx.collections.ArrayCollection;
    import mx.events.CollectionEvent;
    import mx.events.PropertyChangeEvent;

    public class AsyncGridDataModel extends EventDispatcher {

        public function AsyncGridDataModel( se : SingletonEnforcer ) {

            if(se == null)
            {
                throw new IllegalOperationError("Cannot instantiate the AsyncGridDataModel - it is a singleton");
            }


        }

        public static function getInstance():AsyncGridDataModel
        {

            if( !_instance )
            {
                _instance = new AsyncGridDataModel( new SingletonEnforcer() );
            }

            return _instance;
        }

        private static var _instance:AsyncGridDataModel;


        [Bindable]
        public var gridData:ArrayCollection = new ArrayCollection();

        public function populateFakeData():void {

            this.gridData.addItem(new AsyncDataDTO());
            this.gridData.addItem(new AsyncDataDTO());
            this.gridData.addItem(new AsyncDataDTO());
            this.gridData.addItem(new AsyncDataDTO());
            this.gridData.addItem(new AsyncDataDTO());
            this.gridData.addItem(new AsyncDataDTO());
            this.gridData.addItem(new AsyncDataDTO());
            this.gridData.addItem(new AsyncDataDTO());
            this.gridData.addItem(new AsyncDataDTO());
            this.gridData.addItem(new AsyncDataDTO());
            this.gridData.addItem(new AsyncDataDTO());
            this.gridData.addItem(new AsyncDataDTO());
            this.gridData.addItem(new AsyncDataDTO());
            this.gridData.addItem(new AsyncDataDTO());
            this.gridData.addItem(new AsyncDataDTO());
            this.gridData.addItem(new AsyncDataDTO());
            this.gridData.addItem(new AsyncDataDTO());
            this.gridData.addItem(new AsyncDataDTO());
            this.gridData.addItem(new AsyncDataDTO());
            this.gridData.addItem(new AsyncDataDTO());
            this.gridData.addItem(new AsyncDataDTO());
            this.gridData.addItem(new AsyncDataDTO());
            this.gridData.addItem(new AsyncDataDTO());
            this.gridData.addItem(new AsyncDataDTO());
            this.gridData.addItem(new AsyncDataDTO());
            this.gridData.addItem(new AsyncDataDTO());
            this.gridData.addItem(new AsyncDataDTO());
            this.gridData.addItem(new AsyncDataDTO());
            this.gridData.addItem(new AsyncDataDTO());
            this.gridData.addItem(new AsyncDataDTO());
            this.gridData.addItem(new AsyncDataDTO());
            this.gridData.addItem(new AsyncDataDTO());
            this.gridData.addItem(new AsyncDataDTO());
            this.gridData.addItem(new AsyncDataDTO());
            this.gridData.addItem(new AsyncDataDTO());
            this.gridData.addItem(new AsyncDataDTO());
            this.gridData.addItem(new AsyncDataDTO());
            this.gridData.addItem(new AsyncDataDTO());
            this.gridData.addItem(new AsyncDataDTO());
            this.gridData.addItem(new AsyncDataDTO());
            this.gridData.addItem(new AsyncDataDTO());
            this.gridData.addItem(new AsyncDataDTO());
            this.gridData.addItem(new AsyncDataDTO());
            this.gridData.addItem(new AsyncDataDTO());
            this.gridData.addItem(new AsyncDataDTO());
            this.gridData.addItem(new AsyncDataDTO());
            this.gridData.addItem(new AsyncDataDTO());
            this.gridData.addItem(new AsyncDataDTO());
            this.gridData.addItem(new AsyncDataDTO());
            this.gridData.addItem(new AsyncDataDTO());
            this.gridData.addItem(new AsyncDataDTO());
            this.gridData.addItem(new AsyncDataDTO());
            this.gridData.addItem(new AsyncDataDTO());
            this.gridData.addItem(new AsyncDataDTO());
            this.gridData.addItem(new AsyncDataDTO());
            this.gridData.addItem(new AsyncDataDTO());
            this.gridData.addItem(new AsyncDataDTO());
            this.gridData.addItem(new AsyncDataDTO());
            this.gridData.addItem(new AsyncDataDTO());
            this.gridData.addItem(new AsyncDataDTO());
            this.gridData.addItem(new AsyncDataDTO());
            this.gridData.addItem(new AsyncDataDTO());
            this.gridData.addItem(new AsyncDataDTO());
            this.gridData.addItem(new AsyncDataDTO());
            this.gridData.addItem(new AsyncDataDTO());
            this.gridData.addItem(new AsyncDataDTO());
            this.gridData.addItem(new AsyncDataDTO());
            this.gridData.addItem(new AsyncDataDTO());






        }

        public static function copyArrayCollection(src : ArrayCollection) : ArrayCollection
		{
			var rv : ArrayCollection = new ArrayCollection();
			for each (var o : Object in src)
			{
				rv.addItem(o);
			}
			return rv;
		}

    }
}

class SingletonEnforcer {}