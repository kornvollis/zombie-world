package massdefense.ui 
{
	import com.basicgui.BPopUp;
	import com.greensock.easing.Back;
	import com.greensock.TweenLite;
	import flash.geom.Point;
	import massdefense.assets.Assets;
	import massdefense.Game;
	import massdefense.level.Level;
	import massdefense.tests.tower.TowerTest;
	import massdefense.ui.life_panel.LifePanel;
	import massdefense.ui.tower.TowerPanel;
	import massdefense.ui.tower.Shop;
	import massdefense.ui.tower.TowerSelection;
	import massdefense.units.Tower;
	import starling.core.Starling;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	public class UI extends Sprite
	{ 
		public static var popUp          : BPopUp;
		public static var selectedTower  : Tower;
		private var money                : TextField;
		private var towerPanel           : TowerPanel;
		private var shop                 : Shop;
		private var lifePanel            : LifePanel;
		private var level                : Level;
		
		
		public function UI(level:Level)
		{
			this.level = level;
			addTowerPanel(0, 240);
			addMoneyField(0, 0);
			addLifePanel(0, 30);
			addShop(0, 60);
			addPopUp();
			
			level.addEventListener(Level.LIFE_LOST, onLifeLost);
		}
		
		private function addPopUp():void 
		{
			popUp = new BPopUp();
			addChild(popUp);
		}
		
		public function showTowerUpgradeInformation(type:String, level:int):void 
		{
			towerPanel.y     = 100;
			towerPanel.alpha = 0;
			TweenLite.to(towerPanel, 0.5, {y : 240 , alpha : 1 , ease:Back.easeOut } );
			towerPanel.show(type, level);
			towerPanel.showUpgradeButton();
			towerPanel.showSellButton();
		}
		
		public function showTowerInformation(type:String, level:int):void 
		{
			towerPanel.show(type, level);
			towerPanel.hideUpgradeButton();
			towerPanel.hideSellButton();
		}
		
		public function hideTowerPanel():void 
		{
			towerPanel.hide();
		}
		
		private function onLifeLost(e:Event):void 
		{
			lifePanel.life = uint(e.data); 
		}
		
		private function addShop(posx : int, posy:int):void 
		{
			shop = new Shop();
			addChild(shop);
			shop.x = posx;
			shop.y = posy;
		}
		
		private function addLifePanel(posx : int, posy:int):void 
		{
			lifePanel = new LifePanel();
			lifePanel.x = posx;
			lifePanel.y = posy;
			addChild(lifePanel);
			lifePanel.life = level.life;
		}
		
		private function addTowerPanel(posx : int, posy:int):void 
		{
			towerPanel = new TowerPanel(level);
			addChild(towerPanel);
			// towerPanel.x = 600;
			towerPanel.x = posx;
			towerPanel.y = posy;
		}
		
		private function addMoneyField(posx : int, posy:int):void 
		{
			var border : Image = Assets.getImage("BorderSmall");
			border.x = posx;
			border.y = posy;
			addChild(border);
			
			money = new TextField(150,26, "Money: " + level.money, Game.FONT, 26);
			money.hAlign = HAlign.CENTER;
			money.vAlign = VAlign.CENTER;
			money.x = posx;
			money.y = posy;
			
			//money.border = true;
			addChild(money);
			level.addEventListener(Level.MONEY_CHANGED, syncMoney);
		}
		
		private function addBlockButton(posx:int, posy:int):void 
		{
			/*
			block = new Button(Assets.getTexture("BaseButton"), "B");
			block.x = posx;
			block.y = posy;
			addChild(block);
			block.addEventListener(Event.TRIGGERED, onBlockClick);
			*/
		}
		
		private function onBlockClick(e:Event):void 
		{
			// var event : Event = new Event(BLOCK_CLICK);
			// dispatchEvent(event);
		}
		
		private function syncMoney(e:Event):void 
		{
			money.text = "Money: " + level.money;
		}		
	}

}