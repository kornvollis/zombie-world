package massdefense.ui.tower 
{
	import massdefense.Factory;
	import massdefense.level.Level;
	import massdefense.units.Tower;
	import massdefense.units.Units;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;

	public class TowerPanel extends Sprite
	{
		private var towerInformation : TowerInformation;

		private var _tower : Tower;
		private var level:Level;
		
		public function TowerPanel(level:Level)
		{
			this.level = level;
			towerInformation = new TowerInformation();
			addChild(towerInformation);
			
			towerInformation.addEventListener(TowerInformation.TOWER_SELL_EVENT, onTowerSell);
			towerInformation.addEventListener(TowerInformation.UPGRADE_EVENT, onTowerUpgrade);
			
			level.addEventListener(Level.MONEY_CHANGED, onMoneyChange)
			hide();
		}
		
		private function onMoneyChange(e:Event):void 
		{
			if (tower != null && tower.level != Units.getTowerMaxLevel(tower.type)) 
			{
				if (Units.getTowerUpgradeCost(tower.type, tower.level+1) <= level.money) {
					towerInformation.upgradeEnable();
				} else {
					towerInformation.upgradeDisable();
				}
			}
		}
		
		private function onTowerUpgrade(e:Event):void 
		{
			tower.upgrade();
			level.money -= tower.cost;
			updateTowerInformations(tower.type, tower.level);
		}
		
		private function onTowerSell(e:Event):void 
		{
			Factory.sellTower(tower);
			hide();
		}
		
		public function show(type : String, level:uint):void 
		{
			this.visible = true;
			updateTowerInformations(type, level);
		}
		
		private function updateTowerInformations(type:String, level:uint):void 
		{
			if (level == Units.getTowerMaxLevel(type)) {
				towerInformation.setUpgradeMaxed();
			} else {
				towerInformation.setUpgradePrice(Units.getTowerUpgradeCost(type, level + 1));
				onMoneyChange(null);
			}
			
			towerInformation.setTowerName(Units.getTowerName(type));
			towerInformation.setTowerLevel(level);
			towerInformation.setTowerImage(Units.getTowerImage(type, level));
			
			towerInformation.setTowerDamage(Units.getTowerDamage(type, level));
			towerInformation.setTowerRange(Units.getTowerRange(type, level));
			towerInformation.setTowerFireRate(Units.getTowerReloadTime(type, level));
			//towerInformation.setSellPrice(tower.sellPrice.toString());
		}
		
		public function hide():void 
		{
			this.visible = false;
		}
		
		public function hideUpgradeButton():void 
		{
			towerInformation.hideUpgradeButton();
		}
		
		public function hideSellButton():void 
		{
			towerInformation.hideSellButton();
		}
		
		public function showUpgradeButton():void 
		{
			towerInformation.showUpgradeButton();
		}
		
		public function showSellButton():void 
		{
			towerInformation.showSellButton();
		}
		
		public function get tower():Tower 
		{
			return _tower;
		}
		
		public function set tower(value:Tower):void 
		{
			_tower = value;
		}
		
	}

}