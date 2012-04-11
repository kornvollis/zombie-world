package  
{
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author OML!
	 */
	public class GameObject extends MovieClip 
	{
		public var onStage : Boolean = false;
		
		public var position : Point = new Point();
		
		public var isDeleted : Boolean = false;
		
		public function GameObject() 
		{
			
		}
		
		public function update() : void
		{
			
		}
		
		public function addGraphics(mc : MovieClip) : void
		{
			this.addChild(mc);
		}
	}
}