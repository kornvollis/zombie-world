package  
{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author OML!
	 */
	public class GameObject extends MovieClip 
	{
		public var onStage : Boolean = false;
		
		private var _posX : Number = 0;
		private var _posY : Number = 0;
		
		public function GameObject() 
		{
			
		}
	
		public function addGraphics(mc : MovieClip) : void
		{
			this.addChild(mc);
		}
		
			public function get posX():Number 
		{
			return _posX;
		}
		
		public function set posX(value:Number):void 
		{
			_posX = value;
		}
		
		public function get posY():Number 
		{
			return _posY;
		}
		
		public function set posY(value:Number):void 
		{
			_posY = value;
		}
	}

}