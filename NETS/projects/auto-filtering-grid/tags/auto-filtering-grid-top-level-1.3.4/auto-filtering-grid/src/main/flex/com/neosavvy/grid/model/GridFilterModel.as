package com.neosavvy.grid.model {
import mx.collections.ArrayCollection;

[RemoteClass(alias="com.roundarch.grid.model.GridFilterModel")]
public class GridFilterModel {

    private var _columnName:String;
    private var _selectedValues:ArrayCollection = new ArrayCollection();

    public function GridFilterModel( columnName:String = null, selectedValueStrings:Array = null) {
        this._columnName = columnName;
        this._selectedValues = new ArrayCollection(selectedValues);
    }

    public function get columnName():String {
        return _columnName;
    }

    public function set columnName(value:String):void {
        _columnName = value;
    }

    public function get selectedValues():Array {
        return _selectedValues.toArray();
    }

    public function set selectedValues(value:Array):void {
        _selectedValues = new ArrayCollection(value);
    }

    public function addSelectedValue(value:String):void {
        _selectedValues.addItem(value);
    }
 
    public function toString():String {
        return "GridFilterModel{_columnName=" + String(_columnName) + ",_selectedValues=" + String(_selectedValues) + "}";
    }
}
}