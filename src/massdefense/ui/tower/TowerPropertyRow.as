package massdefense.ui.tower 
{
	import massdefense.assets.Assets;
	import massdefense.Game;
	import starling.display.Sprite;
	import starling.text.TextField;
	
	public class TowerPropertyRow extends Sprite 
	{
		public static const FONT_SIZE : uint = 20;
		
		private var leftColumn  : TextField;
		private var rightColumn : TextField;
		
		public function TowerPropertyRow() 
		{
			addChild(Assets.getImage("TowerPropItem"));
			
			leftColumn  = new TextField(100,14, "left  col", Game.FONT, FONT_SIZE);
			addChild(leftColumn);
			//leftColumn.border = true;
			
			rightColumn = new TextField(42, 14, "right col", Game.FONT, FONT_SIZE);
			addChild(rightColumn);
			rightColumn.x = 100;
			//rightColumn.border = true;
		}
		
		public function setLeftText(text : String) : void {
			leftColumn.text = text;
		}
		public function setRightText(text : String) : void {
			rightColumn.text = text;
		}
	}

}