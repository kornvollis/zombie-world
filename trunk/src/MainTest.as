package  
{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import ui.waveEditor.WaveEditor;
	import ui.waveEditor.WaveEditWindow;
	
	/**
	 * ...
	 * @author OML!
	 */
	public class MainTest extends MovieClip 
	{	
		public function MainTest() 
		{
			var ww : WaveEditor = new WaveEditor();
			ww.x = 200;
			ww.y = 100;
			
			addChild(ww);
		}
		
	}

}