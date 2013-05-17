package massdefense.tests 
{
	import flash.display.Sprite;
	import flexunit.framework.Assert;
	import massdefense.misc.SimpleGraphics;
	import massdefense.pathfinder.Grid;
	import massdefense.pathfinder.Node;
	import massdefense.pathfinder.PathFinder;
	
	public class PathfinderTest
	{
		private var pathfinder : PathFinder = new PathFinder();
		
		[Test]  
		public function testWithoutExit():void {  
			
			trace("Grid without exit test: \n");
			var grid : Grid = new Grid(5, 8);
			pathfinder.grid = grid;
			
			pathfinder.calculateNodesDistances();
			Assert.assertNotNull(pathfinder);
		}
		[Test]  
		public function testWithOneExit():void {  
			
			trace("Grid with one exit test: \n");
			var grid : Grid = new Grid(5, 8);
			pathfinder.grid = grid;
			
			grid.getNode(0, 0).exit = true;
			
			pathfinder.calculateNodesDistances();
			Assert.assertNotNull(pathfinder);
		}
		
		[Test]  
		public function testWithBlocks():void {  
			
			trace("Grid with blocks exit test: \n");
			var grid : Grid = new Grid(5, 8);
			pathfinder.grid = grid;
			
			grid.getNode(0, 0).exit = true;
			
			grid.getNode(2, 0).close();
			grid.getNode(2, 1).close();
			grid.getNode(2, 2).close();
			grid.getNode(2, 3).close();
			
			pathfinder.calculateNodesDistances();
			Assert.assertNotNull(pathfinder);
		}
		[Test]  
		public function testGetNext():void {  
			var grid : Grid = new Grid(5, 8);
			pathfinder.grid = grid;
			
			grid.getNode(0, 0).exit = true;
			
			pathfinder.calculateNodesDistances();
			
			var startNode  : Node = pathfinder.grid.getNode(3, 3);
			var targetNode : Node = pathfinder.nextNode(3, 3);
			
			Assert.assertEquals(startNode.distance, targetNode.distance + 1);
		}
	}

}