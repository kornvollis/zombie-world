package  
{
	import mvc.GameModel;
	import screens.GameScreen;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author ...
	 */
	public class Game extends Sprite 
	{
		private var gameModel : GameModel;
		
		private var gameScreen : GameScreen;
		
		public function Game() 
		{
			gameModel = new GameModel();
			
			gameScreen = new GameScreen(gameModel);
			
		}
		
	}

}