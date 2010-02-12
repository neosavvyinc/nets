package com.neosavvy.grid.model
{
  public class AutoFilteringGridColumnVO
  {
    private var _dataField:String;
    private var _headerName:String;
    
    private var _autoFilterEnabled:Boolean;
    private var _enabledByDefault:Boolean;
    private var _enabled:Boolean;
    private var _removable:Boolean;
    
    public function AutoFilteringGridColumnVO(
      dataField:String
      ,headerName:String
      ,autoFilterEnabled:Boolean
      ,enabledByDefault:Boolean
      ,enabled:Boolean
      ,removable:Boolean
      )
    {
      _dataField = dataField;
      _headerName = headerName;
      
      _autoFilterEnabled = autoFilterEnabled;
      _enabledByDefault = enabledByDefault;
      _enabled = enabled;
      _removable = removable;
    }
    
    public function get dataField():String {
      return _dataField;
    }
    
    public function get headerName():String {
      return _headerName;
    }
    
    public function get autoFilterEnabled():Boolean {
      return _autoFilterEnabled;
    }
    
    public function get enabledByDefault():Boolean {
      return _enabledByDefault;
    }
    
    public function get enabled():Boolean {
      return _enabled;
    }
    
    public function get removable():Boolean {
      return _removable;
    }

  }
}