package massdefense 
{
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;

	public class Wave 
	{
		private var _creepsToSpawn: uint
		private var _timeToNextSpawn : Number;
		
		private var _remainingCreepsToSpawn : uint;
		public var startAfterSecond : Number;
		public var delayBetweenSpawns : Number;
		
		public var row : int;
		public var col : int;
		public var type  : String;		
		public var repeat : int;
		public var repeatAfter : Number;
		
		public function Wave() { }
		
		private function spawnCreep():void 
		{			
			Factory.newCreep(row,col,type);
		}
		
		public function update(passedTime:Number):void 
		{
			if (repeat > 0) {
				timeToNextSpawn -= passedTime;
				
				if (_timeToNextSpawn < 0 && remainingCreepsToSpawn > 0) {
					spawnCreep();
					timeToNextSpawn = delayBetweenSpawns;
					remainingCreepsToSpawn--;
				}
				
				if (remainingCreepsToSpawn == 0) {
					repeat--;
					timeToNextSpawn = repeatAfter;
					remainingCreepsToSpawn = creepsToSpawn;
				}
			}
		}
		
		public function get timeToNextSpawn():Number 
		{
			return _timeToNextSpawn;
		}
		
		public function set timeToNextSpawn(timePassed:Number):void 
		{
			_timeToNextSpawn = timePassed;
		}
		
		public function get creepsToSpawn():uint 
		{
			return _creepsToSpawn;
		}
		
		public function set creepsToSpawn(numberOfCreeps:uint):void 
		{
			_creepsToSpawn = numberOfCreeps;
		}
		
		public function get remainingCreepsToSpawn():uint 
		{
			return _remainingCreepsToSpawn;
		}
		
		public function set remainingCreepsToSpawn(value:uint):void 
		{
			_remainingCreepsToSpawn = value;
		}
		
	}

}