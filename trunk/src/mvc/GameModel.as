package mvc
{
	import flash.display.Stage;
	import flash.events.Event;
	import debug.ZDebug;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import levels.LevelLoader;
	import pathfinder.PathFinder;

	/**
	 * ...
	 * @author OML!
	 */
	public class GameModel extends EventDispatcher
	{
		// EVENTS //***********************************************************//		
		private var lifeChangedEvent : GameEvents;
		
		private var _life : int = 10;
		private var _coins : int = 99999;
		
		public var myStage : Stage = null;
		
		private var _turrets : Vector.<Turret> = new Vector.<Turret>;
		
		private var _zombies  : Vector.<Enemy>   = new Vector.<Enemy>();
		private var _boxes    : Vector.<Box> = new Vector.<Box>();
		private var _projectils : Vector.<Projectil> = new Vector.<Projectil>();
		
		public var levelLoader : LevelLoader;
		
		public var pathFinder     : PathFinder;
		public var needPathUpdate : Boolean = false;
		
		
		public function GameModel() 
		{
			//SET PATHFINDER
			PathFinder.getInstance().model = this;
			pathFinder = PathFinder.getInstance();
			//pathFinder  = new PathFinder(this);
			levelLoader = new LevelLoader(this);
			_coins = 100;
		}
		
		public function getNextTargetFor(row: int, col : int) : Point
		{
			var targetPos : Point = null;
			
			var currentCell : Cell = pathFinder.cellGrid.getCell(row, col);
			var nextCell    : Cell = null;
			
			var direction : int = currentCell.next_direction;
			
			//RANDOM MOVEMENT
			if(currentCell.next_alternate_direction != Cell.NULL_NEXT && currentCell.next_direction != currentCell.next_alternate_direction)
			{
				var begin : int = 0;
				var end : int = 1;
				var randomNumber : Number = Math.random();
				if (randomNumber < 0.5)
				{
					direction = currentCell.next_alternate_direction;
				}
			}
			
			
			switch (direction) 
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
				
				if(turret.target == null)
				{
					for each(var zombie2 :Enemy in _zombies)
					{
						var zpos : Point = zombie2.position;
						var tpos : Point = turret.position;
						
						if (Point.distance(zpos, tpos) < turret.range)
						{
							turret.target = zombie2;
							break;
						}
					}
				}
			}
			
			for each(var zombie:Enemy in _zombies)
			{
				zombie.update();
				
				if (zombieReachedTarget(zombie)) {
					
					//var event : GameEvents = new GameEvents(GameEvents.ZOMBIE_REACHED_EXIT);
					//event.data = zombie;
					//dispatchEvent(event);
					Factory.getInstance().removeZombie(zombie);
					
					life-- ;
				}
				
				if (zombie.state == Enemy.Z_IDLE)
				{
					var target : Point = getNextTargetFor(zombie.row, zombie.col);
					
					if (target != null) {
						zombie.target = target;
					}
				}
			}
			
			for each(var projectile : Projectil in _projectils)
			{
				projectile.update();
			}
			
			ZDebug.getInstance().watch("Dobozok szama", _boxes.length);
			ZDebug.getInstance().watch("Zombik szama", _zombies.length);
			ZDebug.getInstance().watch("Projectil szám", _projectils.length);
			ZDebug.getInstance().refresh();
		}
		
		private function zombieReachedTarget(z : Enemy):Boolean 
		{
			for (var i:int = 0; i < PathFinder.getInstance().targetNodes.length; i++) 
			{
				if (pathFinder.targetNodes[i].col == z.col && pathFinder.targetNodes[i].row == z.row) {
					return true;
				}
			}
			return false;
		}
		
		public function get zombies():Vector.<Enemy> 
		{
			return _zombies;
		}
		
		public function set zombies(value:Vector.<Enemy>):void 
		{
			_zombies = value;
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
		
		public function get projectils():Vector.<Projectil> 
		{
			return _projectils;
		}
		
		public function set projectils(value:Vector.<Projectil>):void 
		{
			_projectils = value;
		}
		
		public function get coins():int 
		{
			return _coins;
		}
		
		public function set coins(value:int):void 
		{
			_coins = value;
			dispatchEvent(new GameEvents(GameEvents.COIN_CHANGED));
		}
	}

}