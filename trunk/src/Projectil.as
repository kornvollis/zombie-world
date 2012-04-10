package  
{
	/**
	 * ...
	 * @author OML!
	 */
	public class Projectil extends GameObject
	{
		public var target : GameObject = null;
		
		public var speed : int = 1;
		
		public function Projectil() 
		{
			//TEMP GRAPHICS
			this.graphics.beginFill(0xFFFFFF, 1);
			this.graphics.drawCircle(0, 0, 3);
		}
		
		override public function update() : void
		{
			if (target != null);
			{
				
			}
		}
		
	}

}