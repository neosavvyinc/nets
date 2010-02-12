package com.neosavvy.grid {
import flash.events.Event;
import flash.events.MouseEvent;

import mx.binding.utils.BindingUtils;
import mx.collections.ArrayCollection;
import mx.containers.HBox;
import mx.controls.ComboBox;
import mx.controls.Label;
import mx.controls.LinkButton;
import mx.controls.Spacer;
import mx.events.ListEvent;
import mx.styles.CSSStyleDeclaration;
import mx.styles.StyleManager;

[Style(name="pageSelectPrevButtonStyleName",type="String",inherit="no")]
[Style(name="pageSelectNextButtonStyleName",type="String",inherit="no")]
[Style(name="paginationCntrlComboStyleName",type="String",inherit="no")]

public class PaginationControlBox extends HBox {
    public static const ALL_RECORDS:String = "All";

    private var _grid:AutoFilteringGrid;

    private var _rangeDisplayLbl:Label;

    private var _spacer1:Spacer;

    private var _recPerPageBox:HBox;
    private var _recPerPageLblOne:Label;
    private var _recPerPageLblTwo:Label;
    private var _recPerPageCombo:ComboBox;
    public var defaultRecPerPageComboToAll:Boolean = false;

    private var _spacer2:Spacer;

    private var _pageSelectBox:HBox;
    private var _pageSelectPage:Label;
    private var _pageSelectOf:Label;
    private var _pageSelectCombo:ComboBox;
    private var _pageSelectPrev:LinkButton;
    private var _pageSelectNext:LinkButton;

    public static const CLASS_NAME: String = "PaginationControlBox";
    private static var classConstructed: Boolean = classConstruct();

    private static function classConstruct(): Boolean {
        var selector: CSSStyleDeclaration = StyleManager.getStyleDeclaration(CLASS_NAME);

        if (!selector) {
            selector = new CSSStyleDeclaration();
        }

        selector.defaultFactory = function(): void
        {
            this.pageSelectPrevButtonStyleName = "pageSelectPrevButton";
            this.pageSelectNextButtonStyleName = "pageSelectNextButton";
            this.paginationCntrlComboStyleName = "paginationCntrlCombo";
        };

        StyleManager.setStyleDeclaration(CLASS_NAME, selector, false);
        return true;
    }


    public function set autoFilteringGrid(grid:AutoFilteringGrid):void {
        _grid = grid;

        BindingUtils.bindSetter(updateRangeDisplayLbl, _grid, "pageStartIndex");
        BindingUtils.bindSetter(updateRangeDisplayLbl, _grid, "pageEndIndex");
        BindingUtils.bindSetter(updateRangeDisplayLbl, _grid, "maxRecords");
        BindingUtils.bindSetter(populatePageSelectCombo, _grid, "numOfPages");
        BindingUtils.bindSetter(updateMaxPagesLbl, _grid, "numOfPages");
        BindingUtils.bindSetter(updateCurrentPageSelection, _grid, "currentPage");
        BindingUtils.bindSetter(updateRecPerPageCombo, _grid, "itemsPerPageComboSelection");

        invalidateProperties();
    }
    
    public function get autoFilteringGrid():AutoFilteringGrid {
      return _grid;
    }

    protected function updateRecPerPageCombo(val:Object):void {   
      if(!_grid.paginationEnabled) {
        _recPerPageCombo.selectedItem = ALL_RECORDS;
      }
      else {
       var index:int = (_recPerPageCombo.dataProvider as ArrayCollection).getItemIndex(val);
       if(index != -1) {
        _recPerPageCombo.selectedIndex = index;
       }        
      }        
    }
    
    protected function updateRangeDisplayLbl(val:Object):void {
        var recStart:int = _grid.pageStartIndex;
        var recEnd:int = _grid.pageEndIndex;

        if (_grid.maxRecords > 0) {
            recStart++;
            recEnd++;
        }

        var text:String = "";
        text += "Displaying records ";
        text += "<b>" + recStart + "</b>";
        text += " -  ";
        text += "<b>" + recEnd + "</b>";
        text += " of ";
        text += "<b>" + (_grid.maxRecords) + "</b>";
        text += ".";

        _rangeDisplayLbl.htmlText = text;
    }

    /**
     * Changes how many records per page are visible
     */
    protected function recPerPageComboHandler(evt:ListEvent):void {
        var selectedOption:Object = _recPerPageCombo.selectedItem;
        if (selectedOption == ALL_RECORDS) {
            _grid.enablePagination(false);
            _grid.itemsPerPage = _grid.maxRecords;
        }
        else if (!_grid.paginationEnabled) {
            _grid.enablePagination(true, selectedOption as int);
            _grid.itemsPerPageComboSelection = selectedOption as int;
        }
        else {
            _grid.itemsPerPage = selectedOption as int;
            _grid.itemsPerPageComboSelection = selectedOption as int;
        }
    }

    /**
     * Sets options for 'number of records per page' combo selector
     */
    public function set recPerPageOptions(options:Array):void {
        if (options && options.length > 0) {
            _recPerPageCombo.dataProvider = options;

            if (defaultRecPerPageComboToAll) {
                var index:int = new ArrayCollection(options).getItemIndex(ALL_RECORDS);
                if (index != -1) {
                    _recPerPageCombo.selectedIndex = index;
                }
            }
        }
    }

    /**
     * Populates a comso selector that allows one to
     * jump to a particular page
     */
    protected function populatePageSelectCombo(numOfPages:int):void {
        var comboData:Array = [];
        for (var i:int = 0; i < numOfPages; i++) {
            comboData.push(i + 1);
        }
        _pageSelectCombo.dataProvider = comboData;
    }

    protected function pageSelectComboChangeHandler(evt:ListEvent):void {
        _grid.goToPage(_pageSelectCombo.selectedIndex + 1);
    }

    protected function pageSelectNextClickHandler(evt:Event):void {
        _grid.nextPage();
    }

    protected function pageSelectPrevClickHandler(evt:Event):void {
        _grid.prevPage();
    }

    protected function updateMaxPagesLbl(numOfPages:int):void {
        var text:String = "";
        text += "of  ";
        text += "<b>" + numOfPages + "</b>";

        _pageSelectOf.htmlText = text;
    }

    protected function updateCurrentPageSelection(currentPage:int):void {
        _pageSelectCombo.selectedIndex = currentPage - 1;
    }

    override protected function createChildren():void {
        super.createChildren();

        // ******* RECORD RANGE DISPLAY *******
        if (!_rangeDisplayLbl) {
            _rangeDisplayLbl = new Label();
            this.addChild(_rangeDisplayLbl);
        }
        // ************************************

        if (!_spacer1)
        {
            _spacer1 = new Spacer();
            _spacer1.width = 20;

            this.addChild(_spacer1);
        }

        // ******* RECORDS PER PAGE SELECTION *******
        if (!_recPerPageBox) {
            _recPerPageBox = new HBox();

            this.addChild(_recPerPageBox);
        }

        if (!_recPerPageLblOne) {
            _recPerPageLblOne = new Label();
            _recPerPageLblOne.text = "Display";

            _recPerPageBox.addChild(_recPerPageLblOne);
        }

        if (!_recPerPageCombo) {
            _recPerPageCombo = new ComboBox();
            _recPerPageCombo.addEventListener(ListEvent.CHANGE, recPerPageComboHandler, false, 0, true);
            _recPerPageCombo.styleName = getStyle("paginationCntrlComboStyleName");

            _recPerPageBox.addChild(_recPerPageCombo);

        }

        if (!_recPerPageLblTwo) {
            _recPerPageLblTwo = new Label();
            _recPerPageLblTwo.htmlText = "<b>Records</b> per <b>Page</b>";

            _recPerPageBox.addChild(_recPerPageLblTwo);
        }
        // ************************************

        if (!_spacer2) {
            _spacer2 = new Spacer();
            _spacer2.width = 20;

            this.addChild(_spacer2);
        }

        // ******* PAGE SELECTION *******
        if (!_pageSelectBox) {
            _pageSelectBox = new HBox();

            this.addChild(_pageSelectBox);
        }

        if (!_pageSelectPage) {
            _pageSelectPage = new Label();
            _pageSelectPage.text = "Page";

            _pageSelectBox.addChild(_pageSelectPage);
        }

        if (!_pageSelectPrev) {
            _pageSelectPrev = new LinkButton();
            _pageSelectPrev.addEventListener(MouseEvent.CLICK, pageSelectPrevClickHandler, false, 0, true);
            _pageSelectPrev.styleName = getStyle("pageSelectPrevButtonStyleName");

            _pageSelectBox.addChild(_pageSelectPrev);
        }

        if (!_pageSelectCombo) {
            _pageSelectCombo = new ComboBox();
            _pageSelectCombo.addEventListener(ListEvent.CHANGE, pageSelectComboChangeHandler, false, 0, true);
            _pageSelectCombo.styleName = getStyle("paginationCntrlComboStyleName");

            _pageSelectBox.addChild(_pageSelectCombo);
        }

        if (!_pageSelectNext) {
            _pageSelectNext = new LinkButton();
            _pageSelectNext.addEventListener(MouseEvent.CLICK, pageSelectNextClickHandler, false, 0, true);
            _pageSelectNext.styleName = getStyle("pageSelectNextButtonStyleName");

            _pageSelectBox.addChild(_pageSelectNext);
        }

        if (!_pageSelectOf) {
            _pageSelectOf = new Label();

            _pageSelectBox.addChild(_pageSelectOf);
        }
        // ************************************
    }


}
}