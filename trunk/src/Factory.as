package  
{
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import mvc.GameModel;
	import debug.ZDebug;
	import mvc.GameView;
	/**
	 * @author OML!
	 */
	public class Factory extends EventDispatcher
	{
		public static const WALL_BUILDER     = "WALL_BUILDER";
		public static const ZOMBIE_SPAWNER   = "ZOMBIE_SPAWNER";
		public static const SURVIVOR_SPAWNER = "SURVIVOR_SPAWNER";
		
		public var clickState : String = SURVIVOR_SPAWNER;
		
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
			//TEST SURVIVOR
			addSurvivor(3, 3);
			
			//TEST ZOMBIE
			addZombie(3, 10);
			
			//TURRET
			addTurret(5, 2);
			
			model.pathFinder.addTargetCell(0, 0);
			
			
			model.pathFinder.findPath();
		}	
		
		public static function getInstance():Factory
		{
			return instance;
		}
		
		public function setModel(model: GameModel) :void
		{
			Factory.model = model;
			
			Factory.model.addEventListener(GameEvents.ZOMBIE_REACHED_EXIT, removeZombie);
		}
		
		public function setView(view: GameView) :void
		{
			Factory.view = view;
		}
		
		public function removeSurvivor(s : Survivor) : void
		{
			
		}
		
		public function addSurvivor(row : int , col : int) : void
		{
			
			if (row <0 || row >= Constants.ROW_NUM ||
			    col <0 || col >= Constants.COL_NUM)
			{
				throw(new Error("addSurvivor row, col out of bound"));
			} else {
				if (model != null)
				{
					var survivor : Survivor = new Survivor(row, col);
					model.surviors.push(survivor);
					
					//model.pathFinder.findPath();
				}
			}
		}
		
		public function addBox(row:int , col :int) : void
		{
			if (row <0 || row >= Constants.ROW_NUM ||
			    col <0 || col >= Constants.COL_NUM)
			{
				//throw(new Error("addBox row, col out of bound"));
			} else {
				if (model != null && model.pathFinder.cellGrid.getCell(row,col).state != Cell.CLOSED)
				{
					var box : Box = new Box(row, col);
					model.boxes.push(box);
					model.pathFinder.cellGrid.blockCell(row, col);
					
					model.pathFinder.findPath();
					model.needPathUpdate = true;
				}
			}
			ZDebug.getInstance().refresh();
		}
		
		public function addTurret(row:int, col:int):void 
		{
			if (row <0 || row >= Constants.ROW_NUM ||
			    col <0 || col >= Constants.COL_NUM)
			{
				throw(new Error("addTurret row, col out of bound"));
			} else {
				if (model != null)
				{
					var turret : Turret = new Turret(row, col);
					model.turrets.push(turret);
				}
			}
		}
		
		public function addZombie(row:int, col:int):void 
		{
			if (row <0 || row >= Constants.ROW_NUM ||
			    col <0 || col >= Constants.COL_NUM)
			{
				throw(new Error("addZombie row, col out of bound"));
			} else {
				if (model != null)
				{
					var zombie : Zombie = new Zombie(row, col);
					model.zombies.push(zombie);
				}
			}
		}
		
		public function removeZombie(e : GameEvents):void 
		{
			var zombie : Zombie = Zombie(e.data);
			var zombieIndex : int = model.zombies.indexOf(zombie);
			model.zombies.splice(zombieIndex, 1);
		}
	}

}