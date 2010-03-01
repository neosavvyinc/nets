package com.neosavvy.grid.model
{
public class AutoFilteringDropdownVO
{
    private var _displayValue:String;
    private var _enabled:Boolean;

    public function AutoFilteringDropdownVO(displayValue:String, enabled:Boolean)
    {
        _displayValue = displayValue;
        _enabled = enabled;
    }

    public function get displayValue():String {
        return _displayValue;
    }

    public function get enabled():Boolean {
        return _enabled;
    }

    public function set enabled(enabled:Boolean):void {
        _enabled = enabled;
    }

}
}