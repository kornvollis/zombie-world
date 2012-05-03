package tests 
{
	import asunit.framework.TestCase;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author OML!
	 */
	public class ZombieTest extends TestCase 
	{
		public static const TEST1 : String = "test1";
		public static const TEST2 : String = "test2";
		public static const TEST3 : String = "test3";
		public static const TEST4 : String = "test4";
		public static const TEST5 : String = "test5";
		
		public function ZombieTest(testMethod:String)
		{
			super(testMethod);
		}
		
		public function test1() : void
		{
			var cell : Cell = null;
			
			try 
			{
				var zombie : Enemy = new Enemy(cell);
			} catch (err : Error)
			{
				assertEquals(err.message, Enemy.CONSTRUCTOR_NULL_ERROR);
			}
		}
		
		public function test2() : void
		{
			var c : Cell = new Cell(3, 7);
			
			var z : Enemy = new Enemy(c);
			
			assertEquals(3, z.cellY);
			assertEquals(7, z.cellX);
		}
		
		public function test3() : void
		{
			var c : Cell = new Cell(2, 3);
			
			var z : Enemy = new Enemy(c);
			
			assertEquals(Constants.CELL_SIZE*2 + Constants.CELL_SIZE/2, z.posY);
			assertEquals(Constants.CELL_SIZE*3 + Constants.CELL_SIZE/2, z.posX);
		}
		
		public function test4() : void
		{
			var c : Cell = new Cell(2, 3);
			
			var z : Enemy = new Enemy(c);
			
			assertEquals(z.currentCell, c);
			assertEquals(z.targetCell, null);
		}
		
		public function test5() : void
		{
			var c : Cell = new Cell(2, 3);
			var t : Cell = new Cell(3, 3);
			
			var z : Enemy = new Enemy(c);
			z.targetCell = t;
			
			assertEquals(z.distance(z.targetCell), Constants.CELL_SIZE);
			
			var startDist : Number = z.distance(t);
			
			z.moveTo(t);
			
			var newDist : Number = z.distance(t);
			
			assertEquals(true , startDist > newDist);
			
			/*
			z.currentCell = z.targetCell;
			z.targetCell = null;
			assertEquals(false, z.currentCell == null);
			assertEquals(3, z.currentCell.row);
			*/
			
			while (z.currentCell.row != 3)
			{
				z.moveTo(t);
			}
			
			
			assertEquals(z.currentCell, t);
			assertEquals(z.posX, t.middle_x);
			assertEquals(z.posY, t.middle_y);
		}
	}
	
	
	
}