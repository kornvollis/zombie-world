package massdefense 
{
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.core.FeathersControl;
	import feathers.core.ITextRenderer;
	import flash.text.AntiAliasType;
	import massdefense.assets.Assets;
	import massdefense.level.Level;
	import massdefense.level.LevelLoader;
	import massdefense.screens.Levels;
	import massdefense.screens.MainMenu;
	import massdefense.screens.ScreenManager;
	import massdefense.ui.MyUI;
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
		public static const SCREEN_WITH   : uint = 800;
		public static const SCREEN_HEIGHT : uint = 600;
		
		public static const FONT : String = "Pixel";
		[Embed(source="assets/font/prstart.ttf", embedAsCFF = "false", fontName = "Pixel")]
		//[Embed(source="assets/font/line_pixel-7.ttf", embedAsCFF="false", fontName="Pixel")]
		private static const FONT_PIXEL:String;
		
		public static var stage: Stage = null;
		public static var muted: Boolean = true;
		
		
		
		private var level : Level = null;
		
		private var debugUI : TimeControll = new TimeControll();

		private var levelLoader:LevelLoader = new LevelLoader();
		
		public var paused : Boolean = false;
		public var stepFrames : uint = 0;
		
		public var currentLevel : Level = null;
		
		//private var mainMenu : MainMenu = new MainMenu();
		
		//private var levelsScreen : Levels = new Levels();
		
		private var screenManager : ScreenManager = new ScreenManager();
		
		public function Game() 
		{
			FeathersControl.defaultTextRendererFactory = function():ITextRenderer
			{
				var tr :TextFieldTextRenderer = new TextFieldTextRenderer();
				tr.embedFonts = true;
				tr.antiAliasType = AntiAliasType.ADVANCED;
				return tr;
			};
			
			//mainMenu.addEventListener(MainMenu.NEW_GAME, showLevels);
			addEventListener(Event.ADDED_TO_STAGE, onAdd);
			screenManager.addEventListener(MainMenu.NEW_GAME, showLevels);
			screenManager.addEventListener(Levels.LEVEL_CLICK, startGame);
		}
		
		private function showLevels(e:Event):void 
		{
			trace("show levels");
			screenManager.show(ScreenManager.LEVEL_SELECTION);
		}
		
		private function test():void 
		{
			
		}
		
		public function startGame(e:Event) : void {
			
			currentLevel = levelLoader.createLevel(uint(e.data));
			currentLevel.init();
			currentLevel.debugDraw();
			
			screenManager.addScreen(currentLevel, ScreenManager.GAME);
			screenManager.show(ScreenManager.GAME);
			
			//Factory.addTower(14, 14, "beamTower", true);
			
			/*mainMenu.visible = false;
			if (level != null) removeChild(level);
			if (ui != null) removeChild(ui);
			level = levelLoader.createLevel(currentLevel);
			level.init();
			
			//ui = new UI(level);
			//ui.x = 650;	ui.y = 50;
			level.debugDraw();
			
			myUi = new MyUI();
			inputManager = new InputManager(level, myUi);
			addChild(level);
			//addChild(ui);
			
			
			addChild(myUi);
			
			
			
			*/
		}
		private function onAdd(e:Event):void 
		{
			Game.stage = stage;
			
			addChild(screenManager);
			
			removeEventListener(Event.ADDED_TO_STAGE, onAdd);
			addEventListener(EnterFrameEvent.ENTER_FRAME, update);
			
			//startGame();
			//showMainMenu();
		}
		
		private function showMainMenu():void 
		{
			//addChild(mainMenu);
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
			//startGame();
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
				if(currentLevel != null) {
					currentLevel.update(e.passedTime);
				}
				
				if (stepFrames > 0) stepFrames--;
			}
		}
		
	}

}