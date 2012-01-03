package  
{
	/**
	 * ...
	 * @author OML!
	 */
	public class Box extends GameObject 
	{
		private var _cellX : int = 0;
		private var _cellY : int = 0;
		
		public function Box(row : int, col : int)  
		{
			this._cellX = col;
			this._cellY = row;
			
			this.posX = _cellX * Constants.GRID_SIZE;			
			this.posY = _cellY * Constants.GRID_SIZE;
			
			this.graphics.beginFill(0xB35900);
			this.graphics.drawRect(0, 0, Constants.GRID_SIZE, Constants.GRID_SIZE);
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