package com.neosavvy.grid {
    import flash.display.Graphics;

    import flash.display.Shape;
    import flash.display.Sprite;

    import mx.controls.DataGrid;
    import mx.controls.advancedDataGridClasses.AdvancedDataGridColumn;
    import mx.controls.dataGridClasses.DataGridColumn;
    import mx.controls.listClasses.ListBaseContentHolder;
    import mx.core.FlexShape;
    import mx.core.FlexSprite;
    import mx.events.ScrollEvent;
    import mx.styles.StyleManager;

    public class AsyncGrid extends DataGrid {

        private var rowIndicesMap:Object = new Object();

        protected override function createChildren():void {
            super.createChildren();
            addEventListener(AsyncRowEvent.TYPE, handleAsyncTriggerClicked);
            addEventListener(ScrollEvent.SCROLL, handleScrollEvent);
        }

        private function handleScrollEvent(event:ScrollEvent):void {

            trace("handling scroll event");

            var change:int = event.delta;
            var direction:String = event.direction;

            trace("change: " + change);
            trace("direction: " + direction);

            dumpRowIndicesMap();
            if( event.direction == "vertical")
            {

                var newRowIndicesMap:Object = new Object();
                for ( var key:Object in rowIndicesMap )
                {
                    var keyNum:int = key as int;
                    keyNum = (keyNum - event.delta);
                    newRowIndicesMap[ keyNum ] = rowIndicesMap[ key ];

                }
                rowIndicesMap = newRowIndicesMap;
                invalidateDisplayList();

            }
            dumpRowIndicesMap();

        }

        private function handleAsyncTriggerClicked(event:AsyncRowEvent):void {

            trace("clicking async trigger");

            if( rowIndicesMap.hasOwnProperty(event.listData.rowIndex ) )
            {
                delete rowIndicesMap[ event.listData.rowIndex ];
            }
            else
            {
                rowIndicesMap[ event.listData.rowIndex ] = event;
            }

            invalidateDisplayList();

        }

        protected override function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {

            super.updateDisplayList(unscaledWidth, unscaledHeight);

            drawAsyncOverlays();
        }

        public function get lockedColumnWidth() {
            var measuredWidthOfLockedColumns:int = 0;

            for (var i:int = 0; i < lockedColumnCount; i++)
            {
                measuredWidthOfLockedColumns += (columns[i] as DataGridColumn).width;
            }

            return measuredWidthOfLockedColumns;
        }


        /**
         *  @private
         */
        protected function drawAsyncOverlays():void
        {
            var contentHolder:ListBaseContentHolder = listContent;
            var asyncOverlays:Sprite = Sprite(contentHolder.getChildByName("asyncOverlays"));
            if (!asyncOverlays)
            {
                asyncOverlays = new FlexSprite();
                asyncOverlays.mouseEnabled = false;
                asyncOverlays.name = "asyncOverlays";
                contentHolder.addChild(asyncOverlays);
            }
            contentHolder.setChildIndex(asyncOverlays, contentHolder.numChildren - 1);

            var colors:Array;

            colors = [0x454545];

            if (!colors || colors.length == 0)
            {
                while (asyncOverlays.numChildren > n)
                {
                    asyncOverlays.removeChildAt(asyncOverlays.numChildren - 1);
                }
                return;
            }

            StyleManager.getColorNames(colors);

            var curRow:int = 0;

            var i:int = 0;
            var actualRow:int = verticalScrollPosition;
            var n:int = contentHolder.listItems.length;

            dumpRowIndicesMap();
            while (curRow < n)
            {
                if( rowIndicesMap.hasOwnProperty(curRow) )
                {
                    drawAsyncOverlay(asyncOverlays, i++, contentHolder.rowInfo[curRow].y, contentHolder.rowInfo[curRow].height,
                            colors[actualRow % colors.length], actualRow);
                }
//                else
//                {
//                    removeAsyncOverlay(asyncOverlays, i++, contentHolder.rowInfo[curRow].y, contentHolder.rowInfo[curRow].height,
//                            actualRow);
//                }
                curRow++;
                actualRow++;
            }

            while (asyncOverlays.numChildren > i)
            {
                asyncOverlays.removeChildAt(asyncOverlays.numChildren - 1);
            }
        }

        private function dumpRowIndicesMap():void {
            for (var key:Object in rowIndicesMap)
            {
                trace("key: " + key);
            }
        }

        private function removeAsyncOverlay(asyncOverlays:Sprite, rowIndex:int, y:Number, height:Number, dataIndex:int):void
        {
            if( asyncOverlays.numChildren > rowIndex )
            {
                asyncOverlays.removeChildAt( rowIndex );
            }
        }


        protected function drawAsyncOverlay(s:Sprite, rowIndex:int,
                                             y:Number, height:Number, color:uint, dataIndex:int):void
        {
            var contentHolder:ListBaseContentHolder = ListBaseContentHolder(s.parent);

            var background:Shape;
            if (rowIndex < s.numChildren)
            {
                background = Shape(s.getChildAt(rowIndex));
            }
            else
            {
                background = new FlexShape();
                background.name = "background";
                s.addChild(background);
            }

            background.y = y;

            // Height is usually as tall is the items in the row, but not if
            // it would extend below the bottom of listContent
            var height:Number = Math.min(height,
                    contentHolder.height -
                            y);

            var g:Graphics = background.graphics;
            g.clear();
            g.beginFill(color, getStyle("backgroundAlpha"));
            g.drawRect(0, 0, contentHolder.width, height);
            g.endFill();
        }
    }
}