package units
{
	import adobe.utils.CustomActions;
	import assets.Assets;
	import flash.display.Bitmap;
	import flash.events.EventDispatcher;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import pathfinder.Cell;
	import starling.display.Image;
	import starling.events.EnterFrameEvent;
	import utils.Util;
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
		
		//CALL BACKS
		public var removeCallBack : Function = null;
		
		//PRIVI
		private var speed : int = 50;
		//private var _target : Point = new Point;
		public var targetCell : Cell = null;
		public var currentCell : Cell = null;
		
		//HEALTH BAR
		private var healthBar : HealthBar = new HealthBar;
		
		//PUBI
		public var maxLife : int = 3;
		public var life  : int = 3;
		
		public var row : int = -1;
		public var col : int = -1;
		
		
		
		public function Enemy(row: int, col :int) 
		{
			state = LIVE;
			this.row = row;
			this.col = col;
			
			// GRAPHICS
			addGraphics();
			
			//Health bar graphics
			//healthBar.x = - Constants.CELL_SIZE * 0.5;
			//healthBar.y = - 6 - Constants.CELL_SIZE * 0.5;
			//addChild(healthBar);
		}
		
		private function addGraphics():void 
		{
			var image : Image = Assets.getImage("SimpleEnemyBitmap");
			addChild(image);
		}
		
		public function setTarget(targetCell : Cell) : void {
			this.targetCell = targetCell;
		}
		
		override public function update(e:EnterFrameEvent) : void
		{
			if (state != ESCAPED)
			{
				if (life <= 0) {
					state = DEAD;
				}
				
				if (state == LIVE) {
					moveToTarget(e.passedTime);
				}
			}			
		}
		
		private function moveToTarget(passedTime: Number):void 
		{
			if (targetCell != null)
			{
				
				var move_vector : Point = new Point();
				move_vector.x = targetCell.topLeft.x - getPosition().x;
				move_vector.y = targetCell.topLeft.y - getPosition().y;
				
				move_vector.normalize( 1 * speed * passedTime );
				
				if (Point.distance(getPosition(), targetCell.topLeft) < 3) {
					getPosition().x = targetCell.topLeft.x;
					getPosition().y = targetCell.topLeft.y;
					
					if (targetCell.isExit())
					{
						state = ESCAPED
					}
					
					if (targetCell.next_alter_cell != null) {
						var myRandom : Number = Math.random();
						
						if (myRandom < 0.5) {
							targetCell = targetCell.next_alter_cell;
						} else {
							targetCell = targetCell.next_cell;
						}		
					} else {
						targetCell = targetCell.next_cell;
					}
					
					
				} else {
					this.x += move_vector.x;
					this.y += move_vector.y;
				}
				
				//SET ROW 
				row = int(getPosition().y / Constants.CELL_SIZE);
				col = int(getPosition().x / Constants.CELL_SIZE);		
			}
		}
		
		public function sufferDamage(damage:int):void 
		{
			life -=damage;
			
			if (life <= 0)
			{
				this.state = DEAD
			} else {
				healthBar.setSize(life, maxLife);
			}
		}
	}
}