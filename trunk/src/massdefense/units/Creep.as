package massdefense.units 
{
	import flash.filters.GlowFilter;
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
		public var state			  : String = ALIVE;
		public var speed              : int = 90;
		public var rewardMoney        : int = 5;
		public var maxHealth          : Number = 4;
		private var _health           : Number = 4;
		public var distanceFromTarget : Number;
		
		private var _row 			  : int;
		private var _col              : int;
		private var healthBar		  : HealthBar = new HealthBar();
		private var image			  : String = "";
		private var creepGraphics     : Image;
		private var graphicsPointing  : String = "right";
		
		private var previousPosition  : Point = new Point;
		private var targetNode        : Node = null;
		
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
			creepGraphics = Assets.getImage(image);
			creepGraphics.pivotX = creepGraphics.width  * 0.5;
			creepGraphics.pivotY = creepGraphics.height * 0.5;
			
			addChild(creepGraphics);
			
			healthBar.x = -10;
			healthBar.y = -22;
			healthBar.addGraphics();
			addChild(healthBar);
			healthBar.visible = false;
			
			creepGraphics.useHandCursor = true;
		}
		
		public function update(passedTime : Number) : void 
		{
			setPreviousPosition(this.x, this.x); 
			if (isAlive()) {
				if(distanceFromExit() > 0) {
					goToTheExit(passedTime);
				}
				setGraphicsDirection(previousPosition);
			}
		}
		
		private function setGraphicsDirection(previousPosition:Point):void 
		{
			if (previousPosition.x > this.x && graphicsPointing == "right") {
				graphicsPointing = "left";
				creepGraphics.scaleX = -1;
			} else if (previousPosition.x < this.x && graphicsPointing == "left") {
				graphicsPointing = "right";
				creepGraphics.scaleX = 1;
			}
		}
		
		private function setPreviousPosition(x:Number, y:Number):void 
		{
			previousPosition.x = x;
			previousPosition.y = y;
		}
		
		private function isAlive():Boolean 
		{
			if (health > 0) return true;
			else return false;
		}
		
		private function goToTheExit(passedTime : Number):void 
		{
			if (pathfinder == null) return;
			
			if(targetNode == null || (targetNode.row == row && targetNode.col == col) ) {
				targetNode = pathfinder.nextNode(this.row, this.col);
			}
			goToTheNextNode(targetNode, passedTime);
		}
		
		private function goToTheNextNode(nextNode:Node, passedTime : Number):void 
		{
			if (nextNode != null) {
				var targetPosition : Position = targetNode.toPosition();
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
		
		public function get health():Number 
		{
			return _health;
		}
		
		public function set health(value:Number):void 
		{
			_health = value;
			healthBar.setHpPercent(health / maxHealth);
			if (_health < maxHealth) healthBar.visible = true;
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