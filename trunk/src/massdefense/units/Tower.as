package massdefense.units 
{
	import adobe.utils.ProductManager;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import flexunit.utils.ArrayList;
	import massdefense.assets.Assets;
	import massdefense.Factory;
	import massdefense.misc.Position;
	import massdefense.misc.SimpleGraphics;
	import massdefense.pathfinder.Node;
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class Tower extends Sprite 
	{
		
		public static const IDLE   : String = "idle";
		public static const FIRING : String = "firing";
		
		//Properties
		public var position : Position = new Position();
		public var cost : int = 50;
		
		private var _targetList : Vector.<Creep>;
		private var target : Creep = null;
		public var type : String = "";
		public var angle : Number = 0;
		
		
		public var row : int;
		public var col : int;
		private var _showRange : Boolean = true;
		
		
		// RELOAD && FIRE
		public var damage       : uint = 1;
		public var range        : uint = 250;
		public var reloaded     : Boolean = true;
		public var reloadTime   : Number = 2; 					// IN SECOND
		public var timeToReload : Number = 2;
		
		private var baseImage:Image;
		private var towerImage:Image;
		
		public function Tower() 
		{
			
		}
		
		public function init(attributes:Array):void 
		{
			for (var item : Object in attributes) 
			{
				this[item] = attributes[item];
			}
		}
		
		public function addGraphics():void 
		{
			drawRange();
			//baseImage = Util.bitmapToImage(BaseSprite);
			baseImage = new Image(Assets.getTexture("BaseSprite"));
			towerImage = new Image(Assets.getTexture("TowerSprite01"));
			
			towerImage.pivotX = 16;
			towerImage.pivotY = 16;
			baseImage.pivotX = 16;
			baseImage.pivotY = 16;

			addChild(baseImage);
			addChild(towerImage);
		}
		
		private function drawRange():void 
		{
			addChild(SimpleGraphics.drawCircle(-range, -range, this.range, 2));
			
		}
		
		public function setPositionRowCol(row:Number, col:Number):void 
		{
			// TODO REFACTOR
			setPositionXY(col * Node.NODE_SIZE + Node.NODE_SIZE * 0.5, row * Node.NODE_SIZE + Node.NODE_SIZE * 0.5);
		}
		
		public function setPositionXY(x:Number , y:Number) : void 
		{			
			position.x = x;
			position.y = y;
			
			this.x = position.x;
			this.y = position.y;
		}
		
		public function update(timeElapssed : Number) : void
		{
			checkIfTargetIsAlive();
			reloadProgress(timeElapssed);
			
			if(target == null || outOfRange(target) || target.health <= 0 ) {
				target = findTheFirstTargetInRange();
			}
			
			if (target != null) {
				rotateToTarget();
				if(reloaded) fire();
			}
		}
		
		private function checkIfTargetIsAlive():void 
		{
			if (target != null) {
				if (target.health <= 0) {
					target = null;
				}
			}
		}
		
		public function outOfRange(target:Creep):Boolean 
		{
			if (target == null) return true;
			
			if (Position.distance(target.position, this.position) > this.range) {
				return true;
			}
			
			return false;
		}
		
		public function reloadProgress(timeElapssed:Number):void 
		{
			if (!reloaded) {
				timeToReload -= timeElapssed;
				
				if (timeToReload <= 0) {
					reloaded = true;
					timeToReload = reloadTime;
				}
			}
		}
		
		private function rotateToTarget():void 
		{
			var vect : Point = new Point;
			vect.x = target.x - this.x;
			vect.y = target.y - this.y;
			
			angle = Math.atan2(vect.y, vect.x);
			
			towerImage.rotation = angle;
		}
		
		private function findTheFirstTargetInRange():Creep
		{
			var nearestTarget : Creep = null;
			
			for each (var creep:Creep in targetList ) 
			{				
				if (Position.distance(creep.position, this.position) <= this.range && creep.health > 0 && !creep.isEscaped()) {
					return creep;
				}
			}
			
			return null;
		}
		
		private function fire():void 
		{
			// target.life -= this.damage;
			var projAttr : Dictionary = new Dictionary();
			projAttr["posx"] = this.x;
			projAttr["posy"] = this.y;
			projAttr["target"] = target;
			projAttr["damage"] = this.damage;
			
			Factory.addProjectil(projAttr);
			//target.life -= 1;
			
			reloaded = false;
			timeToReload = reloadTime;
		}
		
		public function get targetList():Vector.<Creep> 
		{
			return _targetList;
		}
		
		public function set targetList(value:Vector.<Creep>):void 
		{
			_targetList = value;
		}
	}
}