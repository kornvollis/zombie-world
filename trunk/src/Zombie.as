package  
{
	import adobe.utils.CustomActions;
	import flash.geom.Point;
	/**
	 * ...
	 * @author OML!
	 */
	public class Zombie extends GameObject 
	{
		private var speed : int = 100;
		private var life  : int = 3;
				
		private var cellX : int = 0;
		private var cellY : int = 0;
		
		public var currentCell : Cell = null;
		public var targetCell : Cell = null;
		
		public function Zombie(cell : Cell) 
		{
			this.cellX = cell.col;
			this.cellY = cell.row;
			
			this.posX = cellX * Constants.GRID_SIZE;			
			this.posY = cellY * Constants.GRID_SIZE;
			
			this.currentCell = cell;
			this.targetCell = cell.nextCell;
			
			this.graphics.beginFill(0x009900);
			this.graphics.drawCircle(Constants.GRID_SIZE/2, Constants.GRID_SIZE/2, Constants.GRID_SIZE/2);
		}
		
		override public function update() : void
		{
			if (currentCell != null && targetCell != null)
			{						
				var move_vector : Point = new Point();
				move_vector.x = targetCell.middle_x - this.posX;
				move_vector.y = targetCell.middle_y - this.posY;
				
				move_vector.normalize( 1 * (speed / 20) );
				
				if (Point.distance(new Point(posX,posY), new Point(targetCell.middle_x,targetCell.middle_y)) < 3)
				{					
					posX = targetCell.middle_x;
					posY = targetCell.middle_y;
					
					currentCell = targetCell;
					targetCell = targetCell.nextCell;
				} else {
					posX += move_vector.x;
					posY += move_vector.y;
				}
				
			}
		}
		
		public function MoveTo(cell : Cell):void 
		{
			
		}
	}
}