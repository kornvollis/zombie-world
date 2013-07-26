package massdefense.ui.tower 
{
	import massdefense.assets.Assets;
	import massdefense.Factory;
	import massdefense.Game;
	import massdefense.level.Level;
	import massdefense.units.Tower;
	import massdefense.units.Units;
	import massdefense.Utils;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	public class TowerPanel extends Sprite
	{
		public static const TOWER_SELL_EVENT:String = "TOWER_SELL_EVENT";
		public static const UPGRADE_EVENT:String    = "upgradeEvent";
		public static const BUTTON_FONT_SIZE:uint   = 6;
		
		private var level            : Level;
		private var towerName        : TextField;
		private var towerLevel       : TextField;
		private var towerImage       : Image;
		
		private var towerDamage      : TowerPropertyRow;
		private var towerRange       : TowerPropertyRow;
		private var towerFireRate    : TowerPropertyRow;
		
		private var sellButton       : Button;
		private var upgradeButton    : Button;
		
		public function TowerPanel(level:Level)
		{
			this.level = level;
			addGraphics();			
			
			level.addEventListener(Level.MONEY_CHANGED, onMoneyChange)
			
			hide();
		}
		
		private function addGraphics():void 
		{
			addChild(Assets.getImage("TowerInfo"));
			
			addTowerName();
			addTowerLevel();
			addTowerProperties();
			addSellButton();
			addUpgradeButton();
		}
		
		private function addTowerName():void 
		{
			towerName = new TextField(114, 20 , "Simple tower", Game.FONT, 12);
			//towerName.border = true;
			addChild(towerName);
			towerName.x = 34;
			towerName.y = 0;
			towerName.hAlign = HAlign.CENTER;
			towerName.vAlign = VAlign.TOP;
		}
		
		private function addTowerLevel():void 
		{
			towerLevel = new TextField(114, 20 , "Level: 1", Game.FONT, 6);
			//towerName.border = true;
			addChild(towerLevel);
			towerLevel.x = 34;
			towerLevel.y = 20;
			towerLevel.hAlign = HAlign.CENTER;
			towerLevel.vAlign = VAlign.TOP;
		}
		
		private function addTowerProperties():void 
		{
			var verticalGap :int = 13;
			
			towerDamage = new TowerPropertyRow();
			towerDamage.setLeftText("Damage: ");
			towerDamage.setRightText("2");
			addChild(towerDamage);
			towerDamage.x = 4; towerDamage.y = 43;
			
			towerRange = new TowerPropertyRow();
			towerRange.setLeftText("Range: ");
			towerRange.setRightText("100");
			addChild(towerRange);
			towerRange.x = towerDamage.x; towerRange.y = towerDamage.y + verticalGap;
			
			towerFireRate = new TowerPropertyRow();
			towerFireRate.setLeftText("Speed: ");
			towerFireRate.setRightText("10");
			addChild(towerFireRate);
			towerFireRate.x = towerDamage.x; towerFireRate.y = towerRange.y + verticalGap;
		}
		
		private function addUpgradeButton():void 
		{
			upgradeButton = new Button(Assets.getTexture("UpgradeButton"), "Upgrade");
			upgradeButton.fontName = Game.FONT;
			upgradeButton.fontSize = BUTTON_FONT_SIZE;
			upgradeButton.fontColor = 359705;
			addChild(upgradeButton);
			upgradeButton.x = 4;
			upgradeButton.y = 173;
			
			upgradeButton.addEventListener(Event.TRIGGERED, onUpgradeClick);
		}
		
		private function onUpgradeClick(e:Event):void 
		{
			dispatchEvent(new Event(UPGRADE_EVENT));
		}
		
		private function addSellButton():void 
		{
			sellButton = new Button(Assets.getTexture("SellButton"), "Sell");
			sellButton.fontName = Game.FONT;
			sellButton.fontSize = BUTTON_FONT_SIZE;
			sellButton.fontColor = 13737473;
			addChild(sellButton);
			sellButton.x = 106;
			sellButton.y = 173;
			
			sellButton.addEventListener(Event.TRIGGERED, onSellClick);
		}
		
		private function onSellClick(e:Event):void 
		{
			dispatchEvent(new Event(TOWER_SELL_EVENT));
		}
		
		
		
		public function setTowerName(name : String) : void {
			this.towerName.text = name;
		}
		
		public function setTowerLevel(level : int) : void {
			this.towerLevel.text = "Level: " + level;
		}
		
		public function setTowerDamage(damage:uint):void 
		{
			towerDamage.setRightText(damage.toString());
		}
		
		public function setTowerRange(range:uint):void 
		{
			towerRange.setRightText(range.toString());
		}
		
		public function setTowerFireRate(reloadTime:Number):void 
		{
			towerFireRate.setRightText(reloadTime.toString());
		}
		
		public function setSellPrice(price : String):void {
			sellButton.text = "Sell for " + price + "$";
		}
		
		public function upgradeEnable() :void {
			upgradeButton.enabled = true;
		}
		
		public function upgradeDisable() :void {
			upgradeButton.enabled = false;
		}
		
		public function setUpgradeMaxed():void 
		{
			upgradeButton.enabled = false;
			upgradeButton.text = "MAX";
		}
		
		public function setUpgradePrice(towerUpgradeCost:int):void 
		{
			upgradeButton.text = "Upgrade " + towerUpgradeCost.toString();
		}
		
		public function setTowerImage(image : Image) : void {
			if (towerImage != null) removeChild(towerImage);
			this.towerImage = image;
			Utils.centerPivot(this.towerImage);
			
			addChild(towerImage);
			towerImage.x = 20;
			towerImage.y = 20;
		}
		
		private function onMoneyChange(e:Event):void 
		{
			/*
			if (tower != null && tower.level != Units.getTowerMaxLevel(tower.type)) 
			{
				if (Units.getTowerUpgradeCost(tower.type, tower.level+1) <= level.money) {
					upgradeEnable();
				} else {
					upgradeDisable();
				}
			}
			*/
		}
		
		private function onTowerUpgrade(e:Event):void 
		{
			/*
			tower.upgrade();
			level.money -= tower.cost;
			updateTowerInformations(tower.type, tower.level);
			*/
		}
		
		private function onTowerSell(e:Event):void 
		{
			/*
			Factory.sellTower(tower);
			hide();
			*/
		}
		
		public function show(type : String, level:uint):void 
		{
			this.visible = true;
			updateTowerInformations(type, level);
		}
		
		private function updateTowerInformations(type:String, level:uint):void 
		{
			/*
			if (level == Units.getTowerMaxLevel(type)) {
				setUpgradeMaxed();
			} else {
				setUpgradePrice(Units.getTowerUpgradeCost(type, level + 1));
				onMoneyChange(null);
			}
			
			setTowerName(Units.getTowerName(type));
			setTowerLevel(level);
			setTowerImage(Units.getTowerImage(type, level));
			
			setTowerDamage(Units.getTowerDamage(type, level));
			setTowerRange(Units.getTowerRange(type, level));
			setTowerFireRate(Units.getTowerReloadTime(type, level));
			//towerInformation.setSellPrice(tower.sellPrice.toString());
			*/
		}
		
		public function hide():void 
		{
			this.visible = false;
		}
		
		public function hideUpgradeButton():void 
		{
			upgradeButton.visible = false;
		}
		
		public function hideSellButton():void 
		{
			sellButton.visible = false;
		}
		
		public function showUpgradeButton():void 
		{
			upgradeButton.visible = true;
		}
		
		public function showSellButton():void 
		{
			sellButton.visible = true;
		}	
	}

}