package
{
	import assets.Assets;
	import flash.text.Font;
	import flash.text.TextFormat;
	import screens.GameScreen;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import units.Enemy;
	import utils.Util;

	public class Game extends Sprite
	{
		private var gameModel  : GameModel;
		private var gameScreen : GameScreen;
		
		//private var theme : MetalWorksMobileTheme;
		
		//KEYBOARD STATE
		public static var isShiftPressed : Boolean = false;
		
		public function Game()
		{
			// REGISTER FONT
			var font : BitmapFont = new BitmapFont(Assets.getTexture("FontTexture"), XML(new Assets.FontXml()));
			TextField.registerBitmapFont(font, Constants.FONT_NAME);
			
			gameModel = new GameModel();
			
			Factory.getInstance().setModel(gameModel);
			
			// Game screen position
			gameModel.gameScreen.x = 50;
			//gameModel.gameScreen.y = 50;
			
			// temp
			Factory.getInstance().addExitPoint(0, 4);
			Factory.getInstance().addEnemy(8, 11);
			//Factory.getInstance().addEnemy(12, 19);
			//Factory.getInstance().addEnemy(14, 20);
			//Factory.getInstance().addEnemy(10, 17);
			Factory.getInstance().addTower(4,4);
			Factory.getInstance().addBlock(4, 3);
			
			//Factory.getInstance().addWave(15, 15, 0, 20, 100, Enemy);
				
			
			addChild(gameModel.gameScreen);
			
			//EVENT LISTENERS
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
			addEventListener(EnterFrameEvent.ENTER_FRAME, enterFrame);
			
		}
		
		private function onKeyDown(e:KeyboardEvent):void 
		{
			if (e.shiftKey == true)
			{
				isShiftPressed = true;
			}
		}
		
		private function onKeyUp(e:KeyboardEvent):void 
		{
			if (e.shiftKey == false)
			{
				isShiftPressed = false;
			}
		}
		
		private function onAdded(e:Event):void 
		{
			stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			//theme = new MetalWorksMobileTheme(stage);
		}
		
		
		
		private function enterFrame(e:EnterFrameEvent):void 
		{
			gameModel.update(e);
		}
	}
}