package mvc
{
	
	import fl.events.ScrollEvent;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import org.as3commons.collections.ArrayList;
	import org.as3commons.collections.framework.IOrderedListIterator;
	import screens.GameScreen;
	import screens.Screen;
	import units.Box;
	import units.Enemy;
	import units.Projectil;
	import units.Turret;
	
	import levels.LevelLoader;
	
	import pathfinder.PathFinder;

	/**
	 * ...
	 * @author OML!
	 */
	public class GameModel extends MovieClip
	{
		// EVENTS //***********************************//		
		public var pause : Boolean = false;
		
		private var lifeChangedEvent : GameEvents;
		
		private var _life : int = 10;
		private var _money : int = 0;
		private var _blockers : int = 1000;
		
		public var myStage : Stage = null;
		
		public var towers       : ArrayList = new ArrayList();
		public var enemies      : ArrayList = new ArrayList();
		public var boxes        : ArrayList = new ArrayList();
		private var _projectils : Vector.<Projectil> = new Vector.<Projectil>();
		
		
		public var pathFinder     : PathFinder;
		public var needPathUpdate : Boolean = false;
		
		//GAME SCREENS
		public var gameScreen : GameScreen;
		
		public function GameModel() 
		{
			//SET PATHFINDER
			pathFinder = new PathFinder(this);
			//pathFinder  = new PathFinder(this);
			gameScreen = new GameScreen(this);
			
			addChild(gameScreen);
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
			if (!pause)
			{
				for each(var turret:Turret in towers)
				{
					turret.update();
					
					if(turret.target == null)
					{
						for each(var zombie2 :Enemy in enemies)
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
				
				var enemiesIterator : IOrderedListIterator = enemies.iterator() as IOrderedListIterator;
				while (enemiesIterator.hasNext()) 
				{
					
					
					var enemy: Enemy = enemiesIterator.next();
					if (enemy != null)
					{
						enemy.update();
						
						switch (enemy.state) 
						{
							case Enemy.LIVE:
								
							break;
							case Enemy.DEAD:
								
							break;
							case Enemy.ESCAPED:
								Factory.getInstance().removeEnemy(enemy);
							break;
						}
					}
				}
				
				for each(var projectile : Projectil in _projectils)
				{
					projectile.update();
				}
			} // END PAUSE
		}// END UPDATE
		
		private function enemyReachedExit(z : Enemy):Boolean 
		{
			for (var i:int = 0; i < pathFinder.exitPoints.length; i++) 
			{
				if (pathFinder.exitPoints[i].col == z.col && pathFinder.exitPoints[i].row == z.row) {
					return true;
				}
			}
			return false;
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
			return money;
		}
		
		public function get money():int 
		{
			return _money;
		}
		
		public function set money(value:int):void 
		{
			_money = value;
			dispatchEvent(new GameEvents(GameEvents.COIN_CHANGED));
		}
		
		public function get blockers():int 
		{
			return _blockers;
		}
		
		public function set blockers(value:int):void 
		{
			_blockers = value;
			dispatchEvent(new GameEvents(GameEvents.BLOCKS_CHANGED));
		}
		
	}

}