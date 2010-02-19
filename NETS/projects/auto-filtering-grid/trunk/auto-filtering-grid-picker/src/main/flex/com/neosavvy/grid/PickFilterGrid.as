package com.neosavvy.grid{
    import com.neosavvy.grid.event.PickFilterGridEvent;
    import com.neosavvy.grid.renderer.CenteredCheckBoxItemRenderer;

    import mx.collections.ArrayCollection;
    import mx.collections.Sort;
    import mx.collections.SortField;
    import mx.core.ClassFactory;

    public class PickFilterGrid extends AutoFilteringGrid {


        override protected function commitProperties():void {

            addEventListener(PickFilterGridEvent.ITEM_SELECTED, handleItemSelected);
            setDefaultSort();
            super.commitProperties();
        }



        /**
         * This value is used to help the selection checkbox column
         * know which value to retrieve from the proxied data set.
         *
         * By default selected is added to the data set, but if there
         * is some other value coming back from the database it can be
         * used instead
         */
        private var _selectedColumnDatafield:String = "selected";

        /**
         * If the default of "Sel" is not what the user wants to display
         * to the users one can override this property
         */
        private var _selectedColumnHeaderText:String = "Sel";

        public function PickFilterGrid() {
            super();
        }

        override public function set dataProvider( value:Object):void {
            var arrayCollection:ArrayCollection = new ArrayCollection();
            for each ( var obj:Object in value ) {
                arrayCollection.addItem(new PickFilterRow(false, obj))
            }
            super.dataProvider = arrayCollection;
        }

        /***
         *
         * This method will always add the select column with
         * a CenteredCheckBoxItemRenderer to the front of the columns
         * array
         *
         * <grid:AutoFilteringGridColumn
         *    enabledByDefault="true"
         *    autoFilterEnabled="false"
         *    dataField="selected"
         *    headerText="Sel"
         *    itemRenderer="com.neosavvy.grid.renderer.CenteredCheckBoxItemRenderer"
         *    removable="false"/>
         * @param value
         */
        override public function set columns( value:Array ):void {

            var selectColumn:AutoFilteringGridColumn = new AutoFilteringGridColumn();
            selectColumn.enabledByDefault = true;
            selectColumn.autoFilterEnabled = false;
            selectColumn.dataField = _selectedColumnDatafield;
            selectColumn.headerText = _selectedColumnHeaderText;
            selectColumn.itemRenderer = new ClassFactory(CenteredCheckBoxItemRenderer);
            selectColumn.removable = false;

            value.splice(0,0,selectColumn);

            super.columns = value;

        }

        override public function resetFilters():void
        {
            super.resetFilters();
            setDefaultSort();
        }

        public function setDefaultSort():void {
            var sort:Sort = new Sort();
            var sortField:SortField = new SortField();
            sortField.name = _selectedColumnDatafield;
            sortField.descending = true;

            var sortField1:SortField = new SortField();
            sortField1.name = getSecondarySortColumnName();
            sortField.descending = true;

            sort.fields = [sortField, sortField1];
            dataProvider.sort = sort;
            dataProvider.refresh();
        }

        override public function searchWrappedFilterFunction(item:Object):Boolean {

            var isItemSelected:Boolean = false;
            if( item.hasOwnProperty(_selectedColumnDatafield) ) {
                isItemSelected = item[_selectedColumnDatafield] as Boolean;
            }
            return super.filterFunction(item) || isItemSelected;
            
        }

        protected function getSecondarySortColumnName():String {

            var columns:Array = this.columns;
            for each ( var column:AutoFilteringGridColumn in columns ) {
                if ( column.dataField == _selectedColumnDatafield ) {
                    continue;
                }
                else {
                    return column.dataField;
                }
            }
            return "";
        }

        private var _selectedNonProxiedItems:ArrayCollection = new ArrayCollection();


        public function get selectedNonProxiedItems():ArrayCollection {
            return _selectedNonProxiedItems;
        }

        public function set selectedNonProxiedItems(value:ArrayCollection):void {
            _selectedNonProxiedItems = value;
        }

        protected function handleItemSelected(event:PickFilterGridEvent):void {

            if( event.pickFilterRow.selected )
            {
                _selectedNonProxiedItems.addItem(event.pickFilterRow.wrappedObject);
            }
            else
            {
                var index:int = _selectedNonProxiedItems.getItemIndex(event.pickFilterRow.wrappedObject);
                _selectedNonProxiedItems.removeItemAt(index);
            }

            setDefaultSort();
        }

        public function get selectedColumnDatafield():String {
            return _selectedColumnDatafield;
        }

        public function set selectedColumnDatafield(value:String):void {
            _selectedColumnDatafield = value;
        }


        public function get selectedColumnHeaderText():String {
            return _selectedColumnHeaderText;
        }

        public function set selectedColumnHeaderText(value:String):void {
            _selectedColumnHeaderText = value;
        }
    }
}