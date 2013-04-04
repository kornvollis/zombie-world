package massdefense.units 
{
	import flash.geom.Point;
	import flexunit.utils.ArrayList;
	import massdefense.assets.Assets;
	import massdefense.Factory;
	import massdefense.misc.Position;
	import massdefense.pathfinder.Node;
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class Tower extends Sprite 
	{
		
		public static const IDLE   : String = "idle";
		public static const FIRING : String = "firing";
		
		//Properties
		private var position : Position = new Position;
		public var damage : int = 1;
		public var range  : int = 250;
		public var cost : int = 50;
		private var reloadTime : Number = 2; //IN SEC
		private var _targetList : Vector.<Creep>;
		private var target : Creep = null;
		public var angle : Number = 0;
		
		//public var rifleGraphics : MovieClip = new MovieClip;
		public var isReloaded : Boolean = true;
		public var row : int;
		public var col : int;
		private var _showRange : Boolean = true;
		
		
		//RELOAD TIME
		private var reloadTimeInSec   : Number = 1;
		private var timeNeedForReload : Number = 1;
		
		private var baseImage:Image;
		private var towerImage:Image;
		
		public function Tower() 
		{
			//addGraphics()
		}
		
		private function addGraphics():void 
		{
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
		
		public function setPositionRowCol(row:int, col:int):void 
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
			reloadProgress(timeElapssed);
			
			if(targetList != null) {
				if (targetList.length > 0) {
					
					if(target == null || target.isDead) {
						findTarget();
					}
					
					if(target != null) {
						rotateToTarget();
						if (isReloaded) fire();
					}
				}
			}
		}
		
		public function reloadProgress(timeElapssed:Number):void 
		{
			if (!isReloaded) {
				timeNeedForReload -= timeElapssed;
				if (timeNeedForReload < 0) {
					timeNeedForReload = reloadTime;
					isReloaded = true;
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
		
		private function findTarget():void 
		{
			for each (var creep : Creep in targetList) 
			{
				if (Position.distance(creep.position, this.position) < this.range) {
					target = creep;
					return;
				}
			}
		}
		
		private function fire():void 
		{
			if (target != null) {
				target.health -= this.damage;
				isReloaded = false;
			}
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