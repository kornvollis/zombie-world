package  
{
	/**
	 * ...
	 * @author OML!
	 */
	public class Survivor extends GameObject 
	{
		private var speed : int = 100;
		private var life  : int = 3;
		public var row : int = 0;
		public var col: int = 0;
		
		public function Survivor(row  : int, col : int)
		{
			this.row = row;
			this.col = col;
			
			this.position.x = col * Constants.CELL_SIZE;			
			this.position.y = row * Constants.CELL_SIZE;
			
			this.graphics.beginFill(0x000099);
			this.graphics.drawCircle(Constants.CELL_SIZE/2, Constants.CELL_SIZE/2, Constants.CELL_SIZE/2);
		}
		
	}

}