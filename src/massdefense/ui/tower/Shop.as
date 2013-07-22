package massdefense.ui.tower 
{
	import massdefense.assets.Assets;
	import massdefense.units.Units;
	import starling.display.Button;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.textures.Texture;
	
	public class Shop  extends Sprite
	{
		private static const ROW : uint = 3;
		private static const COL : uint = 3;
		private static const GAP : uint = 7;
		private static const OFFSET_X : uint = 8;
		private static const OFFSET_Y : uint = 18;
		
		private var towerButtons : Vector.<ShopButton> = new Vector.<ShopButton>;
		
		private var topArrow : Button;
		private var bottomArrow : Button;
		
		
		public function Shop() 
		{
			addChild(Assets.getImage("TowerBuilderBG"));
			
			addTowerButtons();
			addArrows();
			
			addTowers();
		}
		
		private function addTowers():void 
		{
			
			var towerTypes : Vector.<String> = Units.getTowerTypes();
			/*
			for (var i:int = 0; i < towerTypes.length ; i++) 
			{
				towerButtons[i].addButtonGraphics(Units.getTowerImage(towerTypes[i], 1));
				towerButtons[i].type = towerTypes[i];
			}
			*/
		}
		
		private function addArrows():void 
		{
			addTopArrow();
			addBottomArrow();
		}
		
		private function addBottomArrow():void 
		{
			bottomArrow = new Button(Assets.getTexture("MenuArrowUp"), "");
			addChild(bottomArrow);
			bottomArrow.x = 54;
			bottomArrow.y = 4;
		}
		
		private function addTopArrow():void 
		{
			topArrow = new Button(Assets.getTexture("MenuArrowDown"), "");
			addChild(topArrow);
			topArrow.x = 54;
			topArrow.y = 158;
		}
		
		private function addTowerButtons():void 
		{
			for (var row:int = 0; row < ROW; row++) 
			{
				for (var col:int = 0; col < COL; col++)
				{
					var towerButton : ShopButton = new ShopButton(Assets.getImage("TowerBuyBorder"));
					towerButtons.push(towerButton);
					addChild(towerButton);
					towerButton.x = col * 40 + col * GAP + OFFSET_X;
					towerButton.y = row * 40 + row * GAP + OFFSET_Y;
				}
			}
		}
		
	}

}