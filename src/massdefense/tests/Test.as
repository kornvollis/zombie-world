package massdefense.tests 
{
	import flash.display.Sprite;
	import starling.core.Starling;
	/**
	 * ...
	 * @author OMLI
	 */
	public class Test extends Sprite
	{
		private var mStarling:Starling;
		
		public function Test() 
		{
			mStarling = new Starling(TestCases, stage);
			
			// start it!
			mStarling.start();
			mStarling.showStats = false;
		}
		
	}

}