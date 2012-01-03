package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import mvc.GameController;
	import mvc.GameModel;
	import mvc.GameView;

	/**
	 * ...
	 * @author OMLI
	 */
	[Frame(factoryClass="Preloader")]
	public class Main extends Sprite 
	{
		private var model : GameModel;
		private var view  : GameView;
		private var controller : GameController;
		
		private var pathFinder : PathFinder;
		
		public function Main():void 
		{			
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}

		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
		
			//SET FRAME RATE
			stage.frameRate = Constants.FRAME_RATE;
			
			//GAME UPDATE LOOP
			addEventListener(Event.ENTER_FRAME, update);			
			
			
			//GAME MODEL
			model = new GameModel();
			model.myStage = stage;
			controller = new GameController(model);
			view = new GameView(model, controller);
			
			
			
			pathFinder = new PathFinder(model);
			
			addChild(view);
		}

		private function update(e : Event) : void
		{
			//trace("update");
			model.update(e);
			view.update(e);
		}
	}

}