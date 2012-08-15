package  
{
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author OML!
	 */
	public class PointDefense extends Turret 
	{
		
		public function PointDefense(row:int, col:int) 
		{
			super(row, col);
			
			this.range = 400;
			this.damage = 1;
			
			bulletPerSec = 1;
			
			this.graphics.beginFill(0x711911);
			this.graphics.drawRect(0, 0, Constants.CELL_SIZE, Constants.CELL_SIZE);
			
		}
		
	}

}