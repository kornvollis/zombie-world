package massdefense.ui.tower 
{
	import massdefense.assets.Assets;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class TowerShopButton extends Sprite 
	{
		
		
		public function TowerShopButton() 
		{
			addChild(Assets.getImage("TowerBuyBorder"));
			this.useHandCursor = true;
			
			addEventListener(Event.TRIGGERED, onClick);
		}
		
		private function onClick(e:Event):void 
		{
			
		}
		
		
	}

}