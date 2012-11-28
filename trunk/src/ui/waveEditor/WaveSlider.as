package ui.waveEditor 
{
	import flash.display.CapsStyle;
	import flash.display.LineScaleMode;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author OML!
	 */
	public class WaveSlider extends MovieClip 
	{
		private const MIN_WIDTH : uint = 60;
		
		private var startTime : uint;
		private var endTime : uint;
		private var numOfEnemies : uint;
		private var density : uint;
		private var leftSide : Sprite = new Sprite();
		private var rightSide : Sprite = new Sprite();		
		private var isMouseDown : Boolean = false;
		
		public var moveToCallBack : Function = null;
		
		public function WaveSlider(startTime: uint, numOfEnemies: uint, density: uint) 
		{
			this.density = density;
			this.numOfEnemies = numOfEnemies;
			this.startTime = startTime;
			
			endTime = startTime + (numOfEnemies * density) / 1000;
			addEventListener(MouseEvent.CLICK, onClick);
			addEventListener(MouseEvent.MOUSE_DOWN, onDown);
			
			addEventListener(Event.ADDED_TO_STAGE, onAdd);
		}
		
		private function onMove(e:MouseEvent):void 
		{
			if (moveToCallBack != null && isMouseDown)
			{
				moveToCallBack(e, this);
			}
		}
		
		private function onDown(e:MouseEvent):void 
		{
			isMouseDown = true;
			
			//mouseEnabled = false;
			stage.mouseChildren = false;
		}
		
		private function onAdd(e:Event):void 
		{
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUp);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMove);
		}
		
		private function onMouseUp(e:MouseEvent):void 
		{
			isMouseDown = false;
			
			stage.mouseChildren = true;
		}
		
		private function onClick(e:MouseEvent):void 
		{
			
		}
		
		public function drawGraphics(_width: uint, _height: uint) : void {
			graphics.beginFill(0xFFFFFF);
			graphics.drawRect(0, 0, _width, _height);
			
			// DRAW LEFT RIGHT HANDLERS
			var handlerWidth :uint = 10;
			var color :uint = 0xFF0000;
			
			leftSide.graphics.lineStyle(handlerWidth, color, 1, false, LineScaleMode.NORMAL, CapsStyle.NONE);
			leftSide.graphics.moveTo(0, 0);
			leftSide.graphics.lineTo(0, _height);
			
			rightSide.graphics.lineStyle(handlerWidth, color, 1, false, LineScaleMode.NORMAL, CapsStyle.NONE);
			rightSide.graphics.moveTo(0, 0);
			rightSide.graphics.lineTo(0, _height);
			
			rightSide.x = _width - handlerWidth / 2;
			leftSide.x = handlerWidth/2;
			
			addChild(rightSide);
			addChild(leftSide);
		}
	}

}