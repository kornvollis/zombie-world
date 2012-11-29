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
		private var endTime : uint;
		private var numOfEnemies : uint;
		private var _density : uint;
		private var leftSide : MovieClip = new MovieClip();
		private var rightSide : Sprite = new Sprite();		
		
		// MOUSE DOWNS
		private var isMouseDown        : Boolean = false;
		private var isLeftHandlerDown  : Boolean = false;
		private var isRightHandlerDown : Boolean = false;
		
		// SLOT SIZE
		private var slotWidth:uint;
		private var slotHeight:uint;
		
		public var moveToCallBack : Function = null;
		public var adjustLeftSizeCallBack : Function = null;
		public var dragPoint :Point = new Point();
		
		public function WaveSlider(startTime: uint, numOfEnemies: uint, density: uint, slotWidth: uint, slotHeight:uint) 
		{
			this.slotHeight = slotHeight;
			this.slotWidth = slotWidth;
			this.density = density;
			this.numOfEnemies = numOfEnemies;
			this.startTime = startTime;
			
			endTime = startTime + (numOfEnemies * density) / 1000;
			
			// EVENTLISTENERS
			addEventListener(MouseEvent.CLICK, onClick);
			leftSide.addEventListener(MouseEvent.MOUSE_DOWN, onLeftClick);
			
			addEventListener(MouseEvent.MOUSE_DOWN, onDown);
			addEventListener(Event.ADDED_TO_STAGE, onAdd);
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
			dragPoint.x = e.localY;
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
		
		public function drawGraphics() : void {
			
			var durationSec : uint = (numOfEnemies * density) / 1000;
			
			graphics.beginFill(0xFFFFFF);
			
			var innerWidth : uint = (durationSec - 2) * slotWidth;
			
			if (innerWidth < 3 * slotWidth) innerWidth = 3 * slotWidth;
			
			graphics.drawRect(slotWidth, 0, innerWidth, slotHeight);
			
			// DRAW LEFT RIGHT HANDLERS
			leftSide.graphics.beginFill(0xFF0000, 1);
			leftSide.graphics.drawRect(0, 0, slotWidth, slotHeight);
			
			rightSide.graphics.beginFill(0xFF0000, 1);
			rightSide.graphics.drawRect(0, 0, slotWidth, slotHeight);
			
			rightSide.x = innerWidth + slotWidth;
			//leftSide.x = handlerWidth/2;
			
			addChild(rightSide);
			addChild(leftSide);
		}
		
		public function get startTime():uint 
		{
			return _startTime;
		}
		
		public function set startTime(value:uint):void 
		{
			_startTime = value;
			
			//drawGraphics();
		}
		
		public function get density():uint 
		{
			return _density;
		}
		
		public function set density(value:uint):void 
		{
			_density = value;
		}
	}

}