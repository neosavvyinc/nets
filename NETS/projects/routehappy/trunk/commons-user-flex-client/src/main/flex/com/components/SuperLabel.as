package com.components
{
    import flash.display.DisplayObject;
    import flash.events.Event;
    import flash.geom.Rectangle;
    import flash.text.TextLineMetrics;

    import mx.controls.ButtonLabelPlacement;
    import mx.controls.Label;
    import mx.core.UITextField;
    import mx.core.mx_internal;

    use namespace mx_internal;

  //---------------------------------
  // Styles
  //---------------------------------
  /**
   *  Name of the class to use as the icon
   *
   *  @default null
   */
  [Style(name="icon", type = "Class", inherit = "no")]
  
  /**
   *  When true, forces the text to uppercase.
   *
   *  @default null
   */
  [Style(name="forceUppercase", type = "String", inherit = "no")]
  
  /**
   *  Gap between the label and icon, when the <code>labelPlacement</code> property
   *  is set to <code>left</code> or <code>right</code>.
   *
   *  @default 2
   */
  [Style(name="horizontalGap", type = "Number", format = "Length", inherit = "no")]

  /**
   * A custom Label that provides functionality to specify an icon.
   *
   * @author jjung
   */
  public class SuperLabel extends Label
  {
    //---------------------------------------------------------------------
    //
    // Variables
    //
    //---------------------------------------------------------------------
    /**
     * The icon that is being displayed.
     */
    protected var _icon : DisplayObject;

    //---------------------------------------------------------------------
    //
    // Properties
    //
    //---------------------------------------------------------------------
    //----------------------------------
    //  htmlText
    //----------------------------------
    /**
     *  @private
     */
    override public function set htmlText(value : String) : void
    {
      throw new Error("htmlText cannot be set on SuperLabel because necessary properties are private on Label.");
    }

    //----------------------------------
    //  labelPlacement
    //----------------------------------

    /**
     *  @private
     *  Storage for labelPlacement property.
     */
    protected var _labelPlacement : String = ButtonLabelPlacement.RIGHT;

    [Bindable("labelPlacementChanged")]
    [Inspectable(category="General", enumeration = "left,right", defaultValue = "right")]

    /**
     * Orientation of the text in relation to the icon, if one is specified.
     * Valid MXML values are <code>right</code> and <code>left</code>.
     *
     * <p>In ActionScript, you can use the following constants
     * to set this property:
     * <code>ButtonLabelPlacement.RIGHT</code>,
     * <code>ButtonLabelPlacement.LEFT</code>.</p>
     *
     * @default ButtonLabelPlacement.RIGHT
     */
    public function get labelPlacement() : String
    {
      return _labelPlacement;
    }

    /**
     * @private
     */
    public function set labelPlacement(value : String) : void
    {
      _labelPlacement = value;

      invalidateSize();
      invalidateDisplayList();

      dispatchEvent(new Event("labelPlacementChanged"));
    }

    //----------------------------------
    //  toolTip
    //----------------------------------
    /**
     *  @private
     */
    private var toolTipSet : Boolean = false;

    /**
     *  @private
     */
    override public function set toolTip(value : String) : void
    {
      super.toolTip = value;

      toolTipSet = value != null;
    }
    
    //---------------------------------------------------------------------
    //
    // Overridden methods
    //
    //---------------------------------------------------------------------
    /**
     * @inheritDoc
     */
    override protected function createChildren() : void
    {
      super.createChildren();

      if (getStyle("icon")is Class)
      {
        _icon = new(getStyle("icon")as Class)();

        addChild(_icon as DisplayObject);
      }
    }

    /**
     *  @private
     */
    override protected function measure() : void
    {
      super.measure();

      var textWidth : Number = 0;
      var textHeight : Number = 0;

      getMinimumText(text);

      // Determine how large the textField would need to be
      // to display the entire text.
      var textFieldBounds : Rectangle = measureTextFieldBounds(text);

      textWidth = textFieldBounds.width;
      textHeight = textFieldBounds.height;

      var iconWidth : Number = _icon ? _icon.width : 0;
      var iconHeight : Number = _icon ? _icon.height : 0;

      var w : Number = 0;
      var h : Number = 0;

      w = textWidth + iconWidth;

      if (textWidth && iconWidth)
      {
        w += getStyle("horizontalGap");
      }

      h = Math.max(textHeight, iconHeight);

      w += getStyle("paddingLeft") + getStyle("paddingRight");
      h += getStyle("paddingTop") + getStyle("paddingBottom");

      measuredMinWidth = measuredWidth = w;
      measuredMinHeight = measuredHeight = h;
    }

    /**
     * @inheritDoc
     */
    override protected function commitProperties():void
    {
      if (textChanged)
      {
        var forceUppercase : Object = getStyle("forceUppercase");
        
        if (forceUppercase && forceUppercase is String && (forceUppercase as String).toUpperCase() == "YES")
        {
          text = text.toUpperCase();
        }
      }
      
      super.commitProperties();
    }
    
    /**
     *  @private
     */
    override protected function updateDisplayList(unscaledWidth : Number, unscaledHeight : Number) : void
    {
      super.updateDisplayList(unscaledWidth, unscaledHeight);

      var paddingLeft : Number = getStyle("paddingLeft");
      var paddingTop : Number = getStyle("paddingTop");
      var paddingRight : Number = getStyle("paddingRight");
      var paddingBottom : Number = getStyle("paddingBottom");
      var horizontalGap : Number = !isNaN(getStyle("horizontalGap")) ? getStyle("horizontalGap") : 2;

      var iconWidth : Number = _icon ? _icon.width : 0;

      if (iconWidth)
      {
        textField.setActualSize(unscaledWidth - paddingLeft - paddingRight - horizontalGap - iconWidth, unscaledHeight - paddingTop - paddingBottom);
      }
      else
      {
        textField.setActualSize(unscaledWidth - paddingLeft - paddingRight, unscaledHeight - paddingTop - paddingBottom);
      }

      if (labelPlacement == ButtonLabelPlacement.LEFT || !_icon)
      {
        textField.x = paddingLeft;
        textField.y = paddingTop;

        if (_icon)
        {
          _icon.x = paddingLeft + textField.width + horizontalGap;
          _icon.y = paddingTop;
        }
      }
      else
      {
        textField.x = paddingLeft + iconWidth + horizontalGap;
        textField.y = paddingTop;

        if (_icon)
        {
          _icon.x = paddingLeft;
          _icon.y = paddingTop;
        }
      }

      // Determine how large the textField would need to be
      // to display the entire text.
      var textFieldBounds : Rectangle = measureTextFieldBounds(text);

      // Plain text gets truncated with a "...".
      // HTML text simply gets clipped, because it is difficult
      // to skip over the markup and truncate only the non-markup.
      // But both plain text and HTML text gets an automatic tooltip
      // if the full text isn't visible.
      if (truncateToFit)
      {
        var truncated : Boolean;

        // Reset the text in case it was previously
        // truncated with a "...".
        textField.text = text;

        // Determine whether the full text needs to be truncated
        // based on the actual size of the TextField.
        // Note that the actual size doesn't change;
        // the text changes to fit within the actual size.
        truncated = textField.truncateToFit();

        // If no explicit tooltip has been set,
        // implicitly set or clear a "truncation tip".
        if (!toolTipSet)
          super.toolTip = truncated ? text : null;
      }

    }

    //---------------------------------------------------------------------
    //
    // Methods
    //
    //---------------------------------------------------------------------
    /**
     *  @private
     */
    private function measureTextFieldBounds(s : String) : Rectangle
    {
      // Measure the text we need to display.
      var lineMetrics : TextLineMetrics = measureText(s);

      // In order to display this text completely,
      // a TextField must be 4-5 pixels larger.
      return new Rectangle(0, 0, lineMetrics.width + UITextField.TEXT_WIDTH_PADDING, lineMetrics.height + UITextField.TEXT_HEIGHT_PADDING);
    }

    //---------------------------------------------------------------------
    //
    // Constructor
    //
    //---------------------------------------------------------------------
    /**
     * Constructor
     */
    public function SuperLabel()
    {
      super();
    }
  }
}