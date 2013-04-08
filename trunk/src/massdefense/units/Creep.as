package massdefense.units 
{
	import flash.geom.Point;
	import massdefense.assets.Assets;
	import massdefense.Factory;
	import massdefense.misc.Position;
	import massdefense.pathfinder.Node;
	import massdefense.pathfinder.Path;
	import massdefense.tests.creeptest.CreepTestFakeMain;
	import starling.display.Image;
	import starling.display.Sprite;
	/**
	 * ...
	 * @author OMLI
	 */
	public class Creep extends Sprite
	{
		public static const DEAD      : String = "dead";
		public static const ALIVE      : String = "live";
		
		private var _position          : Position = new Position();
		private var _path             : Path = null;
		
		public var pathPosition       : uint = 0;
		public var state			  : String = ALIVE;
		public var speed              : int = 90;
		public var maxLife            : int = 1;
		private var _life               : int = 1;
		public var distanceFromTarget : Number;
		
		private var _row 			  : int;
		private var _col               : int;
		
		public function Creep() 
		{
			//addGraphics();
		}
		
		public function setPositionXY(x:Number , y:Number) : void 
		{			
			position.x = x;
			position.y = y;
			
			this.x = position.x;
			this.y = position.y;
		}
		
		public function addGraphics():void 
		{
			var image : Image = Assets.getImage("SimpleEnemyBitmap");
			
			image.x -= image.width * 0.5;
			image.y -= image.height * 0.5;
			
			addChild(image);
		}
		
		public function isAtEndPosition() : Boolean {
			var endPosition : Boolean = false;
			
			if (this.path != null) {
				endPosition = path.isEndPosition(pathPosition);
			}
			
			return endPosition;
		}
		
		public function update(passedTime : Number) : void 
		{
			if (life > 0) {
				if (path != null && !path.isEndPosition(pathPosition)) {
					followPath(passedTime);
				}
			}
		}
		
		public function setPositionRowCol(row:Number, col:Number):void 
		{
			// TODO REFACTOR
			setPositionXY(col * Node.NODE_SIZE + Node.NODE_SIZE * 0.5, row * Node.NODE_SIZE + Node.NODE_SIZE * 0.5);
		}
		
		private function isReachedPosition(targetPosition:Position):Boolean 
		{
			return Position.isDistanceBetweenLessThan(targetPosition, position, 5);
		}
		
		private function followPath(passedTime : Number):void 
		{
			if (path == null) return;
			
			var targetPosition : Position = path.getPositionAt(pathPosition);
			
			if (isReachedPosition(targetPosition)) 
			{
				pathPosition++;
			} else {
				position = Position.moveToPoint(this.position, targetPosition, this.speed, passedTime);
			}
		}
		
		public function get path():Path 
		{
			return _path;
		}
		
		public function set path(value:Path):void 
		{
			_path = value;
		}
		
		public function get row():int 
		{
			return int(position.y / Node.NODE_SIZE);
		}
		
		public function set row(value:int):void 
		{
			_row = value;
		}
		
		public function get col():int 
		{
			return int(position.x / Node.NODE_SIZE);
		}
		
		public function set col(value:int):void 
		{
			_col = value;
		}
		
		public function get position():Position 
		{
			return _position;
		}
		
		public function set position(pos:Position):void 
		{
			_position = pos;
			this.x = pos.x;
			this.y = pos.y;
		}
		
		public function get life():int 
		{
			return _life;
		}
		
		public function set life(value:int):void 
		{
			_life = value;
		}
	}

}