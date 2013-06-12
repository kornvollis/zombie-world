package massdefense.units 
{
	import massdefense.assets.Assets;
	import massdefense.Factory;
	import massdefense.Game;
	import massdefense.misc.Position;
	import massdefense.Utils;
	import starling.display.Image;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author OMLI
	 */
	public class Projectil extends Sprite 
	{
		public var target : Creep = null;
		private var _position : Position = new Position;
		public var bulletProperties : BulletProperties;
		
		public function Projectil(target : Creep, position : Position, bulletProperties : BulletProperties) 
		{
			this.bulletProperties = bulletProperties;
			this.position = position;
			this.target = target;
			
		}

		public function update(passedTime:Number) : void {
			if (target != null)
			{
				position  = Position.moveToPoint(this.position, target.position, bulletProperties.speed, passedTime);
				
				if (Position.distance(this.position, target.position) < 6) {
					Factory.calculateBulletHitOn(this,target);
				}
			}
		}
		
		public function addGraphics() : void {
			var bullet : Image = Assets.getImage(bulletProperties.image);
			Utils.centerPivot(bullet);
			addChild(bullet);
		}
		
		public function get position():Position 
		{
			return _position;
		}
		
		public function set position(value:Position):void 
		{
			_position = value;
			this.x = _position.x;
			this.y = _position.y;
		}
	}

}