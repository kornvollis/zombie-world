package screens 
{
	/**
	 * ...
	 * @author OML!
	 */
	public class GameScreen extends Screen 
	{
		
		public function GameScreen() 
		{
			//GRID GRPHICS
			drawGrid();
			
			
		}
		
		private function drawGrid() : void
		{
			graphics.lineStyle(1, 0x000000, 0.1);
			for ( var i:int = 0; i < Constants.SCREEN_WIDTH / Constants.CELL_SIZE; i++)
			{
				graphics.moveTo(Constants.CELL_SIZE + Constants.CELL_SIZE*i, 0); 
				graphics.lineTo(Constants.CELL_SIZE + Constants.CELL_SIZE*i, Constants.SCREEN_HEIGHT); 
			}
			
			for ( i = 0; i < Constants.SCREEN_HEIGHT / Constants.CELL_SIZE; i++)
			{
				graphics.moveTo(0, Constants.CELL_SIZE + Constants.CELL_SIZE*i); 
				graphics.lineTo(Constants.SCREEN_WIDTH, Constants.CELL_SIZE + Constants.CELL_SIZE*i); 
			}
		}
		
	}

}