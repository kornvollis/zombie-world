package  
{
	import flash.display.Sprite;
	import flash.events.EventDispatcher;
	import mvc.GameModel;
	import debug.ZDebug;
	import mvc.GameView;
	/**
	 * ...
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
			addSurvivor(1, 10);
			
			//FORCE to redraw the PATH graphics
			model.needPathUpdate = true;
			
			
			//TEST BLOCKERS
			addBox(3, 7);
			addBox(4, 7);
			addBox(5, 7);
			addBox(6, 7);
			addBox(7, 7);
			addBox(8, 7);
			
			model.pathFinder.findPath();
			
			//TEST ZOMBIE
			var zombie :Zombie = new Zombie(model.map.getCell(3,3));			
			model.zombies.push(zombie);
			
			ZDebug.getInstance().watch("Dobozok szama", model.boxes.length);
		}	
		
		public static function getInstance():Factory
		{
			return instance;
		}
		
		public function setModel(model: GameModel) :void
		{
			Factory.model = model;
		}
		
		public function setView(view: GameView) :void
		{
			Factory.view = view;
		}
		
		public function removeSurvivor(s : Survivor) : void
		{
			if (model != null && s != null)
			{
				trace("Factory: 1 survivor removed");
				var row : int = s.cellY;
				var col : int = s.cellX;
				
				//Remove from model
				var index : int = model.surviors.indexOf(s);
				model.surviors.splice(index, 1);
				
				//Remove from cell
				var cell : Cell = model.pathFinder.getCell(row, col);
				cell.removeSurvivor(s);
				
				//Refresh the view
				view.removeSurvivor(s);
				
				model.needPathUpdate = true;
				model.pathFinder.findPath();
			}
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
					
					var cell : Cell = model.pathFinder.getCell(row, col);
					cell.addSurvivor(survivor);
					
					model.needPathUpdate = true;
					model.pathFinder.findPath();
				}
			}
		}
		
		public function addBox(row:int , col :int) : void
		{
			if (row <0 || row >= Constants.ROW_NUM ||
			    col <0 || col >= Constants.COL_NUM)
			{
				throw(new Error("addBox row, col out of bound"));
			} else {
				if (model != null)
				{
					if (!model.pathFinder.getCell(row, col).hasSurvivor())
					{
						var box : Box = new Box(row, col);
						model.boxes.push(box);
						model.pathFinder.findPath();
						model.needPathUpdate = true;
					}
				}
			}
			ZDebug.getInstance().refresh();
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
					var zombie : Zombie = new Zombie(model.pathFinder.getCell(row,col));
					model.zombies.push(zombie);
					
					//var cell : Cell = model.pathFinder.getCell(row, col);
					//cell.addSurvivor(survivor);
				}
			}
		}
	}

}