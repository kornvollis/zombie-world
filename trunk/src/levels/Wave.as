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
		
		private var spawnTimer : Timer;
		
		private var spawnTimerTrigger : Timer;
		
		private var row : int;
		private var col : int;
		
		
		public function Wave(startTimeSec : int, num : int, spawnDelayMilliSec: Number, enemy : Zombie, row:int, col:int) 
		{
			this.row = row;
			this.col = col;
			
			spawnTimerTrigger = new Timer(startTimeSec * 1000,1);
			spawnTimerTrigger.addEventListener(TimerEvent.TIMER, startWave);
			
			spawnTimer = new Timer(spawnDelayMilliSec, num);
			spawnTimer.addEventListener(TimerEvent.TIMER, spawnUnit);
			
			spawnTimerTrigger.start();
		}
		
		private function spawnUnit(e:TimerEvent):void 
		{
			Factory.getInstance().addZombie(row, col);
		}
		
		private function startWave(e:TimerEvent):void 
		{
			spawnTimer.start();
		}
		
	}

}