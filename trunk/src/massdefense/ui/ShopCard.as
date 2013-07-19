package massdefense.ui 
{
	import feathers.controls.Button;
	import feathers.controls.Label;
	import flash.text.TextFormat;
	import massdefense.assets.Assets;
	import starling.display.Image;
	import starling.display.Sprite;

	public class ShopCard extends Sprite 
	{
		private var cardName : Label = new Label;
		
		private var damageLabel : Label = new Label;
		private var rangeLabel  : Label = new Label;
		private var speedLabel  : Label = new Label;
		private var coinLabel   : Label = new Label;
		private var buy         : Button = new Button;
		
		public function ShopCard(name:String, damage:int, range:int,speed:int, price:int, abilities:Array=null)
		{
			addChild(Assets.getImage("ShopCard"));
			
			var cardName : Label = new Label();
			addChild(cardName);
			cardName.text = name;
			cardName.textRendererProperties.textFormat = new TextFormat("Pixel", 16, 0x000000, false);
			cardName.x = 15;
			cardName.y = 8;
			
			// DAMAGE RANGE FIRE RATE
			var list : Image = Assets.getImage("ShopCardList");
			addChild(list);
			list.x = 6;
			list.y = 98;
			
			var damageLabel : Label = new Label()
			addChild(damageLabel);
			damageLabel.text = "Damage: "+damage;
			damageLabel.textRendererProperties.textFormat = new TextFormat("Pixel", 16, 0x000000, false);
			damageLabel.x = list.x + 6;
			damageLabel.y = list.y + 7;
			
			var rangeLabel : Label = new Label()
			addChild(rangeLabel);
			rangeLabel.text = "Range: "+range;
			rangeLabel.textRendererProperties.textFormat = new TextFormat("Pixel", 16, 0x000000, false);
			rangeLabel.x = list.x + 6;
			rangeLabel.y = list.y + 29;
			
			var speedLabel : Label = new Label()
			addChild(speedLabel);
			speedLabel.text = "Speed: "+speed;
			speedLabel.textRendererProperties.textFormat = new TextFormat("Pixel", 16, 0x000000, false);
			speedLabel.x = list.x + 6;
			speedLabel.y = list.y + 51;
			
			// BUY
			addChild(buy);
			buy.useHandCursor = true;
			buy.defaultSkin = Assets.getImage("ShopBuy");
			buy.hoverSkin = Assets.getImage("ShopBuyOver");
			buy.x = 109;
			buy.y = 253;
			
			// COIN
			addChild(coinLabel);
			coinLabel.text = price.toString();
			coinLabel.textRendererProperties.textFormat = new TextFormat("Pixel", 16, 0xf1d806, false);
			coinLabel.x = 10;
			coinLabel.y = 258;
			
			
			// Add abilities
			if(abilities != null) {
				for (var i:int = 0; i < abilities.length; i++) 
				{
					var iconName : String = abilities[i].iconName;
					var iconText : String = abilities[i].iconText;
					
					var icon : Image = Assets.getImage(iconName)
					addChild(icon);
					icon.x = 6;
					icon.y = 185;
				}
			}
		}
		
	}

}