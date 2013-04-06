package massdefense.tests.level 
{
	import flash.text.GridFitType;
	import flash.utils.Dictionary;
	import massdefense.assets.Assets;
	import massdefense.assets.LevelStore;
	import massdefense.Factory;
	import massdefense.level.Level;
	import massdefense.misc.SimpleGraphics;
	import massdefense.pathfinder.Grid;
	import massdefense.pathfinder.PathFinder;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.events.Event;
	
	
	public class LevelTest extends Sprite
	{
		private var xml : XML;
		
		private var level : Level;
		
		private var isAnyError : Boolean = false;
		
		private var grid : Grid;
		private var pathfinder : PathFinder;
		
		public function LevelTest()
		{
			xml = XML(new LevelStore.Level_01());
			
			level = new Level();
			Factory.level = level;
			level.levelData = xml;
			level.initLevel();
			
			var image : Image = Assets.getImage("Level_01");			
			addChild(image);
			
			level.debugDraw();
			addChild(level);
			
			
			// SPAWNER
			level.play();
			
			addEventListener(Event.ADDED_TO_STAGE, onAdd);
		}
		
		private function onAdd(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdd);
			addEventListener(EnterFrameEvent.ENTER_FRAME, update);
		}
		
		private function update(e:EnterFrameEvent):void 
		{
			level.update(e.passedTime);
		}
		
	}

}