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
		private var lastFireTime : Number = -1;
		
		private var baseImage:Image;
		private var towerImage:Image;
		
		public function Tower() 
		{
			addGraphics()
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
			if(targetList!= null) {
			trace(targetList.length);
				if (targetList.length > 0) {
					setTarget();
					rotateToTarget();
				}
			}
			
			/*
			if (!isReloaded) {
				lastFireTime -= e.passedTime;
				if (lastFireTime < 0)
				{
					isReloaded = true;
				}
			}
			
			if (target != null)
			{				
				if(target.state == Enemy.DEAD) {
					target = Factory.getInstance().findTargetForTower(this);
					return;
				}
				
				//IF enemy goes out of range then we looking for another enemy
				if (Point.distance(target.getPosition(), getPosition() ) > range)
				{
					target = null;
					return;
				}
				
				//if (Enemy(target).isDeleted)
				//{
					//target = null;
					//return;
				//}
				
				var vect : Point = new Point;
				vect.x = target.x - this.x;
				vect.y = target.y - this.y;
				
				angle = Math.atan2(vect.y, vect.x);
				
				towerImage.rotation = angle;
				
				if (isReloaded) fire();
			} else {
				target = Factory.getInstance().findTargetForTower(this);
			}
			*/
		}
		
		private function rotateToTarget():void 
		{
			var vect : Point = new Point;
			vect.x = target.x - this.x;
			vect.y = target.y - this.y;
			
			angle = Math.atan2(vect.y, vect.x);
			
			towerImage.rotation = angle;
		}
		
		private function setTarget():void 
		{
			target = targetList[0];
		}
		
		private function fire():void 
		{
			/*
			if (target != null) {
				Factory.getInstance().createProjectil(this.x + Constants.CELL_SIZE * 0.5, this.y + Constants.CELL_SIZE * 0.5, target);
				isReloaded = false;
				lastFireTime = reloadTime;
			}
			*/
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