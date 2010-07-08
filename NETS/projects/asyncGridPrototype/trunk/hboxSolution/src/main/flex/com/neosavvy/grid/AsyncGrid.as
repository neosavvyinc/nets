package com.neosavvy.grid {
    import flash.display.Graphics;

    import mx.controls.AdvancedDataGrid;
    import mx.controls.DataGrid;
    import mx.controls.advancedDataGridClasses.AdvancedDataGridColumn;

    public class AsyncGrid extends AdvancedDataGrid {

        private var rowIndicesMap:Object = new Object();
        private var bRowIndicesMapChanged:Boolean = false;


        protected override function createChildren():void {
            super.createChildren();
            addEventListener(AsyncRowEvent.TYPE, handleAsyncTriggerClicked);
        }

        private function handleAsyncTriggerClicked(event:AsyncRowEvent):void {

            trace("clicking async trigger");

            rowIndicesMap[ event.listData.rowIndex ] = event;
            bRowIndicesMapChanged = true;
            invalidateDisplayList();

        }

        protected override function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void {

            super.updateDisplayList(unscaledWidth, unscaledHeight);

            drawAsyncRowOverlays();
        }

        public function get lockedColumnWidth() {
            var measuredWidthOfLockedColumns:int = 0;

            for ( var i:int  = 0 ; i < lockedColumnCount ; i++)
            {
                measuredWidthOfLockedColumns += (columns[i] as AdvancedDataGridColumn).width;
            }

            return measuredWidthOfLockedColumns;
        }

        public function get verticalScrollbarWidth() {
            return verticalScrollBar.getExplicitOrMeasuredWidth();
        }

        protected function drawAsyncRowOverlays() {

            var x:int = 0;
            var y:int = 0;

            var rowHeight:int = rowHeight;

            var g:Graphics = graphics;
            g.clear();

            for ( var asyncIndex in rowIndicesMap )
            {
                y = asyncIndex * rowHeight;
                x = 100;
                g.beginFill(0x0F0F0F);
                g.drawRect(x,y,100,rowHeight);
                g.endFill();
            }

        }

    }
}