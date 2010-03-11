package com.neosavvy.grid.renderer
{
import com.neosavvy.grid.AutoFilteringGrid;
import com.neosavvy.grid.AutoFilteringGridColumn;
import com.neosavvy.grid.controller.DropdownManager;
import com.neosavvy.grid.controller.DropdownManagerRegistry;
import com.neosavvy.grid.event.AutoFilteringGridEvent;
import com.neosavvy.grid.popup.FilterSelectorDropdown;

import flash.events.Event;
import flash.events.MouseEvent;

import mx.controls.Button;
import mx.controls.List;
import mx.controls.advancedDataGridClasses.AdvancedDataGridHeaderRenderer;
import mx.controls.advancedDataGridClasses.AdvancedDataGridListData;
import mx.controls.listClasses.BaseListData;
import mx.controls.listClasses.IDropInListItemRenderer;
import mx.controls.listClasses.IListItemRenderer;
import mx.core.Application;
import mx.core.IDataRenderer;
import mx.core.IFactory;
import mx.core.UIComponent;
import mx.events.CloseEvent;
import mx.events.FlexMouseEvent;
import mx.events.ListEvent;
import mx.styles.CSSStyleDeclaration;
import mx.styles.StyleManager;

public class AutoFilteringHeaderRenderer extends AdvancedDataGridHeaderRenderer implements IDataRenderer, IListItemRenderer, IDropInListItemRenderer, IFactory
{

    [Embed(source="/icons/add.png")]
    [Bindable]
    private var addFilterIcon:Class;

    [Embed(source="/icons/link.png")]
    [Bindable]
    private var filterAddedIcon:Class;

    private var bFilterDataChanged:Boolean = true;

    public static var FILTER_BUTTON_WIDTH:int = 16;
    public static var FILTER_BUTTON_HEIGHT:int = 16;

    public static var SORT_SPACE_WIDTH:int = 23;

    public static var LEFT_PADDING:int = 10;
    public static var HORIZONTAL_PADDING:int = 3;

    private var _grid:AutoFilteringGrid;
    private var _adgListData:AdvancedDataGridListData;

    private var _showFilterDropdownButton:Button;
    private var _filterSelectorDropdownManager:DropdownManager

    private var _cachedColumnSelectorWidth:int = -1;

    public function AutoFilteringHeaderRenderer() {
        this.styleName = "autoFilteringHeaderRenderer";
    }

    public function newInstance():* {
        return new AutoFilteringHeaderRenderer();
    }

    private static function classConstruct():Boolean {
        var selector:CSSStyleDeclaration = StyleManager.getStyleDeclaration("AutoFilteringHeaderRenderer");

        if (!selector) {
            selector = new CSSStyleDeclaration();
        }

        selector.defaultFactory = function():void {
        }

        StyleManager.setStyleDeclaration("AutoFilteringHeaderRenderer", selector, false);
        return true;
    }

    override protected function createChildren():void {
        super.createChildren();

        if (!_showFilterDropdownButton) {
            _showFilterDropdownButton = new Button();
            addChild(_showFilterDropdownButton);
            _filterSelectorDropdownManager = new DropdownManager(_showFilterDropdownButton, FilterSelectorDropdown.FACTORY);
            DropdownManagerRegistry.getInstance().addDropdownManager(_filterSelectorDropdownManager);
            _showFilterDropdownButton.addEventListener(MouseEvent.CLICK, toggleFilterDropdown);
            _showFilterDropdownButton.addEventListener(MouseEvent.MOUSE_UP, cancelEvent);
            _showFilterDropdownButton.addEventListener(MouseEvent.MOUSE_OVER, cancelEvent);
            _showFilterDropdownButton.addEventListener(MouseEvent.ROLL_OUT, cancelEvent);
            _showFilterDropdownButton.addEventListener(MouseEvent.ROLL_OVER, cancelEvent);
            //_showFilterDropdownButton.styleName = "filterDropdownButton";
        }
    }

    override protected function commitProperties():void {
        super.commitProperties();

        if (_showFilterDropdownButton) {
            _showFilterDropdownButton.visible = isColumnFilterable();
        }

        if (isColumnFilterEnabled()) {
            _showFilterDropdownButton.styleName = "filterDropdownButtonFiltered";
        } else {
            _showFilterDropdownButton.styleName = "filterDropdownButton";
        }

        if ( bFilterDataChanged  && _showFilterDropdownButton)
        {
            bFilterDataChanged = false;
            if( _adgListData && _adgListData.dataField && _grid.isFilterActive(_adgListData.dataField) )
            {
                _showFilterDropdownButton.setStyle("upIcon", filterAddedIcon);
                _showFilterDropdownButton.setStyle("downIcon", filterAddedIcon);
                _showFilterDropdownButton.setStyle("overIcon", filterAddedIcon);
                _showFilterDropdownButton.setStyle("disabledIcon", filterAddedIcon);
                _showFilterDropdownButton.setStyle("selectedUpIcon", filterAddedIcon);
                _showFilterDropdownButton.setStyle("selectedDownIcon", filterAddedIcon);
                _showFilterDropdownButton.setStyle("selectedOverIcon", filterAddedIcon);
                _showFilterDropdownButton.setStyle("selectedDisabledIcon", filterAddedIcon);
            }
            else
            {
                _showFilterDropdownButton.setStyle("upIcon", addFilterIcon);
                _showFilterDropdownButton.setStyle("downIcon", addFilterIcon);
                _showFilterDropdownButton.setStyle("overIcon", addFilterIcon);
                _showFilterDropdownButton.setStyle("disabledIcon", addFilterIcon);
                _showFilterDropdownButton.setStyle("selectedUpIcon", addFilterIcon);
                _showFilterDropdownButton.setStyle("selectedDownIcon", addFilterIcon);
                _showFilterDropdownButton.setStyle("selectedOverIcon", addFilterIcon);
                _showFilterDropdownButton.setStyle("selectedDisabledIcon", addFilterIcon);
            }
        }


    }

    override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {
        super.updateDisplayList(unscaledWidth, unscaledHeight);

        var filterButtonHeight:int;
        var filterButtonWidth:int;

        var columnSelectorButtonHeight:int;
        var columnSelectorButtonWidth:int;

        if (_showFilterDropdownButton) {
            filterButtonHeight = FILTER_BUTTON_HEIGHT;
            filterButtonWidth = FILTER_BUTTON_WIDTH;
            _showFilterDropdownButton.setActualSize(filterButtonWidth, filterButtonHeight);
            _showFilterDropdownButton.move(LEFT_PADDING, 0);
        }

    }

    override public function set listData(value:BaseListData):void {
        super.listData = value;

        _adgListData = AdvancedDataGridListData(value);
        _grid = AutoFilteringGrid(_adgListData.owner);
        invalidateProperties();
    }

    protected function isColumnFilterable():Boolean {

        var column:AutoFilteringGridColumn = _adgListData.item as AutoFilteringGridColumn;
        return column.autoFilterEnabled;

    }

    protected function isColumnFilterEnabled():Boolean {
        var object:Object = _grid.getActiveFilters(_adgListData.dataField);
        for each (var prop:String in object) {
            return true;
        }
        return false;
    }

    protected function toggleFilterDropdown(event:Event):void {
        dispatchEvent(new AutoFilteringGridEvent(AutoFilteringGridEvent.HEADER_DROPDOWN_BUTTON_CLICKED));
        if (_filterSelectorDropdownManager.showingPopup) {
            hidePopup(_filterSelectorDropdownManager, event);
        } else {
            (_filterSelectorDropdownManager.popup as FilterSelectorDropdown).grid = _grid;
            (_filterSelectorDropdownManager.popup as FilterSelectorDropdown).listData = _adgListData;

            showPopup(_filterSelectorDropdownManager, event, DropdownManager.DIRECTION_DOWN, getXOffset(), -3);
        }
        event.preventDefault();
        event.stopImmediatePropagation();
    }

    /**
     * This is extremely hacky - I am aware.
     */
    protected function getXOffset():Number {
        if (this.x > Application.application.width / 2) {
            return - _filterSelectorDropdownManager.popup.getExplicitOrMeasuredWidth() + 32;
        }
        return -10;
    }

    protected function cancelEvent(event:Event):void {
        event.preventDefault();
        event.stopImmediatePropagation();
    }

    protected function showPopup(_dropdownManager:DropdownManager, me:Event, direction:String, xOffset:Number = 0, yOffset:Number = 0):void {
        var popup:UIComponent = _dropdownManager.popup;

        // handle close button in popup
        popup.addEventListener(Event.CLOSE, function(e:Event):void {
            if (_dropdownManager.showingPopup) {
                //_dropdownManager.hide(e);
                hidePopup(_dropdownManager, e);
            }
        });

        popup.addEventListener(CloseEvent.CLOSE, function(e:Event):void {
            if (_dropdownManager.showingPopup) {
                //_dropdownManager.hide(e);
                hidePopup(_dropdownManager, e);
            }
        });

        // handle mouse clicks outside of the popup
        popup.addEventListener(FlexMouseEvent.MOUSE_DOWN_OUTSIDE, function(fme:FlexMouseEvent):void {
            if (fme.target != popup) {
                if (_dropdownManager.showingPopup) {
                    //_dropdownManager.hide(fme);
                    hidePopup(_dropdownManager, fme);
                }
                return;
            }
        });

        // close on mouse wheel outside as well
        popup.addEventListener(FlexMouseEvent.MOUSE_WHEEL_OUTSIDE, function(fme:FlexMouseEvent):void {
            if (fme.target != popup) {
                if (_dropdownManager.showingPopup) {
                    //_dropdownManager.hide(fme);
                    hidePopup(_dropdownManager, fme);
                }
                return;
            }
        });

        if (!_dropdownManager.showingPopup) {
            _dropdownManager.show(direction, {x:xOffset, y:yOffset});
        }
    }

    public function invalidateFilters():void {
        bFilterDataChanged = true;
        invalidateProperties();
    }

    protected function hidePopup(_dropdownManager:DropdownManager, me:Event):void {
        if (_dropdownManager.showingPopup) {
            _dropdownManager.hide(me);
            if (_dropdownManager.popup is FilterSelectorDropdown) {
                invalidateFilters();
            }
        }
    }

    protected function filterData(event:ListEvent):void
    {
        var selectedItems:Array = (event.currentTarget as List).selectedItems;

        if (selectedItems.length > 0 && selectedItems[0] == "All") {
            _grid.removeFilters(_adgListData.dataField, true);
        } else {
            _grid.addActiveFilters(_adgListData.dataField, selectedItems);
        }
    }

}
}