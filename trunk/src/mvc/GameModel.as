package mvc
{
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import flash.utils.getTimer;
	import mapMaker.FileManager;
	import org.as3commons.collections.ArrayList;
	import org.as3commons.collections.framework.IOrderedListIterator;
	import screens.GameScreen;
	import screens.Screen;
	import starling.events.EnterFrameEvent;
	import units.Box;
	import units.Enemy;
	import units.Projectil;
	import units.towers.Tower;	
	
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
		
		private var life   : int = 10;
		private var _money  : int = 0;
		public var blockers : int = 1000;
		
		// GAME ELEMENTS //////////////////////////////////////////
		public var towers       : ArrayList = new ArrayList();
		public var enemies      : ArrayList = new ArrayList();
		public var boxes        : ArrayList = new ArrayList();
		public var projectils   : ArrayList = new ArrayList();
		public var waves        : ArrayList = new ArrayList();
		public var exitPoints   : ArrayList = new ArrayList();
		
		public var pathFinder     : PathFinder;
		public var needPathUpdate : Boolean = false;
		
		//GAME SCREENS
		public var gameScreen : GameScreen;
		
		//FILE MANAGER
		public var levelManager : FileManager;
		
		public function GameModel() 
		{			
			//FILE MANAGER
			levelManager = new FileManager(this);
			
			//SET PATHFINDER
			pathFinder = new PathFinder(this);
			gameScreen = new GameScreen(this);
			
			//addChild(gameScreen);
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
		
		public function update(e: EnterFrameEvent) : void
		{			
			if (!pause)
			{
				//update for next go around
				for (var i:int = towers.size-1; i >=0 ; i--) {
					var t: Tower = towers.itemAt(i);
					t.update(e);
				}
				
				for (i = enemies.size-1; i >=0 ; i--) {
					var enemy: Enemy = enemies.itemAt(i);
					if (enemy != null)
					{
						enemy.update(e);
						
						switch (enemy.state) 
						{
							case Enemy.LIVE:
								
							break;
							case Enemy.DEAD:
								Factory.getInstance().removeEnemy(enemy);
							break;
							case Enemy.ESCAPED:
								Factory.getInstance().removeEnemy(enemy);
							break;
						}
					}
				}
				
				for (i = projectils.size-1; i >= 0 ; i--) {
					var projectile : Projectil = projectils.itemAt(i);
					projectile.update(e);
				}
			} // END PAUSE
		}// END UPDATE
		
		
		public function set money(value:int):void 
		{
			_money = value;
			dispatchEvent(new GameEvents(GameEvents.COIN_CHANGED));
		}
		
	}

}