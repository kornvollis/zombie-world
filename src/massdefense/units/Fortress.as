package massdefense.units 
{
	import massdefense.assets.Assets;
	import massdefense.misc.SimpleGraphics;
	import starling.display.Image;
	import starling.display.Sprite;

	public class Fortress extends GameObject
	{
		private var widthNodeLength  : int;
		private var heightNodeLength : int;
		
		public function Fortress(width:int,height:int) 
		{
			this.widthNodeLength  = width;
			this.heightNodeLength = height;
		}
		
		override public function addGraphics() : void {
			var image : Image = Assets.getImage("Fortress");
			addChild(image);
		}
		
	}

}