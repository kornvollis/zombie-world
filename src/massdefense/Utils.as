package massdefense 
{
	import starling.display.Image;
	public class Utils 
	{
		public static function centerPivot(image : Image) : void {
			image.pivotX = image.width * 0.5;
			image.pivotY = image.height* 0.5;
		}
	}
}