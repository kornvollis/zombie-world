package massdefense.ui 
{
	import massdefense.assets.Assets;
	import massdefense.misc.SimpleGraphics;
	import starling.display.Image;
	import starling.display.Sprite;

	public class TowerPlaceIndicator extends Sprite 
	{
		private var goodSpot : Image;
		private var badSpot  : Image;
		
		public function TowerPlaceIndicator() 
		{
			goodSpot = SimpleGraphics.drawRectangle(32, 32, 0x00ff00, 1);
			badSpot  = SimpleGraphics.drawRectangle(32, 32, 0xff0000, 1);
			
			addChild(goodSpot);
			addChild(badSpot);
			
			this.visible = false;
			this.touchable = false;
		}
		
		public function showGoodSpot() : void {
			goodSpot.visible = true;
			badSpot.visible = false;
		}
		
		public function showBadSpot() : void {
			goodSpot.visible = false;
			badSpot.visible = true;
		}
	}

}