package  
{
	import units.Enemy;
	/**
	 * ...
	 * @author OML!
	 */
	public class BasicEnemy extends Enemy 
	{
		
		public function BasicEnemy(row: int, col :int) 
		{
			super(row, col);
			
			life = 1;
			maxLife = 1;
			
			//TEMP Graphics
			this.graphics.clear();
			this.graphics.beginFill(0x019310);
			this.graphics.drawCircle(0, 0, Constants.CELL_SIZE / 2 - 4);
			
		}
		
	}

}