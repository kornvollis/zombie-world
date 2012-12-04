package ui.waveEditor 
{
	import flash.display.MovieClip;	
	import flash.events.Event;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author OML!
	 */
	public class WaveEditor extends MovieClip 
	{
		private const TIME_INTERVALL : uint = 6;
		private const WIDTH  : uint = 600;
		private const HEIGHT : uint = 500;
		
		private var waveEditWindow : WaveEditWindow;
		private var addWaveButton : AddWaveButton;
		
		public var addButtonIsDragged : Boolean = false;
		
		public function WaveEditor()
		{
			waveEditWindow = new WaveEditWindow(WIDTH, HEIGHT, TIME_INTERVALL);
			addWaveButton = new AddWaveButton(60, 60);
			
			//POSITIONING
			waveEditWindow.y = 70;
			
			//LISTENERS
			addWaveButton.addEventListener(MouseEvent.MOUSE_DOWN, onAddWaveMD);
			
			
			
			//ADD GRPHICS
			addChild(addWaveButton);
			addChild(waveEditWindow);
		}
		
		private function onAddWaveMD(e:MouseEvent):void 
		{
			waveEditWindow.newWaveDraggedOver = true;
		}
	}

}