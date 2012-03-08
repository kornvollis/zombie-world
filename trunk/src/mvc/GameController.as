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
		
		public function GameController(model : GameModel) 
		{
			this.model = model;
			//model.myStage.addEventListener(MouseEvent.CLICK, myClick);
			
		}
		
		public function myClick(e:MouseEvent):void 
		{
			//Just for the test			
			var row:int = e.stageY / Constants.GRID_SIZE;
			var col:int = e.stageX / Constants.GRID_SIZE;
			
			if (Factory.getInstance().clickState == Factory.WALL_BUILDER)
			{
				Factory.getInstance().addBox(row, col);
			} else if (Factory.getInstance().clickState == Factory.ZOMBIE_SPAWNER)
			{
				Factory.getInstance().addZombie(row, col);
			} else if (Factory.getInstance().clickState == Factory.SURVIVOR_SPAWNER)
			{
				Factory.getInstance().addSurvivor(row, col);
			}
			
			
		}
		
	}

}