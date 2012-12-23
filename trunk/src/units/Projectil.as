package units
{
	import flash.geom.Point;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import utils.Util;
	/**
	 * ...
	 * @author OML!
	 */
	public class Projectil extends GameObject
	{
		private var _target : Enemy = null;
		
		public var speed : int = 300;
		public var damage : int = 1;
		private var targetISAlive : Boolean = false;
		
		private var targetPosition : Point = new Point;
		//private var targetLastPosition : Point = null;
		[Embed(source = "../../media/projectils/simple_bullet.png")]
		private var BulletBitmap : Class;
		
		public function Projectil(target : Enemy) 
		{
			this.target = target;
			
			addGraphics();
		}
		
		private function addGraphics():void 
		{
			var bulletImage : Image = Util.bitmapToImage(BulletBitmap);
			
			bulletImage.x = 1;
			bulletImage.y = 1;
			
			addChild(bulletImage);
		}
		
		override public function update(e:EnterFrameEvent) : void
		{
			if (target != null)
			{			
				targetPosition = target.getPosition();
				targetPosition.x += Constants.CELL_SIZE * 0.5;
				targetPosition.y += Constants.CELL_SIZE * 0.5;
				
				var velo:Point = new Point;
				velo.x = (target.x + Constants.CELL_SIZE*0.5) - this.x;
				velo.y = (target.y + Constants.CELL_SIZE*0.5) - this.y;
				
				velo.normalize(speed * e.passedTime);
				this.x += velo.x;
				this.y += velo.y;
				
				if (Point.distance(targetPosition, getPosition()) < 6)
				{
					Factory.getInstance().removeProjectil(this);
					if(!target.isDeleted)
					{
						target.sufferDamage(damage);
					}
				}
			}
		}
		
		public function get target():Enemy
		{
			return _target;
		}
		
		public function set target(value:Enemy):void 
		{
			_target = value;
		}
	}

}