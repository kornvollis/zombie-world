package massdefense 
{
	import massdefense.level.Level;
	import massdefense.level.LevelLoader;
	import massdefense.ui.BasicUI;
	import massdefense.ui.TimeControll;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	

	public class Game extends Sprite 
	{
		[Embed(source="config/units.xml", mimeType = "application/octet-stream")] 
		public static const Units:Class;
		static public var units : XML = XML(new Units());
		
		private var inputManager : InputManager;
		private var level : Level = null;
		private var debugUI : TimeControll = new TimeControll();
		private var ui : BasicUI;
		
		public var paused : Boolean = false;
		public var stepFrames : uint = 0;
		
		public function Game() 
		{
			// TODO remove this juust for testing
			var levelLoader : LevelLoader = new LevelLoader();
			level = levelLoader.createLevel(LevelLoader.Level_01);
			level.debugDraw();
			
			level.pathfinder.calculateNodesDistances();
			addChild(level);
			
			addDebugTimeControll();
			addUI();
			
			inputManager = new InputManager(level, ui);
			
			addEventListener(Event.ADDED_TO_STAGE, onAdd);
		}
		
		private function addUI():void 
		{
			ui = new BasicUI(level);
			ui.x = 650;
			ui.y = 50;
			addChild(ui);
		}
		
		private function addDebugTimeControll():void 
		{
			debugUI.x = 650;
			debugUI.y = 10;
			addChild(debugUI);
			
			debugUI.addEventListener(TimeControll.ON_PLAY_CLICK, onTimeControllPlayClick);
			debugUI.addEventListener(TimeControll.ON_PAUSE_CLICK, onTimeControllPauseClick);
			debugUI.addEventListener(TimeControll.ON_STEP_CLICK, onTimeControllStepClick);
		}
		
		private function onTimeControllPlayClick(e:Event):void 
		{
			trace("play");
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
		
		public function startGame() : void {
			
		}
		
		public function loadMenu() : void {
			
		}
		
		private function onAdd(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdd);
			addEventListener(EnterFrameEvent.ENTER_FRAME, update);
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