package mvc
{
	import flash.display.Stage;
	import flash.events.Event;
	import debug.ZDebug;
	import flash.events.EventDispatcher;
	import flash.geom.Point;

	/**
	 * ...
	 * @author OML!
	 */
	public class GameModel extends EventDispatcher
	{
		// EVENTS //***********************************************************//		
		private var lifeChangedEvent : GameEvents;
		
		private var _life : int = 10;
		
		
		public var myStage : Stage = null;
		
		private var _turrets : Vector.<Turret> = new Vector.<Turret>;
		
		private var _zombies  : Vector.<Zombie>   = new Vector.<Zombie>();
		private var _surviors : Vector.<Survivor> = new Vector.<Survivor>();
		private var _boxes    : Vector.<Box> = new Vector.<Box>();
		
		public var pathFinder     : PathFinder;
		public var needPathUpdate : Boolean = false;
		
		
		public function GameModel() 
		{
			pathFinder = new PathFinder(this);
		}
		
		public function getNextTargetFor(row: int, col : int) : Point
		{
			var targetPos : Point = null;
			
			var currentCell : Cell = pathFinder.cellGrid.getCell(row, col);
			var nextCell : Cell = null;
			
			switch (currentCell.next_direction) 
			{
				case Cell.RIGHT_NEXT : 
					nextCell = pathFinder.cellGrid.getCell(row, col+1);
				break;
				case Cell.LEFT_NEXT : 
					nextCell = pathFinder.cellGrid.getCell(row, col-1);
				break;
				case Cell.TOP_NEXT : 
					nextCell = pathFinder.cellGrid.getCell(row-1, col);
				break;
				case Cell.BOTTOM_NEXT : 
					nextCell = pathFinder.cellGrid.getCell(row+1, col);
				break;
				default:
			}
			
			if (nextCell != null)
			{
				targetPos = new Point(nextCell.middle.x, nextCell.middle.y);
			}
			
			return targetPos;
		}
		
		
		public function update(e: Event) : void
		{
			for each(var turret:Turret in _turrets)
			{
				turret.update();
			}
			
			for each(var zombie:Zombie in _zombies)
			{
				zombie.update();
				
				if (zombieReachedTarget(zombie)) {
					
					var event : GameEvents = new GameEvents(GameEvents.ZOMBIE_REACHED_EXIT);
					event.data = zombie;
					dispatchEvent(event);
					
					life-- ;
				}
				/*
				if (zombie.state == Zombie.Z_IDLE)
				{
					var target = getNextTargetFor(zombie.row, zombie.col);
					
					if (target != null) {
						zombie.target = target;
					}
				}
				*/
			}
			
			ZDebug.getInstance().watch("Dobozok szama", _boxes.length);
			ZDebug.getInstance().watch("Zombik szama", _zombies.length);
			ZDebug.getInstance().watch("Túlélők szama", _surviors.length);
			ZDebug.getInstance().refresh();
		}
		
		private function zombieReachedTarget(z : Zombie):Boolean 
		{
			for (var i:int = 0; i < pathFinder.targetNodes.length; i++) 
			{
				if (pathFinder.targetNodes[i].col == z.col && pathFinder.targetNodes[i].row == z.row) {
					return true;
				}
			}
			return false;
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
		
		public function get life():int 
		{
			return _life;
		}
		
		public function set life(value:int):void 
		{
			_life = value;
			
			lifeChangedEvent = new GameEvents(GameEvents.LIFE_LOST);
			lifeChangedEvent.data = life;
			dispatchEvent(lifeChangedEvent);
			
		}
		
		public function get turrets():Vector.<Turret> 
		{
			return _turrets;
		}
		
		public function set turrets(value:Vector.<Turret>):void 
		{
			_turrets = value;
		}
	}

}