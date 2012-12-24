package units
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author OML!
	 */
	public class HealthBar extends MovieClip 
	{
		private var barGraphics : Sprite = new Sprite;
		
		public function HealthBar() 
		{
			graphics.lineStyle(1, 0x000000);			
			graphics.drawRect(0, 0, Constants.CELL_SIZE, 4);
			
			barGraphics.graphics.lineStyle(1, 0xff0000);			
			barGraphics.graphics.beginFill(0xff0000);
			barGraphics.graphics.drawRect(1, 1, Constants.CELL_SIZE-2, 2);
			
			addChild(barGraphics);
		}
		
		public function setSize(currentHealth : int , maxHealth : int) : void
		{
			var ratio : Number = currentHealth / maxHealth;
			barGraphics.graphics.clear();
			barGraphics.graphics.lineStyle(1, 0xff0000);			
			barGraphics.graphics.beginFill(0xff0000);
			barGraphics.graphics.drawRect(1, 1, (Constants.CELL_SIZE-2)*ratio, 2);
		}
		
	}

}