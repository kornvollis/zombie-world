package
{
	import assets.Assets;
	import feathers.controls.Button;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.core.FeathersControl;
	import feathers.core.ITextRenderer;
	import feathers.text.BitmapFontTextFormat;
	import flash.text.TextFormat;
	import screens.GameScreen;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import starling.text.BitmapFont;
	import utils.Util;

	public class Game extends Sprite
	{
		private var gameModel  : GameModel;
		private var gameScreen : GameScreen;
		
		//private var theme : MetalWorksMobileTheme;
		
		public function Game()
		{
			
			FeathersControl.defaultTextRendererFactory = function():ITextRenderer
			{
				return new TextFieldTextRenderer();
			};
			
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
			
			//addChild(gameModel.gameScreen);
			
			var b : Button = new Button;
			b.defaultIcon = Util.bitmapToImage(Util.DefaultButtonBM);
			b.scaleX = 0.12;
			b.scaleY = 0.12;
			
			
			//b.defaultSkin =  
			//b.defaultLabelProperties //  textRendererProperties.textFormat = new TextFormat( "Astera", 24, 0x323232 );
			//b.label.textRendererProperties.embedFonts = true;
			
			b.label = "kaka";
			addChild(b);
			
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