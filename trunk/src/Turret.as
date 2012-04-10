package  
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.geom.Point;
	import flashx.textLayout.formats.Float;
	/**
	 * ...
	 * @author OML!
	 */
	public class Turret extends GameObject 
	{
		public static const IDLE   : String = "idle";
		public static const FIRING : String = "firing";
		
		public var damage : int = 1;
		public var range  : int = 150;
		public var bulletPerSec : int = 1;	
		
		public var state : String = "idle";
		
		public var target : GameObject = null;
		
		public var angle : Number = 0;
		
		public var rifleGraphics : MovieClip = new MovieClip;
		
		public var row : int;
		public var col : int;
		
		private var _showRange : Boolean = true;
		
		private var rangeGraphics : Sprite = new Sprite;
		
		
		
		public function Turret(row:int, col:int) 
		{
			this.row = row;
			this.col = col;
			
			position.x = col * Constants.CELL_SIZE;
			position.y = row * Constants.CELL_SIZE;
			
			this.graphics.beginFill(0x759933);
			this.graphics.drawRect(0, 0, Constants.CELL_SIZE, Constants.CELL_SIZE);
			
			rifleGraphics.graphics.lineStyle(2, 0xFF0000);
			rifleGraphics.graphics.lineTo(Constants.CELL_SIZE, 0);
			
			rifleGraphics.x = Constants.CELL_SIZE * 0.5;
			rifleGraphics.y = Constants.CELL_SIZE * 0.5;
			
			//Add range graphics
			rangeGraphics.graphics.lineStyle(2, 0xFF0000);
			rangeGraphics.graphics.drawCircle(0, 0, range);
			if (showRange)
			{
				rangeGraphics.visible = true;
			} else {
				rangeGraphics.visible = false;
			}
			
			addChild(rifleGraphics);
			addChild(rangeGraphics);
		}
		
		override public function update() : void
		{
			if (target != null)
			{
				var vect : Point = new Point;
				vect.x = target.x - this.position.x;
				vect.y = target.y - this.position.y;
				
				angle = Math.atan2(vect.y, vect.x) * 180 / Math.PI;
				
				rifleGraphics.rotation = angle;
			}
		}
		
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
	}

}