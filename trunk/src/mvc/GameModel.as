package mvc
{
	import flash.display.Stage;
	import flash.events.Event;
	/**
	 * ...
	 * @author OML!
	 */
	public class GameModel 
	{
		public var needUpdate : Boolean = false;
		public var myStage : Stage = null;
		private var _zombies  : Vector.<Zombie>   = new Vector.<Zombie>();
		private var _surviors : Vector.<Survivor> = new Vector.<Survivor>();
		
		private var _boxes : Vector.<Box> = new Vector.<Box>();
		
		private var _map : Map = new Map(); 
		
		public var pathFinder : PathFinder;
		
		public function GameModel() 
		{
			//TEST ZOMBIE
			var zombie :Zombie = new Zombie(1, 2);			
			
			//TEST SURVIVOR
			var survivor : Survivor = new Survivor(15, 10);
			
			//TEST BLOCKERS
			addBox(3,7);
			addBox(4,7);
			addBox(5, 7);
			addBox(6, 7);
			addBox(7, 7);
			addBox(8, 7);
			
			addBox(8, 6);
			addBox(8, 5);
			addBox(8, 4);
			addBox(9, 4);
			addBox(10, 4);
			
			zombies.push(zombie);
			surviors.push(survivor);
			
			
			pathFinder = new PathFinder(this);
		}
		
		public function addBox(row : int , col : int) : void
		{
			
			var block : Box = new Box(row, col);
			map.getCell(row, col).occupied = true;
			boxes.push(block);
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