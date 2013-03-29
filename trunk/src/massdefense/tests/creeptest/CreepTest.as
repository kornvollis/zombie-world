package massdefense.tests.creeptest 
{
	import flash.display.Sprite;
	import massdefense.units.Creep;
	import massdefense.assets.Assets;
	import starling.core.Starling;
	/**
	 * ...
	 * @author OMLI
	 */
	[SWF(width="1300", height="600", frameRate="60", backgroundColor="#8fc0f2")]
	public class CreepTest extends Sprite
	{
		private var mStarling:Starling;
		
		public function CreepTest() 
		{
			mStarling = new Starling(CreepTestFakeMain, stage);
			
			// start it!
			mStarling.start();
			mStarling.showStats = false;
		}
		
	}

}