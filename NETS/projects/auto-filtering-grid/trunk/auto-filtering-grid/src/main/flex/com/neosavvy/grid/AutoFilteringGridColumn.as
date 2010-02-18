package com.neosavvy.grid
{
import com.neosavvy.grid.model.AutoFilteringGridColumnVO;

import mx.controls.advancedDataGridClasses.AdvancedDataGridColumn;

public class AutoFilteringGridColumn extends AdvancedDataGridColumn
{

    private var _autoFilterEnabled:Boolean = true;

    private var _enabledByDefault:Boolean = false;

    private var _enabled:Boolean = false;

    private var _removable:Boolean = true;

    private var _adjustColumnWidth:Boolean = true;

    private var _searchEnabled:Boolean = true;

    public function AutoFilteringGridColumn(columnName:String = null)
    {
        super(columnName);
    }

    public function set autoFilterEnabled(autoFilterEnabled:Boolean):void {
        _autoFilterEnabled = autoFilterEnabled;
    }

    public function get autoFilterEnabled():Boolean {
        return _autoFilterEnabled;
    }

    public function set enabledByDefault(enabledByDefault:Boolean):void {
        _enabledByDefault = enabledByDefault;
    }

    public function get enabledByDefault():Boolean {
        if (!removable) {
            _enabledByDefault = true;
        }
        return _enabledByDefault;
    }

    public function set enabled(enabled:Boolean):void {
        _enabled = enabled;
    }

    public function get enabled():Boolean {
        return _enabled;
    }

    public function set removable(removable:Boolean):void {
        _enabledByDefault = true;
        _removable = removable;
    }

    public function get removable():Boolean {
        return _removable;
    }

    public function get adjustColumnWidth():Boolean {
        return _adjustColumnWidth;
    }

    public function set adjustColumnWidth(val:Boolean):void {
        _adjustColumnWidth = val;
    }

    public function get searchEnabled():Boolean {
        return _searchEnabled;
    }

    public function set searchEnabled(value:Boolean):void {
        _searchEnabled = value;
    }

    public function getPersistableVO():AutoFilteringGridColumnVO {

        var autoFilteringGridColumnVO:AutoFilteringGridColumnVO =
                new AutoFilteringGridColumnVO(
                        this.dataField
                        , this.headerText
                        , this.autoFilterEnabled
                        , this.enabledByDefault
                        , this.enabled
                        , this.removable
                        );
        return autoFilteringGridColumnVO;

    }

    public static function setFromPersistentVO(valueObject:AutoFilteringGridColumnVO):AutoFilteringGridColumn {
        var column:AutoFilteringGridColumn = new AutoFilteringGridColumn()
        column.dataField = valueObject.dataField;
        column.headerText = valueObject.headerName;
        column.autoFilterEnabled = valueObject.autoFilterEnabled;
        column.enabledByDefault = valueObject.enabledByDefault;
        column.enabled = valueObject.enabled;
        column.removable = valueObject.removable;
        return column;
    }

}
}