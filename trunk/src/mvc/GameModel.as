package mvc
{
	import flash.display.Stage;
	import flash.events.Event;
	import debug.ZDebug;
	/**
	 * ...
	 * @author OML!
	 */
	public class GameModel 
	{
		public var myStage : Stage = null;
		
		private var _zombies  : Vector.<Zombie>   = new Vector.<Zombie>();
		private var _surviors : Vector.<Survivor> = new Vector.<Survivor>();
		private var _boxes : Vector.<Box> = new Vector.<Box>();
		
		private var _map : Map = new Map(); 
		
		public var pathFinder : PathFinder;
		public var needPathUpdate : Boolean = false;
		
		public var testButton : ZButton = new ZButton();
		
		public function GameModel() 
		{
			Factory.getInstance().setModel(this);
			pathFinder = new PathFinder(this);
			
			//TEST SURVIVOR
			var survivor : Survivor = new Survivor(15, 10);
			var survivor2 : Survivor = new Survivor(20, 15);
			var survivor3 : Survivor = new Survivor(5, 5);
			var survivor4 : Survivor = new Survivor(5, 25);
			
			//surviors.push(survivor);
			surviors.push(survivor2);
			//surviors.push(survivor3);
			//surviors.push(survivor4);
			
			
			pathFinder.findPath();
			
			//FORCE to redraw the PATH graphics
			needPathUpdate = true;
			
			//TEST ZOMBIE
			var zombie :Zombie = new Zombie(map.getCell(3,3));			
			zombies.push(zombie);
			
			
			
			
			//TEST BLOCKERS
			Factory.getInstance().addBox(3, 7);
			Factory.getInstance().addBox(4, 7);
			Factory.getInstance().addBox(5, 7);
			Factory.getInstance().addBox(6, 7);
			Factory.getInstance().addBox(7, 7);
			Factory.getInstance().addBox(8, 7);
			
			Factory.getInstance().addBox(8, 6);
			Factory.getInstance().addBox(8, 5);
			Factory.getInstance().addBox(8, 4);
			Factory.getInstance().addBox(9, 4);
			Factory.getInstance().addBox(10, 4);
			
			
			Factory.getInstance().setModel(this);
			
			ZDebug.getInstance().watch("Dobozok szama", _boxes.length);
			
			
			
			
			//pathFinder.traceNexts();
		}
		
		public function addBox(row : int , col : int) : void
		{
			
			var block : Box = new Box(row, col);
			map.getCell(row, col).occupied = true;
			boxes.push(block);
		}
		
		public function update(e: Event) : void
		{
			for each(var zombie:Zombie in _zombies)
			{
				zombie.update();
			}
			
			ZDebug.getInstance().watch("Dobozok szama", _boxes.length);
			ZDebug.getInstance().watch("Zombik szama", _zombies.length);
			ZDebug.getInstance().watch("Túlélők szama", _surviors.length);
			ZDebug.getInstance().refresh();
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