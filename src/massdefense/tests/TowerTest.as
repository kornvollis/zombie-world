package massdefense.tests 
{
	public class TowerTest 
	{
		
		import massdefense.misc.Position;
		import massdefense.pathfinder.Node;
		import massdefense.units.Tower;
		import org.flexunit.Assert;
		import org.flexunit.assertThat;
		
		public function TowerTest() 
		{
			
		}
		
		
		[Test]
		public function setPositionRowColTest_01():void {  
			var tower : Tower = new Tower();	
			tower.setPositionRowCol(0, 0);
			
			Assert.assertEquals(tower.x, Node.NODE_SIZE * 0.5);   
			Assert.assertEquals(tower.y, Node.NODE_SIZE  * 0.5);   
		}
		[Test]
		public function setPositionRowColTest_02():void {  
			var tower : Tower = new Tower();	
			
			tower.setPositionRowCol(3, 5);
			Assert.assertEquals(tower.x, 5 * Node.NODE_SIZE + Node.NODE_SIZE * 0.5);   
			Assert.assertEquals(tower.y, 3 *  Node.NODE_SIZE + Node.NODE_SIZE * 0.5);  
		}
		[Test]
		public function setPositionXY():void {  
			var tower : Tower = new Tower();	
			
			tower.setPositionXY(67, 154);
			Assert.assertEquals(tower.x, 67);   
			Assert.assertEquals(tower.y, 154);  
		}
		
	}

}