package mvc
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author OML!
	 */
	public class GameView extends MovieClip
	{
		private var model : GameModel;
		private var controller : GameController;
		private var debugArrows : Sprite = new Sprite();
		
		
		public var mapArea : Sprite = new Sprite();
		
		private var ui : UI;
		
		public function GameView(model: GameModel, controller : GameController) 
		{
			mapArea.mouseChildren = false;
			
			mapArea.graphics.beginFill(0x00FF00);
			mapArea.graphics.drawRect(0,0,Constants.SCREEN_WIDTH, Constants.SCREEN_HEIGHT);
			mapArea.graphics.endFill();
			
			this.model = model;
			this.ui = new UI(model);
			this.controller = controller;
			
			//mapArea.addChild(model.cellGrid);
			mapArea.addChild(debugArrows);
			
			addChild(mapArea);
			
			//DRAWING THE GRID
			drawGrid() 
			
			mapArea.addEventListener(MouseEvent.CLICK, controller.myClick);
			mapArea.addEventListener(MouseEvent.MOUSE_DOWN, controller.mouseDown);
			mapArea.addEventListener(MouseEvent.MOUSE_UP, controller.mouseUp);
			mapArea.addEventListener(MouseEvent.MOUSE_MOVE, controller.mouseMove);
			
			model.addEventListener(GameEvents.ZOMBIE_REACHED_EXIT, removeZombie);
			
			addChild(ui);
		}
		
		private function removeZombie(e:GameEvents):void 
		{
			removeChild(Zombie(e.data));
		}
		
		private function drawGrid() : void
		{
			mapArea.graphics.lineStyle(1, 0x000000, 1.0);
			for ( var i:int = 0; i < Constants.SCREEN_WIDTH / Constants.CELL_SIZE; i++)
			{
				mapArea.graphics.moveTo(Constants.CELL_SIZE + Constants.CELL_SIZE*i, 0); 
				mapArea.graphics.lineTo(Constants.CELL_SIZE + Constants.CELL_SIZE*i, Constants.SCREEN_HEIGHT); 
			}
			
			for ( i = 0; i < Constants.SCREEN_HEIGHT / Constants.CELL_SIZE; i++)
			{
				mapArea.graphics.moveTo(0, Constants.CELL_SIZE + Constants.CELL_SIZE*i); 
				mapArea.graphics.lineTo(Constants.SCREEN_WIDTH, Constants.CELL_SIZE + Constants.CELL_SIZE*i); 
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
					//trace("draw arrow");
					//var actuelCell : Cell = model.cellGrid.cells[i][j];
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
		
		public function removeSurvivor(s : Survivor) : void
		{
			removeChild(s);
		}
		
		public function update(e:Event) : void
		{
			//UPDATE ZOMBIES
			for each(var zombie : Zombie in model.zombies) 
			{
				if (!zombie.onStage)
				{
					addChild(zombie);
					zombie.onStage = true;
				}
				
				zombie.x = zombie.position.x;
				zombie.y = zombie.position.y;
			}
			
			//UPDATE SURVIVORS
			for each(var survivor : Survivor in model.surviors) 
			{
				if (!survivor.onStage)
				{
					addChild(survivor);
					survivor.onStage = true;
				}
				
				survivor.x = survivor.position.x;
				survivor.y = survivor.position.y;
			}
			
			//UPDATE BOXES
			for each(var box : Box in model.boxes) {
				if (!box.onStage)
				{
					mapArea.addChild(box);
					box.onStage = true;
				}
				
				box.x = box.position.x;
				box.y = box.position.y;
			}
			
			//DRAW DUBG ARROWS
			if (model.needPathUpdate)
			{
				drawDebugPath();
				model.needPathUpdate = false;
			}
		}
		
	}
}