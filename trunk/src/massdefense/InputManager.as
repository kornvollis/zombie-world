package massdefense
{
	import flash.geom.Point;
	import massdefense.level.Level;
	import massdefense.misc.Position;
	import massdefense.pathfinder.Node;
	import massdefense.ui.MyShop;
	import massdefense.ui.MyUI;
	import massdefense.ui.UI;
	import massdefense.ui.tower.ShopButton;
	import massdefense.units.Tower;
	import massdefense.units.Units;
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
		private var ui:UI;
		
		private var mouseDown : Boolean = false;
		private var shiftDown : Boolean = false;
		
		private var selectedTower : Tower;
		private var towerToBuild : String = "";
		
		public function InputManager(level:Level, ui: UI)
		{
			this.ui = ui;
			this.level = level;
			
			//ui.addEventListener(UI.SIMPLE_TOWER_CLICK, onTowerBuilderButtonClick);
			//ui.addEventListener(UI.BLOCK_CLICK, onBlockClick);
			
			ui.addEventListener(ShopButton.CLICK, onTowerBuyClick);
			ui.addEventListener(UI.TOWER_UPGRADE, onTowerUpgrade);
			ui.addEventListener(UI.TOWER_SELL, onTowerSell);
			level.addEventListener(TouchEvent.TOUCH, onLevelTouch);
			level.addEventListener(Tower.CLICK, onTowerClick);
			level.addEventListener(Tower.HOVER, onTowerHover);
			level.addEventListener(Tower.HOVER_OUT, onTowerHoverOut);
			Game.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			Game.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyUp);
		}
		
		private function onTowerSell(e:Event):void 
		{
			Factory.sellTower(Tower(e.data));
			ui.hideTowerSell();
			ui.hideTowerUpgrade();
		}
		
		private function onTowerUpgrade(e:Event):void 
		{
			if (Units.getTowerUpgradeCost(UI.selectedTower.type, UI.selectedTower.level + 1) <= level.money) {
				Factory.upgradeTower(UI.selectedTower);
			}
		}
		
		private function onTowerHoverOut(e:Event):void 
		{
			UI.popUp.hide();
		}
		
		private function onTowerHover(e:Event):void 
		{
			var tower:Tower = Tower(e.data);
			// UI.popUp.show(tower.x, tower.y);
		}
		
		private function onTowerBuyClick(e:Event):void 
		{
			state = SIMPLE_TOWER_BUILD;
			towerToBuild = String(e.data);
			ui.showTowerInformation(towerToBuild, 1);
		}
		
		private function onTowerClick(e:Event):void 
		{
			if (UI.selectedTower != null) UI.selectedTower.deselect();
			
			var tower : Tower = Tower(e.data);
			UI.selectedTower = tower;
			// UI.selectedTower.select();
			if(!tower.isMaxLevel()) ui.showTowerUpgrade();
			ui.showTowerSell();
			ui.showTowerUpgradeInformation(tower.type, tower.level);
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
				Factory.addTower(clickedRow, clickedCol, towerToBuild);
			} else if (state == BLOCK_BUILDER) {
				Factory.addBlock(clickedRow, clickedCol, "simpleBlock");
			} 
			
			// CLOSE SHOP
			MyShop.instance.close();
			
			//ui.hideTowerPanel();
			if (UI.selectedTower != null) {
				UI.selectedTower.deselect();
				ui.hideTowerUpgrade();
				ui.hideTowerSell();
			}
			
			
			if(!shiftDown) state = IDLE;
		}
		
		
		
	}
}