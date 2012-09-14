package units
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author OML!
	 */
	public class Projectil extends GameObject
	{
		private var _target : GameObject = null;
		
		public var speed : int = 10;
		public var damage : int = 1;
		private var targetISAlive : Boolean = false;
		
		private var targetPosition : Point = new Point;
		//private var targetLastPosition : Point = null;
		
		
		public function Projectil(posX : int, posY : int, target : GameObject) 
		{
			this.position.x = posX;
			this.position.y = posY;
			
			this.target = target;
			this.targetPosition.x = target.position.x;
			this.targetPosition.y = target.position.y;
			//TEMP GRAPHICS
			this.graphics.beginFill(0x000000, 1);
			this.graphics.drawCircle(0, 0, 1.5);
		}
		
		override public function update() : void
		{
			if (isDeleted == false)
			{
				if (target != null)
				{
					targetPosition.x = target.position.x;
					targetPosition.y = target.position.y;
				}
				
				var velo:Point = new Point;
				velo.x = targetPosition.x - position.x;
				velo.y = targetPosition.y - position.y;
				
				velo.normalize(speed);
				position.x += velo.x;
				position.y += velo.y;
				
				if (Point.distance(targetPosition, position) < 6)
				{
					Factory.getInstance().removeProjectil(this);
					if(!Enemy(target).isDeleted)
					{
						Enemy(target).sufferDamage(damage);
					}
				}
			}
		}
		
		public function get target():GameObject
		{
			return _target;
		}
		
		public function set target(value:GameObject):void 
		{
			_target = value;
		}
		
	}

}