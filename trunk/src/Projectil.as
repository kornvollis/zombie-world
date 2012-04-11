package  
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author OML!
	 */
	public class Projectil extends GameObject
	{
		private var _target : GameObject = null;
		
		public var speed : int = 6;
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
			this.graphics.beginFill(0xFFFFFF, 1);
			this.graphics.drawCircle(0, 0, 3);
		}
		
		override public function update() : void
		{
			//trace("upi");
			if (isDeleted == false)
			{
				//trace("kakas");
				if (target != null)
				{
					targetPosition.x = target.position.x;
					targetPosition.y = target.position.y;
				}
				
				var velo:Point = new Point;
				velo.x = targetPosition.x - position.x;
				velo.y = targetPosition.y - position.y;
				//velo.x = target.position.x - position.x;
				//velo.y = target.position.y - position.y;
				
				velo.normalize(speed);
				position.x += velo.x;
				position.y += velo.y;
				
				if (Point.distance(targetPosition, position) < 3)
				{
					Factory.getInstance().removeProjectil(this);
					if(!Zombie(target).isDeleted)
					{
						Zombie(target).sufferDamage(damage);
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