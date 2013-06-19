package com.basicgui 
{
	import com.greensock.TweenLite;
	import flash.geom.Point;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;

	public class BButton extends Sprite
	{
		private var background : Sprite = new Sprite;
		
		public function BButton()
		{
			addChild(background);
			addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		public function addGraphcis(image:Image):void {
			background.addChild(image);
		}
		
		private function onTouch(e:TouchEvent):void 
		{
			var touch: Touch = e.getTouch(this);
			
			if (touch != null) 
			{
				var clickPos:Point = touch.getLocation(this);
				
				if (touch.phase == TouchPhase.ENDED) 
				{
					TweenLite.to(background, 0.1, { x:0, y:0});
				} else if (touch.phase == TouchPhase.BEGAN) 
				{
					TweenLite.to(background, 0.1, { x:2, y: 2});
				} 
			}
		}
		
	}

}