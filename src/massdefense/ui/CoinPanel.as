package massdefense.ui 
{
	import feathers.controls.Label;
	import flash.text.TextFormat;
	import massdefense.assets.Assets;
	import starling.display.Sprite;

	public class CoinPanel extends Sprite 
	{
		private var coins : Label = new Label();
		
		public function CoinPanel() 
		{
			addChild(Assets.getImage("Coin"));
			addChild(coins);
			
			coins.text = "9999";
			coins.textRendererProperties.textFormat = new TextFormat("Pixel", 16, 0x000000, false);
			coins.x = 40;
			coins.y = 5;
		}
		
		public function setCoins(value :String):void {
			coins.text = value;
		}
	}

}