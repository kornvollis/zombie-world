package massdefense.ui.tower 
{
	import com.basicgui.BButton;
	import massdefense.assets.Assets;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class ShopButton extends BButton 
	{

		public static const CLICK : String = "tower_buy_click";
		private var borderimage:Image;
		public var type : String;
		
		public function ShopButton() 
		{
			super();
			borderimage = Assets.getImage("TowerBuyBorder");
			addGraphcis(borderimage);
			this.useHandCursor = true;
			addEventListener(TouchEvent.TOUCH, onClick);
		}
		
		public function addButtonGraphics(towerImage:Image):void 
		{
			towerImage.pivotX = towerImage.width * 0.5;
			towerImage.pivotY = towerImage.height * 0.5;
			
			towerImage.x = borderimage.width * 0.5;
			towerImage.y = borderimage.height * 0.5;
			
			towerImage.scaleX = 0.8;
			towerImage.scaleX = 0.8;
			
			addGraphcis(towerImage);
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