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
			model = new GameModel(this);
			
			Factory.getInstance().setModel(model);
			Factory.getInstance().init();
			
			//TEMP
			addChild(model);
			
			
			//DEFAULT LOAD MAP
			model.fileManager.loadMap();
			
			dispatchEvent(new GameEvents(GameEvents.TURRET_SELL_EVENT));
		}

		private function update(e : Event) : void
		{
			model.update(e);
		}
	}

}