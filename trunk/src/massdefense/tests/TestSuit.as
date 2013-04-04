package massdefense.tests 
{
	import massdefense.tests.position.PositionTest;
	import massdefense.tests.tower.TowerTest;
	import org.flexunit.runners.Suite;

	[Suite]
	[RunWith("org.flexunit.runners.Suite")]
	public class TestSuit 
	{
		public var t1:PositionTest;
		public var t2:TowerTest;
	}

}