package tests 
{
	import asunit.framework.TestCase;
	/**
	 * ...
	 * @author OML!
	 */
	public class CellTest extends TestCase
	{
		
		public function CellTest(testMethod:String)
		{
		  super(testMethod);
		}
		
		public function TestConstructor() : void
		{
			var c : Cell = new Cell(5, 8);
			assertEquals(5, c.row);
			assertEquals(8, c.col);
			
			c = new Cell(0, 0);
			assertEquals(Constants.GRID_SIZE / 2, c.middle_x);
			assertEquals(Constants.GRID_SIZE / 2, c.middle_y);
		}
	}
}