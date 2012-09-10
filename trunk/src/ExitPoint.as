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
		
		public function ExitPoint(row:int, col:int) 
		{
			this.col = col;
			this.row = row;
			//TEMP Graphics
			graphics.beginFill(0x0000FF, 0.2);
			graphics.drawRect(col * Constants.CELL_SIZE, row * Constants.CELL_SIZE, Constants.CELL_SIZE, Constants.CELL_SIZE);
			
			addEventListener(MouseEvent.CLICK, onClick);
		}
		
		private function onClick(e:MouseEvent):void 
		{
			dispatchEvent(new GameEvents(GameEvents.EXIT_POINT_CLICK));
		}
	}
}
