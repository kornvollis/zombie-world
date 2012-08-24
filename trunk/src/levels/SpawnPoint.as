package levels 
{
	import fl.controls.Label;
	/**
	 * ...
	 * @author OML!
	 */
	public class SpawnPoint extends GameObject 
	{
		public var row: int;
		public var col: int;
		public var label : Label = new Label();
		public function SpawnPoint(row : int , col : int) 
		{
			this.col = col;
			this.row = row;
			
			position.x = col * Constants.CELL_SIZE + Constants.CELL_SIZE / 2;
			position.y = row * Constants.CELL_SIZE + Constants.CELL_SIZE / 2;
			
			this.x = position.x;
			this.y = position.y;
			
			//TMEP GRAPHICS
			
			this.graphics.lineStyle(3,0x009900);
			this.graphics.drawCircle(0, 0, Constants.CELL_SIZE / 2);
			this.graphics.drawCircle(0, 0, 8);
			this.graphics.drawCircle(0, 0, 4);
				
			
			label.x = position.x - 15;
			label.y = position.y + 9;
			
			label.text = row + "/" + col ;			
		}
		
		override public function toString():String {
			return row + "/" + col;
		};
		
	}

}