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
	public class WaveEditor extends Sprite
	{		
		public static const TIME_INTERVALL : uint = 6;
		public static const WIDTH  : uint = 600;
		public static const HEIGHT : uint = 500;
		
		private var intervall : uint = 6; // MINUTES
		
		private var addWaveButton : AddWaveButton = new AddWaveButton(100, 100);
		private var _newWaveDraggedOver : Boolean = false;
		
		// GRAPHICS
		private var table : Sprite = new Sprite();
		private var gridLines : Sprite = new Sprite();
		private var labels : Sprite = new Sprite();
		private var waves : ArrayList = new ArrayList();
		
		public  var newWaveGhost : Sprite = new Sprite();
		private var options : WaveOptions = new WaveOptions();	
			
		// SIZES 
		private var slotWidth  : uint;
		private var slotHeight : uint;
		
		// MOUSE STATE
		
		
		public function WaveEditor() 
		{
			this.intervall = intervall;
			
			
			slotWidth  = WIDTH / 60;
			slotHeight = HEIGHT / intervall;
			
			addWaveButton  = new AddWaveButton(150, slotHeight);
			
			// POSITIONING
			addWaveButton.y = - slotHeight - 10;
			
			// LISTENERS
			addEventListener(Event.ADDED_TO_STAGE, onAdd);
			addWaveButton.addEventListener(MouseEvent.MOUSE_DOWN, onAddWaveMD);
			
			// GRAPHICS
			newWaveGhost.visible = false;
			options.visible = false;
			gridLines.mouseEnabled = false;
			
			addChild(labels);
			addChild(table);
			addChild(gridLines);
			addChild(newWaveGhost);
			addChild(addWaveButton);
			addChild(options);
			
			drawGraphics();
		}
		
		private function onAddWaveMD(e:MouseEvent):void 
		{
			newWaveDraggedOver = true;
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
			
			//SET CALL BACK
			nw.moveToCallBack = moveSlider;
			nw.adjustLeftSizeCallBack = adjustLeftSizeCallBack;
			nw.adjustRightSizeCallBack = adjustRightSizeCallBack;
			nw.clickCallBack = sliderClick;
			
			// REFRESH THE NEW POS
			nw.refresh();
			
			table.addChild(nw);
			waves.add(nw);
		}
		
		public function sliderClick (e:MouseEvent, waveSlider : WaveSlider):void
		{
			options.visible = true;
		}
		
		public function adjustRightSizeCallBack(e:MouseEvent, waveSlider : WaveSlider):void
		{
			// POSITIONS
			var worldPosition : Point = new Point(e.currentTarget.mouseX, e.currentTarget.mouseY);
			var tablePosition : Point = table.globalToLocal(worldPosition);
			
			// SET NEW TIMES
			var endTime : int = tablePositionToStartTime(tablePosition) + 1;
			
			
			
			if(endTime >= waveSlider.startTime + 5 && endTime - waveSlider.startTime < 60)
			{				
				waveSlider.endTime = endTime;
				waveSlider.duration = waveSlider.endTime - waveSlider.startTime;
				
				// REFRESH THE POS
				waveSlider.drawGraphics();
				waveSlider.refresh();
			}
		}
		
		public function adjustLeftSizeCallBack(e:MouseEvent, waveSlider : WaveSlider):void
		{
			// POSITIONS
			var worldPosition : Point = new Point(e.currentTarget.mouseX, e.currentTarget.mouseY);
			var tablePosition : Point = table.globalToLocal(worldPosition);
			
			// SET NEW TIMES
			var startTime : int = tablePositionToStartTime(tablePosition);
			
			if(startTime <= waveSlider.endTime - 5 && waveSlider.endTime - startTime < 60)
			{
				waveSlider.startTime = startTime;
				waveSlider.duration = waveSlider.endTime - waveSlider.startTime;
				
				// REFRESH THE POS
				waveSlider.drawGraphics();
				waveSlider.refresh();
			}
		}
		
		public function moveSlider(e:MouseEvent, waveSlider : WaveSlider):void
		{
			// POSITIONS
			var worldPosition : Point = new Point(e.currentTarget.mouseX, e.currentTarget.mouseY);
			var tablePosition : Point = table.globalToLocal(worldPosition);
			
			// SET DRAG OFFSET 
			tablePosition.x -= waveSlider.dragPoint.x;
			
			// SET NEW TIMES
			var startTime : int = tablePositionToStartTime(tablePosition);
			waveSlider.startTime = startTime;
			waveSlider.endTime = startTime + waveSlider.duration;
			
			// REFRESH THE POS
			waveSlider.refresh();
		}
		
		private function onMove(e:MouseEvent):void 
		{
			if (newWaveDraggedOver)
			{
				newWaveGhost.visible = true;
				
				var properPosition : Point = new Point(e.currentTarget.mouseX, e.currentTarget.mouseY);
				properPosition = table.globalToLocal(properPosition);
				
				// CALCULATE X
				properPosition.x = properPosition.x - (properPosition.x % (WIDTH / 60));
				if (properPosition.x < 0)  properPosition.x = 0;
				if (properPosition.x > WIDTH) {
					properPosition.x  = WIDTH;
				}
				properPosition.x = properPosition.x - (properPosition.x % (WIDTH/60));
				
				// CALCULATE Y
				var row : int = int(properPosition.y / slotHeight);
				if (row < 0 ) row = 0;
				if (row >= intervall) row = intervall-1;
				
				properPosition.y = row * slotHeight;
				
				// SHOW NEW WAVE GHOST
				newWaveGhost.x = properPosition.x;
				newWaveGhost.y = properPosition.y;
			}
		}
		
		private function tablePositionToStartTime(position : Point) : int 
		{
			// MAGIC -2
			if (position.x < 0) position.x = 0;
			if (position.x > WIDTH-2) position.x = WIDTH-2;
			
			if (position.y < 0) position.y = 0;
			if (position.y > HEIGHT) position.y = HEIGHT;
			
			var row : int = int(position.y / slotHeight);
			if (row >= intervall) row = intervall - 1;
			
			var time : int = int(position.x / slotWidth) + row * 60;
			
			return time;
		}
		
		private function drawGraphics():void 
		{
			//DRAWING THE BASE BODER
			this.graphics.beginFill(0xd4dbca);
			this.graphics.drawRect(0, 0, WIDTH, HEIGHT);
			
			//DRAWING THE LINES		
			gridLines.graphics.lineStyle(2, 0x000000);
			gridLines.graphics.drawRect(0, 0, WIDTH, HEIGHT);
			
			for (var i:int = 1; i <= intervall; i++) 
			{
				var lineHeight : uint = i * slotHeight;
				if(i!= intervall) {
					gridLines.graphics.moveTo(0, lineHeight);
					gridLines.graphics.lineTo(WIDTH, lineHeight);
				}
				
				var leftSideTime : Label = new Label();
				var rightSideTime : Label = new Label();
				
				leftSideTime.mouseEnabled = false;
				rightSideTime.mouseEnabled = false;
				
				leftSideTime.text = String((i - 1) * 60);
				rightSideTime.text = String(i * 60 - 1);
				leftSideTime.y = lineHeight - 0.5 * slotHeight;
				leftSideTime.x = -30;
				rightSideTime.y = leftSideTime.y
				rightSideTime.x = WIDTH + 10;
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
				table.graphics.lineTo(k * slotWidth, HEIGHT);
			}
				
			
			//SPRITE GHOST GRAPHICS
			newWaveGhost.graphics.beginFill(0x00FF00, 1);
			newWaveGhost.graphics.drawRect(-1, 0, 3, slotHeight);
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
