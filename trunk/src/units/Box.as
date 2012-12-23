package units
{
	import flash.events.MouseEvent;
	import starling.display.Image;
	import starling.display.Sprite;
	import utils.Util;
	/**
	 * ...
	 * @author OML!
	 */
	public class Box extends GameObject
	{
		public var col : int = 0;
		public var row : int = 0;
		public var removeCallBack:Function = null;
		
		//GRAPHICS
		[Embed(source = "../../media/blocks/block_01.png")]
		private var BlockBitmap : Class;
		private var blockImage : Image;
		
		public function Box(row : int, col : int)
		{
			this.col = col;
			this.row = row;
				
			// GRAPHICS
			blockImage = Util.bitmapToImage(BlockBitmap);
			addChild(blockImage);
			
			//addEventListener(MouseEvent.CLICK, onClick);
			//addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
			
			
		}
		
		//private function onMouseMove(e:MouseEvent):void 
		//{
			//if (removeCallBack != null && Factory.getInstance().clickState == Factory.REMOVE && Factory.mouseDown)
			//{
				//removeCallBack();
			//}
		//}
		//
		//private function onClick(e:MouseEvent):void 
		//{
			//if (removeCallBack != null && Factory.getInstance().clickState == Factory.REMOVE)
			//{
				//removeCallBack();
			//}
		//}
	}
}