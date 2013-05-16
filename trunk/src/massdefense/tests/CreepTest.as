package massdefense.tests 
{
	import flash.utils.Dictionary;
	import flexunit.framework.Assert;
	import massdefense.units.Creep;
	public class CreepTest 
	{
		private var creep: Creep;
		private var attributes : Array = new Array();
		public function CreepTest() 
		{
			
		}
		
		[Before]
		public function init():void {
			attributes = new Array();
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
		[Test]
		public function	testInitRow(): void {
			attributes["row"] = 5;
			creep.init(attributes);
			
			Assert.assertEquals(5, creep.row);
		}
		[Test]
		public function	testInitCol(): void {
			attributes["col"] = 4;
			creep.init(attributes);
			
			Assert.assertEquals(4, creep.col);
		}
		[Test]
		public function	testInitMaxHealth(): void {
			attributes["maxHealth"] = 10;
			creep.init(attributes);
			
			Assert.assertEquals(10, creep.maxHealth);
		}
		[Test]
		public function	testInitHealth(): void {
			attributes["health"] = 10;
			creep.init(attributes);
			
			Assert.assertEquals(10, creep.health);
		}
		
		
	}

}