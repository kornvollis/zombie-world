package massdefense 
{
	import massdefense.level.Level;
	import massdefense.level.LevelLoader;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	

	public class Game extends Sprite 
	{
		[Embed(source="config/units.xml", mimeType = "application/octet-stream")] 
		public static const Units:Class;
		
		static public var units : XML = XML(new Units());
		
		private var level : Level = null;
		
		public function Game() 
		{
			// TODO remove this juust for testing
			var levelLoader : LevelLoader = new LevelLoader();
			level = levelLoader.createLevel(LevelLoader.Level_01);
			level.debugDraw();
			
			level.pathfinder.calculateNodesDistances();
			addChild(level);
			
			addEventListener(Event.ADDED_TO_STAGE, onAdd);
		}
		
		public function loadLevel(index : uint) : void {
			//level = LevelStore.getLevel(index);
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
			if(level != null) {
				level.update(e.passedTime);
			}
		}
		
	}

}