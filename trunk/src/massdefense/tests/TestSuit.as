package massdefense.tests
{
	import massdefense.level.LevelLoader;
	import massdefense.pathfinder.PathFinder;
	import massdefense.tests.level.LevelLoaderTest;
	import massdefense.tests.position.PositionTest;
	import massdefense.tests.tower.TowerTest;
	import org.flexunit.runners.Suite;
	
	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	
	public class TestSuit
	{
		public static var isTestRun : Boolean = false;
		
		public var t1:PositionTest;
		public var t2:TowerTest;
		public var levelLoader:LevelLoaderTest;
		public var node:NodeTest;
		public var grid:GridTest;
		public var pathFinder:PathfinderTest;
		public var creep:CreepTest;
		public var units:UnitsTest;
		public var gameObject:GameObjectTest;
		
	}

}