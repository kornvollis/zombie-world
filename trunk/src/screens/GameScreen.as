package screens 
{
	import flash.display.MovieClip;
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
		private var debugArrows : MovieClip = new MovieClip();
		
		
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
			
			addChild(debugArrows);
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
		
		public function drawDebugPath() : void
		{
			debugArrows.graphics.clear();
			debugArrows.graphics.lineStyle(2, 0xFF0000, 0.3);
			for (var i : int = 0; i < Constants.ROW_NUM; i++)
			{
				for (var  j:int  = 0; j < Constants.COL_NUM; j++)
				{
					var actuelCell : Cell = model.pathFinder.cellGrid.getCell(i, j);
					
					switch (actuelCell.next_direction)
					{
						case Cell.BOTTOM_NEXT:
							debugArrows.graphics.moveTo(j * Constants.CELL_SIZE + Constants.CELL_SIZE / 2, i * Constants.CELL_SIZE);
							debugArrows.graphics.lineTo(j * Constants.CELL_SIZE + Constants.CELL_SIZE / 2, i * Constants.CELL_SIZE + Constants.CELL_SIZE);
							
							debugArrows.graphics.moveTo( (j * Constants.CELL_SIZE + Constants.CELL_SIZE / 2), (i * Constants.CELL_SIZE + Constants.CELL_SIZE) );
							debugArrows.graphics.lineTo( (j * Constants.CELL_SIZE + Constants.CELL_SIZE / 2) - 3, (i * Constants.CELL_SIZE + Constants.CELL_SIZE) - 3 );
							
							debugArrows.graphics.moveTo( (j * Constants.CELL_SIZE + Constants.CELL_SIZE / 2), (i * Constants.CELL_SIZE + Constants.CELL_SIZE) );
							debugArrows.graphics.lineTo( (j * Constants.CELL_SIZE + Constants.CELL_SIZE / 2)+3, (i * Constants.CELL_SIZE + Constants.CELL_SIZE)-3 );
						break;
						case Cell.LEFT_NEXT:
							debugArrows.graphics.moveTo(j * Constants.CELL_SIZE, i * Constants.CELL_SIZE + Constants.CELL_SIZE / 2);
							debugArrows.graphics.lineTo(j * Constants.CELL_SIZE + Constants.CELL_SIZE, i * Constants.CELL_SIZE + Constants.CELL_SIZE / 2);
							
							debugArrows.graphics.moveTo( (j * Constants.CELL_SIZE ), (i * Constants.CELL_SIZE + Constants.CELL_SIZE / 2) );
							debugArrows.graphics.lineTo( (j * Constants.CELL_SIZE ) + 3, (i * Constants.CELL_SIZE + Constants.CELL_SIZE / 2) - 3 );
							
							debugArrows.graphics.moveTo( (j * Constants.CELL_SIZE ) , (i * Constants.CELL_SIZE + Constants.CELL_SIZE / 2) );
							debugArrows.graphics.lineTo( (j * Constants.CELL_SIZE ) + 3, (i * Constants.CELL_SIZE + Constants.CELL_SIZE / 2)+3 );
						break;
						
						case Cell.RIGHT_NEXT:
							debugArrows.graphics.moveTo(j * Constants.CELL_SIZE, i * Constants.CELL_SIZE + Constants.CELL_SIZE / 2);
							debugArrows.graphics.lineTo(j * Constants.CELL_SIZE + Constants.CELL_SIZE, i * Constants.CELL_SIZE + Constants.CELL_SIZE / 2);
							
							debugArrows.graphics.moveTo( (j * Constants.CELL_SIZE + Constants.CELL_SIZE), (i * Constants.CELL_SIZE + Constants.CELL_SIZE / 2) );
							debugArrows.graphics.lineTo( (j * Constants.CELL_SIZE + Constants.CELL_SIZE) - 3, (i * Constants.CELL_SIZE + Constants.CELL_SIZE / 2) - 3 );
							
							debugArrows.graphics.moveTo( (j * Constants.CELL_SIZE + Constants.CELL_SIZE), (i * Constants.CELL_SIZE + Constants.CELL_SIZE / 2) );
							debugArrows.graphics.lineTo( (j * Constants.CELL_SIZE + Constants.CELL_SIZE)-3, (i * Constants.CELL_SIZE + Constants.CELL_SIZE / 2)+3 );								
						break;
							
						case Cell.TOP_NEXT:
							debugArrows.graphics.moveTo(j * Constants.CELL_SIZE + Constants.CELL_SIZE / 2, i * Constants.CELL_SIZE);
							debugArrows.graphics.lineTo(j * Constants.CELL_SIZE + Constants.CELL_SIZE / 2, i * Constants.CELL_SIZE + Constants.CELL_SIZE);
							
							debugArrows.graphics.moveTo( (j * Constants.CELL_SIZE + Constants.CELL_SIZE / 2), (i * Constants.CELL_SIZE) );
							debugArrows.graphics.lineTo( (j * Constants.CELL_SIZE + Constants.CELL_SIZE / 2) - 3, (i * Constants.CELL_SIZE) + 3 );
							
							debugArrows.graphics.moveTo( (j * Constants.CELL_SIZE + Constants.CELL_SIZE / 2), (i * Constants.CELL_SIZE) );
							debugArrows.graphics.lineTo( (j * Constants.CELL_SIZE + Constants.CELL_SIZE / 2) + 3, (i * Constants.CELL_SIZE) + 3 );
						break;
					}
				}
			}
		}
	}

}