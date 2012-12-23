package  
{
	import flash.events.Event;
	import flash.events.MouseEvent;
	import starling.display.Image;
	import utils.Util;
	/**
	 * ...
	 * @author OML!
	 */
	public class ExitPoint extends GameObject 
	{
		public var row : int;
		public var col : int;
		
		public var removeCallBack : Function = null;
		
		// GRAPHICS
		[Embed(source = "../media/exit/exit.png")]
		private var ExitBitmap : Class;
		
		
		public function ExitPoint(row:int, col:int) 
		{
			super();
			this.col = col;
			this.row = row;
			
			addGraphics();
			
			id = row * 10000 + col;
			//addEventListener(MouseEvent.CLICK, onClick);
			//addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		}
		
		public function equals(exitPoint : ExitPoint) : Boolean
		{
			if (exitPoint.row == row && exitPoint.col == col)
			{
				return true;
			} else return false;
		}
		
		private function addGraphics():void 
		{
			var image : Image = Util.bitmapToImage(ExitBitmap);
			addChild(image);
			
		}
		
		/*private function onClick(e:MouseEvent):void 
		{
			if (removeCallBack != null && Factory.getInstance().clickState == Factory.REMOVE)
			{
				removeCallBack();
			}
		}
		
		private function onMouseMove(e:MouseEvent):void 
		{
			if (removeCallBack != null && Factory.getInstance().clickState == Factory.REMOVE && Factory.mouseDown)
			{
				removeCallBack();
			}
		}*/
	}
}
