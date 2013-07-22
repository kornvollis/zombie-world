package massdefense.tests 
{
	import flexunit.framework.Assert;
	import massdefense.units.Tower;
	import massdefense.units.Units;
	
	public class UnitsTest 
	{
		[Test]
		public function testGetTowerProperties():void {
			var towerObject : Object = Units.getTowerProperties("simpleTower",1);
			
			var tower: Tower = new Tower();
			tower.injectProperties(towerObject);
			
			Assert.assertNotNull(towerObject);
			Assert.assertEquals(tower.damage, towerObject.damage);
			Assert.assertEquals(tower.range, towerObject.range);
		}
	}

}