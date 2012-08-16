package levels 
{
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author OML!
	 */
	public class NewWave 
	{
		private var spawnPoint : SpawnPoint;
		
		private var waveStart : Timer;
		private var spawner : Timer;
		private var enemySpawnPerMin:int;
		private var enemyNum:int;
		private var enemyClass:Class;
		
		
		public function NewWave(spawnPoint : SpawnPoint, startTime : int, enemyClass : Class, enemySpawnPerMin : int, enemyNum : int) 
		{
			this.enemyClass = enemyClass;
			this.enemyNum = enemyNum;
			this.enemySpawnPerMin = enemySpawnPerMin;
			waveStart = new Timer(startTime * 1000, 1);
			waveStart.addEventListener(TimerEvent.TIMER, spawnWave);
		}
		
		private function spawnWave(e:TimerEvent):void 
		{
			//trace("wave start");
			spawner = new Timer(Number(enemySpawnPerMin) / 60 * 1000, enemyNum);
			spawner.addEventListener(TimerEvent.TIMER, spawnEnemy);
			spawner.start();
		}
		
		private function spawnEnemy(e:TimerEvent):void 
		{
			//trace("spawn enemy");
		}
		
		public function startWave() : void
		{
			waveStart.start();
		}
	}

}