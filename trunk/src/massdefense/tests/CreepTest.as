package massdefense.tests 
{
	import flash.utils.Dictionary;
	import flexunit.framework.Assert;
	import massdefense.units.Creep;
	public class CreepTest 
	{
		private var creep: Creep;
		private var properties : Object = new Object();
		
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
		[Test]
		public function	testInitRow(): void {
			creep.injectProperties( { row:5 } );
			
			Assert.assertEquals(5, creep.row);
		}
		[Test]
		public function	testInitCol(): void {
			creep.injectProperties( { col:4 } );
			
			Assert.assertEquals(4, creep.col);
		}
		[Test]
		public function	testInitMaxHealth(): void {
			creep.injectProperties( { maxHealth:10 } );
			
			Assert.assertEquals(10, creep.maxHealth);
		}
		[Test]
		public function	testInitHealth(): void {
			creep.injectProperties( { health:10 } );
			
			Assert.assertEquals(10, creep.health);
		}
		
		
	}

}