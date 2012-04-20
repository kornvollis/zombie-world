package mvc 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	/**
	 * @author OML!
	 */
	public class GameController extends MovieClip
	{
		private var model : GameModel;
		
		private var mousePressed : Boolean = false;
		
		public function GameController(model : GameModel) 
		{
			this.model = model;
			//model.myStage.addEventListener(MouseEvent.CLICK, myClick);
			
		}
		
		public function myClick(e:MouseEvent):void 
		{
			//Just for the test			
			var row:int = e.stageY / Constants.CELL_SIZE;
			var col:int = e.stageX / Constants.CELL_SIZE;
			
			if (Factory.getInstance().clickState == Factory.WALL_BUILDER)
			{
				var cell : Cell = model.pathFinder.cellGrid.getCell(row, col);
				
				if (cell.box == null)
				{
					Factory.getInstance().addBox(row, col);
				} else {
					Factory.getInstance().removeBox(row, col);
				}
				
			} else if (Factory.getInstance().clickState == Factory.ZOMBIE_SPAWNER)
			{
				Factory.getInstance().addZombie(row, col);
			} 
		}
		
		public function mouseDown(e:MouseEvent):void 
		{
			mousePressed = true;
		}
		
		public function mouseMove(e:MouseEvent):void 
		{
			var row:int = e.stageY / Constants.CELL_SIZE;
			var col:int = e.stageX / Constants.CELL_SIZE;
			
			if (mousePressed && Factory.getInstance().clickState == Factory.WALL_BUILDER)
			{
				var cell : Cell = model.pathFinder.cellGrid.getCell(row, col);
				
				if (cell.box == null) 
				{
					Factory.getInstance().addBox(row, col);
				}
			}
		}
		
		public function mouseUp(e:MouseEvent):void 
		{
			trace("Mouse Up");
			mousePressed = false;
		}
		
	}

}