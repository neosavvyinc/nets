package com.neosavvy.grid.popup
{
import com.neosavvy.grid.AutoFilteringGrid;
import com.neosavvy.grid.model.AutoFilteringDropdownVO;
import com.neosavvy.grid.model.GridFilterModel;
import com.neosavvy.grid.renderer.AutoFilteringGridColumnCheckboxRenderer;

import flash.events.MouseEvent;

import mx.collections.ArrayCollection;
import mx.collections.Sort;
import mx.collections.SortField;
import mx.containers.HBox;
import mx.containers.VBox;
import mx.controls.Button;
import mx.controls.Label;
import mx.controls.List;
import mx.controls.advancedDataGridClasses.AdvancedDataGridListData;
import mx.core.ClassFactory;
import mx.core.IFactory;
import mx.events.CloseEvent;
import mx.events.CollectionEvent;
import mx.events.FlexMouseEvent;
import mx.events.ListEvent;
import mx.events.ScrollEvent;

public class FilterSelectorDropdown extends VBox
{
    private var _label:Label;

    private var _showAllButton:Button;

    private var bListChanged:Boolean = true;
    private var _list:List;

    private var _buttonContainer:HBox;
    private var _okButton:Button;
    private var _cancelButton:Button;

    private var bFilterValuesChanged:Boolean = false;
    private var _filterValues:ArrayCollection;

    private var _rollbackFilterValues:ArrayCollection;

    private var bGridChanged:Boolean = false;
    private var _grid:AutoFilteringGrid;

    private var bListDataChanged:Boolean = false;
    private var _adgListData:AdvancedDataGridListData;

    private var _selectedFilters:Array = new Array();

    private var bGridFilterModelChanged:Boolean = false;
    private var _gridFilterModel:GridFilterModel;

    public static const FACTORY:IFactory = new ClassFactory(FilterSelectorDropdown);

    public function FilterSelectorDropdown() {
        setStyle("backgroundColor", 0xFFFFFF);
        setStyle("borderStyle", "solid");
        setStyle("borderThickness", 1);
        setStyle("paddingTop", 10);
        setStyle("paddingLeft", 10);
        setStyle("paddingRight", 10);
        setStyle("paddingBottom", 10);
        styleName = "filterSelectorDropdown";
        this.addEventListener(FlexMouseEvent.MOUSE_DOWN_OUTSIDE, cancelClickHandler);
        this.addEventListener(ScrollEvent.SCROLL, cancelClickHandler);

    }

    override protected function commitProperties():void {
        super.commitProperties();

        if (_label) {
            _label.text = "Filter By...";
        }

        if (_showAllButton) {
            _showAllButton.label = "Show All";
            _showAllButton.addEventListener(MouseEvent.CLICK, showAllClickHandler);
        }

        if (_okButton) {
            _okButton.label = "Ok";
            _okButton.addEventListener(MouseEvent.CLICK, okClickHandler);
        }

        if (_cancelButton) {
            _cancelButton.label = "Cancel";
            _cancelButton.addEventListener(MouseEvent.CLICK, cancelClickHandler);
        }

        if (bFilterValuesChanged) {
            _list.dataProvider = _filterValues;
            bFilterValuesChanged = false;
        }

        if (bListDataChanged && bGridChanged) {
            calculateUniqueFilterValues();
            refreshRollbackFilterValues();
            bGridChanged = bListChanged = false;
        }

        if (bFilterValuesChanged) {
            _list.dataProvider = _filterValues;
            refreshRollbackFilterValues();
            bFilterValuesChanged = false;
        }

    }

    override protected function createChildren():void {
        super.createChildren();

        if (!_label) {
            _label = new Label();
            addChild(_label);
        }

        if (!_showAllButton) {
            _showAllButton = new Button();
            addChild(_showAllButton);
        }

        if (!_list) {
            _list = new List();
            /**
             * TODO: This should be extracted into a property so it can be easily set.
             */
            _list.labelField = "displayValue";
            _list.itemRenderer = new ClassFactory(AutoFilteringGridColumnCheckboxRenderer);
            addChild(_list);
        }

        if (!_buttonContainer) {
            _buttonContainer = new HBox();
            _buttonContainer.percentWidth = 100;
            addChild(_buttonContainer)
            if (!_okButton) {
                _okButton = new Button();
                _buttonContainer.addChild(_okButton);
            }

            if (!_cancelButton) {
                _cancelButton = new Button();
                _buttonContainer.addChild(_cancelButton);
            }
        }
    }

    override protected function measure():void {
        super.measure();

        this.measuredMinHeight = this.minHeight = 5 * 36;
        this.measuredMinWidth = this.minWidth = 100;

    }

    override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
        super.updateDisplayList(unscaledWidth, unscaledHeight);

        if (_list) {
            _list.width = 150;
        }
    }


    public function set filterValues(filterValues:ArrayCollection):void {
        bFilterValuesChanged = true;
        _filterValues = filterValues
        invalidateProperties();
        dispatchEvent(new CollectionEvent(CollectionEvent.COLLECTION_CHANGE));
    }

    public function get filterValues():ArrayCollection {
        return _filterValues;
    }

    public function set rollbackFilterValues(rollbackFilterValues:ArrayCollection):void {
        this._rollbackFilterValues = rollbackFilterValues;
    }

    public function get rollbackFilterValues():ArrayCollection {
        return _rollbackFilterValues;
    }

    public function set grid(grid:AutoFilteringGrid):void {
        _grid = grid;
        bGridChanged = true;
    }

    public function set listData(listData:AdvancedDataGridListData):void {
        _adgListData = listData;
        bListDataChanged = true;
    }

    public function get selectedFilters():Array {
        return _selectedFilters;
    }

    public function get gridFilterModel():GridFilterModel {
        return _gridFilterModel;
    }

    public function set gridFilterModel( gridFilterModel:GridFilterModel ):void {
        _gridFilterModel = gridFilterModel;
        bGridFilterModelChanged = true;
    }

    protected function calculateUniqueFilterValues():void {
        if (!_filterValues) {
            var uniqueFilterValueMap:Object = new Object();

            for each (var object:Object in (_grid.dataProvider as ArrayCollection).source) {

                if (object.hasOwnProperty(_adgListData.dataField)) {
                    var valueFromObject:Object = object[_adgListData.dataField];

                    if ( valueFromObject is String )
                    {
                        uniqueFilterValueMap[valueFromObject] = valueFromObject;
                    }
                    else if ( valueFromObject is ArrayCollection )
                    {
                        for each ( var valueFromArrayCollection:Object in valueFromObject ) {
                            uniqueFilterValueMap[valueFromArrayCollection.toString()] = valueFromArrayCollection.toString();
                        }
                    }
                }

            }
            var activeFilters:Object = _grid.getActiveFilters(_adgListData.dataField);

            /**
             * This holds the actual unique values that are displayed
             */
            var uniqueCollection:ArrayCollection = new ArrayCollection();

            for each (var fv:Object in uniqueFilterValueMap) {

                if ( fv is String )
                {
                    var isFilterActiveInGrid:Boolean = activeFilters.hasOwnProperty(fv)
                    var fvVO:AutoFilteringDropdownVO = new AutoFilteringDropdownVO(fv as String, isFilterActiveInGrid);
                    uniqueCollection.addItem(fvVO);
                }
            }

            sortCollectionOnField(uniqueCollection, ["displayValue"]);
            this.filterValues = uniqueCollection;
        }
    }

    protected function refreshRollbackFilterValues():void {
        if (!_filterValues) {
            var uniqueFilterValueMap:Object = new Object();
            var copyOfGridDataProvider:ArrayCollection = new ArrayCollection((_grid.dataProvider as ArrayCollection).toArray());
            for each (var object:Object in _grid.dataProvider) {

                if (object.hasOwnProperty(_adgListData.dataField)) {
                    var valueFromObject:Object = object[_adgListData.dataField];
                    uniqueFilterValueMap[valueFromObject] = valueFromObject;
                }

            }

            var rollbackCollection:ArrayCollection = new ArrayCollection();

            for each (var fv:Object in uniqueFilterValueMap) {
                var activeFilters:Object = _grid.getActiveFilters(_adgListData.dataField);
                var isFilterActiveInGrid:Boolean = activeFilters.hasOwnProperty(fv)
                var fvVOCopy:AutoFilteringDropdownVO = new AutoFilteringDropdownVO(fv as String, isFilterActiveInGrid);

                rollbackCollection.addItem(fvVOCopy);
            }


            sortCollectionOnField(rollbackCollection, ["displayValue"]);
            this.rollbackFilterValues = rollbackCollection;
        } else {

            var copyOfFilterValues:ArrayCollection = new ArrayCollection();
            for each (var afdVO:AutoFilteringDropdownVO in _filterValues) {
                var copyFv:AutoFilteringDropdownVO = new AutoFilteringDropdownVO(afdVO.displayValue, afdVO.enabled);
                copyOfFilterValues.addItem(copyFv);
            }

            sortCollectionOnField(copyOfFilterValues, ["displayValue"]);
            this.rollbackFilterValues = copyOfFilterValues;


        }
    }

    protected function sortCollectionOnField(collection:ArrayCollection, fields:Array):void {
        var dataSort:Sort = new Sort();

        for each (var fieldStr:String in fields) {
            var dataSortField:SortField = new SortField();
            dataSortField.name = fieldStr;
            if (dataSort.fields == null) {
                dataSort.fields = [];
            }
            dataSort.fields.push(dataSortField);
        }

        collection.sort = dataSort;
        collection.refresh();
    }

    protected function showAllClickHandler(event:MouseEvent):void {
        _grid.removeFilters(_adgListData.dataField, true);
        _grid.saveOrUpdateGridFilterModel(_gridFilterModel);
        clearFilters();
        dispatchEvent(new CloseEvent(CloseEvent.CLOSE));

    }

    protected function okClickHandler(event:MouseEvent):void {
        var selectedFilters:ArrayCollection = new ArrayCollection();
        _gridFilterModel = new GridFilterModel(_adgListData.dataField);
        for each (var filterValue:AutoFilteringDropdownVO in filterValues) {
            if (filterValue.enabled) {
                selectedFilters.addItem(filterValue);
                _gridFilterModel.addSelectedValue(filterValue.displayValue);
            }
        }

        /**
         * If the user removed all selections the just took
         * the long way of clicking show all so show all instead
         * of filtering to nothing.
         */
        if (selectedFilters != null && selectedFilters.length == 0) {
            _gridFilterModel = new GridFilterModel(_adgListData.dataField);
            showAllClickHandler(event);
        } else {
            _grid.removeFilters(_adgListData.dataField, false);
            _grid.addActiveFilters(_adgListData.dataField, selectedFilters.toArray());
            _grid.saveOrUpdateGridFilterModel(_gridFilterModel);
            _selectedFilters = selectedFilters.toArray();
            dispatchEvent(new CloseEvent(CloseEvent.CLOSE));

        }
    }

    protected function cancelClickHandler(event:MouseEvent):void {
        this.filterValues = this.rollbackFilterValues;
        dispatchEvent(new CloseEvent(CloseEvent.CLOSE));
    }

    public function clearFilters():void {
        _selectedFilters = new Array();
        _filterValues = null;
        dispatchEvent(new CloseEvent(CloseEvent.CLOSE));
    }
}
}