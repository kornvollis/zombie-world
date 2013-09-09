package massdefense 
{
	import feathers.controls.Button;
	import feathers.controls.Label;
	import flash.text.TextFormat;
	import massdefense.assets.Assets;
	import starling.display.DisplayObject;
	import starling.display.Image;
	public class Utils 
	{
		public static function centerPivot(displayObject : DisplayObject) : void {
			displayObject.pivotX = displayObject.width * 0.5;
			displayObject.pivotY = displayObject.height* 0.5;
		}
		
		public static function createButton(skinImageName : String, hoverImageName: String, text: String = "") : Button {
			var button : Button = new Button();
			button.useHandCursor = true;
			button.defaultSkin = Assets.getImage(skinImageName);
			button.hoverSkin = Assets.getImage(hoverImageName);
			button.label = text;
			button.defaultLabelProperties.textFormat = new TextFormat("Pixel", 16, 0x000000, false);
			//coins.text = "9999";
			//coins.textRendererProperties.textFormat = new TextFormat("Pixel", 16, 0x000000, false);
			//button.defaultLabelProperties
			
			return button;
		}
	}
}