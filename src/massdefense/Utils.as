package massdefense 
{
	import starling.display.DisplayObject;
	import starling.display.Image;
	public class Utils 
	{
		public static function centerPivot(displayObject : DisplayObject) : void {
			displayObject.pivotX = displayObject.width * 0.5;
			displayObject.pivotY = displayObject.height* 0.5;
		}
	}
}