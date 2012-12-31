package units.towers
{
	import assets.Assets;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import org.as3commons.collections.ArrayList;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.textures.Texture;
	import units.Enemy;
	import utils.Util;
	/**
	 * ...
	 * @author OML!
	 */
	public class Tower extends GameObject 
	{
		public static const IDLE   : String = "idle";
		public static const FIRING : String = "firing";
		
		//Properties
		public var damage : int = 1;
		public var range  : int = 250;
		public var cost : int = 50;
		private var reloadTime : Number = 2; //IN SEC
		private var target : Enemy = null;
		public var angle : Number = 0;
		
		//public var rifleGraphics : MovieClip = new MovieClip;
		public var isReloaded : Boolean = true;
		public var row : int;
		public var col : int;
		private var _showRange : Boolean = true;
		
		
		//RELOAD TIME
		private var lastFireTime : Number = -1;
		public  var removeCallBack:Function;
		public  var targetList : ArrayList = new ArrayList();
		
		private var baseImage:Image;
		private var towerImage:Image;
		
		public function Tower(row:int, col:int, towerData : TowerData = null) 
		{
			//state = IDLE;
			//RELOAD TIMER
			
			this.row = row;
			this.col = col;
			
			addGraphics();
			
			//CLICK LISTENER
			//this.addEventListener(MouseEvent.CLICK, onClick);
			//this.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		
		private function addGraphics():void 
		{
			//baseImage = Util.bitmapToImage(BaseSprite);
			baseImage = new Image(Assets.getTexture("BaseSprite"));
			towerImage = new Image(Assets.getTexture("TowerSprite01"));
			
			towerImage.pivotX = 16;
			towerImage.pivotY = 16;
			towerImage.x = 16;
			towerImage.y = 16;
			
			addChild(baseImage);
			addChild(towerImage);
		}
		/*
		private function reload(e:TimerEvent):void 
		{
			if (!isReloaded) isReloaded = true;
		}
		*/
		override public function update(e:EnterFrameEvent) : void
		{
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
			
		}
		
		private function fire():void 
		{
			if (target != null) {
				Factory.getInstance().createProjectil(this.x + Constants.CELL_SIZE * 0.5, this.y + Constants.CELL_SIZE * 0.5, target);
				isReloaded = false;
				lastFireTime = reloadTime;
			}
		}
		/*
		public function get showRange():Boolean 
		{
			return _showRange;
		}
		
		public function set showRange(visible:Boolean):void 
		{
			if (visible)
			{
				rangeGraphics.visible = visible;
			} else {
				rangeGraphics.visible = !visible;
			}
			
			_showRange = visible;
		}
		
		public function get target():GameObject 
		{
			return _target;
		}
		
		public function set target(value:GameObject):void 
		{
			_target = value;
		}*/
	}

}