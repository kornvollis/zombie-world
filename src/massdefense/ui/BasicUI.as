package massdefense.ui 
{
	import massdefense.assets.Assets;
	import massdefense.level.Level;
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.text.TextField;
	import starling.utils.HAlign;

	public class BasicUI extends Sprite
	{
		public static const SIMPLE_TOWER_CLICK : String = "SIMPLE_TOWER_CLICK";
		public static const BLOCK_CLICK : String = "BLOCK_CLICK";
		
		private var simpleTower : Button;
		private var block : Button;
		private var money : TextField;
		private var level:Level;
		
		
		public function BasicUI(level:Level)
		{
			this.level = level;
			addMoneyField();
			addTowerButtons();
			addBlockButton();
		}
		
		private function addMoneyField():void 
		{
			money = new TextField(100, 30, "Money: " + level.money);
			money.hAlign = HAlign.LEFT;
			money.y = 50;
			money.x = 0;
			addChild(money);
			level.addEventListener(Level.MONEY_CHANGED, syncMoney);
		}
		
		private function addTowerButtons():void 
		{
			simpleTower = new Button(Assets.getTexture("BaseButton"), "T");
			addChild(simpleTower);
			simpleTower.addEventListener(Event.TRIGGERED, onSimpleTowerClick);
		}
		
		private function onSimpleTowerClick(e:Event):void 
		{
			var event : Event = new Event(SIMPLE_TOWER_CLICK);
			dispatchEvent(event);
		}
		
		private function addBlockButton():void 
		{
			block = new Button(Assets.getTexture("BaseButton"), "B");
			block.x = 40;
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
		
		
		
	}

}