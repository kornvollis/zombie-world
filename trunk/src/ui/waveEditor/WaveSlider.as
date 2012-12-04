package ui.waveEditor 
{
	import flash.display.CapsStyle;
	import flash.display.LineScaleMode;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventPhase;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import ui.UI;
	
	/**
	 * ...
	 * @author OML!
	 */
	public class WaveSlider extends MovieClip 
	{
		private const MIN_WIDTH : uint = 50;
			
		private var _startTime : uint;
		private var _density : uint;
		
		private var _endTime : uint;
		private var numOfEnemies : uint;
		
		private var leftSide  : Sprite = new Sprite();
		private var rightSide : Sprite = new Sprite();		
		
		// MOUSE DOWNS
		private var isMouseDown        : Boolean = false;
		private var isLeftHandlerDown  : Boolean = false;
		private var isRightHandlerDown : Boolean = false;
		
		// SLOT SIZE
		private var slotWidth:uint;
		private var slotHeight:uint;
		
		// GRAPHICS	
		public var duration : int;
		public var moveToCallBack : Function = null;
		public var adjustLeftSizeCallBack : Function = null;
		public var dragPoint :Point = new Point();
		
		public function WaveSlider(startTime: uint, endTime: uint, numOfEnemies: uint, slotWidth: uint, slotHeight:uint) 
		{
			this.numOfEnemies = numOfEnemies;
			this._startTime    = startTime;
			this.endTime      = endTime;
			
			this.slotHeight   = slotHeight;
			this.slotWidth    = slotWidth;
			
			this.duration = endTime - startTime;
			
			endTime = startTime + (numOfEnemies * density) / 1000;
			
			// EVENTLISTENERS
			addEventListener(MouseEvent.CLICK, onClick);
			leftSide.addEventListener(MouseEvent.MOUSE_DOWN, onLeftClick);
			
			addEventListener(MouseEvent.MOUSE_DOWN, onDown);
			addEventListener(Event.ADDED_TO_STAGE, onAdd);
			
			// SET POSITION
			x = slotWidth * (startTime % 60);
			y = int(startTime / 60) * slotHeight;
			
			// GRAPHICS
			addChild(rightSide);
			addChild(leftSide);
		}
		
		private function onLeftClick(e:MouseEvent):void 
		{
			trace("left down");
			
			isLeftHandlerDown = true;
			
			e.stopPropagation();
		}
		
		private function onMove(e:MouseEvent):void 
		{
			if (moveToCallBack != null && isMouseDown) {
				moveToCallBack(e, this);
			} else if (adjustLeftSizeCallBack != null && isLeftHandlerDown ) {
				adjustLeftSizeCallBack(e, this);
			}
		}
		
		private function onDown(e:MouseEvent):void 
		{
			isMouseDown = true;
			dragPoint.x = e.localX;
			dragPoint.y = e.localY;
		}
		
		private function onAdd(e:Event):void 
		{
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMove);
		}
		
		private function onMouseUp(e:MouseEvent):void 
		{
			isMouseDown        = false;
			isLeftHandlerDown  = false;
			isRightHandlerDown = false;
		}
		
		private function onClick(e:MouseEvent):void 
		{
			trace("onclick");
		}
		
		public function refresh() : void {
			x = slotWidth * (startTime % 60);
			y = int(startTime / 60) * slotHeight;	
		}
		
		public function drawGraphics() : void {
			
			graphics.clear();
			graphics.beginFill(0xFFFFFF);
			
			var innerWidth : uint = (endTime-startTime - 2) * slotWidth;
			
			if (innerWidth < 3 * slotWidth) innerWidth = 3 * slotWidth;
			
			graphics.drawRect(slotWidth, 0, innerWidth, slotHeight);
			
			// DRAW LEFT RIGHT HANDLERS
			leftSide.graphics.beginFill(0xFF0000, 1);
			leftSide.graphics.drawRect(0, 0, slotWidth, slotHeight);
			
			rightSide.graphics.beginFill(0xFF0000, 1);
			rightSide.graphics.drawRect(0, 0, slotWidth, slotHeight);
			
			rightSide.x = innerWidth + slotWidth;						
		}
		
		public function get startTime():uint 
		{
			return _startTime;
		}
		
		public function set startTime(value:uint):void 
		{
			_startTime = value;
		}
		
		public function get density():uint 
		{
			return _density;
		}
		
		public function set density(value:uint):void 
		{
			_density = value;
		}
		
		public function get endTime():uint 
		{
			return _endTime;
		}
		
		public function set endTime(newEndTime:uint):void 
		{
			if (int(startTime / 60) != int(newEndTime / 60))
			{
				var reminder : int = newEndTime % 60;
				newEndTime -= reminder;
				startTime -= reminder;
			} 
			
			_endTime = newEndTime;
		}
	}

}