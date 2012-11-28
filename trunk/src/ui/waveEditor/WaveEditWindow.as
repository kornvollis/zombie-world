package ui.waveEditor 
{
	import fl.controls.Label;
	import flash.display.Sprite;
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
		
		
		// MOUSE STATE
		
		
		public function WaveEditWindow(_width:uint, _height:uint, intervall:uint) 
		{
			this.intervall = intervall;
			this._height   = _height;
			this._width    = _width;
			
			rowHeight = _height / intervall;
			addWaveButton  = new AddWaveButton(150, rowHeight);
			
			// POSITIONING
			addWaveButton.y = - rowHeight - 10;
			
			// LISTENERS
			table.addEventListener(MouseEvent.MOUSE_MOVE, onMove);
			table.addEventListener(MouseEvent.MOUSE_UP, onMouseUP);
			
			// GRAPHICS
			newWaveGhost.visible = false;
			gridLines.mouseEnabled = false;
			
			addChild(labels);
			addChild(table);
			addChild(newWaveGhost);
			drawGraphics();
			addChild(gridLines);
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
				var startTime : int = (_width * 60 / positionX) + row * 60;
				var numOfEnemies : uint = 10;
				var density : uint = 200;
				
				// CREATE NEW SLIDER
				createSlider(startTime, numOfEnemies, density, positionX, row);
			}
		}
		
		private function createSlider(startTime:int, numOfEnemies:uint, density:uint, positionX : Number, row : uint):void 
		{
			var nw : WaveSlider = new WaveSlider(startTime, numOfEnemies, density);
			nw.drawGraphics(60, rowHeight);
			
			// SLIDER POSITION
			nw.x = positionX;
			nw.y = row * rowHeight;
			
			//SET CALL BACK
			nw.moveToCallBack = moveSlider;
			
			table.addChild(nw);
			waves.add(nw);
		}
		
		public function moveSlider(e:MouseEvent, waveSlider : WaveSlider):void
		{
			var properPosition : Point = new Point(e.localX, e.localY);
			properPosition = table.globalToLocal(properPosition);
			//properPosition = getProperLocalPositionY(properPosition);
			
			var row: int = properPosition.y / rowHeight;
			
			// X //
			if (properPosition.x < 0) properPosition.x = 0;
			if (properPosition.x > _width - waveSlider.width) properPosition.x = _width - waveSlider.width;
			
			// Y //
			if (row < 0) row = 0;
			else if (row > intervall - 1) row = intervall - 1;
			properPosition.y = row * rowHeight;
			
			var oldPos : Point = new Point(waveSlider.x, waveSlider.y);
			
			waveSlider.x = properPosition.x;
			waveSlider.y = properPosition.y;
			
			// CHECK IF ITS COLLIDE
			/*
			for each (var wave in waves ) 
			{
				if (wave != waveSlider)
				{
					
					if(waveSlider.hitTestObject(wave))
					{
						waveSlider.x = oldPos.x;
						waveSlider.y = oldPos.y;
						return;
					}
				}
			}
			*/
		}
		
		private function onMove(e:MouseEvent):void 
		{
			if (newWaveDraggedOver)
			{
				newWaveGhost.visible = true;
				
				var mousePositionX : Number = e.localX;
				var mousePositionY : Number = e.localY;
				
				// CALCULATE X
				if (mousePositionX > _width - newWaveGhost.width) {
					mousePositionX  = _width - newWaveGhost.width;
				}
				
				// CALCULATE Y
				var row : uint = uint(mousePositionY / rowHeight);
				if (row == intervall) row--;
				var newPosY : int = row*rowHeight;
				
				// SHOW NEW WAVE GHOST
				newWaveGhost.x = mousePositionX;
				newWaveGhost.y = newPosY;
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
				rightSideTime.mouseEnabled = false;
				leftSideTime.mouseEnabled = false;
				labels.addChild(leftSideTime);
				labels.addChild(rightSideTime);
			}
			
			//SPRITE GHOST GRAPHICS
			newWaveGhost.graphics.beginFill(0xFF0000,0.3);
			newWaveGhost.graphics.lineStyle(1, 0x000000);
			newWaveGhost.graphics.drawRect(0, 0, 60, rowHeight);
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