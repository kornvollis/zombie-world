package  
{
	/**
	 * ...
	 * @author OML!
	 */
	public class Map extends GameObject
	{			
		public var cells : Vector.<Vector.<Cell>> = new Vector.<Vector.<Cell>>();
		
		public function Map() 
		{
			for (var  i:int  = 0; i < Constants.ROW_NUM; i++)
			{
				cells.push(new Vector.<Cell>());
			}
			
			//INIT CELLS
			for (i = 0; i < Constants.ROW_NUM; i++)
			{
				for (var  j:int  = 0; j < Constants.COL_NUM; j++)
				{
					cells[i][j] = new Cell(i,j);
				}				
			}
			
			drawGrid();
		}
		
		private function drawGrid() : void
		{
			this.graphics.lineStyle(1, 0x000000, 1.0);
			for ( var i:int = 0; i < Constants.SCREEN_WIDTH / Constants.GRID_SIZE; i++)
			{
				this.graphics.moveTo(Constants.GRID_SIZE + Constants.GRID_SIZE*i, 0); 
				this.graphics.lineTo(Constants.GRID_SIZE + Constants.GRID_SIZE*i, Constants.SCREEN_HEIGHT); 
			}
			
			for ( i = 0; i < Constants.SCREEN_HEIGHT / Constants.GRID_SIZE; i++)
			{
				this.graphics.moveTo(0, Constants.GRID_SIZE + Constants.GRID_SIZE*i); 
				this.graphics.lineTo(Constants.SCREEN_WIDTH, Constants.GRID_SIZE + Constants.GRID_SIZE*i); 
			}
		}
	}
}