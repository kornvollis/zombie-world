package screens 
{
	import mvc.GameModel;
	import ui.MapMaker;
	/**
	 * ...
	 * @author OML!
	 */
	public class GameScreen extends Screen 
	{
		private var model : GameModel;
		private var mapMaker : MapMaker;
		
		
		public function GameScreen(model : GameModel) 
		{
			this.model = model;			
			//MAP MAKER
			mapMaker = new MapMaker(model, this);
			
			
			//TEMP GRAPHICS
			graphics.beginFill(0x116601);
			graphics.drawRect(0, 0, 720, 600);
			
			//GRID GRPHICS
			drawGrid();
			
			addChild(mapMaker);
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