package massdefense.screens 
{
	import flash.utils.Dictionary;
	import massdefense.level.Level;
	import starling.display.Sprite;

	public class ScreenManager extends Sprite 
	{
		public static const MAIN_MENU       : String = "mm";
		public static const LEVEL_SELECTION : String = "ls";
		static public const GAME:String = "game";
		
		private var activeScreenName : String;
		
		private var screens : Dictionary = new Dictionary;
		
		public function ScreenManager() 
		{
			addScreen(new MainMenu(), MAIN_MENU);
			addScreen(new Levels(), LEVEL_SELECTION);
			
			
			activeScreenName = MAIN_MENU;
			addChild(screens[MAIN_MENU]);
		}
		
		public function addScreen(screen : Sprite, name : String) : void {
			screens[name] = screen;
		}
		
		public function show(screenName : String) : void {
			if (activeScreenName != screenName) {
				removeChildAt(0);
			}
			
			activeScreenName = screenName;
			addChild(screens[screenName]);
		}
	}

}