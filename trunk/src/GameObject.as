package  
{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author OML!
	 */
	public class GameObject extends MovieClip 
	{
		
		public function GameObject() 
		{
			
		}
	
		public function addGraphics(mc : MovieClip)
		{
			this.addChild(mc);
		}
	}

}