package massdefense.ui 
{
	import flash.geom.Point;
	import massdefense.assets.Assets;
	import massdefense.Game;
	import massdefense.level.Level;
	import massdefense.ui.tower.TowerPanel;
	import massdefense.ui.tower.TowerShop;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;
	import starling.utils.VAlign;

	public class BasicUI extends Sprite
	{
		public static const SIMPLE_TOWER_CLICK : String = "SIMPLE_TOWER_CLICK";
		public static const BLOCK_CLICK : String = "BLOCK_CLICK";
		
		private var simpleTower : Button;
		private var block : Button;
		private var money : TextField;
		private var level:Level;
		private var _towerPanel : TowerPanel;
		private var towerShop : TowerShop;
		private var hearts:Image;
		
		public function BasicUI(level:Level)
		{
			this.level = level;
			addMoneyField(0, 0);
			addLifeField(0, 30);
			addTowerButtons(170, 0);
			addBlockButton(220, 0);
			addTowerShop(0, 60);
			addTowerPanel(0, 240);
			
			level.addEventListener(Level.LIFE_LOST, onLifeLost);
		}
		
		private function onLifeLost(e:Event):void 
		{
			hearts.setTexCoords(1, new Point(0, 0.5));
			hearts.setTexCoords(2,new Point(1,0.5));
		}
		
		private function addTowerShop(posx : int, posy:int):void 
		{
			towerShop = new TowerShop();
			addChild(towerShop);
			towerShop.x = posx;
			towerShop.y = posy;
		}
		
		private function addLifeField(posx : int, posy:int):void 
		{
			var border : Image = Assets.getImage("BorderSmall");
			border.x = posx;
			border.y = posy;
			addChild(border);
			
			hearts = Assets.getImage("Hearts");
			hearts.x = posx+3;
			hearts.y = posy+5;
			addChild(hearts);
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
		
		private function addTowerButtons(posx:int , posy:int):void 
		{
			simpleTower = new Button(Assets.getTexture("BaseButton"), "T");
			addChild(simpleTower);
			simpleTower.addEventListener(Event.TRIGGERED, onSimpleTowerClick);
			simpleTower.x = posx;
			simpleTower.y = posy;
		}
		
		private function onSimpleTowerClick(e:Event):void 
		{
			var event : Event = new Event(SIMPLE_TOWER_CLICK);
			dispatchEvent(event);
		}
		
		private function addBlockButton(posx:int, posy:int):void 
		{
			block = new Button(Assets.getTexture("BaseButton"), "B");
			block.x = posx;
			block.y = posy;
			addChild(block);
			block.addEventListener(Event.TRIGGERED, onBlockClick);
			
		}
		
		private function onBlockClick(e:Event):void 
		{
			var event : Event = new Event(BLOCK_CLICK);
			dispatchEvent(event);
		}
		
		private function syncMoney(e:Event):void 
		{
			money.text = "Money: " + level.money;
		}
		
		public function get towerPanel():TowerPanel
		{
			return _towerPanel;
		}
		
		public function set towerPanel(value:TowerPanel):void 
		{
			_towerPanel = value;
		}
		
		
		
	}

}