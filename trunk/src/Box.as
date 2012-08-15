package  
{
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author OML!
	 */
	public class Box extends GameObject 
	{
		private var col : int = 0;
		private var row : int = 0;
		
		public function Box(row : int, col : int)  
		{
			this.col = col;
			this.row = row;
			
			this.position.x = col * Constants.CELL_SIZE;			
			this.position.y = row * Constants.CELL_SIZE;
			
			this.graphics.beginFill(0xB35900);
			this.graphics.drawRect(0, 0, Constants.CELL_SIZE, Constants.CELL_SIZE);
			
			addEventListener(MouseEvent.CLICK, onClick);
		}			
		
		private function onClick(e:MouseEvent):void 
		{
			trace("BOX click");
		}
	}

}