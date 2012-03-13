package mvc
{
	import flash.display.Stage;
	import flash.events.Event;
	import debug.ZDebug;
	import flash.geom.Point;

	/**
	 * ...
	 * @author OML!
	 */
	public class GameModel 
	{
		public var myStage : Stage = null;
		
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
			for each(var zombie:Zombie in _zombies)
			{
				zombie.update();
				
				if (zombie.state == Zombie.Z_IDLE)
				{
					var target = getNextTargetFor(zombie.row, zombie.col);
					
					if (target != null) {
						zombie.target = target;
					}
				}
				
			}
			
			ZDebug.getInstance().watch("Dobozok szama", _boxes.length);
			ZDebug.getInstance().watch("Zombik szama", _zombies.length);
			ZDebug.getInstance().watch("Túlélők szama", _surviors.length);
			ZDebug.getInstance().refresh();
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