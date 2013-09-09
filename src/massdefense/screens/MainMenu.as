package massdefense.screens 
{
	import feathers.controls.Button;
	import feathers.controls.Screen;
	import massdefense.assets.Assets;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class MainMenu extends Sprite 
	{
		public static const NEW_GAME : String = "START_GAME";
		
		private var start : Button = new Button();
		private var load  : Button = new Button();
		private var about : Button = new Button();
		
		private var bg : Sprite;
		
		public function MainMenu() 
		{
			bg = new Sprite();
			bg.addChild(Assets.getImage("MainMenuBG"));
			
			addChild(bg);
			
			bg.x = (800 - bg.width) * 0.5;
			bg.y = (600 - bg.height) * 0.5;
			
			addAboutButton();
			addLoadButton();
			addStartButton();
		}
		
		private function addStartButton():void 
		{
			start.useHandCursor = true;
			start.defaultSkin = Assets.getImage("MainMenuNewGame");
			start.hoverSkin = Assets.getImage("MainMenuNewGameOver");
			bg.addChild(start);
			start.y = 247;
			
			start.addEventListener(Event.TRIGGERED, onStartClick);
		}
		
		private function onStartClick(e:Event):void 
		{
			dispatchEvent(new Event(NEW_GAME, true));
		}
		
		private function addLoadButton():void 
		{
			load.useHandCursor = true;
			load.defaultSkin = Assets.getImage("MainMenuLoad");
			load.hoverSkin = Assets.getImage("MainMenuLoadOver");
			bg.addChild(load);
			load.y = 334;
		}
		
		private function addAboutButton():void 
		{
			about.useHandCursor = true;
			about.defaultSkin = Assets.getImage("MainMenuAbout");
			about.hoverSkin = Assets.getImage("MainMenuAboutOver");
			bg.addChild(about);
			about.y = 419;
		}
		
		
		
		
		
	}

}