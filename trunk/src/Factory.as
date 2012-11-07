package  
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import flashx.textLayout.events.ModelChange;
	import levels.Wave;
	import mvc.GameModel;
	import debug.ZDebug;
	import mvc.GameView;
	import org.as3commons.collections.framework.IOrderedListIterator;
	import pathfinder.PathFinder;
	import units.Box;
	import units.Enemy;
	import units.Projectil;
	import units.Turret;
	/**
	 * @author OML!
	 */
	public class Factory extends EventDispatcher
	{
		//TODO: REFACTORING THIS TO THE GAMECONTROLLER
		public static const BLOCK_BUILDER   : String  = "WALL_BUILDER";
		public static const ENEMY_SPAWNER : String  = "ZOMBIE_SPAWNER";
		public static const TOWER_BUILDER : String  = "TURRET_BUILDER";
		public static const IDLE 		   : String  = "IDLE_FACTORY";
		
		//MAP MAKER
		public static const SPAWN_POINT_CREATOR : String = "spawnPointCreator";
		public static const ADD_EXIT : String = "ADD_EXIT";
		static public const REMOVE : String = "remove";
		
		
		//TODO: REFACTOR THIS TOO TO THEEEEEE TO THE GAMECONTROLLER
		public var clickState : String = Factory.IDLE;
		
		private static var model : GameModel = null;
		private static var view  : GameView  = null;
		
        private static var instance:Factory = new Factory();
		
		//MOUSE STATE
		public static var mouseDown : Boolean = false;
		
       	public function Factory()
		{
			if(instance)
			{
				throw new Error ("We cannot create a new instance.Please use Factory.getInstance()");
			}
		}
		
		public function init():void
		{
			//model.levelLoader.loadLevel(1);
			//TEMP STUFF
			
			//Factory.getInstance().addTower2(5, 5);
			
			//removeTowers();
		}	
		
		public static function getInstance():Factory
		{
			return instance;
		}
		
		public function setModel(model: GameModel) :void
		{
			Factory.model = model;
			
			Factory.model.addEventListener(GameEvents.ZOMBIE_REACHED_EXIT, removeEnemy);
		}
		
		public function setView(view: GameView) :void
		{
			Factory.view = view;
		}
		
		public function removeTowers() : void 
		{
			var iterator : IOrderedListIterator = model.towers.iterator() as IOrderedListIterator;
            while (iterator.hasNext()) 
			{
				trace("maki");
				var t: Turret = iterator.next();
				model.gameScreen.removeChild(t);
				model.towers.remove(t);
			}
		}
		
		public function createProjectil(posX:int, posY:int, target : GameObject) : void
		{
			var projectil : Projectil = new Projectil(posX, posY, target);
			model.projectils.push(projectil);
		}
		
		public function sellTower(tower: Turret) : void
		{
			/*
			if (Factory.getInstance().clickState == Factory.SELL_TOWER)
			{
				if (tower.onStage)
				{
					if(view.contains(tower)) view.mapAreaLayer2.removeChild(tower);
				}
				
				model.money += tower.cost;
				
				var towerIndex : int = model.turrets.indexOf(tower);			
				model.turrets.splice(towerIndex, 1);	
				
				//CELL fix
				var cell : Cell = model.pathFinder.cellGrid.getCell(tower.row, tower.col);
				cell.towerOnIt = null;
			}
			*/
		}
		
		public function removeBlock(block : Box) : void
		{
			model.boxes.remove(block);
			model.gameScreen.removeChild(block);
			model.pathFinder.cellGrid.getCell(block.row, block.col).blocked = false;
			model.pathFinder.cellGrid.openCell(block.row, block.col);
			
			model.pathFinder.findPath();
		}
		
		public function addBlock(row:int , col:int, isFree:Boolean = false ) : void
		{
			var cell : Cell = model.pathFinder.cellGrid.getCell(row, col);
			
			if (!cell.isExit() && !cell.isBlocked())
			{
				if(model.blockers > 0 || isFree)
				{
					var block : Box = new Box(row, col);
					
					//model
					model.boxes.add(block);
					model.pathFinder.cellGrid.blockCell(row, col);
					cell.blocked = true;
					
					//view
					model.gameScreen.addChild(block);
					
					if (!isFree)	model.blockers = model.blockers - 1;

					block.removeCallBack = function removeBlockCallBack():void {
						Factory.getInstance().removeBlock(block);
					};
					
					model.pathFinder.findPath();
				}
			}
		}
			
		public function addTower(row:int, col:int, TowerType : Class, isFree: Boolean = false ): void 
		{
			if (row <0 || row >= Constants.ROW_NUM ||
			    col <0 || col >= Constants.COL_NUM)
			{
				throw(new Error("addTurret row, col out of bound"));
			} else {
				//var turret : Turret = new Turret(row, col);
				var tower : Turret = new TowerType(row, col);
				var buildCell : Cell = model.pathFinder.cellGrid.getCell(row, col);
				buildCell.towerOnIt = tower;
				if (model.coins >= tower.cost || isFree == true )
				{
					model.money -= tower.cost;
					model.towers.add(tower);
					model.gameScreen.addChild(tower);
				}
			}
		}
		
		public function addEnemy(row:int, col:int, TypeOfEnemy: Class):Enemy
		{
			var cell : Cell = model.pathFinder.cellGrid.getCell(row, col);
			
			if (!cell.isExit() && !cell.isBlocked())
			{
				if (row <0 || row >= Constants.ROW_NUM ||
					col <0 || col >= Constants.COL_NUM)
				{
					throw(new Error("addEnemy row, col out of bound"));
				} else {
					if (model != null)
					{
						var enemy : Enemy = new TypeOfEnemy(row, col);
						enemy.setTarget(model.pathFinder.cellGrid.getCell(row, col));
						
						model.enemies.add(enemy);
						model.gameScreen.addChild(enemy);
						
						enemy.removeCallBack = function removeEnemyCallBack():void {
							Factory.getInstance().removeEnemy(enemy);
						};
						
						return enemy;
					}
				} 
			}
			
			return null;
		}
		
		public function removeAllEnemy():void 
		{
			for (var i : int = model.enemies.size-1; i>=0 ; i-- )
			{
				removeEnemy(model.enemies.removeAt(i));
			}
		}
		
		public function removeEnemy(e : Enemy):void 
		{
			model.enemies.remove(e);
			model.gameScreen.removeChild(e);
		}
		
		public function removeProjectil(e : Projectil):void 
		{
			var projectile : Projectil = e;
			projectile.isDeleted = true;
			var projIndex : int = model.projectils.indexOf(projectile);
			model.projectils.splice(projIndex, 1);
			
			if (e.onStage)
			{
				view.mapAreaLayer2.removeChild(e);
			}
		}
		
		public function removeExitPoint(exitPoint:ExitPoint):void 
		{
			model.pathFinder.removeExitPoint(exitPoint.row, exitPoint.col);
		}
		
		public function addExitPoint(exitPoint: ExitPoint):void 
		{
			if (model.pathFinder.addExitPoint(exitPoint))
			{
				model.gameScreen.addChild(exitPoint);
				
				//RUN THE PATHFINDER
				model.pathFinder.findPath();
				model.gameScreen.drawDebugPath();
				
				exitPoint.removeCallBack = function removeExitCallBack():void {
					Factory.getInstance().removeExitPoint(exitPoint);
					model.gameScreen.removeChild(exitPoint); 
				};
			}
		}
	}

}