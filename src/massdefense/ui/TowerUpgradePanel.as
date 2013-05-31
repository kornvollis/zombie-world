package massdefense.ui 
{
	import massdefense.assets.Assets;
	import massdefense.level.Level;
	import massdefense.misc.SimpleGraphics;
	import massdefense.units.Tower;
	import massdefense.units.Units;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;

	public class TowerUpgradePanel extends Sprite 
	{
		private var buyUpgrade : Button;
		
		private var upgradeImage : Image = null;
		private var priceText : TextField;
		private var propertiesText : TextField;
		private var level:Level;
		private var upgradeCost : int;
		private var tower : Tower;
		
		public function TowerUpgradePanel(level : Level) 
		{
			this.level = level;
			
			var background : Image = SimpleGraphics.drawRectangle(150, 300, 0xffffff);
			addChild(background);
			
			upgradeImage = Assets.getImage("TowerSprite02");
			addChild(upgradeImage);
			
			addPriceField();
			addPropertiesField();
			addUpgradeButton();
			
			this.visible = false;
		}
		
		public function show(tower : Tower):void { 
			this.visible = true;
			initProperties(tower);
		}
		
		public function hide():void { this.visible = false; }
		
		private function initProperties(tower:Tower):void 
		{
			this.tower = tower;
			var nextLevel : int = tower.level + 1;
			if (tower.level == Units.getTowerMaxLevel(tower.type)) {
				buyUpgrade.enabled = false;
				buyUpgrade.text = "MAX";
				nextLevel--;
			}
			
			if (upgradeImage != null) {
				removeChild(upgradeImage);
				upgradeImage = Units.getTowerImage(tower.type, nextLevel);
				addChild(upgradeImage);
			}
			
			var nextLevelTowerDamage     : int    = Units.getTowerDamage(tower.type, nextLevel);
			var nextLevelTowerRange      : int    = Units.getTowerRange(tower.type, nextLevel);
			var nextLevelTowerReloadTime : Number = Units.getTowerReloadTime(tower.type, nextLevel);
			
			var text : String = "Damage: " + tower.damage + " > " + nextLevelTowerDamage;
			text += "\nRange: " + tower.range + " > " + nextLevelTowerRange;
			text += "\nReload time: " + tower.reloadTime + " > " + nextLevelTowerReloadTime;
			
			upgradeCost = Units.getTowerUpgradeCost(tower.type, nextLevel);
			
			propertiesText.text = text;
			
			priceText.text = upgradeCost + "$";
			
			
		}
		
		private function addUpgradeButton():void 
		{
			buyUpgrade = new Button(Assets.getTexture("BuyButton"), "BUY");
			addChild(buyUpgrade);
			buyUpgrade.y = 250;
			buyUpgrade.x = 40;
			
			buyUpgrade.addEventListener(Event.TRIGGERED, onBuyClick);
		}
		
		private function onBuyClick(e:Event):void 
		{
			if (tower.level != Units.getTowerMaxLevel(tower.type)) {
				
				if (level.money > upgradeCost) {
					tower.upgrade();
					level.money -= upgradeCost;
				}
				
				if (tower.level == Units.getTowerMaxLevel(tower.type)) {
					hide();
				} else {
					initProperties(tower);
				}
			}
		}
		
		private function addPropertiesField():void 
		{
			propertiesText = new TextField(140, 200, "", "Line Pixel-7", 20);
			propertiesText.hAlign = HAlign.LEFT; 
			propertiesText.text = "DAMAGE: 2 > 3 \n\n";
			propertiesText.text += "Range: 120 > 135 \n";
			
			addChild(propertiesText);
			propertiesText.y = 60;
		}
		
		private function addPriceField():void 
		{
			priceText = new TextField(50, 50, "", "Line Pixel-7", 24);
			priceText.text = "50$";
			priceText.x = 80;
			
			addChild(priceText);
		}
	}
}