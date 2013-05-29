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
		
		private var _upgradeImage : Image;
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
			
			_upgradeImage = Assets.getImage("TowerSprite02");
			addChild(_upgradeImage);
			
			addPriceField();
			addPropertiesField();
			addUpgradeButton();
			
			this.visible = false;
		}
		
		public function show():void	{ this.visible = true; }
		
		public function hide():void { this.visible = false; }
		
		public function setUpgradeProperties(tower:Tower):void 
		{
			this.tower = tower;
			var nextLevelTowerDamage : int = Units.getTowerDamage(tower.type, tower.level+1);
			
			var text : String = "Damage: " + tower.damage + " > " + nextLevelTowerDamage;
			text += "\nRange: " + tower.range;
			
			upgradeCost = Units.getTowerUpgradeCost(tower.type, tower.level + 1);
			
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
			if (level.money > upgradeCost) {
				tower.upgrade();
				level.money -= upgradeCost;
			}
			
			if (tower.level != Units.getTowerMaxLevel(tower.type)) {
				setUpgradeProperties(tower);
			}
		}
		
		private function addPropertiesField():void 
		{
			propertiesText = new TextField(140, 200, "");
			propertiesText.hAlign = HAlign.LEFT; 
			propertiesText.text = "Damage: 2 > 3 \n\n";
			propertiesText.text += "Range: 120 > 135 \n";
			
			addChild(propertiesText);
			propertiesText.y = 60;
		}
		
		private function addPriceField():void 
		{
			priceText = new TextField(50, 50, "", "Verdana", 24);
			priceText.text = "50$";
			priceText.x = 80;
			
			addChild(priceText);
		}
		
		public function get upgradeImage():Image 
		{
			return _upgradeImage;
		}
		
		public function set upgradeImage(value:Image):void 
		{
			_upgradeImage = value;
		}
		
		
		
	}

}