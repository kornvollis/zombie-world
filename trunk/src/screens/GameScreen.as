package screens 
{
	import flash.display.MovieClip;
	import mvc.GameModel;
	import starling.display.Sprite;
	import ui.MapMaker;
	/**
	 * ...
	 * @author OML!
	 */
	public class GameScreen extends Sprite
	{
		public var hasDebug : Boolean = true;
		
		private var model : GameModel;
		private var mapMaker : MapMaker;
		//private var debugArrows : MovieClip = new MovieClip();
		private var drawArrow : Boolean = true;
		
		
		public function GameScreen(model : GameModel = null) 
		{
			this.model = model;			
			//MAP MAKER
			mapMaker = new MapMaker(model, this);
			
			/*
			//TEMP GRAPHICS
			graphics.beginFill(0xFFFFFF);
			graphics.drawRect(0, 0, 720, 600);
			
			//DEBUG GRAPHICS
			debugArrows.mouseChildren = false;
			debugArrows.mouseEnabled = false;
			
			//GRID GRPHICS
			drawGrid();
			
			addChild(mapMaker);
			
			if(hasDebug) addChildAt(debugArrows,1);*/
		}
		
		/*private function drawGrid() : void
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
			
			for (var i : int = 0; i < Constants.ROW_NUM; i++)
			{
				for (var  j:int  = 0; j < Constants.COL_NUM; j++)
				{
					var actuelCell : Cell = model.pathFinder.cellGrid.getCell(i, j);
					
					
					//CLOSD OR OPENED???
					if (actuelCell.state == Cell.OPEN_PATH && actuelCell.next_direction != Cell.NULL_NEXT)
					{
						debugArrows.graphics.lineStyle(2, 0x00FF00, 0.1);
						debugArrows.graphics.drawCircle(j * Constants.CELL_SIZE + Constants.CELL_SIZE / 2, i * Constants.CELL_SIZE + Constants.CELL_SIZE / 2, Constants.CELL_SIZE / 2 - 1);
					} else if(actuelCell.state == Cell.CLOSED_PATH){
						debugArrows.graphics.lineStyle(2, 0xFF0000, 0.9);
						debugArrows.graphics.drawCircle(j * Constants.CELL_SIZE + Constants.CELL_SIZE / 2, i * Constants.CELL_SIZE + Constants.CELL_SIZE / 2, Constants.CELL_SIZE / 2 - 1);
					} else if (actuelCell.state == Cell.OPEN_PATH && actuelCell.next_direction == Cell.NULL_NEXT) {
						debugArrows.graphics.lineStyle(2, 0x0000FF, 0.5);
						debugArrows.graphics.drawCircle(j * Constants.CELL_SIZE + Constants.CELL_SIZE / 2, i * Constants.CELL_SIZE + Constants.CELL_SIZE / 2, Constants.CELL_SIZE / 2 - 1);
					}
					
					if (drawArrow)
					{
						debugArrows.graphics.lineStyle(2, 0x000000, 0.3);
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
		}*/
	} // END OF CLASS

}