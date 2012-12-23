package  
{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import screens.GameScreen;
	import starling.core.Starling;
	import starling.display.Sprite;
	import ui.waveEditor.WaveEditor;
	
	/**
	 * ...
	 * @author OML!   002143
	 */
	[SWF(width="1000", height="600", frameRate="60", backgroundColor="#8fc0f2")]
	public class MainTest extends flash.display.Sprite 
	{	
		private var mStarling:Starling;
		
		public function MainTest()
		{
			// create our Starling instance
			mStarling = new Starling(Game, stage);
			//mStarling
			// set anti-aliasing (higher the better quality but slower performance)
			//mStarling.antiAliasing = 1;
			
			// start it!
			mStarling.start();
			mStarling.showStats = false;
		}
		
	}

}