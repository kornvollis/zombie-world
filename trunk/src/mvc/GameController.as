package mvc 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author OML!
	 */
	public class GameController extends MovieClip
	{
		private var model : GameModel;
		
		public function GameController(model : GameModel) 
		{
			this.model = model;
			
			model.myStage.addEventListener(MouseEvent.CLICK, myClick);
		}
		
		private function myClick(e:MouseEvent):void 
		{
			trace(e.stageX + " " + e.stageY);
		}
		
	}

}