package massdefense.screens
{
	import feathers.controls.Button;
	import feathers.controls.Screen;
	import flash.utils.getDefinitionByName;
	import massdefense.Utils;
	import starling.display.Sprite;
	import starling.events.Event;
	
	public class Levels extends Sprite
	{
		public static const LEVEL_CLICK : String = "level_click";
		
		private static const numOfLevels : uint = 2;
		private var levels: Vector.<Button> = new Vector.<Button>;

		public function Levels()
		{
			for (var i:int = 0; i < numOfLevels; i++)
			{
				var button : Button = Utils.createButton("LevelBox", "LevelBox", (i+1).toString());
				
				button.x = (i * 45) % 450;
				button.y = int(i / 10) * 45;
				
				addChild(button);
				
				button.addEventListener(Event.TRIGGERED, onLevelClick);
			}
		}
		
		private function onLevelClick(e:Event):void 
		{
			var index : uint = uint(Button(e.currentTarget).label);
			index--;
			trace(index);
			dispatchEvent(new Event(LEVEL_CLICK, true, index));
		}
	}
}