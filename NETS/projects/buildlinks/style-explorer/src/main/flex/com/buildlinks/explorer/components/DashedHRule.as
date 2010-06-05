package com.buildlinks.explorer.components
{
	import mx.core.UIComponent;

    public class DashedHRule extends UIComponent
    {
        private var _lineHeight:Number=10;
        private var _lineLength:Number=10;
        private var _gapLength:Number=5;
        private var _useRects:Boolean=true;
        public var color:uint=0x000000;
        
        public function DashedHRule()
        {
            super();
        }
        public function set gapLength(value:Number):void
        {
            _gapLength=value;
            invalidateDisplayList();
        }
        public function get gapLength():Number
        {
            return _gapLength;
        }
        public function set lineLength(value:Number):void
        {
            _lineLength=value;
            invalidateDisplayList();
        }
        public function get lineLength():Number
        {
            return _lineLength;
        }
        public function set lineHeight(value:Number):void
        {
            _lineHeight=value;
            invalidateDisplayList();
        }
        public function get lineHeight():Number
        {
            return _lineHeight;
        }
        public function set useRects(value:Boolean):void
        {
            _useRects=value;
            invalidateDisplayList();
        }
        public function get useRects():Boolean
        {
            return _useRects;
        }
        override protected function measure():void
        {
            minHeight=0;
            maxHeight=100;
            measuredHeight=lineHeight;
        }
        override protected function updateDisplayList(w:Number, h:Number):void
        {
            var segmentLength:Number=(lineLength+gapLength);
            var numberOfLinesWGaps:Number=Math.floor(w/segmentLength);
            
            graphics.clear();
            
            if(useRects)
                graphics.beginFill(color,lineHeight)
            else
                graphics.lineStyle(lineHeight,color,1,true);
            
            for(var i:int=0;i<numberOfLinesWGaps;i++)
            {
                if(useRects)
                    graphics.drawRect(i*segmentLength,0,lineLength,lineHeight);
                else
                {
                    graphics.lineTo(lineLength+i*segmentLength,0);
                    graphics.moveTo(segmentLength*(i+1),0);
                }
            }
            
            if(useRects)
            {
                var lastRectWidth:Number=Math.min(w-numberOfLinesWGaps*segmentLength,lineLength);
                graphics.drawRect(numberOfLinesWGaps*segmentLength,0,lastRectWidth,lineHeight);
            }
            else
            {
                var lastLineWidth:Number=Math.min(w-numberOfLinesWGaps*segmentLength, lineLength);
                graphics.lineTo(numberOfLinesWGaps*segmentLength+lastLineWidth,0);
            }
        }
    }
}
