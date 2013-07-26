package massdefense.ui 
{
	import com.greensock.easing.Back;
	import com.greensock.TweenLite;
	import feathers.controls.Button;
	import flash.geom.Point;
	import massdefense.assets.Assets;
	import massdefense.misc.SimpleGraphics;
	import massdefense.ui.life_panel.LifePanel;
	import massdefense.Utils;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class MyUI extends Sprite 
	{
		static public const TOWER_UPGRADE_CLICKED : String = "towerUpgradeClicked";
		static public const TOWER_SELL_CLICKED    : String = "towerSellClicked";
		
		public var shop               : MyShop = new MyShop();
		private var towerUpgrade       : Button;
		private var towerSell	       : Button;
		private var lifePanel          : LifePanel;
		private var coinPanel          : CoinPanel;
		
		public var towerPlaceIndicator : TowerPlaceIndicator = new TowerPlaceIndicator
		
		public function MyUI() 
		{
			addChild(shop);
			
			addTowerUpgradeButton();
			addTowerSellButton();
			
			addLifePanel();
			addCoinPanel();
			
			addTowerPlaceIndicator();
		}
		
		private function addTowerPlaceIndicator():void 
		{
			addChild(towerPlaceIndicator);
		}
		
		private function addCoinPanel():void 
		{
			coinPanel = new CoinPanel();
			addChild(coinPanel);
			coinPanel.x = 105;
			coinPanel.y = 5;
		}
		
		private function addLifePanel():void 
		{
			lifePanel = new LifePanel();
			addChild(lifePanel);
			lifePanel.x = 5;
			lifePanel.y = 5;
		}
		
		private function addTowerSellButton():void 
		{
			towerSell = new Button(); // (Assets.getImage("TowerUpgrade"), Assets.getImage("TowerUpgradeDisabled"));
			Utils.centerPivot(towerSell);
			addChild(towerSell);
			towerSell.defaultSkin  = Assets.getImage("TowerSell");
			
			towerSell.addEventListener(Event.TRIGGERED, dispatchSellClick);
		}
		
		public function showTowerSellButton(towerPos : Point):void 
		{
			TweenLite.killTweensOf(towerSell);
			towerSell.x = towerPos.x;
			towerSell.y = towerPos.y-16;
			TweenLite.to(towerSell, 0.6, { x : towerPos.x - 50, alpha:1 , ease:Back.easeOut } );
			//towerUpgrade.touchable = true;
			towerSell.useHandCursor = true;
		}

		public function hideTowerSellButton():void 
		{
			TweenLite.to(towerSell, 0.6, { x : -50, alpha:1 , ease:Back.easeOut } );
		}
		
		private function addTowerUpgradeButton():void 
		{
			towerUpgrade = new Button(); // (Assets.getImage("TowerUpgrade"), Assets.getImage("TowerUpgradeDisabled"));
			Utils.centerPivot(towerUpgrade);
			addChild(towerUpgrade);
			towerUpgrade.defaultSkin  = Assets.getImage("TowerUpgrade");
			towerUpgrade.disabledSkin = Assets.getImage("TowerUpgradeDisabled");
			
			towerUpgrade.addEventListener(Event.TRIGGERED, dispatchUpgradeClick);
		}
		
		public function showUpgradeButton(towerPos : Point):void 
		{
			TweenLite.killTweensOf(towerUpgrade);
			towerUpgrade.x = towerPos.x-16;
			towerUpgrade.y = towerPos.y;
			TweenLite.to(towerUpgrade, 0.6, { y : towerPos.y - 50, alpha:1 , ease:Back.easeOut } );
			//towerUpgrade.touchable = true;
			towerUpgrade.useHandCursor = true;
		}

		public function hideUpgradeButton():void 
		{
			TweenLite.to(towerUpgrade, 0.6, { y : -50, alpha:1 , ease:Back.easeOut } );
		}
		
		private function dispatchUpgradeClick(e:Event):void 
		{
			dispatchEvent(new Event(TOWER_UPGRADE_CLICKED, true));
		}
		
		private function dispatchSellClick(e:Event):void 
		{
			dispatchEvent(new Event(TOWER_SELL_CLICKED, true));
		}
			
		public function closeShop() : void {
			shop.close();
		}
		
		public function setLife(value:String):void 
		{
			lifePanel.setLife(value);
		}
		
		public function setCoins(value:String):void 
		{
			coinPanel.setCoins(value);
		}
		
		
	}

}