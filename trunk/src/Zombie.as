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
		public static const CONSTRUCTOR_NULL_ERROR : String = "Zombie's construcotr must be not NULL";
		
		private var speed : int = 50;
		private var life  : int = 3;
				
		private var _cellX : int = 0;
		private var _cellY : int = 0;
		
		public var currentCell : Cell = null;
		public var targetCell : Cell = null;
		
		public function Zombie(cell : Cell) 
		{
			if (cell == null) throw( new Error(CONSTRUCTOR_NULL_ERROR));			
			
			this._cellX = cell.col;
			this._cellY = cell.row;
			
			this.posX = cellX * Constants.GRID_SIZE + Constants.GRID_SIZE/2;			
			this.posY = cellY * Constants.GRID_SIZE + Constants.GRID_SIZE/2;
			
			this.currentCell = cell;
			this.targetCell = cell.nextCell;
			
			this.graphics.beginFill(0x009900);
			this.graphics.drawCircle(0, 0, Constants.GRID_SIZE/2);
		}
		
		override public function update() : void
		{
			if (targetCell != null)
			{						
				moveTo(targetCell);	
				//trace("updateing zombie");
				
				if (currentCell.hasSurvivor())
				{
					trace("Zombie: target cell has a survivor Yuppy");
					var s : Survivor = currentCell.giveMeASurvivor();
					Factory.getInstance().removeSurvivor(s);
				}
			}
		}
		
		public function moveTo(cell : Cell):void 
		{
			var move_vector : Point = new Point();
			move_vector.x = targetCell.middle_x - this.posX;
			move_vector.y = targetCell.middle_y - this.posY;
			
			move_vector.normalize( 1 * (speed / 20) );
			
			if (distance(targetCell) < 3)
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
		
		public function get cellX():int 
		{
			return _cellX;
		}
		
		public function get cellY():int 
		{
			return _cellY;
		}
		
		public function distance(cell : Cell) : Number
		{
			if(cell != null) {
				return Point.distance(new Point(posX, posY), new Point(targetCell.middle_x, targetCell.middle_y));
			}			
			throw new Error("Zombie distance cell null error");
		}
	}
}