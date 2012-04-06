package  
{
	import flash.display.MovieClip;
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
		
		public var state : String = "idle";
		
		public var closestEnemy : GameObject = null;
		
		public var angle : Number = 0;
		
		public var rifleGraphics : MovieClip = new MovieClip;
		
		public var row : int;
		public var col : int;
		
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
			
			addChild(rifleGraphics);
		}
		
		override public function update() : void
		{
			//rifleGraphics.rotation+= 3;
		}
	}

}