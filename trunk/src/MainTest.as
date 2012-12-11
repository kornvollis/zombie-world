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
	 * @author OML!
	 */
	[SWF(width="1280", height="752", frameRate="60", backgroundColor="#002143")]
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
			mStarling.showStats = true;
		}
		
	}

}