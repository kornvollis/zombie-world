package units
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
		public static const ESCAPED   : String = "escaped";
		public static const DEAD   : String = "dead";
		public static const LIVE : String = "live";
		
		public static const CONSTRUCTOR_NULL_ERROR : String = "Enemy's construcotr must be not NULL";
		
		
		
		//PRIVI
		private var speed : int = 50;
		//private var _target : Point = new Point;
		public var target : Cell = null;
		
		//HEALTH BAR
		private var healthBar : HealthBar = new HealthBar;
		
		//PUBI
		public var maxLife : int = 3;
		public var life  : int = 3;
		public var state : String = LIVE;	
		public var row : int = -1;
		public var col : int = -1;
		
		public function Enemy(row: int, col :int) 
		{
			this.row = row;
			this.col = col;
			
			this.position.x = col * Constants.CELL_SIZE + Constants.CELL_SIZE/2;			
			this.position.y = row * Constants.CELL_SIZE + Constants.CELL_SIZE/2;
			this.x = position.x;
			this.y = position.y;
			
			//TEMP Graphics
			this.graphics.beginFill(0x009900);
			this.graphics.drawCircle(0, 0, Constants.CELL_SIZE / 2);
			
			//Health bar graphics
			healthBar.x = - Constants.CELL_SIZE * 0.5;
			healthBar.y = - 6 - Constants.CELL_SIZE * 0.5;
			addChild(healthBar);
		}
		
		public function setTarget(targetCell : Cell) : void {
			this.target = targetCell;
		}
		
		override public function update() : void
		{
			if (state != ESCAPED)
			{
				if (life <= 0) {
					state = DEAD;
				}
				
				if (state == LIVE) {
					moveToTarget();
				}
			}			
		}
		
		private function moveToTarget():void 
		{
			var move_vector : Point = new Point();
			move_vector.x = target.middle.x - position.x;
			move_vector.y = target.middle.y - position.y;
			
			move_vector.normalize( 1 * (speed / 20) );
			
			if (Point.distance(position, target.middle) < 3) {
				position.x = target.middle.x;
				position.y = target.middle.y;
				
				if (target.isExit())
				{
					state = ESCAPED
				}
				target = target.next_cell;
			} else {
				position.x += move_vector.x;
				position.y += move_vector.y;
				this.x = position.x;
				this.y = position.y;
			}
			
			//SET ROW 
			row = int(position.y / Constants.CELL_SIZE);
			col = int(position.x / Constants.CELL_SIZE);			
		}
		
		public function sufferDamage(damage:int):void 
		{
			life -=damage;
			
			if (life < 1)
			{
				dispatchEvent(new GameEvents(GameEvents.ZOMBIE_REACHED_EXIT));
				Factory.getInstance().removeEnemy(this); 
			} else {
				healthBar.setSize(life, maxLife);
			}
		}
	}
}