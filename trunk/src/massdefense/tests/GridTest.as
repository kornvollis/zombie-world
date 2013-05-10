package massdefense.tests 
{
	import flexunit.framework.Assert;
	import massdefense.pathfinder.Grid;
	public class GridTest 
	{
		private var grid : Grid;
		
		
		[Before]
		public function initGrid():void {
			grid = new Grid(5, 9);
		}
		
		[Test]
		public function testNodeAtRowCol():void {
			Assert.assertNull(grid.getNodeAtRowCol(0, -3));
			Assert.assertNull(grid.getNodeAtRowCol(0, -3));
			Assert.assertNull(grid.getNodeAtRowCol(0, -3));
		}
	}
}