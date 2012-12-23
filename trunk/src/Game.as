package
{
	import feathers.controls.Button;
	import mvc.GameModel;
	import screens.GameScreen;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	import utils.Util;
	
	/**
	 * ...
	 * @author ...
	 */
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
			
			
			
			//addChild(gameModel.gameScreen);
			
			var b : Button = new Button;
			b.defaultIcon = Util.bitmapToImage(Util.DefaultButtonBM);
			b.scaleX = 0.12;
			b.scaleY = 0.12;
			
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