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
		public static const WALL_BUILDER   : String  = "WALL_BUILDER";
		public static const ZOMBIE_SPAWNER : String  = "ZOMBIE_SPAWNER";
		public static const TURRET_BUILDER : String  = "TURRET_BUILDER";
		public static const IDLE 		   : String  = "IDLE_FACTORY";
		public static const REMOVE_BLOCK   : String  = "REMOVE_BLOCK";
		static public const SELL_TOWER     : String  = "sellTower";
		
		//MAP MAKER
		public static const SPAWN_POINT_CREATOR : String = "spawnPointCreator";
		public static const SPAWN_POINT_REMOVER : String = "spawnPointRemover";
		public static const ADD_EXIT : String = "ADD_EXIT";
		public static const REMOVE_EXIT : String = "REMOVE_EXIT";
		
		
		//TODO: REFACTOR THIS TOO TO THEEEEEE TO THE GAMECONTROLLER
		public var clickState : String = Factory.IDLE;
		
		private static var model : GameModel = null;
		private static var view  : GameView  = null;
		
        private static var instance:Factory = new Factory();
		
		
		
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
			//model.pathFinder.findPath();
			
			//model.dispatchEvent(new Event(GameEvents.REDRAW_EXIT_POINTS));
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
		
		public function createProjectil(posX:int, posY:int, target : GameObject) : void
		{
			var projectil : Projectil = new Projectil(posX, posY, target);
			model.projectils.push(projectil);
		}
		
		public function sellTower(tower: Turret) : void
		{
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
		}
		
		public function removeBox(row:int, col:int) : void
		{
			var boxCell : Cell = model.pathFinder.cellGrid.getCell(row, col);
			var b : Box = boxCell.boxOnIt;
			
			if (b != null)
			{			
				if(view.mapAreaLayer1.contains(b)) view.mapAreaLayer1.removeChild(b);
				
				model.pathFinder.cellGrid.openCell(row, col);
				
				b.isDeleted = true;
				var boxIndex : int = model.boxes.indexOf(b);
				model.boxes.splice(boxIndex, 1);
				boxCell.boxOnIt = null;
				
				model.pathFinder.findPath();
				model.needPathUpdate = true;
			}
		}
		
		public function addBox(row:int , col :int) : void
		{
			if(model.blockers > 0)
			{
				var box : Box = new Box(row, col);
				model.boxes.push(box);
				model.pathFinder.cellGrid.blockCell(row, col);
				model.pathFinder.cellGrid.getCell(row, col).boxOnIt = box;
				model.pathFinder.findPath();
				model.needPathUpdate = true;	
				model.blockers = model.blockers-1;
			}
		}
		
		public function addTower(row:int, col:int): Turret 
		{
			if (row <0 || row >= Constants.ROW_NUM ||
			    col <0 || col >= Constants.COL_NUM)
			{
				throw(new Error("addTurret row, col out of bound"));
			} else {
				//var turret : Turret = new Turret(row, col);
				var tower : Turret = new model.buildTowerClass(row, col);
				var buildCell : Cell = model.pathFinder.cellGrid.getCell(row, col);
				buildCell.towerOnIt = tower;
				if(model.coins >= tower.cost)
				{
					model.money -= tower.cost;
					model.turrets.push(tower);
					
					
					var gameEvent : GameEvents =  new GameEvents(GameEvents.UI_MESSAGE);
					gameEvent.data = "Tower built";
					dispatchEvent(gameEvent);
					
					return tower;
				}
			}
			
			return null;
		}
		
		public function addZombie(row:int, col:int):Enemy 
		{
			if (row <0 || row >= Constants.ROW_NUM ||
			    col <0 || col >= Constants.COL_NUM)
			{
				throw(new Error("addZombie row, col out of bound"));
			} else {
				if (model != null)
				{
					var zombie : Enemy = new model.spawnEnemyClass(row, col);
					model.enemies.push(zombie);
					
					return zombie;
				}
			}
			
			return null;
		}
		
		public function removeAllEnemy():void 
		{
			for each (var e: Enemy in model.enemies) 
			{
				if (view.contains(e)) view.mapAreaLayer2.removeChild(e);
			}
			
			for (var i:int = 0; i < model.enemies.length; i++) 
			{
				model.enemies.pop();
			}
		}
		
		public function removeEnemy(e : Enemy):void 
		{
			if (e.onStage)
			{
				if(view.contains(e)) view.mapAreaLayer2.removeChild(e);
			}
			
			var enemy : Enemy = e;
			enemy.isDeleted = true;
			var enemyIndex : int = model.enemies.indexOf(enemy);
			model.enemies.splice(enemyIndex, 1);
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
	}

}