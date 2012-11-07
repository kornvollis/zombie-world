package  
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author OML!
	 */
	public class ExitPoint extends GameObject 
	{
		public var row : int;
		public var col : int;
		
		public var removeCallBack : Function = null;
		
		public function ExitPoint(row:int, col:int) 
		{
			this.col = col;
			this.row = row;
			//TEMP Graphics
			graphics.beginFill(0x0000FF, 1);
			graphics.drawRect(0,0, Constants.CELL_SIZE, Constants.CELL_SIZE);
			
			this.x = col * Constants.CELL_SIZE;
			this.y = row  * Constants.CELL_SIZE;
			
			addEventListener(MouseEvent.CLICK, onClick);
			addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		
		private function onClick(e:MouseEvent):void 
		{
			if (removeCallBack != null && Factory.getInstance().clickState == Factory.REMOVE)
			{
				removeCallBack();
			}
		}
		
		private function onMouseMove(e:MouseEvent):void 
		{
			if (removeCallBack != null && Factory.getInstance().clickState == Factory.REMOVE && Factory.mouseDown)
			{
				removeCallBack();
			}
		}
	}
}
