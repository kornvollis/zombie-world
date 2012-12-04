package ui.waveEditor 
{
	import fl.controls.Label;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventPhase;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import org.as3commons.collections.ArrayList;
	/**
	 * ...
	 * @author OML!
	 */
	public class WaveEditWindow extends Sprite
	{		
		private var intervall : uint = 6; // MINUTES
		private var _width : uint = 600;
		private var _height : uint = 500;
		private var addWaveButton : AddWaveButton;
		private var rowHeight : uint;
		private var _newWaveDraggedOver : Boolean = false;
		
		// GRAPHICS
		private var table : Sprite = new Sprite();
		private var gridLines : Sprite = new Sprite();
		private var labels : Sprite = new Sprite();
		private var waves : ArrayList = new ArrayList();
		
		public var newWaveGhost : Sprite = new Sprite();
		
		// SIZES 
		private var slotWidth  : uint;
		private var slotHeight : uint;
		
		// MOUSE STATE
		
		
		public function WaveEditWindow(_width:uint, _height:uint, intervall:uint) 
		{
			this.intervall = intervall;
			this._height   = _height;
			this._width    = _width;
			
			
			slotWidth  = _width / 60;
			slotHeight = _height / intervall;
			
			rowHeight = _height / intervall;
			addWaveButton  = new AddWaveButton(150, rowHeight);
			
			// POSITIONING
			addWaveButton.y = - rowHeight - 10;
			
			// LISTENERS
			addEventListener(Event.ADDED_TO_STAGE, onAdd);
			
			
			// GRAPHICS
			newWaveGhost.visible = false;
			gridLines.mouseEnabled = false;
			
			addChild(labels);
			addChild(table);
			addChild(gridLines);
			addChild(newWaveGhost);
			
			drawGraphics();
		}
		
		private function onAdd(e:Event):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, onAdd);
			stage.addEventListener(MouseEvent.MOUSE_MOVE, onMove);
			stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUP);
		}
		
		private function onMouseUP(e:MouseEvent):void 
		{		
			if (newWaveDraggedOver) {
				// INIT
				var worldPosition : Point = new Point(e.currentTarget.mouseX, e.currentTarget.mouseY);
				var tablePosition : Point = table.globalToLocal(worldPosition);
				
				var startTime : int = tablePositionToStartTime(tablePosition);
				
				// CREATE NEW SLIDER
				createSlider(startTime, startTime + 5, 10);
				
				newWaveDraggedOver = false;
			}
		}
		
		private function createSlider(startTime:int, endTime:uint, numOfEnemies:uint):void 
		{
			
			
			
			var nw : WaveSlider = new WaveSlider(startTime, endTime, numOfEnemies, slotWidth, slotHeight );
			nw.drawGraphics();
			
			// SLIDER POSITION
			var row : uint = startTime / 60;
			var horizontalPos : Number = (_width / 60) * (startTime % 60);
			
			nw.x = horizontalPos;
			nw.y = row * rowHeight;
			
			//SET CALL BACK
			nw.moveToCallBack = moveSlider;
			nw.adjustLeftSizeCallBack = adjustLeftSizeCallBack;
			
			table.addChild(nw);
			waves.add(nw);
		}
		
		public function adjustLeftSizeCallBack(e:MouseEvent, waveSlider : WaveSlider):void
		{
			var mouseStagePos : Point = new Point(e.currentTarget.mouseX, e.currentTarget.mouseY);
			var mouseSliderPos : Point = table.globalToLocal(mouseStagePos);
			
			//trace(mouseSliderPos.x + " " + mouseSliderPos.x);
			// CALCULATE TIME
			if (mouseSliderPos.x < 0) mouseSliderPos.x = 0;
			if (mouseSliderPos.x > _width) mouseSliderPos.x = _width;
			
			if (mouseSliderPos.y < 0) mouseSliderPos.y = 0;
			if (mouseSliderPos.y > _height) mouseSliderPos.y = _height;
			
			var currentTime : int = int(mouseSliderPos.x / slotWidth);
			currentTime += int(mouseSliderPos.y / slotHeight) * 60;			
			
			//var difference : int = mouseSliderPos.x / (_width / 60);
			trace(currentTime);
			
			waveSlider.startTime = currentTime;
			waveSlider.x = (waveSlider.startTime % 60) * slotWidth;
		}
		
		public function moveSlider(e:MouseEvent, waveSlider : WaveSlider):void
		{
			var worldPosition : Point = new Point(e.currentTarget.mouseX, e.currentTarget.mouseY);
			var tablePosition : Point = table.globalToLocal(worldPosition);
			// SET DRAG OFFSET 
			tablePosition.x -= waveSlider.dragPoint.x;
			//tablePosition.y -= waveSlider.dragPoint.y;
			
			var startTime : int = tablePositionToStartTime(tablePosition);
			
			trace(startTime);
						
			waveSlider.startTime = startTime;
			waveSlider.endTime = startTime + waveSlider.duration;
			
			if (int(waveSlider.startTime / 60) != int(waveSlider.endTime / 60))
			{
				trace("ujsor");
			}
			
			
			setWaveSliderPosition(waveSlider);
		}
		
		private function setWaveSliderPosition(waveSlider:WaveSlider):void 
		{
			waveSlider.x = (waveSlider.startTime % 60) * slotWidth;
			waveSlider.y = int(waveSlider.startTime / 60) * slotHeight;
		}
		
		private function onMove(e:MouseEvent):void 
		{
			if (newWaveDraggedOver)
			{
				newWaveGhost.visible = true;
				
				var properPosition : Point = new Point(e.currentTarget.mouseX, e.currentTarget.mouseY);
				properPosition = table.globalToLocal(properPosition);
				
				// CALCULATE X
				properPosition.x = properPosition.x - (properPosition.x % (_width / 60));
				if (properPosition.x < 0)  properPosition.x = 0;
				if (properPosition.x > _width) {
					properPosition.x  = _width;
				}
				properPosition.x = properPosition.x - (properPosition.x % (_width/60));
				
				// CALCULATE Y
				var row : int = int(properPosition.y / rowHeight);
				if (row < 0 ) row = 0;
				if (row >= intervall) row = intervall-1;
				
				properPosition.y = row * rowHeight;
				
				// SHOW NEW WAVE GHOST
				newWaveGhost.x = properPosition.x;
				newWaveGhost.y = properPosition.y;
			}
		}
		
		private function tablePositionToStartTime(position : Point) : int 
		{
			if (position.x < 0) position.x = 0;
			if (position.x > _width) position.x = _width-1;
			
			if (position.y < 0) position.y = 0;
			if (position.y > _height) position.y = _height;
			
			var row : int = int(position.y / slotHeight);
			if (row >= intervall) row = intervall - 1;
			
			var time : int = int(position.x / slotWidth) + row * 60;
			
			return time;
		}
		
		private function drawGraphics():void 
		{
			//DRAWING THE BASE BODER
			this.graphics.beginFill(0xd4dbca);
			this.graphics.drawRect(0, 0, _width, _height);
			
			//DRAWING THE LINES		
			gridLines.graphics.lineStyle(2, 0x000000);
			gridLines.graphics.drawRect(0, 0, _width, _height);
			
			for (var i:int = 1; i <= intervall; i++) 
			{
				var lineHeight : uint = i * rowHeight;
				if(i!= intervall) {
					gridLines.graphics.moveTo(0, lineHeight);
					gridLines.graphics.lineTo(_width, lineHeight);
				}
				
				var leftSideTime : Label = new Label();
				var rightSideTime : Label = new Label();
				leftSideTime.text = String((i - 1) * 60);
				rightSideTime.text = String(i * 60 - 1);
				leftSideTime.y = lineHeight - 0.5 * rowHeight;
				leftSideTime.x = -30;
				rightSideTime.y = leftSideTime.y
				rightSideTime.x = _width + 10;
				labels.addChild(leftSideTime);
				labels.addChild(rightSideTime);
			}
			
			table.graphics.lineStyle(1, 0x000000, 0.6);
			for (var k:int = 0; k < 60; k++) 
			{
				if (k % 10 == 0)
				{
					table.graphics.lineStyle(1, 0xFF0000, 0.8);
				} else {
					if (k % 5 == 0) {
						table.graphics.lineStyle(1, 0x000000, 0.2);
					} else {
						table.graphics.lineStyle(1, 0x000000, 0.1);
					}
				}
				table.graphics.moveTo(k * slotWidth, 0);
				table.graphics.lineTo(k * slotWidth, _height);
			}
				
			
			//SPRITE GHOST GRAPHICS
			newWaveGhost.graphics.beginFill(0x00FF00, 1);
			newWaveGhost.graphics.drawRect(-1, 0, 3, rowHeight);
			//newWaveGhost.graphics.lineStyle(1, 0x000000);
			newWaveGhost.mouseEnabled = false;
		}
		
		public function get newWaveDraggedOver():Boolean 
		{
			return _newWaveDraggedOver;
		}
		
		public function set newWaveDraggedOver(value:Boolean):void 
		{
			if (!value) {
				newWaveGhost.visible = false;
			}
			
			_newWaveDraggedOver = value;
		}
		
	}

}
