package massdefense.ui.tower 
{
	import massdefense.assets.Assets;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class TowerShopButton extends Sprite 
	{
		public static const CLICK : String = "tower_buy_click";
		
		public var type : String;
		
		public function TowerShopButton() 
		{
			addChild(Assets.getImage("TowerBuyBorder"));
			this.useHandCursor = true;
			addEventListener(TouchEvent.TOUCH, onClick);
		}
		
		private function onClick(e:TouchEvent):void 
		{
			var touch : Touch = e.getTouch(this);
			
			if (touch != null) {
				
				if(touch.phase == TouchPhase.ENDED){
				var event : Event = new Event(CLICK, true, type);
				dispatchEvent(event);
				}
			}
		}
		
		
	}

}