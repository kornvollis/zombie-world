package mvc
{
	import flash.display.MovieClip;
	import flash.events.Event;
	/**
	 * ...
	 * @author OML!
	 */
	public class GameView extends MovieClip
	{
		private var model : GameModel;
		private var controller : GameController;
		
		public function GameView(model: GameModel, controller : GameController) 
		{
			this.model = model;
			this.controller = controller;
			
			addChild(model.map);
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
			/*
			for (i = 0; i < Constants.ROW_NUM; i++)
			{
				for (var  j:int  = 0; j < Constants.COL_NUM; j++)
				{
					var actuelCell : Cell = model.map.cells[i][j];
					var nextCell : Cell = model.map.cells[i][j].nextCell;
				
					//LEFT
					if (nextCell.col - actuelCell.col == -1) 
					{
						
					}
					
					//RIGHT
					
					//TOP
					
					//BOTTOM
					
				}				
			}
			*/
		}
		
	}
}