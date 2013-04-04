package massdefense.tests.tower 
{
	import massdefense.pathfinder.Node;
	import massdefense.units.Creep;
	import massdefense.units.Tower;
	import org.flexunit.Assert;
	import org.flexunit.events.AsyncResponseEvent;

	public class TowerTest 
	{
		private var tower : Tower;
		
		[Before]
		public function runBeforeEveryTest():void {
		   tower = new Tower();
		}
		[Test]
		public function setposXY():void {
		    tower.setPositionXY(45, 98);
			Assert.assertEquals(tower.x, 45);   
			Assert.assertEquals(tower.y, 98); 
		}
		[Test]
		public function setRowCol():void {
		    tower.setPositionRowCol(3, 5);
			Assert.assertEquals(tower.x, 5 * Node.NODE_SIZE + Node.NODE_SIZE*0.5);   
			Assert.assertEquals(tower.y, 3 * Node.NODE_SIZE + Node.NODE_SIZE*0.5); 
		}
		[Test]
		public function reload():void {
		    tower.reloaded = false;
			tower.reloadTime = 2;
			tower.timeToReload = 2;
			
			tower.reloadProgress(1);
			Assert.assertEquals(tower.reloaded, false); 
			
			tower.reloadProgress(1);
			Assert.assertEquals(tower.reloaded, true); 
		}
		[Test]
		public function outOfRange():void {
		    tower.setPositionXY(50, 50);
			tower.range = 500;
			var creep: Creep = new Creep();
			creep.setPositionXY(55, 50);
			var creep2: Creep = new Creep();
			creep2.setPositionXY(55, 5000);
			
			
			Assert.assertEquals(tower.outOfRange(creep), false); 
			Assert.assertEquals(tower.outOfRange(creep2), true); 
			
		}
		
	}
}