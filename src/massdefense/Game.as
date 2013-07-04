package massdefense 
{
	import massdefense.assets.Assets;
	import massdefense.level.Level;
	import massdefense.level.LevelLoader;
	import massdefense.ui.UI;
	import massdefense.ui.TimeControll;
	import starling.core.Starling;
	import starling.display.Sprite;
	import starling.display.Stage;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.extensions.PDParticleSystem;
	

	public class Game extends Sprite 
	{
		public static const FONT : String = "Pixel";
		[Embed(source="assets/font/line_pixel-7.ttf", embedAsCFF="false", fontName="Pixel")]
		private static const FONT_PIXEL:String;
		
		public static var stage: Stage = null;
		
		private var inputManager : InputManager;
		
		private var level : Level = null;
		
		private var debugUI : TimeControll = new TimeControll();
		private var ui : UI;
		private var levelLoader:LevelLoader = new LevelLoader();
		
		public var paused : Boolean = false;
		public var stepFrames : uint = 0;
		
		public var currentLevel : Class = LevelLoader.Level_01;
		
		public function Game() 
		{
			addEventListener(Event.ADDED_TO_STAGE, onAdd);
		}
		
		private function test():void 
		{
			
		}
		
		public function startGame() : void {
			if (level != null) removeChild(level);
			if (ui != null) removeChild(ui);
			level = levelLoader.createLevel(currentLevel);
			level.init();
			
			ui = new UI(level);
			ui.x = 650;	ui.y = 50;
			
			
			level.debugDraw();
			
			
			inputManager = new InputManager(level, ui);
			addChild(level);
			addChild(ui);
		}
		
		private function onAdd(e:Event):void 
		{
			Game.stage = stage;
			
			removeEventListener(Event.ADDED_TO_STAGE, onAdd);
			addEventListener(EnterFrameEvent.ENTER_FRAME, update);
			
			startGame();
		}
		
		private function addDebugTimeControll():void 
		{
			debugUI.x = 650;
			debugUI.y = 10;
			addChild(debugUI);
			
			debugUI.addEventListener(TimeControll.START_GAME_EVENT, onTimeControllStartClick);
			debugUI.addEventListener(TimeControll.ON_PAUSE_CLICK, onTimeControllPauseClick);
			debugUI.addEventListener(TimeControll.ON_STEP_CLICK, onTimeControllStepClick);
		}
		
		private function onTimeControllStartClick(e:Event):void
		{
			startGame();
		}
		
		private function onTimeControllPauseClick(e:Event):void 
		{
			pauseGame();
		}
		
		private function onTimeControllStepClick(e:Event):void 
		{
			this.stepFrames = 10;
		}
		
		public function loadLevel(index : uint) : void {
			//level = LevelStore.getLevel(index);
		}
		
		public function pauseGame() : void {
			paused = !paused;
		}
		
		public function loadMenu() : void {
			
		}
		
		private function update(e:EnterFrameEvent):void 
		{
			if (!paused || stepFrames > 0) {
				if(level != null) {
					level.update(e.passedTime);
				}
				
				if (stepFrames > 0) stepFrames--;
			}
		}
		
	}

}