package com.neosavvy.grid.controller
{
  import com.neosavvy.grid.popup.FilterSelectorDropdown;
  
  import flash.errors.IllegalOperationError;
  
  import mx.collections.ArrayCollection;
  
  public class DropdownManagerRegistry
  {
    private var _dropdownManagers:ArrayCollection = new ArrayCollection();

    public static var _instance:DropdownManagerRegistry;
    
    public function DropdownManagerRegistry(sge:SingletonEnforcer)
    {
      if(!sge) {
        throw new IllegalOperationError("DropdownManagerRegistry is a singleton, call getInstance() instead");
      }
    }
    
    public static function getInstance():DropdownManagerRegistry {
      if(! _instance ) {
        _instance = new DropdownManagerRegistry( new SingletonEnforcer() );
      } 
      return _instance;
    }
    
    public function addDropdownManager( ddm:DropdownManager ):void {
      _dropdownManagers.addItem( ddm );
    }
    
    public function closeAllVisibleDropdowns():void {
      for each (var ddm:DropdownManager in _dropdownManagers ) {
        if(ddm.showingPopup) {
          ddm.hide( null );
        }
      }
    }
    
    public function resetFilterSelections():void {
      for each (var ddm:DropdownManager in _dropdownManagers ) {
        if( ddm.popup is FilterSelectorDropdown) {
          (ddm.popup as FilterSelectorDropdown).clearFilters();
        }
      }
    }

  }
}
class SingletonEnforcer {}