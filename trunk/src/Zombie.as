package  
{
	import adobe.utils.CustomActions;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	/**
	 * ...
	 * @author OML!
	 */
	public class Zombie extends GameObject
	{
		//ZOMBIE STATES
		public static const Z_IDLE   : String = "Idle bazdmeg";
		public static const Z_MOVING : String = "Mozog bazdmeg";
		
		public static const CONSTRUCTOR_NULL_ERROR : String = "Zombie's construcotr must be not NULL";
		
		
		//PRIVI
		private var speed : int = 50;
		private var life  : int = 3;
		private var row : int = -1;
		private var col : int = -1;
		
		
		//PUBI
		public var state : String = Z_IDLE;		
		public var target : Point = new Point;
		
		/*
		public var currentCell : Cell = null;
		public var targetCell : Cell = null;
		*/
		public function Zombie(row: int, col :int) 
		{
			this.position.x = col * Constants.CELL_SIZE;			
			this.position.y = row * Constants.CELL_SIZE;
			
			this.graphics.beginFill(0x009900);
			this.graphics.drawCircle(0, 0, Constants.CELL_SIZE/2);
		}
		
		override public function update() : void
		{
			//if (hasToGoSomeWhere)
			{
				
			}
		}
		
		public function moveTo(cell : Cell):void 
		{
			/*var move_vector : Point = new Point();
			move_vector.x = targetCell.middle_x - this.position.x;
			move_vector.y = targetCell.middle_y - this.position.y;
			
			move_vector.normalize( 1 * (speed / 20) );
			
			if (distance(targetCell) < 3)
			{
				position.x = targetCell.middle_x;
				position.y = targetCell.middle_y;
				hasToGoSomeWhere = false;
			} else {
				posX += move_vector.x;
				posY += move_vector.y;
			}*/
		}
		
		/*
		public function distance(cell : Cell) : Number
		{
			if(cell != null) {
				return Point.distance(new Point(posX, posY), new Point(targetCell.middle_x, targetCell.middle_y));
			}			
			throw new Error("Zombie distance cell null error");
			
		}
		*/
	}
}