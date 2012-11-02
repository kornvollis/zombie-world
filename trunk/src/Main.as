package 
{
	import debug.ZDebug;
	import levels.NewWave;
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.getTimer;
	
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
		//private var view  : GameView;
		//private var controller : GameController;
		
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
			
			//DEPRI
			//controller = new GameController(model);
			//view = new GameView(model, controller);
			
			Factory.getInstance().setModel(model);
			//Factory.getInstance().setView(view);
			Factory.getInstance().init();
			
			//addChild(view);
			
			//TEMP
			addChild(model);
			
			dispatchEvent(new GameEvents(GameEvents.TURRET_SELL_EVENT));
		}

		private function update(e : Event) : void
		{
			
			//trace("update");
			model.update(e);
			//view.update(e);
			
			//var updateTime : int = getTimer() - updateStart;
			//trace("Update time: " + updateTime);
		}
	}

}