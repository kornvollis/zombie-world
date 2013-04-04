package massdefense.tests.position 
{
	import massdefense.misc.Position;
	import org.flexunit.Assert;
	import org.flexunit.assertThat;
	
	/**
	 * ...
	 * @author OMLI
	 */
	public class PositionTest
	{
		
		public function PositionTest() 
		{
			
		}
		
		[Test(description = "Check distance calculation" )]  
		public function distance():void {  
			var p1 : Position = new Position();
			p1.x = 0;
			p1.y = 5;
			
			var p2 : Position = new Position();
			p2.x = 16;
			p2.y = 3;
			
			
			
			Assert.assertEquals(Position.distance(p1, p2), 18);   
		}
		
		[Test(description = "This p1 p2 dist less then 5" )]  
		public function distanceIsLess():void {  
			var p1 : Position = new Position();
			p1.x = 20;
			p1.y = 20;
			
			var p2 : Position = new Position();
			p2.x = 22;
			p2.y = 22;
			
			var isLess : Boolean = Position.isDistanceBetweenLessThan(p1, p2, 5);
			Assert.assertEquals(isLess, true);   
		}
		
		[Test(description = "This p1 p2 dist less then 5 failure" )] 
		public function distanceIsLessFailure():void {  
			var p1 : Position = new Position();
			p1.x = 20;
			p1.y = 20;
			
			var p2 : Position = new Position();
			p2.x = 22;
			p2.y = 22;
			
			var isLess : Boolean = Position.isDistanceBetweenLessThan(p1, p2, 3);
			Assert.assertEquals(isLess, false);   
		}
		[Test] 
		public function moveTo():void {  
			var p1 : Position = new Position();
			p1.x = 20;
			p1.y = 20;
			
			var p2 : Position = new Position();
			p2.x = 200;
			p2.y = 20;
			
			p1 = Position.moveToPoint(p1, p2, 50, 1);
			
			Assert.assertEquals(p1.x, 70);   
			Assert.assertEquals(p1.y, 20);   
		}
		
	}

}