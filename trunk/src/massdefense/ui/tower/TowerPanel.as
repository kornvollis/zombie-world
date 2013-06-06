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

		private var tower : Tower;
		private var level:Level;
		
		public function TowerPanel(level:Level) 
		{
			this.level = level;
			towerInformation = new TowerInformation();
			addChild(towerInformation);
			
			towerInformation.addEventListener(TowerInformation.TOWER_SELL_EVENT, onTowerSell);
			towerInformation.addEventListener(TowerInformation.UPGRADE_EVENT, onTowerUpgrade);
			
			hide();
		}
		
		private function onTowerUpgrade(e:Event):void 
		{
			tower.upgrade();
			updateTowerInformations(tower);
		}
		
		private function onTowerSell(e:Event):void 
		{
			Factory.sellTower(tower);
			hide();
		}
		
		public function show(tower:Tower):void 
		{
			this.visible = true;
			this.tower = tower;
			updateTowerInformations(tower);
		}
		
		private function updateTowerInformations(tower:Tower):void 
		{
			if (tower.level == Units.getTowerMaxLevel(tower.type)) {
				towerInformation.setUpgradeMaxed();
			} else if (Units.getTowerUpgradeCost(tower.type, tower.level+1) <= level.money) {
				towerInformation.upgradeEnable(Units.getTowerUpgradeCost(tower.type, tower.level+1).toString());
			} else {
				towerInformation.upgradeDisable();
			}
			
			towerInformation.setTowerName(Units.getTowerName(tower.type));
			towerInformation.setTowerLevel(tower.level);
			towerInformation.setTowerImage(Units.getTowerImage(tower.type, tower.level));
			
			towerInformation.setTowerDamage(tower.damage);
			towerInformation.setTowerRange(tower.range);
			towerInformation.setTowerFireRate(tower.reloadTime);
			//towerInformation.setSellPrice(tower.sellPrice.toString());
		}
		
		public function hide():void 
		{
			this.visible = false;
		}
		
	}

}