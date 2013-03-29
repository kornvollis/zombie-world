package massdefense 
{
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	/**
	 * ...
	 * @author OMLI
	 */
	public class Wave 
	{
		private var _creepsToSpawn: uint
		private var _timeToNextSpawn : Number;
		
		private var _remainingCreepsToSpawn : uint;
		public var startAfterSecond : int;
		public var delayBetweenSpawns : Number;
		
		public var row : int;
		public var col : int;
		public var TypeOfCreep  : Class;		
		public var CreepAttributes  : Object;		
		
		public function Wave() 
		{
			
		}
		
		private function spawnCreep():void 
		{
			var creepAttributes : Dictionary = new Dictionary();
			creepAttributes["row"] = row;
			creepAttributes["col"] = col;
			
			Factory.spawnCreep(creepAttributes);
		}
		
		private function startWave(e:TimerEvent):void 
		{
			//spawnTimer.start();
		}
		
		public function reset() : void {
			remainingCreepsToSpawn = creepsToSpawn;
			timeToNextSpawn = startAfterSecond;
		}
		
		public function get timeToNextSpawn():Number 
		{
			return _timeToNextSpawn;
		}
		
		public function set timeToNextSpawn(value:Number):void 
		{
			_timeToNextSpawn = value;
			
			if (_timeToNextSpawn < 0 && remainingCreepsToSpawn > 0) {
				spawnCreep();
				_timeToNextSpawn = delayBetweenSpawns;
				remainingCreepsToSpawn--;
			}
			
		}
		
		public function get creepsToSpawn():uint 
		{
			return _creepsToSpawn;
		}
		
		public function set creepsToSpawn(numberOfCreeps:uint):void 
		{
			_creepsToSpawn = numberOfCreeps;
			remainingCreepsToSpawn = numberOfCreeps;
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