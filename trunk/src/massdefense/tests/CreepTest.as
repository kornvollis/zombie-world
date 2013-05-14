package massdefense.tests 
{
	import flexunit.framework.Assert;
	import massdefense.units.Creep;
	public class CreepTest 
	{
		private var creep: Creep;
		
		public function CreepTest() 
		{
			
		}
		
		[Before]
		public function init():void {
			creep = new Creep();
		}
		
		[Test]
		public function setPositionXY():void {
			creep.setPositionXY(123, 75);
			
			Assert.assertEquals(123, creep.x);
			Assert.assertEquals(123, creep.position.x);
			
			Assert.assertEquals(75, creep.y);
			Assert.assertEquals(75, creep.position.y);
		}
		
	}

}