package com.neosavvy.grid {
    import flash.display.Graphics;

    import flash.display.Shape;
    import flash.display.Sprite;

    import flash.geom.Point;

    import mx.collections.ArrayCollection;
    import mx.collections.ListCollectionView;
    import mx.controls.DataGrid;
    import mx.controls.advancedDataGridClasses.AdvancedDataGridColumn;
    import mx.controls.dataGridClasses.DataGridColumn;
    import mx.controls.listClasses.ListBaseContentHolder;
    import mx.core.FlexShape;
    import mx.core.FlexSprite;
    import mx.events.ScrollEvent;
    import mx.styles.StyleManager;

    public class AsyncGrid extends DataGrid {

        private var refreshing:Boolean = false;

        private var asyncOverlayShapes:Array = new Array();

        protected override function createChildren():void {
            super.createChildren();
            addEventListener(AsyncRowEvent.TYPE, handleAsyncTriggerClicked);
        }

        private function handleAsyncTriggerClicked(event:AsyncRowEvent):void {

            trace("clicking async trigger");

            (event.data as AsyncDataDTO).requestingAsync = !(event.data as AsyncDataDTO).requestingAsync;

            invalidateDisplayList();

        }

        protected override function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {

            super.updateDisplayList(unscaledWidth, unscaledHeight);

            drawAsyncOverlays();

            if ( horizontalScrollBar && verticalScrollBar )
            {
                horizontalScrollBar.width = this.width - lockedColumnWidth - verticalScrollBar.width;
                horizontalScrollBar.move( lockedColumnWidth, horizontalScrollBar.y );
            }

        }

        public function toggleRefreshingOverlay():void
        {
            if ( !refreshing ) {
                drawRefreshingGridOverlay( listContent, 0x000000 );
            }
            else
            {
                removeRefreshingGridOverlay( listContent );
            }
            refreshing = !refreshing;
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

            trace("actualRow:"+ actualRow);

            var newAsyncOverlays:Array = new Array();

            var dataProviderCollection:ListCollectionView = dataProvider as ListCollectionView;
            while (curRow < n && dataProviderCollection && curRow + verticalScrollPosition < dataProviderCollection.length)
            {

                var itemAt:Object = dataProviderCollection.getItemAt( curRow + verticalScrollPosition );
                var asyncObjectAt:AsyncDataDTO = itemAt as AsyncDataDTO;
                if( asyncObjectAt.requestingAsync )
                {
                    drawAsyncOverlay(
                            asyncOverlays
                            , i++
                            , curRow * contentHolder.rowInfo[curRow].height
                            , contentHolder.rowInfo[curRow].height
                            , colors[actualRow % colors.length]
                            , actualRow
                            , asyncOverlayShapes
                            , newAsyncOverlays);
                }

                curRow++;
                actualRow++;
            }

            for each ( var s:Shape in asyncOverlayShapes )
            {
                s.visible = false;
                newAsyncOverlays.push( s );
            }
            asyncOverlayShapes = newAsyncOverlays;
        }


        private function removeAsyncOverlay(asyncOverlays:Sprite, rowIndex:int, y:Number, height:Number, dataIndex:int):void
        {
            if( asyncOverlays.numChildren > rowIndex )
            {
                asyncOverlays.removeChildAt( rowIndex );
            }
        }


        protected function drawAsyncOverlay(s:Sprite, rowIndex:int,
                                             y:Number, height:Number, color:uint, dataIndex:int, asyncOverlays:Array, newAsyncOverlays:Array):void
        {
            var contentHolder:ListBaseContentHolder = ListBaseContentHolder(s.parent);

            var background:Shape;
            if ( asyncOverlays.length > 0)
            {
                background = Shape( asyncOverlays.pop() );
                background.y = y;
                background.visible = true;
            }
            else
            {
                background = new FlexShape();
                background.name = "background" + rowIndex;
                s.addChild(background);

                background.y = y;
                var height:Number = Math.min(height, contentHolder.height - y);

                var g:Graphics = background.graphics;
                g.clear();
                g.beginFill(color, getStyle("backgroundAlpha"));
                g.drawRect(0, 0, contentHolder.width, height);
                g.endFill();
            }

            newAsyncOverlays.push( background );


        }

        protected function removeRefreshingGridOverlay(s:Sprite):void
        {
            var background:Shape = getChildByName("refreshingBackground") as Shape;
            removeChild( background );
            background = null;
        }

        protected function drawRefreshingGridOverlay(s:Sprite, color:uint):void
        {
            if( !horizontalScrollBar )
                return;

            var contentHolder:ListBaseContentHolder = ListBaseContentHolder(s);

            var background:Shape = getChildByName("refreshingBackground") as Shape;
            if ( !background ) {
                background = new FlexShape();
                background.name = "refreshingBackground";
                addChild(background);
                setChildIndex(background, numChildren - 1)
            }

            background.y = 0;

            var g:Graphics = background.graphics;
            g.clear();
            g.beginFill(color, .5);
            g.drawRect(lockedColumnWidth + 1, headerHeight, contentHolder.width, height - headerHeight - horizontalScrollBar.height - 1);
            g.endFill();
        }


        protected override function makeRowsAndColumns(left:Number, top:Number, right:Number, bottom:Number, firstCol:int, firstRow:int, byCount:Boolean = false, rowsNeeded:uint = 0):Point {
            var returnValue:Point = super.makeRowsAndColumns(left, top, right, bottom, firstCol, firstRow, byCount, rowsNeeded);

            drawAsyncOverlays();

            return returnValue;
        }
    }
}