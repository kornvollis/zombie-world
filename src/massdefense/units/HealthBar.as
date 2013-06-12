package massdefense.units 
{
	import massdefense.misc.SimpleGraphics;
	import starling.display.Image;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author OMLI
	 */
	public class HealthBar extends Sprite 
	{
		static public const WIDTH : uint = 20;
		static private const BORDER_COLOR:Number = 0x990000;
		static private const BAR_COLOR:Number = 0x009900;
		private var border : Image;
		private var bar    : Image;
		
		public function HealthBar() 
		{
			
		}
		
		public function addGraphics() : void {
			//bar = SimpleGraphics.drawRectangle(20, 5, BAR_COLOR);
			bar = SimpleGraphics.drawRectangle(20, 5, BAR_COLOR);
			//border = SimpleGraphics.drawGrid(1, 4, 5, 1, BORDER_COLOR);
			border = SimpleGraphics.drawRectangle(20, 5, BORDER_COLOR);
			
			//bar.y = 1;
			
			
			addChild(border);
			addChild(bar);
		}
		
		public function setHpPercent(percent : Number) : void {
			if (bar != null) {
				bar.width = WIDTH * percent;
			}
		}
	}

}