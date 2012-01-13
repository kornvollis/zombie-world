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
			addTest(new TestFirstTry("TestIntegerMath"));
            addTest(new TestFirstTry("TestFloatMath"));
		}
		
	}

}