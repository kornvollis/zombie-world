package  
{
	import flash.display.MovieClip;
	import flash.geom.Point;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	
	/**
	 * ...
	 * @author OML!
	 */
	public class GameObject extends Sprite 
	{
		public static var id : int = 0;
		
		public var state : String;
		
		//public var onStage : Boolean = false;
		
		private var position : Point = new Point();
		
		public var isDeleted : Boolean = false;
		
		public var id : int;
		
		public function GameObject() 
		{
			id = GameObject.id;
			GameObject.id++;
		}
		
		public function update(e:EnterFrameEvent) : void
		{
			
		}
		
		public function getPosition():Point {
			this.position.x = this.x;
			this.position.y = this.y;
			
			return position;
		}
	}
}