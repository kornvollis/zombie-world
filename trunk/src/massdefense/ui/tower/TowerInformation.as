package massdefense.ui.tower 
{
	import massdefense.assets.Assets;
	import massdefense.Game;
	import massdefense.Utils;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	public class TowerInformation extends Sprite 
	{
		public static const TOWER_SELL_EVENT:String = "TOWER_SELL_EVENT";
		public static const UPGRADE_EVENT:String = "upgradeEvent";
		public static const BUTTON_FONT_SIZE:uint = 20;
		
		private var towerName  : TextField;
		private var towerLevel : TextField;
		private var towerImage : Image;
		
		private var towerDamage    : TowerPropertyRow;
		private var towerRange     : TowerPropertyRow;
		private var towerFireRate  : TowerPropertyRow;
		
		private var sellButton : Button;
		private var upgradeButton : Button;
		
		public function TowerInformation()
		{
			addChild(Assets.getImage("TowerInfo"));
			
			addTowerName();
			addTowerLevel();
			addTowerProperties();
			addSellButton();
			addUpgradeButton();
		}
		
		
		
		public function hideUpgradeButton() : void {
			upgradeButton.visible = false;
		}
		
		public function hideSellButton() : void {
			sellButton.visible = false;
		}
		
		public function showUpgradeButton() : void {
			upgradeButton.visible = true;
		}
		
		public function showSellButton() : void {
			sellButton.visible = true;
		}
		
		public function setTowerImage(image : Image) : void {
			if (towerImage != null) removeChild(towerImage);
			this.towerImage = image;
			Utils.centerPivot(this.towerImage);
			
			addChild(towerImage);
			towerImage.x = 20;
			towerImage.y = 20;
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
	}

}