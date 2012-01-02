package mvc
{
	import flash.events.Event;
	/**
	 * ...
	 * @author OML!
	 */
	public class GameModel 
	{
		private var _zombies  : Vector.<Zombie>   = new Vector.<Zombie>();
		private var _surviors : Vector.<Survivor> = new Vector.<Survivor>();
		
		private var _boxes : Vector.<Box> = new Vector.<Box>();
		
		private var _map : Map = new Map(); 
		
		public function GameModel() 
		{
			//TEST ZOMBIE
			var zombie :Zombie = new Zombie(1, 2);			
			
			//TEST SURVIVOR
			var survivor : Survivor = new Survivor(15, 10);
			
			//TEST BLOCKERS
			var block1 : Box = new Box(7, 3);
			var block2 : Box = new Box(7, 4);
			var block3 : Box = new Box(7, 5);
			var block4 : Box = new Box(7, 6);
			var block5 : Box = new Box(7, 7);
			var block6 : Box = new Box(7, 8);
			
			zombies.push(zombie);
			surviors.push(survivor);
			
			boxes.push(block1);
			boxes.push(block2);
			boxes.push(block3);
			boxes.push(block4);
			boxes.push(block5);
			boxes.push(block6);
		}
		
		public function update(e: Event) : void
		{
			
		}
		
		public function get map():Map 
		{
			return _map;
		}
		
		public function get zombies():Vector.<Zombie> 
		{
			return _zombies;
		}
		
		public function set zombies(value:Vector.<Zombie>):void 
		{
			_zombies = value;
		}
		
		public function get surviors():Vector.<Survivor> 
		{
			return _surviors;
		}
		
		public function set surviors(value:Vector.<Survivor>):void 
		{
			_surviors = value;
		}
		
		public function get boxes():Vector.<Box> 
		{
			return _boxes;
		}
		
		public function set boxes(value:Vector.<Box>):void 
		{
			_boxes = value;
		}
	}

}