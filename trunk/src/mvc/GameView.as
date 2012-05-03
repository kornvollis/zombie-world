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
		
		public var mapAreaLayer1 : Sprite = new Sprite();
		public var mapAreaLayer2 : Sprite = new Sprite();
		
		public var exitPointsGraphics: Sprite = new Sprite();
		
		
		
		private var ui : UI;
		
		public function GameView(model: GameModel, controller : GameController) 
		{
			mapAreaLayer1.mouseChildren = false;
			mapAreaLayer1.graphics.beginFill(0xffffff);
			mapAreaLayer1.graphics.drawRect(0,0,Constants.SCREEN_WIDTH, Constants.SCREEN_HEIGHT);
			mapAreaLayer1.graphics.endFill();
			
			this.model = model;
			this.ui = new UI(model);
			this.controller = controller;
			
			//mapAreaLayer1.addChild(model.cellGrid);
			mapAreaLayer1.addChild(debugArrows);
			
			addChild(mapAreaLayer1);
			
			//DRAWING THE GRID
			drawGrid() 
			
			mapAreaLayer1.addEventListener(MouseEvent.CLICK, controller.myClick);
			mapAreaLayer1.addEventListener(MouseEvent.MOUSE_DOWN, controller.mouseDown);
			mapAreaLayer1.addEventListener(MouseEvent.MOUSE_UP, controller.mouseUp);
			mapAreaLayer1.addEventListener(MouseEvent.MOUSE_MOVE, controller.mouseMove);
			
			
			//ADD LISTENERS
			model.addEventListener(GameEvents.ZOMBIE_REACHED_EXIT, removeZombie);
			model.addEventListener(GameEvents.REDRAW_EXIT_POINTS, drawExitPointsGraphics);
			
			addChild(ui);
			addChild(mapAreaLayer1);
			addChild(exitPointsGraphics);
			addChild(mapAreaLayer2);
		}
		
		private function removeZombie(e:GameEvents):void 
		{
			removeChild(Enemy(e.data));
		}
		
		private function drawGrid() : void
		{
			mapAreaLayer1.graphics.lineStyle(1, 0x000000, 0.1);
			for ( var i:int = 0; i < Constants.SCREEN_WIDTH / Constants.CELL_SIZE; i++)
			{
				mapAreaLayer1.graphics.moveTo(Constants.CELL_SIZE + Constants.CELL_SIZE*i, 0); 
				mapAreaLayer1.graphics.lineTo(Constants.CELL_SIZE + Constants.CELL_SIZE*i, Constants.SCREEN_HEIGHT); 
			}
			
			for ( i = 0; i < Constants.SCREEN_HEIGHT / Constants.CELL_SIZE; i++)
			{
				mapAreaLayer1.graphics.moveTo(0, Constants.CELL_SIZE + Constants.CELL_SIZE*i); 
				mapAreaLayer1.graphics.lineTo(Constants.SCREEN_WIDTH, Constants.CELL_SIZE + Constants.CELL_SIZE*i); 
			}
		}
		
		public function drawExitPointsGraphics(e : Event) : void
		{
			trace("drawing exit points");
			exitPointsGraphics.graphics.beginFill(0x0000FF, 0.2);
			
			for (var i:int = 0; i < model.pathFinder.targetNodes.length; i++) 
			{
				trace("szopo");
				var c : Cell = model.pathFinder.targetNodes[i];
				
				//TEMP Graphics
				exitPointsGraphics.graphics.drawRect(c.col*Constants.CELL_SIZE, c.row*Constants.CELL_SIZE, Constants.CELL_SIZE, Constants.CELL_SIZE);
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
		
		
		public function update(e:Event) : void
		{
			//UPDATE TURRETS
			for each(var turret : Turret in model.turrets) 
			{
				if (!turret.onStage)
				{
					mapAreaLayer2.addChild(turret);
					turret.onStage = true;
					turret.x = turret.position.x;
					turret.y = turret.position.y;
				}
				
				
			}
			
			//UPDATE ZOMBIES
			for each(var zombie : Enemy in model.zombies) 
			{
				if (!zombie.onStage)
				{
					mapAreaLayer2.addChild(zombie);
					zombie.onStage = true;
				}
				
				zombie.x = zombie.position.x;
				zombie.y = zombie.position.y;
			}
			
			//UPDATE BOXES
			for each(var box : Box in model.boxes) {
				if (!box.onStage)
				{
					mapAreaLayer1.addChild(box);
					box.onStage = true;
				}
				
				box.x = box.position.x;
				box.y = box.position.y;
			}
			
			//UPDATE PROJECTILS
			for each(var projectil : Projectil in model.projectils) 
			{
				if (!projectil.onStage)
				{
					mapAreaLayer2.addChild(projectil);
					projectil.onStage = true;
				}
				
				projectil.x = projectil.position.x;
				projectil.y = projectil.position.y;
			}
			
			//DRAW DUBG ARROWS
			/*
			if (model.needPathUpdate)
			{
				drawDebugPath();
				model.needPathUpdate = false;
			}
			*/
		}
		
	}
}