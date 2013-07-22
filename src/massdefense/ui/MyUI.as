package massdefense.ui 
{
	import massdefense.assets.Assets;
	import starling.display.Sprite;
	
	public class MyUI extends Sprite 
	{
		private var shop : MyShop = new MyShop();
		
		public function MyUI() 
		{
			addChild(shop);
		}
		
		public function closeShop() : void {
			shop.close();
		}
	}

}