package massdefense
{
	import flash.geom.Point;
	import massdefense.level.Level;
	import massdefense.misc.Position;
	import massdefense.pathfinder.Node;
	import massdefense.ui.BasicUI;
	import massdefense.units.Tower;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.KeyboardEvent;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class InputManager extends Sprite
	{
		public static const SIMPLE_TOWER_BUILD : String = "SIMPLE_TOWER_BUILD";
		public static const BLOCK_BUILDER : String = "BLOCK_BUILDER";
		public static const IDLE : String = "IDLE";
		
		private var state : String = IDLE;
		private var level:Level;
		private var ui:BasicUI;
		
		private var mouseDown : Boolean = false;
		private var shiftDown : Boolean = false;
		
		private var selectedTower : Tower;
		
		public function InputManager(level:Level, ui:BasicUI)
		{
			this.ui = ui;
			this.level = level;
			
			ui.addEventListener(BasicUI.SIMPLE_TOWER_CLICK, onTowerBuilderButtonClick);
			ui.addEventListener(BasicUI.BLOCK_CLICK, onBlockClick);
			level.addEventListener(TouchEvent.TOUCH, onLevelTouch);
			level.addEventListener(Tower.TOWER_CLICKED_EVENT, onTowerClick);
			Game.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			Game.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyUp);
		}
		
		private function onTowerClick(e:Event):void 
		{
			var tower : Tower = Tower(e.data);
			if (selectedTower != null && !(selectedTower.row == tower.row && selectedTower.col == tower.col) )
			{
				selectedTower.hideRange();
			}
			ui.towerPanel.show(Tower(e.data));
			selectedTower = tower;
			tower.showRange();
		}
		
		private function onKeyUp(e:KeyboardEvent):void 
		{
			shiftDown = e.shiftKey;
		}
		
		private function onKeyDown(e:KeyboardEvent):void 
		{
			shiftDown = e.shiftKey;
		}
		
		private function onTowerBuilderButtonClick(e:Event):void {state = SIMPLE_TOWER_BUILD;}
		
		private function onBlockClick(e:Event):void {state = BLOCK_BUILDER}
		
		private function onLevelTouch(e:TouchEvent):void 
		{
			var touch: Touch = e.getTouch(level);
			
			if (touch != null) 
			{
				var clickPos:Point = touch.getLocation(level);
				
				if (touch.phase == TouchPhase.ENDED) 
				{
					ui.towerPanel.hide();
					if(selectedTower != null) { selectedTower.hideRange(); }
					onLevelClick(clickPos);
				} else if (touch != null && touch.phase == TouchPhase.MOVED && shiftDown) {
					onLevelClick(clickPos);
				}
			}
		}
		
		private function onLevelClick(clickPos:Point):void 
		{
			var clickedRow : int = int(clickPos.y / Node.NODE_SIZE);
			var clickedCol : int = int(clickPos.x / Node.NODE_SIZE);
			
			if (state == SIMPLE_TOWER_BUILD) {
				Factory.addTower(clickedRow, clickedCol, "simpleTower");
			} else if (state == BLOCK_BUILDER) {
				Factory.addBlock(clickedRow, clickedCol, "simpleBlock");
			}
			
			if(!shiftDown) state = IDLE;
		}
		
		
		
	}
}