package com.neosavvy.grid.controller {
  import flash.events.Event;
  import flash.geom.Point;
  import flash.geom.Rectangle;
  
  import mx.core.IFactory;
  import mx.core.UIComponent;
  import mx.core.UIComponentGlobals;
  import mx.core.mx_internal;
  import mx.effects.Tween;
  import mx.events.DropdownEvent;
  import mx.managers.PopUpManager;

  use namespace mx_internal;

  public class DropdownManager {
    public static const DIRECTION_UP:String = "up";
    public static const DIRECTION_DOWN:String = "down";
    
    protected var _parent:UIComponent;
    protected var _popup:UIComponent;
    
    protected var _triggerEvent:Event;
    protected var _tween:Tween = null;
    protected var _tweenUp:Boolean = false;
    protected var _inTween:Boolean = false;
    protected var _showingPopup:Boolean = false;
    protected var _bRemovePopup:Boolean = false;
    protected var _cachedPopup:Boolean;
    
    public var popupFactory:IFactory;

    /**
     * Constructor 
     */
    public function DropdownManager(parent:UIComponent, defaultFactory:IFactory = null, cachedPopup:Boolean = false) {
      _parent = parent;
      _cachedPopup = cachedPopup;
      if(defaultFactory != null) {
        factory = defaultFactory;
      }
      _parent.addEventListener(Event.UNLOAD, parent_unloadHandler);
      _parent.addEventListener(Event.ADDED_TO_STAGE, parent_addedToStage);
      _parent.addEventListener(Event.REMOVED_FROM_STAGE, parent_removedFromStage);
    }

    public function get parent():UIComponent {
      return _parent;
    }
    
    public function get popup():UIComponent {
      return getPopup();
    }
    
    public function show(direction:String = DIRECTION_DOWN, offset:Object = null):void {
      displayPopup(true, null, direction, offset);
    }
    
    public function hide(triggerEvent:Event = null):void {
      if (_showingPopup) {
        displayPopup(false, triggerEvent);
      }
    }
    
    public function hasPopup():Boolean {
      return _popup != null;
    }

    public function get showingPopup():Boolean {
      return _showingPopup;
    }
    
    public function set factory(newFactory:IFactory):void{
      popupFactory = newFactory;
      displayPopup(false);
      _showingPopup =false;
      _inTween=false;
      PopUpManager.removePopUp(_popup);
      destroyPopup();
    }

    protected function getPopup():UIComponent {
      if (!_parent.initialized) {
        return null;
      }
      
      if (!hasPopup() && popupFactory) {
        _popup = popupFactory.newInstance();
        _popup.visible = false;
        _popup.focusEnabled = false;
        _popup.owner = _parent;
        
        PopUpManager.addPopUp(_popup, _parent);

        UIComponentGlobals.layoutManager.validateClient(_popup, true);
        
        _popup.setActualSize(_popup.getExplicitOrMeasuredWidth(), _popup.getExplicitOrMeasuredHeight());
        _popup.validateDisplayList();
        _popup.cacheAsBitmap = true; 
        
        _parent.systemManager.addEventListener(Event.RESIZE, stage_resizeHandler, false, 0, true);
      }
      
      _popup.scaleX = _parent.scaleX;
      _popup.scaleY = _parent.scaleY;
      
      return _popup;
    }

    protected function displayPopup(show:Boolean, triggerEvent:Event = null, direction:String = DIRECTION_DOWN, offset:Object = null):void {
      if (!_parent.initialized || show == _showingPopup) {
        return;
      }
    
      var initY:Number;
      var endY:Number;
      var duration:Number = 250;
      var easingFunction:Function;
      var point:Point = new Point(0, _parent.getExplicitOrMeasuredHeight());
      
      point = _parent.localToGlobal(point);
    
      if (show) {
        getPopup();
      
        if (_popup.parent == null) {
          PopUpManager.addPopUp(_popup, _parent);
        }
        else {
          PopUpManager.bringToFront(_popup);
        }
      
        point = _popup.parent.globalToLocal(point);
        
        if (direction == DIRECTION_UP || point.y + _popup.height > _parent.screen.height && point.y > _popup.height) {
          point.y -= _parent.getExplicitOrMeasuredHeight() + _popup.height;
          initY = -_popup.height;
          _tweenUp = true;
        }
        else {
          initY = _popup.height;
          _tweenUp = false;
        }

        if (offset != null) {
          if (offset.hasOwnProperty("x") && isValidNumber(offset["x"])) {
            point.x += Number(offset["x"]);
          }
          
          if (offset.hasOwnProperty("y") && isValidNumber(offset["y"])) {
            point.y += Number(offset["y"]);
          }
        }

        // shift left if there's not enough space to the right of the dropdown
        if (point.x + _popup.width > _parent.screen.width) {
          point.x = _parent.screen.width - _popup.width - 10;
        }

        if (_popup.x != point.x || _popup.y != point.y) {          
          _popup.move(point.x, point.y);
        }
      
        _popup.scrollRect = new Rectangle(0, initY, _popup.width, _popup.height);
        
        if (!_popup.visible) {
          _popup.visible = true;
        }
      
        _bRemovePopup = false;
        _showingPopup = show;

        endY = 0;
      }
      else if (_popup) {
        point = _popup.parent.globalToLocal(point);
        endY = (point.y + _popup.height > _parent.screen.height || _tweenUp ? -_popup.height : _popup.height);
        _showingPopup = show;
        initY = 0;
      }
    
      _inTween = true;
      UIComponentGlobals.layoutManager.validateNow();
      UIComponent.suspendBackgroundProcessing();
      
      if (_popup) {
        _popup.enabled = false;
      }
      
      duration = Math.max(1, duration);
      _tween = new Tween(this, initY, endY, duration);

      _triggerEvent = triggerEvent;
    }

    protected function destroyPopup():void {
      if (_popup && !_showingPopup) {
        if (_inTween) {
          _tween.endTween();
        }
        else {
          PopUpManager.removePopUp(_popup);
          _popup = null;
        }
      }
    }

    protected function dispatchDropdownEvent():void {
      var de:DropdownEvent = new DropdownEvent(_showingPopup ? DropdownEvent.OPEN : DropdownEvent.CLOSE);
      de.triggerEvent = _triggerEvent;
      _parent.dispatchEvent(de);
    }

    protected function parent_unloadHandler(event:Event):void {
      if (_inTween) {
        UIComponent.resumeBackgroundProcessing();
        _inTween = false;
      }
      
      if (_popup) {
        _popup.parent.removeChild(_popup);
      }
    }
    
    protected function parent_removedFromStage(event:Event):void {
      destroyPopup();
    }
    
    protected function parent_addedToStage(event:Event):void {
      if (_cachedPopup) {
        getPopup();
      }
    }

    protected function stage_resizeHandler(event:Event):void {
      if (_popup) {
        _popup.$visible = false;
        _showingPopup = false;
      }
    }
    
    mx_internal function onTweenUpdate(value:Number):void {
      if (_popup) {
        _popup.scrollRect = new Rectangle(0, value, _popup.width, _popup.height);
      }
    }

    mx_internal function onTweenEnd(value:Number):void {
      if (_popup) {
        _popup.scrollRect = null;
        _inTween = false;
        _popup.enabled = true;
        _popup.visible = _showingPopup;
      }
      
      if (_bRemovePopup) {
        PopUpManager.removePopUp(_popup);
        _popup = null;
        _bRemovePopup = false;
      }
      
      UIComponent.resumeBackgroundProcessing();
      dispatchDropdownEvent();
    }
    
    public function isValidNumber(value:*):Boolean {
       return (value != null &&
               value != 'undefined' &&
               !isNaN(value) &&
               value != Infinity &&
               value != -Infinity);
    }

  }
}