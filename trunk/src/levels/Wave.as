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
		public var spawnTimer : Timer;
		public var spawnTimerTrigger : Timer;
		public var spawnPoint : SpawnPoint;		
		public var startTimeSec:int = 0;
		public var spawnDelayMilliSec : Number;
		
		public var row : int;
		public var col : int;
		public var numOfEnemies:int;
		public var TypeOfEnemy : Class;
		
		//FOR COMBOBOX
		public var label : String;
		public var data  : Wave;
		public var icon : Object;
		
		
		public function Wave(spawnPoint : SpawnPoint, startTimeSec : int, num : int, spawnDelayMilliSec: Number, enemy : Class) 
		{
			this.startTimeSec = startTimeSec;
			this.spawnDelayMilliSec = spawnDelayMilliSec;
			this.numOfEnemies = num;
			this.TypeOfEnemy = enemy;
			this.spawnPoint = spawnPoint;
			this.row = spawnPoint.row;
			this.col = spawnPoint.col;
			
			this.data = this;
			this.label = "S: " + startTimeSec + " | " + "#: " + num + " | " + "D: " + spawnDelayMilliSec + " T: " + enemy;
			
			spawnTimerTrigger = new Timer(startTimeSec * 1000,1);
			spawnTimerTrigger.addEventListener(TimerEvent.TIMER, startWave);
			
			spawnTimer = new Timer(spawnDelayMilliSec, num);
			spawnTimer.addEventListener(TimerEvent.TIMER, spawnUnit);
			
			//spawnTimerTrigger.start();
		}
		
		public function start() : void
		{
			spawnTimerTrigger.reset();
			spawnTimer.reset();
			
			spawnTimerTrigger.start();
		}
		
		public function setStartTime(sec : int):void 
		{
			startTimeSec = sec;
			spawnTimerTrigger.delay = sec;
		}
		
		public function setDelay(delay:int):void 
		{
			this.spawnDelayMilliSec = delay;
			spawnTimer.delay = delay;
		}
		
		public function refreshLabel():void 
		{
			this.label = "S: " + startTimeSec + " | " + "#: " + numOfEnemies + " | " + "D: " + spawnDelayMilliSec + "T: " + TypeOfEnemy;
		}
		
		private function spawnUnit(e:TimerEvent):void 
		{
			Factory.getInstance().addEnemy(row, col, TypeOfEnemy);
		}
		
		private function startWave(e:TimerEvent):void 
		{
			spawnTimer.start();
		}
		
		
		
	}

}