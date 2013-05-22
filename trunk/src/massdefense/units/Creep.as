package massdefense.units 
{
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import massdefense.assets.Assets;
	import massdefense.Factory;
	import massdefense.Game;
	import massdefense.misc.Position;
	import massdefense.pathfinder.Node;
	import massdefense.pathfinder.PathFinder;
	import massdefense.tests.creeptest.CreepTestFakeMain;
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class Creep extends Sprite
	{
		public static const DEAD         : String = "dead";
		public static const ALIVE        : String = "live";
		public static const ESCAPED      : String = "escaped";
		
		private var _position         : Position   = new Position();
		private var _pathfinder       : PathFinder = null;
		
		public var type 			  : String = "";
		public var pathPosition       : uint = 0;
		public var state			  : String = ALIVE;
		public var speed              : int = 90;
		public var rewardMoney        : int = 5;
		public var maxHealth          : int = 4;
		private var _health           : int = 4;
		public var distanceFromTarget : Number;
		
		private var _row 			  : int;
		private var _col              : int;
		private var healthBar		  : HealthBar = new HealthBar();
		
		
		public function Creep() {}
		
		public function init(attributes:Array):void 
		{
			for (var item : Object in attributes) 
			{
				this[item] = attributes[item];
			}
			
			setTypeSpecificAttributes();
		}
		
		private function setTypeSpecificAttributes():void 
		{
			var creepProps : XMLList = Game.units.creep.(@type == type).children();
			
			for each(var typeSpecPropety : XML in creepProps) 
			{
				var propName  : String = typeSpecPropety.localName();
				var propValue : Object= typeSpecPropety;
				this[propName] = propValue;
			}
		}
		
		public function setPositionXY(x:Number , y:Number) : void 
		{			
			position.x = x;
			position.y = y;
			
			this.x = position.x;
			this.y = position.y;
		}
		
		public function setPositionRowCol(row:Number, col:Number):void 
		{
			setPositionXY(col * Node.NODE_SIZE + Node.NODE_SIZE * 0.5, row * Node.NODE_SIZE + Node.NODE_SIZE * 0.5);
		}
		
		public function addGraphics():void 
		{
			var image : Image = Assets.getImage("SimpleEnemyBitmap");
			
			image.x -= image.width * 0.5;
			image.y -= image.height * 0.5;
			
			addChild(image);
			
			healthBar.x = -10;
			healthBar.y = -16;
			healthBar.addGraphics();
			addChild(healthBar);
		}
		
		public function update(passedTime : Number) : void 
		{
			if (isAlive()) {
				if(distanceFromExit() > 0) {
					goToTheExit(passedTime);
				}
			}
		}
		
		private function isAlive():Boolean 
		{
			if (health > 0) return true;
			else return false;
		}
		
		private function goToTheExit(passedTime : Number):void 
		{
			if (pathfinder == null) return;
			
			var nextNode : Node = pathfinder.nextNode(this.row, this.col);
			goToTheNextNode(nextNode, passedTime);
		}
		
		private function goToTheNextNode(nextNode:Node, passedTime : Number):void 
		{
			if (nextNode != null) {
				var targetPosition : Position = pathfinder.nextNode(this.row, this.col).toPosition();
				position = Position.moveToPoint(this.position, targetPosition, this.speed, passedTime);
			}
		}
		
		public function distanceFromExit():uint 
		{
			var distance : uint = Node.INFINIT;
			
			if (pathfinder != null) {
				var node : Node = pathfinder.grid.getNode(this.row, this.col);
				distance = node.distance;
			}
			
			return distance;
		}
		
		public function isEscaped():Boolean 
		{
			var escaped : Boolean = false;
			if (distanceFromExit() == 0) {
				escaped = true;
			}
			return escaped;
		}
		
		public function get row():int 
		{
			return int(position.y / Node.NODE_SIZE);
		}
		
		public function set row(row:int):void 
		{
			position.y = row * Node.NODE_SIZE + Node.NODE_SIZE * 0.5;
			_row = row;
		}
		
		public function get col():int 
		{
			return int(position.x / Node.NODE_SIZE);
		}
		
		public function set col(col:int):void 
		{
			position.x = col * Node.NODE_SIZE + Node.NODE_SIZE * 0.5;
			_col = col;
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
		
		public function get health():int 
		{
			return _health;
		}
		
		public function set health(value:int):void 
		{
			_health = value;
			healthBar.setHpPercent(health / maxHealth);
		}
		
		public function get pathfinder():PathFinder 
		{
			return _pathfinder;
		}
		
		public function set pathfinder(value:PathFinder):void 
		{
			_pathfinder = value;
		}
	}

}