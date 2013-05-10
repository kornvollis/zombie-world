package massdefense.tests.pathfinder 
{
	import flash.display.Sprite;
	import massdefense.misc.SimpleGraphics;
	import massdefense.pathfinder.Grid;
	import massdefense.pathfinder.Node;
	import massdefense.pathfinder.Path;
	import massdefense.pathfinder.PathFinder;
	
	/**
	 * ...
	 * @author OMLI
	 */
	public class PathfinderTest
	{
		private var pathfinder : PathFinder = new PathFinder();
		
		[Test]  
		public function distance():void {  
			var p1 : Position = new Position();
			p1.x = 0;
			p1.y = 5;
			
			var p2 : Position = new Position();
			p2.x = 16;
			p2.y = 3;
			
			Assert.assertEquals(Position.distance(p1, p2), Math.sqrt(16*16+2*2) );   
		}
		
	}

}