package massdefense.units 
{
	import massdefense.assets.Assets;
	import massdefense.Factory;
	import massdefense.misc.Position;
	import starling.display.Image;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author OMLI
	 */
	public class Projectil extends Sprite 
	{
		
		public var target : Creep = null;
		public var speed : Number = 350;
		public var damage : uint = 1;
		private var _position : Position = new Position;
		
		public function Projectil() 
		{
			
		}
		
		public function update(passedTime:Number) : void {
			if (target != null)
			{
				
				position  = Position.moveToPoint(this.position, target.position, speed, passedTime);
				
				if (Position.distance(this.position, target.position) < 6) {
					target.health -= this.damage;
					Factory.removeProjectil(this);
				}
			}
		}
		
		public function addGraphics() : void {
			var bullet : Image = new Image(Assets.getTexture("SimpleBullet"));
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