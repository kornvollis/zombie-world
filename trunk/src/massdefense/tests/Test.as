package massdefense.tests 
{
	import flash.display.Sprite;
	import flash.geom.Point;
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
			mStarling.start();
			mStarling.showStats = false;
			
		}
		
	}

}