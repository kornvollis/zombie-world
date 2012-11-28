package ui.waveEditor 
{
	import flash.display.MovieClip;
	
	/**
	 * ...
	 * @author OML!
	 */
	public class AddWaveButton extends MovieClip 
	{
		private var _width:uint;
		private var _height:uint;
		
		public function AddWaveButton(_width:uint, _height:uint) 
		{
			this._height = _height;
			this._width = _width;
			
			
			drawGraphics();
			
		}
		
		private function drawGraphics():void 
		{
			graphics.beginFill(0xff0810);
			graphics.drawRect(0, 0, _width, _height);
		}
		
	}

}