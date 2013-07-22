package massdefense.ui 
{
	import com.greensock.easing.Back;
	import com.greensock.easing.Sine;
	import com.greensock.TweenMax;
	import feathers.controls.Label;
	import flash.geom.Point;
	import flash.text.TextFormat;
	import massdefense.assets.Assets;
	import massdefense.units.Units;
	import starling.display.DisplayObject;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	
	public class MyShop extends Sprite 
	{
		private static const TIER_ONE   : String = "tier_one";
		private static const TIER_TWO   : String = "tier_two";
		private static const TIER_THREE : String = "tier_three";
		
		private static const CLOSED : String = "closed";
		static public const OPEN:String = "open";
		private var state : String = CLOSED;
		private var selectedTab : String = TIER_ONE;
		
		public static var instance : MyShop;
		private var bg : Image = Assets.getImage("ShopBG");
		
		private var tierOneCards : Vector.<ShopCard> = new Vector.<ShopCard>;
		
		private static const FIRST_CARD_TOP_LEFT_X : int = 8;
		private static const FIRST_CARD_TOP_LEFT_Y : int = 67;
		
		public function MyShop() 
		{
			addChild(bg);
			
			this.x = (800 - this.width) * 0.5;
			this.y = 572;
			
			bg.addEventListener(TouchEvent.TOUCH, onShopTouch);
			
			instance = this;
			
			initCards();
			showSelectedTab();
		}
		
		private function showSelectedTab():void
		{
			if (selectedTab == TIER_ONE) {
				for (var i:int = 0; i < tierOneCards.length; i++)
				{
					addChild(tierOneCards[i]);
					tierOneCards[i].x = FIRST_CARD_TOP_LEFT_X + i* 194;
					tierOneCards[i].y = FIRST_CARD_TOP_LEFT_Y;
				}
			}
		}
		
		private function initCards():void
		{
			var tierOneTowerTypes : Vector.<String> = Units.getTowerTypes();
			for (var i:int = 0; i < tierOneTowerTypes.length; i++) 
			{
				var towerProps : Object = Units.getTowerProperties(tierOneTowerTypes[i], 1);
				var card   : ShopCard = new ShopCard(tierOneTowerTypes[i], towerProps.name, towerProps.damage, towerProps.range, towerProps.reloadTime, towerProps.cost, towerProps.shopImage, [{iconName: "TargetIcon", iconText: "kaka"}]);
				tierOneCards.push(card);
			}
		}
		
		public function close():void 
		{
			TweenMax.to(this, 1, { y:572, ease:Back.easeOut } );
		}
		
		private function onShopTouch(e:TouchEvent):void 
		{
			e.stopImmediatePropagation();
			var touch: Touch = e.getTouch(bg);
			if (touch != null) 
			{				
				if (touch.phase == TouchPhase.ENDED) 
				{
					openShop();
				} else if (touch.phase == TouchPhase.HOVER) {
					if(state == CLOSED) {
						TweenMax.to(this, 1, { y:562 } );
					}
				}
			}
			
			if(state == CLOSED) {
				if (!e.getTouch(e.target as DisplayObject, TouchPhase.HOVER)) {
					TweenMax.to(this, 1, { y:572 } );
				}
			}
		}
		
		private function openShop():void 
		{
			state = OPEN;
			TweenMax.to(this, 1, { y:194, ease: Back.easeIn});
		}
		
	}

}