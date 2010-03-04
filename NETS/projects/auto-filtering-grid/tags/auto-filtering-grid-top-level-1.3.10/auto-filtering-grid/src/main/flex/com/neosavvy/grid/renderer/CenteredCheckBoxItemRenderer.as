package com.neosavvy.grid.renderer {
    import com.neosavvy.grid.PickFilterRow;
    import com.neosavvy.grid.event.PickFilterGridEvent;

    import flash.display.DisplayObject;
    import flash.events.MouseEvent;

    import flash.text.TextField;

    import mx.controls.CheckBox;
    import mx.controls.dataGridClasses.DataGridListData;

    /***
     * Thanks to this blog location for the code in this file
     * http://www.benclinkinbeard.com/2007/11/efficient-reusable-and-centered-checkbox-renderers-for-datagrids/
     *
     * It was helpful not to have to write these few lines of code.
     */
    public class CenteredCheckBoxItemRenderer extends CheckBox
    {
        // update data item on click
        override protected function clickHandler(event:MouseEvent):void
        {
            super.clickHandler(event);
            data[DataGridListData(listData).dataField] = selected;

            dispatchEvent(new PickFilterGridEvent(PickFilterGridEvent.ITEM_SELECTED, data as PickFilterRow));
        }

        // center the checkbox icon
        override protected function updateDisplayList(w:Number, h:Number):void
        {
            super.updateDisplayList(w, h);

            var n:int = numChildren;
            for (var i:int = 0; i <n; i++)
            {
                var c:DisplayObject = getChildAt(i);
                // CheckBox component is made up of box skin and label TextField
                if (!(c is TextField))
                {
                    c.x = (w - c.width) / 2;
                    c.y = (h - c.height) / 2;
                }
            }
        }
    }
}