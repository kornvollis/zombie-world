package tests 
{
	import asunit.framework.TestSuite;
	/**
	 * ...
	 * @author OML!
	 */
	public class AllTests extends TestSuite
	{
		
		public function AllTests() 
		{
			super();
			
			/*CELL TESTS*/
			addTest(new CellTest("TestConstructor"));
            
			/*ZOMBIE TESTS*/
			addTest(new ZombieTest(ZombieTest.TEST1));
			addTest(new ZombieTest(ZombieTest.TEST2));
			addTest(new ZombieTest(ZombieTest.TEST3));
			addTest(new ZombieTest(ZombieTest.TEST4));
			addTest(new ZombieTest(ZombieTest.TEST5));
		}
		
	}

}