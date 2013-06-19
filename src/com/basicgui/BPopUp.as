package com.basicgui 
{
	import flash.geom.Point;
	import massdefense.misc.SimpleGraphics;
	import starling.display.DisplayObject;
	import starling.display.Sprite;
	import starling.events.Touch;
	import starling.events.TouchEvent;
	import starling.events.TouchPhase;
	import starling.text.TextField;
	
	public class BPopUp extends Sprite
	{
		private var textArea : TextField = new TextField(140, 100, "");
		private var target : DisplayObject = null;
		
		public function BPopUp() 
		{
			addChild(SimpleGraphics.drawRectangle(140, 100, 0xD6D6D6, 0.7));
			addChild(textArea);
			textArea.border = true;
			visible = false;
			touchable = false;
		}
		
		public function setTarget(target : DisplayObject):void {
			this.target = target;
			target.addEventListener(TouchEvent.TOUCH, onTouch);
		}
		
		private function onTouch(e:TouchEvent):void 
		{
			var touch: Touch = e.getTouch(this);
			
			if (touch != null) 
			{
				var clickPos:Point = touch.getLocation(this);
				
				if (touch.phase == TouchPhase.ENDED) 
				{
					//TweenLite.to(background, 0.1, { x:0, y:0});
				} else if (touch.phase == TouchPhase.BEGAN) 
				{
					//TweenLite.to(background, 0.1, { x:2, y: 2});
				} 
			}
		}
		
		public function show(posx:int, posy:int):void {
			x = 0; y = 0;
			var pos : Point = this.globalToLocal(new Point(posx, posy));
			visible = true; 
			x = pos.x;
			y = pos.y + 30;
		}
		
		public function hide():void 
		{
			visible = false;
		}
	}

}