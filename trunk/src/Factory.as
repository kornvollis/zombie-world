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
	import org.as3commons.collections.framework.IOrderedListIterator;
	import pathfinder.PathFinder;
	import units.Box;
	import units.Enemy;
	import units.Projectil;
	import units.towers.Tower;
	import utils.Util;
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
		
		public static function getInstance():Factory
		{
			return instance;
		}
		
		public function setModel(model: GameModel) :void
		{
			Factory.model = model;
		}
		
		public function addWave(row:int, col:int, start:int, num:int, spawnDelayInMillisec:int, typeOfEnemy:Class) : void
		{
			var wave : Wave = new Wave(row, col, start, num, spawnDelayInMillisec, typeOfEnemy);
			
			model.waves.add(wave);
		}
		
		public function removeTowers() : void 
		{
			var iterator : IOrderedListIterator = model.towers.iterator() as IOrderedListIterator;
            while (iterator.hasNext()) 
			{
				var t: Tower = iterator.next();
				model.gameScreen.removeChild(t);
				model.towers.remove(t);
			}
		}
		
		public function createProjectil(posX:int, posY:int, target : Enemy) : void
		{
			var projectil : Projectil = new Projectil(target);
			projectil.x = posX;
			projectil.y = posY;
			
			model.projectils.add(projectil);
			model.gameScreen.addChild(projectil);
		}
		
		public function removeBlock(block : Box) : void
		{
			model.boxes.remove(block);
			model.gameScreen.removeChild(block);
			model.pathFinder.cellGrid.getCell(block.row, block.col).blocked = false;
			model.pathFinder.cellGrid.getCell(block.row, block.col).state = Cell.OPEN_PATH;
			
			model.pathFinder.findPath();
			if(model.gameScreen.hasDebug) model.gameScreen.drawDebugPath();
		}
		
		public function addBlock(row:int , col:int, isFree:Boolean = false ) : void
		{
			var cell : Cell = model.pathFinder.cellGrid.getCell(row, col);
			
			if (!cell.isExit() && !cell.blocked)
			{
				if(model.blockers > 0 || isFree)
				{
					//TODO optimize this
					//IN ORDER TO NOT PUT BOX ON THE CREEP HEADS
					 for (var i:int = 0; i < model.enemies.size; i++) {
						if (model.enemies.itemAt(i).row == row && model.enemies.itemAt(i).col == col) {
							return;
						}
					}
					
					var block : Box = new Box(row, col);
					block.x = col * Constants.CELL_SIZE;
					block.y = row * Constants.CELL_SIZE;
					
					//model
					model.boxes.add(block);
					model.gameScreen.addChild(block);
					
					
					model.pathFinder.findPath();
					if (model.gameScreen.hasDebug) model.gameScreen.drawDebugPath();
					if (!isFree)	model.blockers = model.blockers - 1;
				}
			}
		}
		
		public function addTower(row:int, col:int, isFree: Boolean = false ): Tower 
		{
			if (row <0 || row >= Constants.ROW_NUM ||
			    col <0 || col >= Constants.COL_NUM)
			{
				throw(new Error("addTurret row, col out of bound"));
			} else {
				var tower : Tower = new Tower(row, col);
				
				tower.x = col * Constants.CELL_SIZE;
				tower.y = row * Constants.CELL_SIZE;
				
				model.towers.add(tower);
				model.gameScreen.addChild(tower);
			}
			
			return null;
		}
		
		public function findTargetForTower(tower:Tower):Enemy 
		{
			for (var i:int = 0; i < model.enemies.size; i++) 
			{
				var enemy : Enemy = model.enemies.itemAt(i);
				
				if (Point.distance(enemy.getPosition(), tower.getPosition()) < tower.range) {
					return enemy;
				}
			}
			return null;
		}
		
		public function addEnemy(row:int, col:int, properties: Object = null):Enemy
		{
			var cell : Cell = model.pathFinder.cellGrid.getCell(row, col);
			
			if (!cell.isExit() && !cell.blocked)
			{
				if (row <0 || row >= Constants.ROW_NUM ||
					col <0 || col >= Constants.COL_NUM)
				{
					throw(new Error("addEnemy row, col out of bound"));
				} else {
					if (model != null)
					{
						var enemy : Enemy = new Enemy(row, col);
						
						enemy.x = col * Constants.CELL_SIZE;
						enemy.y = row * Constants.CELL_SIZE;
						
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
		
		public function removeProjectil(p : Projectil):void 
		{
			model.projectils.remove(p);
			model.gameScreen.removeChild(p);
		}
		
		public function removeExitPoint(exitPoint:ExitPoint):void 
		{
			//model.pathFinder.removeExitPoint(exitPoint.row, exitPoint.col);
		}
		
		public function addExitPoint(row:int, col:int):void 
		{
			var exitPoint : ExitPoint = new ExitPoint(row, col);
			if(!Util.isContainingId(exitPoint.id, model.exitPoints)) {
				// ADDING TO THE MODEL
				model.exitPoints.add(exitPoint);
				
				// ADD GRAPHICS
				model.gameScreen.addChild(exitPoint);
				
				// SET POSITION
				exitPoint.x = col * Constants.CELL_SIZE;
				exitPoint.y = row * Constants.CELL_SIZE;
				
				//RUN THE PATHFINDER
				model.pathFinder.findPath();
				model.gameScreen.drawDebugPath();
				
				exitPoint.removeCallBack = function removeExitCallBack():void {
					Factory.getInstance().removeExitPoint(exitPoint);
					model.gameScreen.removeChild(exitPoint); 
				};
			}
		}
		
		public function removeTower(t:Tower):void 
		{
			model.towers.remove(t);
			model.gameScreen.removeChild(t);
		}
	}

}