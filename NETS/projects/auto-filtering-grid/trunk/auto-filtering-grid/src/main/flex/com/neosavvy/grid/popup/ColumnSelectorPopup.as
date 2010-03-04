package com.neosavvy.grid.popup
{
    import com.neosavvy.grid.AutoFilteringColumnGroup;
    import com.neosavvy.grid.AutoFilteringGrid;
    import com.neosavvy.grid.AutoFilteringGridColumn;
    import com.neosavvy.grid.AutoFilteringGridColumn;
import com.neosavvy.grid.model.AutoFilteringDropdownVO;
import com.neosavvy.grid.renderer.AutoFilteringGridColumnCheckboxRenderer;

import flash.events.Event;
import flash.events.MouseEvent;

import mx.collections.ArrayCollection;
import mx.containers.HBox;
import mx.containers.TitleWindow;
import mx.controls.Button;
import mx.controls.Label;
import mx.controls.List;
    import mx.controls.advancedDataGridClasses.AdvancedDataGridColumn;
    import mx.core.ClassFactory;
import mx.events.CloseEvent;
import mx.managers.PopUpManager;

public class ColumnSelectorPopup extends TitleWindow
{
    private var _label:Label;

    private var bWidthChanged:Boolean = false;
    private var bListChanged:Boolean = true;
    private var _list:List;

    private var _buttonContainer:HBox;

    private var _deselctAllButton:Button;
    private var _selectAllButton:Button;

    private var _okButton:Button;
    private var _cancelButton:Button;

    private var bColumnsChanged:Boolean = false;
    private var _columns:ArrayCollection;

    private var _grid:AutoFilteringGrid;


    public function ColumnSelectorPopup() {
        setStyle("backgroundColor", 0xFFFFFF);
        setStyle("borderStyle", "solid");
        setStyle("borderThickness", 1);
        setStyle("paddingTop", 10);
        setStyle("paddingLeft", 10);
        setStyle("paddingRight", 10);
        setStyle("paddingBottom", 10);
        styleName = "columnSelectorDropdown";
    }

    override protected function commitProperties():void {
        super.commitProperties();

        if (_label) {
            _label.text = "Select Columns...";
        }

        if (bColumnsChanged) {

            var columnVOs:ArrayCollection = new ArrayCollection();

            for each (var col:Object in _columns) {
                if( col is AutoFilteringColumnGroup && (col as AutoFilteringColumnGroup))
                {
                    var dropdownVO:AutoFilteringDropdownVO = new AutoFilteringDropdownVO((col as AutoFilteringColumnGroup).headerText, (col as AutoFilteringColumnGroup).enabled);
                    columnVOs.addItem(dropdownVO);
                }
                else if ( col is AutoFilteringGridColumn && (col as AutoFilteringGridColumn).removable )
                {
                    var dropdownVO:AutoFilteringDropdownVO = new AutoFilteringDropdownVO((col as AutoFilteringGridColumn).headerText, (col as AutoFilteringGridColumn).enabled);
                    columnVOs.addItem(dropdownVO);
                }
            }

            _list.dataProvider = columnVOs;
            bColumnsChanged = false;
        }

        if (_okButton) {
            _okButton.label = "OK";
            _okButton.addEventListener(MouseEvent.CLICK, okClickHandler);
        }

        if (_cancelButton) {
            _cancelButton.label = "Cancel";
            _cancelButton.addEventListener(MouseEvent.CLICK, cancelClickHandler);
        }

        if (_deselctAllButton) {
            _deselctAllButton.label = "(-)";
            _deselctAllButton.addEventListener(MouseEvent.CLICK, deselectAllClickHandler);
        }

        if (_selectAllButton) {
            _selectAllButton.label = "(+)";
            _selectAllButton.addEventListener(MouseEvent.CLICK, selectAllClickHandler);
        }

        if (_list && bWidthChanged && bListChanged) {
            _list.width = this.width;
            bListChanged = false;
        }

        this.title = "Manage Columns";
        this.addEventListener(CloseEvent.CLOSE, cancelClickHandler);

    }

    override protected function createChildren():void {
        super.createChildren();

        if (!_label) {
            _label = new Label();
            addChild(_label);
        }

        if (!_list) {
            _list = new List();
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

            //TODO: move these buttons into a new container that is
            //capable of being toggled.
            if (!_deselctAllButton) {
                _deselctAllButton = new Button();
                _buttonContainer.addChild(_deselctAllButton);
            }

            if (!_selectAllButton) {
                _selectAllButton = new Button();
                _buttonContainer.addChild(_selectAllButton);
            }
        }
    }

    override protected function measure():void {
        super.measure();

        this.measuredMinHeight = this.minHeight = 5 * 36;
        this.measuredMinWidth = this.minWidth = 100;
        bWidthChanged = true;
    }

    override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
        super.updateDisplayList(unscaledWidth, unscaledHeight);
    }


    public function set columns(columns:ArrayCollection):void {
        bColumnsChanged = true;
        _columns = columns
        invalidateProperties();
    }

    public function get columns():ArrayCollection {
        return _columns;
    }

    public function set grid(grid:AutoFilteringGrid):void {
        _grid = grid;
        columns = _grid.getAvailableColumns();
    }


    protected function okClickHandler(event:MouseEvent):void {

        var valueObjectsFromDropdown:ArrayCollection = _list.dataProvider as ArrayCollection;
        var selectedColumsnFromVOs:ArrayCollection = new ArrayCollection();
        var groupedColumnsFoundInAvailableColumns:Boolean = false;

        for each (var columnFromDropdown:AutoFilteringDropdownVO in valueObjectsFromDropdown) {

            for each (var col:Object in _grid.getAvailableColumns()) {

                if ( col is AutoFilteringGridColumn)
                {
                    var adgColumn:AutoFilteringGridColumn = col as AutoFilteringGridColumn
                    if (adgColumn.headerText == columnFromDropdown.displayValue) {
                        adgColumn.enabled = columnFromDropdown.enabled;
                        selectedColumsnFromVOs.addItem(adgColumn);
                    }
                }

                else if ( col is AutoFilteringColumnGroup )
                {
                    groupedColumnsFoundInAvailableColumns = true;
                    var adgColumnGroup:AutoFilteringColumnGroup = col as AutoFilteringColumnGroup
                    if (adgColumnGroup.headerText == columnFromDropdown.displayValue) {
                        adgColumnGroup.enabled = columnFromDropdown.enabled;
                        selectedColumsnFromVOs.addItem(adgColumnGroup);
                    }
                }
            }

        }

        if( groupedColumnsFoundInAvailableColumns )
        {
            _grid.groupedColumns = selectedColumsnFromVOs.toArray();
        }
        else
        {
            _grid.columns = selectedColumsnFromVOs.toArray();
        }
        PopUpManager.removePopUp(this);
    }

    protected function cancelClickHandler(event:Event):void {
        PopUpManager.removePopUp(this);
    }

    protected function deselectAllClickHandler(event:MouseEvent):void {
        var allDeSelected:ArrayCollection = new ArrayCollection();
        for each (var colVO:AutoFilteringDropdownVO in _list.dataProvider) {
            colVO.enabled = false;
            allDeSelected.addItem(colVO);
        }
        _list.dataProvider = allDeSelected;
    }

    protected function selectAllClickHandler(event:MouseEvent):void {
        var allSelected:ArrayCollection = new ArrayCollection();
        for each (var colVO:AutoFilteringDropdownVO in _list.dataProvider) {
            colVO.enabled = true;
            allSelected.addItem(colVO);
        }
        _list.dataProvider = allSelected;
    }
}
}