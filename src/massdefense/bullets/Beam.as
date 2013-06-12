package massdefense.bullets 
{
	import com.greensock.plugins.DynamicPropsPlugin;
	import com.greensock.plugins.TweenPlugin;
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import flash.display.MovieClip;
	import flash.geom.Point;
	import massdefense.assets.Assets;
	import massdefense.misc.Position;
	import massdefense.units.Creep;
	import massdefense.units.Tower;
	import starling.display.Sprite;

	public class Beam extends Sprite 
	{
		private var _beamReleased : Boolean = false;
		public var target : Creep = null;
		private var beamSpriteWidth : Number = 10;
		private var tower:Tower;
		private var position : Position = new Position;
		
		public function Beam(position : Position) 
		{
			this.position = position;
			//visible = false;
			addChild(Assets.getImage("Laser"));
			this.width = beamSpriteWidth;
			this.height = 2;
		}
		
		public function update(timeElapssed : Number) :void {
			if (target == null || target.health <= 0) beamReleased = false;
			else {
				rotation = 0;
				width = Position.distance(target.position, position);
				
				var vect : Point = new Point;
				vect.x = target.x - position.x;
				vect.y = target.y - position.y;
				var angle : Number = Math.atan2(vect.y, vect.x);
				rotation = angle;
			}
			//trace(width);
		}
		
		public function get beamReleased():Boolean 
		{
			return _beamReleased;
		}
		
		public function set beamReleased(value:Boolean):void 
		{
			if (value == true) {
				visible = true;
				{
					if (_beamReleased == false) {
						this.alpha = 0;
						TweenMax.to(this, 2, { alpha:0.8 } );
					}
				}
			} else {
				visible = false;
			}
			
			_beamReleased = value;
		}
	}

}