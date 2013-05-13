package massdefense.tests 
{
	import flexunit.framework.Assert;
	import massdefense.pathfinder.Grid;
	import massdefense.pathfinder.Node;
	public class GridTest 
	{
		private var grid : Grid;
		
		
		[Before]
		public function initGrid():void {
			grid = new Grid(9, 9);
		}
		[Test]
		public function testGetNode():void {
			Assert.assertNull(grid.getNode(0, -3));
			Assert.assertNull(grid.getNode(-3, -3));
			Assert.assertNull(grid.getNode(7, 9));
		}
		[Test]
		public function testLeftNeighbour():void {
			var node : Node = grid.getNode(4, 4);
			var leftNode : Node = grid.leftNeighbourOfNode(node);
			Assert.assertEquals(3, leftNode.col);
			Assert.assertEquals(4, leftNode.row);
		}
		[Test]
		public function testTopNeighbour():void {
			var node : Node = grid.getNode(4, 4);
			var topNode : Node = grid.topNeighbourOfNode(node);
			Assert.assertEquals(4, topNode.col);
			Assert.assertEquals(3, topNode.row);
		}
		[Test]
		public function testRightNeighbour():void {
			var node : Node = grid.getNode(4, 4);
			var rightNode : Node = grid.rightNeighbourOfNode(node);
			Assert.assertEquals(5, rightNode.col);
			Assert.assertEquals(4, rightNode.row);
		}
		[Test]
		public function testBottomNeighbour():void {
			var node : Node = grid.getNode(4, 4);
			var bottomNode : Node = grid.bottomNeighbourOfNode(node);
			Assert.assertEquals(4, bottomNode.col);
			Assert.assertEquals(5, bottomNode.row);
		}
		[Test]
		public function testExitNodes():void {
			grid.getNode(3, 3).exit = true;
			grid.getNode(2, 4).exit = true;
			grid.getNode(1, 7).exit = true;
			
			var nodes : Vector.<Node> = grid.exitNodes();
			Assert.assertEquals(3, nodes.length);
		}
	}
}