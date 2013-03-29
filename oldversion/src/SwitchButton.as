package  
{
	import starling.display.Button;
	import starling.display.Image;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class SwitchButton extends Button 
	{
		public var on : Boolean = false;
		private var _off : Boolean = !on;
		
		public var data : Object;
		
		public function SwitchButton(upState:Texture, textString:String="", downState:Texture=null ) 
		{
			super(upState, textString, downState);
			
			scaleWhenDown = 0.8;
			pivotX = upState.width * 0.5;
			pivotY = upState.height * 0.5;
			
			addEventListener(Event.TRIGGERED, onTrigger);
		}
		
		public function addImage(image:Image) : void
		{
			addChild(image);
		}
		
		public function setPos(posX:Number, posY:Number):void 
		{
			this.x = posX + this.width * 0.5;
			this.y = posY + this.height * 0.5;
		}
		
		private function onTrigger(e:Event):void 
		{
			switchIt();
			trace("belso");
		}
		
		public function switchIt() :void {
			if (on) {
				on = false;
				scaleX = 1;
				scaleY = 1;
			} else {
				on = true;
				scaleX = scaleWhenDown;
				scaleY = scaleWhenDown;
			}
		}
		
		public function get off():Boolean 
		{
			return !on;
		}
		
	}

}