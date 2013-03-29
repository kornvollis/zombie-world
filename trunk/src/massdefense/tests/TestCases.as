package massdefense.tests 
{
	import massdefense.pathfinder.PathFinder;
	import massdefense.tests.level.LevelTest;
	import massdefense.tests.pathfinder.PathfinderTest;
	import massdefense.Wave;
	import starling.display.Sprite;
	
	/**
	 * ...
	 * @author OMLI
	 */
	public class TestCases extends Sprite 
	{
		public function TestCases() 
		{
			var levelTest : LevelTest = new LevelTest();
			addChild(levelTest);
			
			// PathfinderTest
			// var pathTest : PathfinderTest = new PathfinderTest();
			
			// Wave test
			// var wave : Wave = new Wave() ;
			// wave.start();
			
		}
		
	}

}