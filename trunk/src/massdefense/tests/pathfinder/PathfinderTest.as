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
	public class PathfinderTest extends Sprite 
	{
		private var pathfinder : PathFinder = new PathFinder();
		
		
		public function PathfinderTest() 
		{
			testSuit_01();
			
			//testSuit_02();
		}
		
		private function testSuit_02():void 
		{
			
		}
		
		private function testSuit_01():void 
		{
			trace("start");
			var grid : Grid = new Grid(10, 15);			
			pathfinder.grid = grid;	
			
			var startNodes : Vector.<Node> = new Vector.<Node>;
			startNodes.push(grid.getNodeAtRowCol(1, 2));
			startNodes.push(grid.getNodeAtRowCol(9, 14));
			pathfinder.setStartNodes(startNodes);
			
			var closedNodes : Vector.<Node> = new Vector.<Node>;
			closedNodes.push(grid.getNodeAtRowCol(0, 5));
			closedNodes.push(grid.getNodeAtRowCol(5, 0));
			closedNodes.push(grid.getNodeAtRowCol(5, 1));
			closedNodes.push(grid.getNodeAtRowCol(5, 2));
			closedNodes.push(grid.getNodeAtRowCol(5, 3));
			
			pathfinder.closeNodes(closedNodes);
			
			pathfinder.calculateNodesDistances();
			
			trace("Find path for row/col: 6/0 \n");
			var path : Path = pathfinder.getRandomPathForNode(grid.getNodeAtRowCol(6, 0));
			path.print();
			var path2 : Path = pathfinder.getRandomPathForNode(grid.getNodeAtRowCol(4, 9));
			path2.print();
			var path3 : Path = pathfinder.getRandomPathForNode(grid.getNodeAtRowCol(4, 9));
			path3.print();
			
			
			// PATH TEST
				
			trace("0. indes is the end of path?" + path3.isEndPosition(0));
			trace("10. indes is the end of path?" + path3.isEndPosition(10));
			trace("9. indes is the end of path?" + path3.isEndPosition(9));
			trace("11. indes is the end of path?" + path3.isEndPosition(11));
		}
		
	}

}