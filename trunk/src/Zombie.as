package  
{
	import adobe.utils.CustomActions;
	/**
	 * ...
	 * @author OML!
	 */
	public class Zombie extends GameObject 
	{
		private var speed : int = 100;
		private var life  : int = 3;
				
		private var cellX : int = 0;
		private var cellY : int = 0;
		
		public function Zombie(cellX : int, cellY : int) 
		{
			this.cellX = cellX;
			this.cellY = cellY;
			
			this.posX = cellX * Constants.GRID_SIZE;			
			this.posY = cellY * Constants.GRID_SIZE;
			
			this.graphics.beginFill(0x009900);
			this.graphics.drawCircle(Constants.GRID_SIZE/2, Constants.GRID_SIZE/2, Constants.GRID_SIZE/2);
		}
		
		public function MoveTo(cell : Cell):void 
		{
			
		}
	}
}