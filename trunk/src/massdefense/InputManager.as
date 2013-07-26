package massdefense
{
	import feathers.core.PopUpManager;
	import flash.geom.Point;
	import massdefense.level.Level;
	import massdefense.misc.Position;
	import massdefense.pathfinder.Node;
	import massdefense.ui.MyShop;
	import massdefense.ui.MyUI;
	import massdefense.ui.ShopCard;
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
		
		private var _state : String = IDLE;
		private var level:Level;
		private var ui:MyUI;
		
		private var mouseDown : Boolean = false;
		private var shiftDown : Boolean = false;
		
		private var selectedTower : Tower;
		private var towerToBuild : String = "";
		
		public function InputManager(level:Level, ui: MyUI)
		{
			this.ui = ui;
			this.level = level;
			
			ui.setLife(level.life.toString());
			ui.setCoins(level.money.toString());
			
			ui.addEventListener(ShopCard.TOWER_BUY_CLICK, onTowerBuyClick);
			ui.addEventListener(MyUI.TOWER_UPGRADE_CLICKED, onTowerUpgrade);
			ui.addEventListener(MyUI.TOWER_SELL_CLICKED, onTowerSell);
			//ui.addEventListener(UI.SIMPLE_TOWER_CLICK, onTowerBuilderButtonClick);
			//ui.addEventListener(UI.BLOCK_CLICK, onBlockClick);
			
			//ui.addEventListener(ShopButton.CLICK, onTowerBuyClick);
			//ui.addEventListener(UI.TOWER_UPGRADE, onTowerUpgrade);
			//ui.addEventListener(UI.TOWER_SELL, onTowerSell);
			level.addEventListener(TouchEvent.TOUCH, onLevelTouch);
			level.addEventListener(Tower.CLICK, onTowerClick);
			level.addEventListener(Tower.HOVER, onTowerHover);
			level.addEventListener(Tower.HOVER_OUT, onTowerHoverOut);
			level.addEventListener(Level.LIFE_LOST, onLifeLost);
			level.addEventListener(Level.MONEY_CHANGED, onMoneyChanged);
			Game.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			Game.stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyUp);
		}
		
		private function onMoneyChanged(e:Event):void 
		{
			ui.setCoins(String(e.data));
		}
		
		private function onLifeLost(e:Event):void 
		{
			ui.setLife(String(e.data));
		}
		
		private function onTowerSell(e:Event):void 
		{
			Factory.sellTower(selectedTower);
			ui.hideTowerSellButton();
			ui.hideUpgradeButton();
		}
		
		private function onTowerUpgrade(e:Event):void 
		{
			var success : int = Factory.upgradeTower(selectedTower);
			if (success == 1) {
				ui.hideTowerSellButton();
				ui.hideUpgradeButton();
			} 
		}
		
		private function onTowerHoverOut(e:Event):void 
		{
			//UI.popUp.hide();
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
			trace("tower bulid mode");
			
			if (Factory.affordable(Units.getTowerProperties(towerToBuild, 1).cost)) {
				ui.closeShop();
			} else {
				ui.shop.showMessage("You have NOT ENOUGH MONEY",2);
				state = IDLE;
			}
			//ui.showTowerInformation(towerToBuild, 1);
		}
		
		private function onTowerClick(e:Event):void 
		{
			//if (UI.selectedTower != null) UI.selectedTower.deselect();
			selectedTower = Tower(e.data);
			ui.showUpgradeButton(new Point(selectedTower.x, selectedTower.y));
			ui.showTowerSellButton(new Point(selectedTower.x, selectedTower.y));
			//UI.selectedTower = tower;
			// UI.selectedTower.select();
			//if(!tower.isMaxLevel()) ui.showTowerUpgrade();
			//ui.showTowerSell();
			//ui.showTowerUpgradeInformation(tower.type, tower.level);
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
				var row : uint = clickPos.y / 32;
				var col : uint = clickPos.x / 32;
				ui.towerPlaceIndicator.y = row*32;
				ui.towerPlaceIndicator.x = col*32;
				
				if(level.pathfinder.grid.getNode(row, col) != null) {
					if (level.pathfinder.grid.getNode(row, col).distance != Node.INFINIT) {
						ui.towerPlaceIndicator.showGoodSpot();
					} else ui.towerPlaceIndicator.showBadSpot();
				}
				
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
			if (selectedTower != null) {
				//selectedTower.deselect();
				ui.hideUpgradeButton();
				ui.hideTowerSellButton();
			}
			if(!shiftDown) state = IDLE;
		}
		
		public function get state():String 
		{
			return _state;
		}
		
		public function set state(value:String):void 
		{
			if (value == InputManager.SIMPLE_TOWER_BUILD) {
				ui.towerPlaceIndicator.visible = true;
			} else {
				ui.towerPlaceIndicator.visible = false;
			}
			_state = value;
		}
	}
}