package com.neosavvy.grid.model {
    import mx.collections.ArrayCollection;

    [RemoteClass(alias="com.roundarch.grid.model.GridFilterModels")]
    public class GridFilterModels {

        private var _gridFilterModels:ArrayCollection = new ArrayCollection();

        public function get gridFilterModels():Array {
            return _gridFilterModels.toArray();
        }

        public function set gridFilterModels(value:Array):void {
            _gridFilterModels = new ArrayCollection(value);
        }

        public function addGridFilterModel(gridFilterModel:GridFilterModel):void {
            _gridFilterModels.addItem(gridFilterModel);
        }

        public function saveOrUpdateGridFilterModel(gridFilterModel:GridFilterModel):void {
            for each (var gfm:GridFilterModel in _gridFilterModels) {
                if (!gfm) {
                    continue;
                }
                if (gfm.columnName == gridFilterModel.columnName) {
                    _gridFilterModels.setItemAt(gridFilterModel, _gridFilterModels.getItemIndex(gfm));
                    return;
                }
            }

            //must be a new save since it wasn't found yet
            addGridFilterModel(gridFilterModel);
        }
    }
}