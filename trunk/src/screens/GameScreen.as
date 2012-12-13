package screens 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import starling.display.Image;
	import starling.textures.Texture;
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
		//private var drawingSprite : MovieClip = new MovieClip();
		private var drawArrow : Boolean = true;
		private var drawingSprite : flash.display.Sprite = new flash.display.Sprite();
		private var bmd:BitmapData = new BitmapData(Constants.SCREEN_WIDTH, Constants.SCREEN_HEIGHT,true, 0);
		
		public function GameScreen(model : GameModel = null) 
		{
			this.model = model;			
			//MAP MAKER
			mapMaker = new MapMaker(model, this);
			
			
			//TEMP GRAPHICS
			drawGrid();
			
			drawVectorGraphics();
		}
		
		private function drawVectorGraphics():void 
		{
			bmd.draw(drawingSprite);
			
			var texture : Texture = Texture.fromBitmapData(bmd);
			
			// create an Image out of the texture
			var image:Image = new Image(texture);
			// show it!
			addChild(image);
		}
		
		private function drawGrid() : void
		{
			drawingSprite.graphics.lineStyle(2, 0xFFFFFF);
			drawingSprite.graphics.drawRect(0, 0, Constants.SCREEN_WIDTH, Constants.SCREEN_HEIGHT);
			
			drawingSprite.graphics.lineStyle(1, 0xFFFFFF, 0.3);
			for ( var i:int = 0; i < Constants.SCREEN_WIDTH / Constants.CELL_SIZE; i++)
			{
				drawingSprite.graphics.moveTo(Constants.CELL_SIZE + Constants.CELL_SIZE*i, 0); 
				drawingSprite.graphics.lineTo(Constants.CELL_SIZE + Constants.CELL_SIZE*i, Constants.SCREEN_HEIGHT); 
			}
			
			for ( i = 0; i < Constants.SCREEN_HEIGHT / Constants.CELL_SIZE; i++)
			{
				drawingSprite.graphics.moveTo(0, Constants.CELL_SIZE + Constants.CELL_SIZE*i); 
				drawingSprite.graphics.lineTo(Constants.SCREEN_WIDTH, Constants.CELL_SIZE + Constants.CELL_SIZE*i); 
			}
		}
		
		public function drawDebugPath() : void
		{
			for (var i : int = 0; i < Constants.ROW_NUM; i++)
			{
				for (var  j:int  = 0; j < Constants.COL_NUM; j++)
				{
					var actuelCell : Cell = model.pathFinder.cellGrid.getCell(i, j);
					
					
					//CLOSD OR OPENED???
					if (actuelCell.state == Cell.OPEN_PATH && actuelCell.next_direction != Cell.NULL_NEXT)
					{
						drawingSprite.graphics.lineStyle(2, 0x00FF00, 0.1);
						drawingSprite.graphics.drawCircle(j * Constants.CELL_SIZE + Constants.CELL_SIZE / 2, i * Constants.CELL_SIZE + Constants.CELL_SIZE / 2, Constants.CELL_SIZE / 2 - 1);
					} else if(actuelCell.state == Cell.CLOSED_PATH){
						drawingSprite.graphics.lineStyle(2, 0xFF0000, 0.9);
						drawingSprite.graphics.drawCircle(j * Constants.CELL_SIZE + Constants.CELL_SIZE / 2, i * Constants.CELL_SIZE + Constants.CELL_SIZE / 2, Constants.CELL_SIZE / 2 - 1);
					} else if (actuelCell.state == Cell.OPEN_PATH && actuelCell.next_direction == Cell.NULL_NEXT) {
						drawingSprite.graphics.lineStyle(2, 0x0000FF, 0.5);
						drawingSprite.graphics.drawCircle(j * Constants.CELL_SIZE + Constants.CELL_SIZE / 2, i * Constants.CELL_SIZE + Constants.CELL_SIZE / 2, Constants.CELL_SIZE / 2 - 1);
					}
					
					if (drawArrow)
					{
						drawingSprite.graphics.lineStyle(2, 0x000000, 0.3);
						switch (actuelCell.next_direction)
						{
							case Cell.BOTTOM_NEXT:
								drawingSprite.graphics.moveTo(j * Constants.CELL_SIZE + Constants.CELL_SIZE / 2, i * Constants.CELL_SIZE);
								drawingSprite.graphics.lineTo(j * Constants.CELL_SIZE + Constants.CELL_SIZE / 2, i * Constants.CELL_SIZE + Constants.CELL_SIZE);
								
								drawingSprite.graphics.moveTo( (j * Constants.CELL_SIZE + Constants.CELL_SIZE / 2), (i * Constants.CELL_SIZE + Constants.CELL_SIZE) );
								drawingSprite.graphics.lineTo( (j * Constants.CELL_SIZE + Constants.CELL_SIZE / 2) - 3, (i * Constants.CELL_SIZE + Constants.CELL_SIZE) - 3 );
								
								drawingSprite.graphics.moveTo( (j * Constants.CELL_SIZE + Constants.CELL_SIZE / 2), (i * Constants.CELL_SIZE + Constants.CELL_SIZE) );
								drawingSprite.graphics.lineTo( (j * Constants.CELL_SIZE + Constants.CELL_SIZE / 2)+3, (i * Constants.CELL_SIZE + Constants.CELL_SIZE)-3 );
							break;
							case Cell.LEFT_NEXT:
								drawingSprite.graphics.moveTo(j * Constants.CELL_SIZE, i * Constants.CELL_SIZE + Constants.CELL_SIZE / 2);
								drawingSprite.graphics.lineTo(j * Constants.CELL_SIZE + Constants.CELL_SIZE, i * Constants.CELL_SIZE + Constants.CELL_SIZE / 2);
								
								drawingSprite.graphics.moveTo( (j * Constants.CELL_SIZE ), (i * Constants.CELL_SIZE + Constants.CELL_SIZE / 2) );
								drawingSprite.graphics.lineTo( (j * Constants.CELL_SIZE ) + 3, (i * Constants.CELL_SIZE + Constants.CELL_SIZE / 2) - 3 );
								
								drawingSprite.graphics.moveTo( (j * Constants.CELL_SIZE ) , (i * Constants.CELL_SIZE + Constants.CELL_SIZE / 2) );
								drawingSprite.graphics.lineTo( (j * Constants.CELL_SIZE ) + 3, (i * Constants.CELL_SIZE + Constants.CELL_SIZE / 2)+3 );
							break;
							
							case Cell.RIGHT_NEXT:
								drawingSprite.graphics.moveTo(j * Constants.CELL_SIZE, i * Constants.CELL_SIZE + Constants.CELL_SIZE / 2);
								drawingSprite.graphics.lineTo(j * Constants.CELL_SIZE + Constants.CELL_SIZE, i * Constants.CELL_SIZE + Constants.CELL_SIZE / 2);
								
								drawingSprite.graphics.moveTo( (j * Constants.CELL_SIZE + Constants.CELL_SIZE), (i * Constants.CELL_SIZE + Constants.CELL_SIZE / 2) );
								drawingSprite.graphics.lineTo( (j * Constants.CELL_SIZE + Constants.CELL_SIZE) - 3, (i * Constants.CELL_SIZE + Constants.CELL_SIZE / 2) - 3 );
								
								drawingSprite.graphics.moveTo( (j * Constants.CELL_SIZE + Constants.CELL_SIZE), (i * Constants.CELL_SIZE + Constants.CELL_SIZE / 2) );
								drawingSprite.graphics.lineTo( (j * Constants.CELL_SIZE + Constants.CELL_SIZE)-3, (i * Constants.CELL_SIZE + Constants.CELL_SIZE / 2)+3 );								
							break;
								
							case Cell.TOP_NEXT:
								drawingSprite.graphics.moveTo(j * Constants.CELL_SIZE + Constants.CELL_SIZE / 2, i * Constants.CELL_SIZE);
								drawingSprite.graphics.lineTo(j * Constants.CELL_SIZE + Constants.CELL_SIZE / 2, i * Constants.CELL_SIZE + Constants.CELL_SIZE);
								
								drawingSprite.graphics.moveTo( (j * Constants.CELL_SIZE + Constants.CELL_SIZE / 2), (i * Constants.CELL_SIZE) );
								drawingSprite.graphics.lineTo( (j * Constants.CELL_SIZE + Constants.CELL_SIZE / 2) - 3, (i * Constants.CELL_SIZE) + 3 );
								
								drawingSprite.graphics.moveTo( (j * Constants.CELL_SIZE + Constants.CELL_SIZE / 2), (i * Constants.CELL_SIZE) );
								drawingSprite.graphics.lineTo( (j * Constants.CELL_SIZE + Constants.CELL_SIZE / 2) + 3, (i * Constants.CELL_SIZE) + 3 );
							break;
						}
					}
				}
			}
		}
	} // END OF CLASS

}