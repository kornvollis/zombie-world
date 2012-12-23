package utils 
{
	import flash.display.Bitmap;
	import org.as3commons.collections.ArrayList;
	import starling.display.Image;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author ...
	 */
	public class Util 
	{
		
		[Embed(source = "../../media/gui/buttons/default-button.png")]
		public static var DefaultButtonBM : Class;
		
		public function Util()
		{
			
		}
		
		public static function bitmapToImage(bitmapClass: Class) : Image {
			var bitmap : Bitmap = new bitmapClass();
			var texture : Texture = Texture.fromBitmap(bitmap, false);
			var image:Image = new Image(texture);
			
			return image;
		}
		
		public static function isContainingId(id:int, arraylist : ArrayList) : Boolean {
			for (var i:int = 0; i < arraylist.size; i++) 
			{
				if (arraylist.itemAt(i).id == id) {
					return true;
				}
			}
			return false;
		}
	}

}