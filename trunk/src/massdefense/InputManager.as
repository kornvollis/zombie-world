package massdefense
{
	import massdefense.level.Level;
	import massdefense.pathfinder.Node;
	import massdefense.ui.BasicUI;
	import massdefense.units.Tower;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	public class InputManager extends Sprite
	{
		public static const SIMPLE_TOWER_BUILD : String = "SIMPLE_TOWER_BUILD";
		public static const IDLE : String = "IDLE";
		
		private var state : String = IDLE;
		private var level:Level;
		private var ui:BasicUI;
		
		public function InputManager(level:Level, ui:BasicUI)
		{
			this.ui = ui;
			this.level = level;
			
			ui.addEventListener(BasicUI.SIMPLE_TOWER_CLICK, onSimpleTowerClick);
			level.addEventListener(TouchEvent.TOUCH, onLevelTouch);
		}
		
		private function onLevelTouch(e:TouchEvent):void 
		{
			var touch: Touch = e.getTouch(level);
			
			if (touch != null && touch.phase == TouchPhase.ENDED) 
			{
				onLevelClick(touch);
			}
		}
		
		private function onLevelClick(touch:Touch):void 
		{
			if (state == SIMPLE_TOWER_BUILD) {
				Factory.addTower(int(touch.globalY / Node.NODE_SIZE), int(touch.globalX / Node.NODE_SIZE));
				state = IDLE;
			}
		}
		
		private function onSimpleTowerClick(e:Event):void 
		{
			state = SIMPLE_TOWER_BUILD;
		}
		
	}
}