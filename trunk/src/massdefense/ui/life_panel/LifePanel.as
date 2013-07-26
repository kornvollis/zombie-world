package massdefense.ui.life_panel 
{
	import feathers.controls.Label;
	import flash.text.TextFormat;
	import massdefense.assets.Assets;
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class LifePanel extends Sprite 
	{
		private var life : Label = new Label();
		
		public function LifePanel() 
		{
			addChild(Assets.getImage("Life"));
			addChild(life);
			
			life.text = "99";
			life.textRendererProperties.textFormat = new TextFormat("Pixel", 16, 0x000000, false);
			life.x = 40;
			life.y = 5;
		}
		
		public function setLife(value : String) : void {
			life.text = value;
		}
	}

}