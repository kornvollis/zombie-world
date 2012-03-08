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

		private var _cellX : int = 0;
		private var _cellY : int = 0;
		
		public function Survivor(cellY  : int, cellX : int)
		{
			this.cellX = cellX;
			this.cellY = cellY;
			
			this.posX = cellX * Constants.GRID_SIZE;			
			this.posY = cellY * Constants.GRID_SIZE;
			
			this.graphics.beginFill(0x000099);
			this.graphics.drawCircle(Constants.GRID_SIZE/2, Constants.GRID_SIZE/2, Constants.GRID_SIZE/2);
		}
		
		public function get cellX():int 
		{
			return _cellX;
		}
		
		public function set cellX(value:int):void 
		{
			_cellX = value;
		}
		
		public function get cellY():int 
		{
			return _cellY;
		}
		
		public function set cellY(value:int):void 
		{
			_cellY = value;
		}
		
	}

}