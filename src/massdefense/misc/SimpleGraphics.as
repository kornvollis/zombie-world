package massdefense.misc 
{
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.geom.Point;
	import starling.display.Image;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author OMLI
	 */
	public class SimpleGraphics 
	{
		private static var oldSprite : Sprite = new Sprite;
		
		public function SimpleGraphics() 
		{
			
		}
		
		public static function drawXatRowCol(rows : uint , cols: uint, cellSize: uint, lineSize: Number = 1, color: uint = 0x880000, alpha:Number = 1 ) : Image {
			var oldSprite : flash.display.Sprite = new flash.display.Sprite;
			oldSprite.graphics.lineStyle(lineSize, color, alpha);

			oldSprite.graphics.moveTo(0, 0);
			oldSprite.graphics.lineTo(cellSize, cellSize);
	
			oldSprite.graphics.moveTo(cellSize, 0);
			oldSprite.graphics.lineTo(0, cellSize);
			
			////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			var bData:BitmapData=new BitmapData(oldSprite.width, oldSprite.height,true,1);
			bData.draw(oldSprite);
			
			var texture:Texture = Texture.fromBitmapData(bData);
			var image:Image = new Image(texture);
			
			image.x = cols*cellSize;
			image.y = rows*cellSize;
			
			return image;
		}
		
		public static function drawGrid(rows : uint , cols: uint, cellSize: uint, borderSize:uint = 1, borderColor: uint = 0x880000, alpha: Number = 1) : Image {
			var width  : int = cols * cellSize;
			var height : int = rows * cellSize;			
			
			var oldSprite : flash.display.Sprite = new flash.display.Sprite;
			oldSprite.graphics.lineStyle(borderSize, borderColor, alpha);
			
			
			for (var  row:int  = 0; row <= rows; row++)
			{
				oldSprite.graphics.moveTo(0, cellSize*row);
				oldSprite.graphics.lineTo(width, cellSize*row);
			}
			for (var  col:int  = 0; col <= cols; col++)
			{
				oldSprite.graphics.moveTo(cellSize*col, 0);
				oldSprite.graphics.lineTo(cellSize*col, height);
			}
			
			////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
			var bData:BitmapData=new BitmapData(oldSprite.width, oldSprite.height,true,1);
			bData.draw(oldSprite);
			
			var texture:Texture = Texture.fromBitmapData(bData);
			var image:Image = new Image(texture);
			
			
			return image;
		}
		
		public static function drawLineFromTo(begin:Point, end:Point, lineWidth : Number = 1, color: uint =  0x880000) : Image {
			var oldSprite : flash.display.Sprite = new flash.display.Sprite;
			oldSprite.graphics.lineStyle(lineWidth, color);
			oldSprite.graphics.lineTo(end.x-begin.x, end.y-begin.y);
			
			var bData:BitmapData=new BitmapData(oldSprite.width, oldSprite.height,true,1);
			bData.draw(oldSprite);
			
			var texture:Texture = Texture.fromBitmapData(bData);
			var image:Image= new Image(texture);
			
			image.x = begin.x;
			image.y = begin.y;
			
			return image;
		}
		
		static public function drawCircle(posX:Number, posY:Number, radius:Number, lineWidth : Number = 1, color: uint =  0x880000):Image 
		{
			var oldSprite : flash.display.Sprite = new flash.display.Sprite;
			oldSprite.graphics.lineStyle(lineWidth, color);
			oldSprite.graphics.drawCircle(radius, radius, radius);
			
			var bData:BitmapData=new BitmapData(oldSprite.width, oldSprite.height,true,1);
			bData.draw(oldSprite);
			
			var texture:Texture = Texture.fromBitmapData(bData);
			var image:Image= new Image(texture);
			
			image.x = posX;
			image.y = posY;
			
			return image;
		}
		
	}

}