package  
{
	/**
	 * ...
	 * @author OML!
	 */
	public class Cannon extends Turret 
	{
		
		public function Cannon(row: int,col:int) 
		{
			super(row, col);
			
			this.range = 300;
			this.damage = 3;
			
			bulletPerSec = 2;
			
			this.graphics.beginFill(0x003311);
			this.graphics.drawRect(0, 0, Constants.CELL_SIZE, Constants.CELL_SIZE);
		}
		
	}

}