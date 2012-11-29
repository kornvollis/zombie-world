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
			table.addEventListener(MouseEvent.MOUSE_UP, onMouseUP);
			
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
		}
		
		private function onMouseUP(e:MouseEvent):void 
		{			
			if (newWaveDraggedOver) {
				
				// INIT
				var positionX : Number = e.localX;
				var positionY : Number = e.localY;
				var row : uint = uint(positionY / rowHeight);
				
				if (positionX > _width - newWaveGhost.width) {
					positionX  = _width - newWaveGhost.width;
				}
				
				// DATA
				var startTime : int = (positionX * 60 / _width) + row * 60;
				var numOfEnemies : uint = 10;
				var density : uint = 200;
				
				// CREATE NEW SLIDER
				createSlider(startTime, numOfEnemies, density);
			}
		}
		
		private function createSlider(startTime:int, numOfEnemies:uint, density:uint):void 
		{
			var nw : WaveSlider = new WaveSlider(startTime, numOfEnemies, density, slotWidth, slotHeight );
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
			var mouseStagePos : Point = new Point(e.currentTarget.mouseX, e.currentTarget.mouseX);
			var mouseSliderPos : Point = waveSlider.globalToLocal(mouseStagePos);
			
			//trace(mouseSliderPos.x + " " + mouseSliderPos.x);
			
			var difference : int = mouseSliderPos.x / (_width / 60);
			trace(difference);
			
			waveSlider.startTime -= difference;
			
			//re pos
			waveSlider.x += difference * (_width / 60);
		}
		
		public function moveSlider(e:MouseEvent, waveSlider : WaveSlider):void
		{
			if (e.eventPhase == EventPhase.AT_TARGET || true)
			{
				//trace("Target: " + e.currentTarget);
				//trace("Phase: " + e.eventPhase + " target: " + e.currentTarget +  " --- " + e.localX + ", " + e.localY);
				//trace(e.currentTarget.mouseX + " " + e.currentTarget.mouseY);
				
				var properPosition : Point = new Point(e.currentTarget.mouseX - waveSlider.dragPoint.x, e.currentTarget.mouseY - waveSlider.dragPoint.y);
				properPosition = table.globalToLocal(properPosition);
				
				var row: int = properPosition.y / rowHeight;
				
				// X //
				if (properPosition.x < 0) properPosition.x = 0;
				if (properPosition.x > _width - waveSlider.width) properPosition.x = _width - waveSlider.width;
				
				properPosition.x = properPosition.x - (properPosition.x % (_width/60));
				
				// Y //
				if (row < 0) row = 0;
				else if (row > intervall - 1) row = intervall - 1;
				properPosition.y = row * rowHeight;
				
				waveSlider.x = properPosition.x;
				waveSlider.y = properPosition.y;
				
				// TODO Change timeproperty !!!
			}
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

		private function drawGraphics():void 
		{
			//DRAWING THE BASE BODER
			table.graphics.beginFill(0xd4dbca);
			//table.graphics.lineStyle(2, 0x000000);
			table.graphics.drawRect(0, 0, _width, _height);
			
			//DRAWING THE LINES		
			gridLines.graphics.lineStyle(2, 0x000000);
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
			
			// SEC LINES
			table.graphics.lineStyle(1, 0x000000, 0.3);
			for (var j : Number  = 1; j < 60; j++) 
			{
				table.graphics.moveTo(j * (_width / 60), 0);
				table.graphics.lineTo(j * (_width / 60), _height);
				
				table.graphics.lineStyle(1, 0x000000, 0.3);
			}
			// DRAW SEC STUFF
			
			
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