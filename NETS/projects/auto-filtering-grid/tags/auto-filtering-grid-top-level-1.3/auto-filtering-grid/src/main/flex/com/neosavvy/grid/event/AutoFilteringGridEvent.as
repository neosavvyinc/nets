package com.neosavvy.grid.event
{
  import flash.events.Event;

  public class AutoFilteringGridEvent extends Event
  {
    
    public static var HEADER_DROPDOWN_BUTTON_CLICKED:String = "headerButtonClicked";
    public static var COLUMNS_CHANGED:String = "autoFilterColumnsChanged";
    
    public function AutoFilteringGridEvent(type:String, bubbles:Boolean=true, cancelable:Boolean=true)
    {
      super(type, bubbles, cancelable);
    }
    
  }
}