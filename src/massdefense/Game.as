package massdefense 
{
	import massdefense.assets.LevelStore;
	import massdefense.level.Level;
	import starling.display.Sprite;
	

	public class Game extends Sprite 
	{
		//private var model  : Model;
		//private var screen : Screen;
		//private var inputManager : InputManager;
		
		private var level : Level;
		
		public function Game() 
		{
			
		}
		
		public function loadLevel(index : uint) : void {
			level = LevelStore.getLevel(index);
		}
		
		public function start() : void {
			
		}
		
		public function stop() : void {
			
		}
		
		public function pause() : void {
			
		}
	}

}