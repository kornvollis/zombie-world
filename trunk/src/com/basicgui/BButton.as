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
		public static const CLICK : String = "CLICK";
		
		private var image : Image = null ;
		private var disabledImage : Image = null;
		
		private var enabled : Boolean = true;
		
		public function BButton(image: Image, disabled: Image = null)
		{
			this.image = image;
			this.disabledImage = disabled;
			addChild(this.image);
			if(disabled != null) addChild(this.disabledImage);
			addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		public function enable() : void {
			image.visible = true;
			enabled = true;
			
			if (disabledImage != null) {
				disabledImage.visible = false;
			}
		}
		
		public function disable() : void {
			enabled = false;
			
			if (disabledImage != null) {
				image.visible = false;
				disabledImage.visible = true;
			}
		}
		
		private function onTouch(e:TouchEvent):void 
		{
			var touch: Touch = e.getTouch(this);
			
			if (touch != null && enabled) 
			{
				var clickPos:Point = touch.getLocation(this);
				
				if (touch.phase == TouchPhase.ENDED) 
				{
					var clickEvent: Event = new Event(CLICK, true, this);
					dispatchEvent(clickEvent);
					TweenLite.to(image, 0.1, { x:0, y:0});
				} else if (touch.phase == TouchPhase.BEGAN) 
				{
					TweenLite.to(image, 0.1, { x:2, y: 2});
				} 
			}
		}
		
	}

}