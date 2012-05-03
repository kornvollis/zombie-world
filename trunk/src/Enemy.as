package  
{
	import adobe.utils.CustomActions;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	/**
	 * ...
	 * @author OML!
	 */
	public class Enemy extends GameObject
	{
		//ZOMBIE STATES
		public static const Z_IDLE   : String = "Idle bazdmeg";
		public static const Z_MOVING : String = "Mozog bazdmeg";
		
		public static const CONSTRUCTOR_NULL_ERROR : String = "Enemy's construcotr must be not NULL";
		
		
		
		//PRIVI
		private var speed : int = 50;
		private var _target : Point = new Point;
		//HEALTH BAR
		private var healthBar : HealthBar = new HealthBar;
		
		//PUBI
		public var maxLife : int = 3;
		public var life  : int = 3;
		public var state : String = Z_IDLE;		
		public var row : int = -1;
		public var col : int = -1;
		
		/*
		public var currentCell : Cell = null;
		public var targetCell : Cell = null;
		*/
		public function Enemy(row: int, col :int) 
		{
			this.row = row;
			this.col = col;
			
			this.position.x = col * Constants.CELL_SIZE + Constants.CELL_SIZE/2;			
			this.position.y = row * Constants.CELL_SIZE + Constants.CELL_SIZE/2;
			
			//TEMP Graphics
			this.graphics.beginFill(0x009900);
			this.graphics.drawCircle(0, 0, Constants.CELL_SIZE / 2);
			
			//Health bar graphics
			healthBar.x = - Constants.CELL_SIZE * 0.5;
			healthBar.y = - 6 - Constants.CELL_SIZE * 0.5;
			addChild(healthBar);
		}
		
		override public function update() : void
		{
			if (state == Z_MOVING)
			{
				moveToTarget();
			}
		}
		
		private function moveToTarget():void 
		{
			var move_vector : Point = new Point();
			move_vector.x = target.x - position.x;
			move_vector.y = target.y - position.y;
			
			move_vector.normalize( 1 * (speed / 20) );
			
			if (Point.distance(position, target) < 3)
			{
				position.x = target.x;
				position.y = target.y;
				state = Z_IDLE;
			} else {
				position.x += move_vector.x;
				position.y += move_vector.y;
			}
			
			//SET ROW 
			row = int(position.y / Constants.CELL_SIZE);
			col = int(position.x / Constants.CELL_SIZE);			
		}
		
		public function get target():Point 
		{
			return _target;
		}
		
		public function sufferDamage(damage:int):void 
		{
			life -=damage;
			
			if (life < 1)
			{
				dispatchEvent(new GameEvents(GameEvents.ZOMBIE_REACHED_EXIT));
				Factory.getInstance().removeZombie(this); 
			} else {
				healthBar.setSize(life, maxLife);
			}
		}
		
		public function set target(value:Point):void 
		{
			if (state == Z_IDLE)
			{
				state = Z_MOVING;
			}
			_target = value;
		}
	}
}