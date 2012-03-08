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
		
		private var ui : UI = new UI();
		
		public function GameView(model: GameModel, controller : GameController) 
		{
			mapArea.mouseChildren = false;
			//mapArea.width = 640;
			//mapArea.height = 420;
			
			this.model = model;
			this.controller = controller;
			
			mapArea.addChild(model.map);
			mapArea.addChild(debugArrows);
			
			addChild(mapArea);
			
			
			mapArea.addEventListener(MouseEvent.CLICK, controller.myClick);
			
			//model.testButton.y = 430;
			//model.testButton.ztext.text = "savanyucukor";
			addChild(ui);
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
					var actuelCell : Cell = model.map.cells[i][j];
					
					switch (actuelCell.next_direction)
					{
						case Cell.BOTTOM_NEXT:
							debugArrows.graphics.moveTo(j * Constants.GRID_SIZE + Constants.GRID_SIZE / 2, i * Constants.GRID_SIZE);
							debugArrows.graphics.lineTo(j * Constants.GRID_SIZE + Constants.GRID_SIZE / 2, i * Constants.GRID_SIZE + Constants.GRID_SIZE);
							
							debugArrows.graphics.moveTo( (j * Constants.GRID_SIZE + Constants.GRID_SIZE / 2), (i * Constants.GRID_SIZE + Constants.GRID_SIZE) );
							debugArrows.graphics.lineTo( (j * Constants.GRID_SIZE + Constants.GRID_SIZE / 2) - 3, (i * Constants.GRID_SIZE + Constants.GRID_SIZE) - 3 );
							
							debugArrows.graphics.moveTo( (j * Constants.GRID_SIZE + Constants.GRID_SIZE / 2), (i * Constants.GRID_SIZE + Constants.GRID_SIZE) );
							debugArrows.graphics.lineTo( (j * Constants.GRID_SIZE + Constants.GRID_SIZE / 2)+3, (i * Constants.GRID_SIZE + Constants.GRID_SIZE)-3 );
						break;
						case Cell.LEFT_NEXT:
							debugArrows.graphics.moveTo(j * Constants.GRID_SIZE, i * Constants.GRID_SIZE + Constants.GRID_SIZE / 2);
							debugArrows.graphics.lineTo(j * Constants.GRID_SIZE + Constants.GRID_SIZE, i * Constants.GRID_SIZE + Constants.GRID_SIZE / 2);
							
							debugArrows.graphics.moveTo( (j * Constants.GRID_SIZE ), (i * Constants.GRID_SIZE + Constants.GRID_SIZE / 2) );
							debugArrows.graphics.lineTo( (j * Constants.GRID_SIZE ) + 3, (i * Constants.GRID_SIZE + Constants.GRID_SIZE / 2) - 3 );
							
							debugArrows.graphics.moveTo( (j * Constants.GRID_SIZE ) , (i * Constants.GRID_SIZE + Constants.GRID_SIZE / 2) );
							debugArrows.graphics.lineTo( (j * Constants.GRID_SIZE ) + 3, (i * Constants.GRID_SIZE + Constants.GRID_SIZE / 2)+3 );
						break;
						
						case Cell.RIGHT_NEXT:
							debugArrows.graphics.moveTo(j * Constants.GRID_SIZE, i * Constants.GRID_SIZE + Constants.GRID_SIZE / 2);
							debugArrows.graphics.lineTo(j * Constants.GRID_SIZE + Constants.GRID_SIZE, i * Constants.GRID_SIZE + Constants.GRID_SIZE / 2);
							
							debugArrows.graphics.moveTo( (j * Constants.GRID_SIZE + Constants.GRID_SIZE), (i * Constants.GRID_SIZE + Constants.GRID_SIZE / 2) );
							debugArrows.graphics.lineTo( (j * Constants.GRID_SIZE + Constants.GRID_SIZE) - 3, (i * Constants.GRID_SIZE + Constants.GRID_SIZE / 2) - 3 );
							
							debugArrows.graphics.moveTo( (j * Constants.GRID_SIZE + Constants.GRID_SIZE), (i * Constants.GRID_SIZE + Constants.GRID_SIZE / 2) );
							debugArrows.graphics.lineTo( (j * Constants.GRID_SIZE + Constants.GRID_SIZE)-3, (i * Constants.GRID_SIZE + Constants.GRID_SIZE / 2)+3 );								
						break;
							
						case Cell.TOP_NEXT:
							debugArrows.graphics.moveTo(j * Constants.GRID_SIZE + Constants.GRID_SIZE / 2, i * Constants.GRID_SIZE);
							debugArrows.graphics.lineTo(j * Constants.GRID_SIZE + Constants.GRID_SIZE / 2, i * Constants.GRID_SIZE + Constants.GRID_SIZE);
							
							debugArrows.graphics.moveTo( (j * Constants.GRID_SIZE + Constants.GRID_SIZE / 2), (i * Constants.GRID_SIZE) );
							debugArrows.graphics.lineTo( (j * Constants.GRID_SIZE + Constants.GRID_SIZE / 2) - 3, (i * Constants.GRID_SIZE) + 3 );
							
							debugArrows.graphics.moveTo( (j * Constants.GRID_SIZE + Constants.GRID_SIZE / 2), (i * Constants.GRID_SIZE) );
							debugArrows.graphics.lineTo( (j * Constants.GRID_SIZE + Constants.GRID_SIZE / 2) + 3, (i * Constants.GRID_SIZE) + 3 );
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
				
				zombie.x = zombie.posX;
				zombie.y = zombie.posY;
			}
			
			//UPDATE SURVIVORS
			for each(var survivor : Survivor in model.surviors) 
			{
				if (!survivor.onStage)
				{
					addChild(survivor);
					survivor.onStage = true;
				}
				
				survivor.x = survivor.posX;
				survivor.y = survivor.posY;
			}
			
			//UPDATE BOXES
			for each(var box : Box in model.boxes) {
				if (!box.onStage)
				{
					addChild(box);
					box.onStage = true;
				}
				
				box.x = box.posX;
				box.y = box.posY;
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