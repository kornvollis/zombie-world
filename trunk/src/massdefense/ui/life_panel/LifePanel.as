package massdefense.ui.life_panel 
{
	import massdefense.assets.Assets;
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class LifePanel extends Sprite 
	{
		private var _life : uint = 8;
		private var hearts : Vector.<Image> = new Vector.<Image>; 
		
		public function LifePanel() 
		{
			addChild(Assets.getImage("BorderSmall"));
			
			drawHearts();
		}
		
		private function drawHearts():void 
		{
			for (var i : int = 0; i < life; i++) {
				var heart : Image = Assets.getImage("Heart");
				hearts.push(heart);
				addChild(heart);
				heart.x = 3 + i * 18 ;
				heart.y = 5;
			}
		}
		
		public function get life():uint 
		{
			return _life;
		}
		
		public function set life(value:uint):void 
		{
			_life = value;
			
			while (_life < hearts.length) {
				removeHeart();
			}
		}
		
		private function removeHeart():void 
		{
			if(hearts.length > 0) {
				var heart : Image = hearts.pop();
				removeChild(heart);
			}
		}
	}

}