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
		
		public var clickCallBack : Function = null;
		
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
		}
		
		private function onClick(e:MouseEvent):void 
		{
			if (clickCallBack != null && Factory.getInstance().clickState == Factory.REMOVE_EXIT)
			{
				clickCallBack();
			}
		}
	}
}
