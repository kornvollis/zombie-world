package pathfinder  
{
	import mvc.GameModel;
	/**
	 * ...
	 * @author OML!
	 */
	public class PathFinder 
	{
		public var cellGrid : CellGrid = new CellGrid(); 
		private var model : GameModel;
		private var openNodes:Vector.<Cell> = null;
		
		public var exitPoints : Vector.<ExitPoint> = new Vector.<ExitPoint>;
		
		public function PathFinder(gameModel : GameModel) : void
		{
			this.model = gameModel;
		}
		
		public function addExitPoint(exitPoint : ExitPoint) : void
		{
			var cell : Cell = cellGrid.getCell(exitPoint.row, exitPoint.col);
			if (!cell.isExit())
			{
				trace("kaka");
				exitPoints.push( exitPoint );
				cell.exit = true;
			}
		}
		
		private function ResetCells() : void
		{
			for (var i : int = 0; i < Constants.ROW_NUM; i++)
			{
				for (var  j:int  = 0; j < Constants.COL_NUM; j++)
				{
					var c : Cell = cellGrid.getCell(i, j);
					c.exit = false;
					c.distance = 99999;
					c.next_direction = Cell.NULL_NEXT;
					c.next_alternate_direction = Cell.NULL_NEXT;
					//c.state = Cell.OPEN;
					c.isProcessed = false;
				}
			}
		}
		
		public function findPath() : void 
		{
			// 0. Reset Cells
			ResetCells();
			
			// 1. Get starting open nodes
			openNodes = getStartNodes();
			//openNodes = targetNodes;
			
			// If there is no survivor
			if (openNodes.length == 0) 
			{
				trace("Pathfinder: no more survivor");
				
				return;
			}
			
			// If there is living survivor
			while (openNodes.length > 0)
			{
				var startingCell : Cell = openNodes.shift();
				
				var leftCell   : Cell = cellGrid.getLeftNeighbour(startingCell);
				var rightCell  : Cell = cellGrid.getRightNeighbour(startingCell);
				var topCell    : Cell = cellGrid.getTopNeighbour(startingCell);
				var bottomCell : Cell = cellGrid.getBottomNeighbour(startingCell);
				
				processNeighbour(leftCell,   startingCell,Cell.RIGHT_NEXT);
				processNeighbour(rightCell,  startingCell,Cell.LEFT_NEXT);
				processNeighbour(topCell,    startingCell,Cell.BOTTOM_NEXT);
				processNeighbour(bottomCell, startingCell,Cell.TOP_NEXT);
				
				startingCell.isProcessed = true;
				
			}
			
			//REDRAW THE DEBUG ARROWS
			model.needPathUpdate = true;
		}	
		
		private function processNeighbour(neighbourCell:Cell, startingCell:Cell, direction:int):void 
		{			
			if (neighbourCell != null && openNodes != null)
			{
				if (neighbourCell.distance > startingCell.distance + 1)
				{
					if (startingCell == null) throw(new Error("Pathfinder process neighbour error"));
					//neighbourCell.nextCell = pickedCell;
					neighbourCell.distance = startingCell.distance + 1;
					neighbourCell.next_direction = direction;
				}
				
				//ZIK ZAK
				if (neighbourCell.distance == startingCell.distance + 1)
				{
					if (neighbourCell.next_direction != direction)
					{
						neighbourCell.next_alternate_direction = direction;
					}
				}
				
				if (!neighbourCell.isProcessed)
				{
					openNodes.push(neighbourCell);
					neighbourCell.isProcessed = true;
				}
			}
		}
		
		private function exitPointToCell(exitPoint: ExitPoint) : Cell
		{
			var cell : Cell = cellGrid.getCell(exitPoint.row, exitPoint.col);
			return cell;
		}
		
		private function getStartNodes():Vector.<Cell> 
		{
			var openNodes : Vector.<Cell> = new Vector.<Cell>();
			
			for (var i:int = 0; i < exitPoints.length; i++)
			{
				var cell : Cell = exitPointToCell(exitPoints[i]);
				cell.distance = 0;
				cell.exit = true;
				openNodes.push(cell);
			}
			
			return openNodes;
		}
	}
}