package com.neosavvy.grid
{
import com.neosavvy.grid.controller.DropdownManagerRegistry;
import com.neosavvy.grid.event.AutoFilteringGridEvent;
import com.neosavvy.grid.model.AutoFilteringDropdownVO;
import com.neosavvy.grid.model.GridFilterModel;
import com.neosavvy.grid.model.GridFilterModels;
import com.neosavvy.grid.popup.ColumnSelectorPopup;
import com.neosavvy.grid.renderer.AutoFilteringHeaderRenderer;

import flash.events.MouseEvent;
import flash.text.TextLineMetrics;

import mx.collections.ArrayCollection;
import mx.collections.ICollectionView;
import mx.collections.IViewCursor;
import mx.controls.AdvancedDataGrid;
import mx.core.FlexSprite;
import mx.core.IFactory;
import mx.core.IFlexDisplayObject;
import mx.core.mx_internal;
import mx.events.AdvancedDataGridEvent;
import mx.events.CollectionEvent;
import mx.events.CollectionEventKind;
import mx.managers.PopUpManager;

use namespace mx_internal;

[Event(name="autoFilterColumnsChanged", type="com.neosavvy.grid.event.AutoFilteringGridEvent")]
public class AutoFilteringGrid extends AdvancedDataGrid
{

    private var initializedComplete:Boolean = false;

    private var _availableColumns:ArrayCollection;

    private var _autoResizeColumnHeaders:Boolean = false;

    private var bColumnsChanged:Boolean = false;

    /** PAGINATION SUPPORT **/
    public var paginationEnabled:Boolean = false;
    private var _itemsPerPage:int = 1;
    
    //keeps track of what selection has been 
    //chosen for num of records per page; _itemsPerPage is calculated 
    //based on the actual records and might not correspond to any 
    //available option 
    [Bindable]
    public var itemsPerPageComboSelection:int = -1;

    /**
     * Used in a filter function to determine whether
     * an item falls within a visible page range. Need to have a
     * separate collection to ensure that grid sort does not affect
     * pagination.
     */
    [Bindable]
    public var dataProviderClone:ArrayCollection;

    [Bindable]
    public var pageStartIndex:int;
    [Bindable]
    public var pageEndIndex:int;
    [Bindable]
    public var currentPage:int = 1;
    [Bindable]
    public var numOfPages:int = 1;
    [Bindable]
    public var maxRecords:int = 0;
    /** END PAGINATION SUPPORT **/

    public function AutoFilteringGrid()
    {
        super();
        addEventListener(AutoFilteringGridEvent.HEADER_DROPDOWN_BUTTON_CLICKED, headerDropdownClickHandler);
    }

    public function headerDropdownClickHandler(event:AutoFilteringGridEvent):void {

        DropdownManagerRegistry.getInstance().closeAllVisibleDropdowns();

    }

    override protected function mouseOverHandler(event:MouseEvent):void {
        super.mouseOverHandler(event);

        var hs:FlexSprite = FlexSprite(selectionLayer.getChildByName("headerSelection"));

        if (hs) {
            hs.visible = false;
        }
    }

    override protected function commitProperties():void {

        super.commitProperties();

        if (bColumnsChanged) {

            if (_autoResizeColumnHeaders) {
                calculateWidthsOfEachAvailableColumns();
            }

            bColumnsChanged = false;
        }

    }

    override public function set columns(value:Array):void {
        //Only execute this the first time - not every time columns are set
        if (!initializedComplete) {
            _availableColumns = new ArrayCollection(value);
            for each (var adgColumn:AutoFilteringGridColumn in _availableColumns) {
                adgColumn.headerRenderer = IFactory(new AutoFilteringHeaderRenderer());
                if (adgColumn.enabledByDefault) {
                    adgColumn.enabled = true;
                }
            }
            initializedComplete = true;
        }

        _availableColumns.filterFunction = function f(item:Object):Boolean {
            if (item is AutoFilteringGridColumn) {
                return (item as AutoFilteringGridColumn).enabled;
            }
            return false;
        }
        _availableColumns.refresh();
        super.columns = _availableColumns.toArray();

        bColumnsChanged = true;
        invalidateProperties();
        dispatchEvent(new AutoFilteringGridEvent(AutoFilteringGridEvent.COLUMNS_CHANGED, true, false));
    }

    public function getAvailableColumns():ArrayCollection {
        _availableColumns.filterFunction = null;
        _availableColumns.refresh();
        return _availableColumns;
    }

    private var _activeFilters:Object = new Object();

    public function manageColumns():void {
        var displayObject:IFlexDisplayObject = PopUpManager.createPopUp(this, ColumnSelectorPopup, true);

        var columnSelector:ColumnSelectorPopup = displayObject as ColumnSelectorPopup;
        columnSelector.grid = this;

        PopUpManager.centerPopUp(displayObject);
    }

    public function resetFilters():void {
        _activeFilters = new Object();
        
        if (this.dataProvider is ICollectionView) {
            (this.dataProvider as ICollectionView).sort = null;
        }
        DropdownManagerRegistry.getInstance().resetFilterSelections();

        if(this.dataProvider) 
            this.dataProvider.refresh();

        conditionallyGoToPageOne();
    }

    public function removeFilters(filterType:String, refresh:Boolean):void {
        if (_activeFilters.hasOwnProperty(filterType)) {
            delete _activeFilters[filterType];
        }

        if (refresh)
            this.dataProvider.refresh();
    }

    public function getActiveFilters(filterType:String):Object {

        var activeFiltersAsObjectMap:Object = new Object();
        for each (var elem:Object in _activeFilters[filterType]) {
            activeFiltersAsObjectMap[elem] = elem;
        }

        return activeFiltersAsObjectMap;
    }

    public function addActiveFilters(filterType:String, filterValues:Array):void {
        if (!(_activeFilters.hasOwnProperty(filterType))) {
            _activeFilters[filterType] = new Array();
        }
        for each (var filterValue:AutoFilteringDropdownVO in filterValues) {
            (_activeFilters[filterType] as Array).push(filterValue.displayValue);
        }

        if(this.dataProvider)
            this.dataProvider.refresh();
    }

    protected function filterFunctionWithPagination(item:Object):Boolean {

        //Determine whether item falls within the range of the
        //visible page, ie between pageStartIndex and pageEndIndex
        var prePaginationResult:Boolean = filterFunctionNoPagination(item);
        if (prePaginationResult && paginationEnabled) {
            var itemIndex:int = getIndex(dataProviderClone, item);
            if (itemIndex >= pageStartIndex && itemIndex <= pageEndIndex) {
                return true;
            }
            else {
                return false;
            }
        }

        return prePaginationResult;
    }

    public function filterFunctionNoPagination(item:Object):Boolean {
        var matches:Object = new Object();

        //Iterate through each column's filter selections
        for (var filterType:String in _activeFilters) {

            //Ensure that at least one value in the selection matches the incoming object
            var typeFilterValues:Array = _activeFilters[filterType] as Array;
            for each (var value:String in typeFilterValues) {
                if (value == item[filterType]) {
                    matches[filterType] = true;
                    break;
                }
            }

            //If no matches were found in the above loop - ensure that a false is placed
            //in the matches array for that filter type
            if (!matches.hasOwnProperty(filterType)) {
                matches[filterType] = false;
            }

        }

        //Calculate whether or not the object matches all filter selections
        var calculatedFullMatch:Boolean = true;
        for each (var match:Boolean in matches) {
            calculatedFullMatch = calculatedFullMatch && match;
        }

        return calculatedFullMatch;
    }

    public function set autoResizeColumnHeaders(autoResize:Boolean):void {
        _autoResizeColumnHeaders = autoResize;
    }

    public function get autoResizeColumnHeaders():Boolean {
        return _autoResizeColumnHeaders;
    }

    protected function calculateWidthsOfEachAvailableColumns():void {
        for each (var column:AutoFilteringGridColumn in columns) {
            if (column.adjustColumnWidth) {
                column.minWidth = calculateMinWidthOfColumnHeader(column);
            }
        }
    }

    protected function calculateMinWidthOfColumnHeader(column:AutoFilteringGridColumn):int {
        var stringToMeasure:String = column.headerText;
        var textMetrics:TextLineMetrics = measureText(stringToMeasure);
        var calculatedSize:int = textMetrics.width;
        calculatedSize = calculatedSize + AutoFilteringHeaderRenderer.FILTER_BUTTON_WIDTH * 2;
        calculatedSize = calculatedSize + AutoFilteringHeaderRenderer.SORT_SPACE_WIDTH;
        calculatedSize = calculatedSize + AutoFilteringHeaderRenderer.LEFT_PADDING;
        calculatedSize = calculatedSize + AutoFilteringHeaderRenderer.HORIZONTAL_PADDING * 4;
        return calculatedSize;
    }

    protected function calculateMinWidthOfColumnData(dataFieldName:String):int {
        var highestColumnWidth:int = 0;
        var textMetrics:TextLineMetrics = null
        for each (var element:Object in dataProvider) {

            if (element.hasOwnProperty(dataFieldName)) {
                var dataValue:Object = element[dataFieldName];
                if (dataValue is String) {
                    textMetrics = this.measureText(dataValue as String);
                    if (textMetrics && textMetrics.width > maxWidth) {
                        highestColumnWidth = textMetrics.width;
                    }
                }

            }

        }
        return highestColumnWidth;
    }

    public function getEnabledColumnNames():ArrayCollection {
        var columnNames:ArrayCollection = new ArrayCollection();
        for each (var col:AutoFilteringGridColumn in columns) {
            columnNames.addItem(col.dataField);
        }
        return columnNames;
    }

    public function overrideColumnsFromRestoredState(columnsToOverride:ArrayCollection):void {
        var columnsToActivate:Array = new Array();
        for each (var col:AutoFilteringGridColumn in getAvailableColumns()) {

            //if the input columns contains the datafield - turn on that column
            if (columnsToOverride.contains(col.dataField)) {
                col.enabled = true;
                columnsToActivate.push(col);
                continue;
            } else {
                //ensure it is turned off if it is not in the list of fields to turn on
                col.enabled = false;
                columnsToActivate.push(col);
            }

            //These columns are not configurable externally - must be changed in code
            if (col.enabledByDefault || !col.removable) {
                columnsToActivate.push(col);
            }

        }
        //They are stored backwards because a push operation was used
        this.columns = columnsToActivate;
    }

    /**
     * Exposing renderer array
     */
    public function get rendererArray():Array {
        return super.rendererArray;
    }

    /** PAGINATION SUPPORT **/
    protected function dataProviderChanged(evt:CollectionEvent):void {
        if (evt.kind == CollectionEventKind.ADD || evt.kind == CollectionEventKind.REMOVE) {
            maxRecords = collection.length;
            enablePagination(paginationEnabled, _itemsPerPage);
            processFilters();
        }
    }

    override public function set dataProvider(value:Object):void {
        for each (var val in value) {
            trace("Dataprovider value: " + val.toString());
        }
        super.dataProvider = value;
        collection.filterFunction = filterFunctionWithPagination;
        collection.addEventListener(CollectionEvent.COLLECTION_CHANGE, dataProviderChanged);

        maxRecords = collection.length;
        enablePagination(paginationEnabled, _itemsPerPage);
    }

    public function enablePagination(val:Boolean, itemsPerPageValue:int = -1):void {
        if (val == true) {
            paginationEnabled = true;
            populateDataProviderClone();

            //calc default page size, ie split into 3 pages
            if (itemsPerPageValue == -1) {
                itemsPerPageValue = Math.floor(collection.length / 3);
            }
        }
        else {
            paginationEnabled = false;
            itemsPerPageValue = collection.length;
        }
        itemsPerPage = itemsPerPageValue;
    }

    /**
     * Pagination filter function can't depend on the
     * original data provider since .refersh() first
     * applies the filterFunction and then applies the sort.
     * This makes it impossible to paginate a sorted list.
     *
     * This is a shallow clone!
     **/
    private function populateDataProviderClone():void {
        dataProviderClone = new ArrayCollection();
        dataProviderClone.filterFunction = filterFunctionNoPagination;

        var cursor:IViewCursor = collection.createCursor();
        while (!cursor.afterLast) {
            dataProviderClone.addItem(cursor.current);
            cursor.moveNext();
        }

        maxRecords = dataProviderClone.length;
    }

    /**
     * Setter for itemsPerPage
     * Defaults to page 1
     */
    public function set itemsPerPage(val:int):void {
        if (val < 1) {
            return;
        }

        if (val > maxRecords) {
            val = maxRecords;
        }

        _itemsPerPage = val;
        pageStartIndex = 0;
        pageEndIndex = val - 1;
        currentPage = 1;
        numOfPages = calcNumOfPages();

        if (pageEndIndex > maxRecords - 1) {
            pageEndIndex = maxRecords - 1
        }

        collection.refresh();
    }

    public function calcNumOfPages():int {
        var numOfPages:Number = maxRecords / _itemsPerPage;
        numOfPages = Math.ceil(numOfPages);
        return numOfPages;
    }

    public function goToPage(pageNumber:int):void {
        pageStartIndex = pageNumber * _itemsPerPage - _itemsPerPage;
        pageEndIndex = pageNumber * _itemsPerPage - 1;

        if (pageEndIndex > maxRecords - 1) {
            pageEndIndex = maxRecords - 1;
        }

        numOfPages = calcNumOfPages();
        if (pageNumber > numOfPages) {
            pageNumber = numOfPages;
        }

        if (pageNumber < 1) {
            pageNumber = 1;
        }

        currentPage = pageNumber;
        collection.refresh();
    }

    public function nextPage():void {
        if (pageEndIndex == maxRecords - 1) {
            return;
            trace("No next page.");
        }

        pageStartIndex = pageEndIndex + 1;
        pageEndIndex = pageStartIndex + _itemsPerPage - 1;

        if (pageEndIndex > maxRecords - 1) {
            pageEndIndex = maxRecords - 1;
        }

        currentPage++;
        collection.refresh();
    }

    public function prevPage():void {
        if (pageStartIndex == 0) {
            return;
            trace("No previous page.");
        }

        pageEndIndex = pageStartIndex - 1;
        pageStartIndex = pageEndIndex - _itemsPerPage + 1;

        currentPage--;
        collection.refresh();
    }

    /**
     * Intercept sort to ensure that sort is applied to
     * the entire collection, not just the visible rows
     */
    override protected function headerReleaseHandler(event:AdvancedDataGridEvent):void {
        if (paginationEnabled) {
            collection.filterFunction = null;
            super.headerReleaseHandler(event);

            //mimic the sort on dataProviderClone
            dataProviderClone.sort = this.collection.sort;
            dataProviderClone.refresh();

            collection.filterFunction = filterFunctionWithPagination;
            goToPage(1);
        }
        else {
            super.headerReleaseHandler(event);
        }
    }

    /**
     * Utility function to find item index in an array.
     * Built-in getItemIndex() relies on sort and other internal
     * variables that result in exceptions.
     */
    protected function getIndex(arr:ArrayCollection, item:Object):int {
        for (var i:int = 0; i < arr.length; i++) {
            if (arr.getItemAt(i) == item) {
                return i;
            }
        }
        return -1;
    }

    /**
     * If pagination is enabled, need to respond to every
     * filter change. Filter changes impact the underlying
     * data set and thus affect pagination functionality.
     *
     * Once fitler changes are in effect,
     * default back to page 1.
     */
    public function conditionallyGoToPageOne():void {
        if (paginationEnabled) {
            dataProviderClone.refresh();
            maxRecords = dataProviderClone.length;
            goToPage(1);
        }
    }
    /** END PAGINATION SUPPORT **/

    /** Begin Save Filter Support **/
    [Bindable]
    var _gridFilterModels:GridFilterModels = new GridFilterModels();

    public function get gridFilterModels():GridFilterModels {

        return _gridFilterModels;

    }

    public function processFilters():void {
        for each (var gfm:GridFilterModel in _gridFilterModels.gridFilterModels) {
            var selectedFilters:Array = new Array();
            for each (var value:String in gfm.selectedValues) {
                var autoFilterGridVo:AutoFilteringDropdownVO = new AutoFilteringDropdownVO(value, true);
                selectedFilters.push(autoFilterGridVo);
            }
            if (selectedFilters && selectedFilters.length > 0)
                addActiveFilters(gfm.columnName, selectedFilters);
        }
    }

    public function set gridFilterModels( gridFilterModels:GridFilterModels ):void {
        resetFilters();
        _gridFilterModels = gridFilterModels;
        processFilters();
        dispatchEvent(new CollectionEvent(CollectionEvent.COLLECTION_CHANGE));
    }

    public function saveOrUpdateGridFilterModel( gridFilterModel:GridFilterModel ) :void {
        _gridFilterModels.saveOrUpdateGridFilterModel( gridFilterModel );
    }

//    public function isValueValidForData(value:String, column:String):Boolean {
//        for each (var obj:Object in dataProvider.source) {
//            if(obj.hasOwnProperty(column) && obj[column] == value){
//                return true;
//            }
//        }
//        return false;
//    }
    /** END Save Filter Support **/

}

}