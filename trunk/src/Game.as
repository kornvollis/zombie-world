package
{
	import assets.Assets;
	import flash.text.Font;
	import flash.text.TextFormat;
	import screens.GameScreen;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.text.BitmapFont;
	import starling.text.TextField;
	import utils.Util;

	public class Game extends Sprite
	{
		private var gameModel  : GameModel;
		private var gameScreen : GameScreen;
		
		//private var theme : MetalWorksMobileTheme;
		
		public function Game()
		{
			gameModel = new GameModel();
			
			Factory.getInstance().setModel(gameModel);
			
			// Game screen position
			gameModel.gameScreen.x = 50;
			//gameModel.gameScreen.y = 50;
			
			// temp
			Factory.getInstance().addExitPoint(0, 4);
			Factory.getInstance().addEnemy(8, 11);
			Factory.getInstance().addTower(4,4);
			Factory.getInstance().addBlock(4, 3);
			
		
			
			addChild(gameModel.gameScreen);
			/*
			var font : BitmapFont = new BitmapFont(Assets.getTexture("FontTexture"), XML(new Assets.FontXml()));
			
			TextField.registerBitmapFont(font, "Myfont");
			
			var starlingButton : starling.display.Button = new starling.display.Button(Assets.getTexture("ButtonDefaultBM"), "KAKA");
			starlingButton.fontName = "Myfont";
			starlingButton.fontSize = 50;
			addChild(starlingButton);
			*/
			
			//EVENT LISTENERS
			addEventListener(Event.ADDED_TO_STAGE, onAdded);
			addEventListener(EnterFrameEvent.ENTER_FRAME, enterFrame);
		}
		
		private function onAdded(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdded);
			
			//theme = new MetalWorksMobileTheme(stage);
		}
		
		private function enterFrame(e:EnterFrameEvent):void 
		{
			gameModel.update(e);
		}
	}
}