package levels 
{
	import fl.timeline.TimelineManager;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author OML!
	 */
	public class Wave 
	{
		public var startTime : int = 0;
		
		private var _spawnTimer : Timer;
		private var _spawnTimerTrigger : Timer;
		private var _spawnPoint : SpawnPoint;		
		
		private var _row : int;
		private var _col : int;
		public var enemy : Class;
		
		//FOR COMBOBOX
		public var label : String;
		public var data  : Wave;
		public var icon ;
		
		public function Wave(spawnPoint : SpawnPoint, startTimeSec : int, num : int, spawnDelayMilliSec: Number, enemy : Class) 
		{
			this.enemy = enemy;
			this.spawnPoint = spawnPoint;
			this.row = spawnPoint.row;
			this.col = spawnPoint.col;
			
			this.data = this;
			this.label = "S: " + startTimeSec + " | " + "#: " + num + " | " + "D: " + spawnDelayMilliSec + "T: " + enemy;
			
			spawnTimerTrigger = new Timer(startTimeSec * 1000,1);
			spawnTimerTrigger.addEventListener(TimerEvent.TIMER, startWave);
			
			spawnTimer = new Timer(spawnDelayMilliSec, num);
			spawnTimer.addEventListener(TimerEvent.TIMER, spawnUnit);
			
			spawnTimerTrigger.start();
		}
		
		public function setStartTime(sec : int):void 
		{
			_spawnTimerTrigger.delay = sec;
		}
		
		public function setDelay(delay:int):void 
		{
			spawnTimer.delay = delay;
		}
		
		private function spawnUnit(e:TimerEvent):void 
		{
			Factory.getInstance().addZombie(row, col);
		}
		
		private function startWave(e:TimerEvent):void 
		{
			spawnTimer.start();
		}
		
		public function get spawnTimer():Timer 
		{
			return _spawnTimer;
		}
		
		public function set spawnTimer(value:Timer):void 
		{
			_spawnTimer = value;
		}
		
		public function get spawnTimerTrigger():Timer 
		{
			return _spawnTimerTrigger;
		}
		
		public function set spawnTimerTrigger(value:Timer):void 
		{
			_spawnTimerTrigger = value;
		}
		
		public function get spawnPoint():SpawnPoint 
		{
			return _spawnPoint;
		}
		
		public function set spawnPoint(value:SpawnPoint):void 
		{
			_spawnPoint = value;
		}
		
		public function get row():int 
		{
			return _row;
		}
		
		public function set row(value:int):void 
		{
			_row = value;
		}
		
		public function get col():int 
		{
			return _col;
		}
		
		public function set col(value:int):void 
		{
			_col = value;
		}
		
	}

}