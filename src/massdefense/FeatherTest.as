package massdefense 
{
	import feathers.controls.Button;
	import feathers.controls.Label;
	import feathers.controls.text.TextFieldTextRenderer;
	import feathers.core.FeathersControl;
	import feathers.core.ITextRenderer;
	import flash.text.AntiAliasType;
	import flash.text.TextFormat;
	import massdefense.assets.Assets;
	import starling.display.Sprite;
	import starling.events.Event;

	public class FeatherTest extends Sprite 
	{
		public static const FONT : String = "Pixel";
		// [Embed(source="assets/font/pixelmix.ttf", embedAsCFF="false", fontName="Pixel")]
		[Embed(source="assets/font/prstart.ttf", embedAsCFF = "false", fontName = "Pixel")]
		private static const FONT_PIXEL:String;
		
		public function FeatherTest() 
		{
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event):void 
		{
			FeathersControl.defaultTextRendererFactory = function():ITextRenderer
			{
				var tr :TextFieldTextRenderer = new TextFieldTextRenderer();
				tr.embedFonts = true;
				tr.antiAliasType = AntiAliasType.ADVANCED;
				return tr;
			};
			
			removeEventListener(Event.ADDED_TO_STAGE, init);
			var button:Button = new Button();
			button.defaultSkin = Assets.getImage("TowerBuilderBG");
			
			button.label = "Click Me";
			button.x = 400;
			button.y = 150;
			this.addChild( button );
			
			 var obj:Object = button.defaultLabelProperties;
			 obj.textFormat = new TextFormat("Pixel",18,0xFF00FF,false);
			 button.defaultLabelProperties = obj;
			 
			addLabelTests();
		}
		
		private function addLabelTests():void 
		{
			for (var i:int = 8; i <40; i++) 
			{
				var label : Label = new Label();
				label.text = "Hello bello my size is: " + i + "px ";
				label.textRendererProperties.textFormat = new TextFormat("Pixel", i, 0xFF00FF, false);
				label.y = (i-8) * 30 ;
				addChild(label);
			}
		}
		
	}

}