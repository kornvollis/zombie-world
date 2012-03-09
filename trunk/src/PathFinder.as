package  
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
		
		public function PathFinder(gameModel : GameModel) : void
		{
			this.model = gameModel;
		}
		
		private function ResetCells() : void
		{
			for (var i : int = 0; i < Constants.ROW_NUM; i++)
			{
				for (var  j:int  = 0; j < Constants.COL_NUM; j++)
				{
					var c : Cell = cellGrid.getCell(i, j);
					c.distance = 99999;
					c.next_direction = Cell.NULL_NEXT;
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
					if (startingCell == null) throw(new Error("kakak"));
					//neighbourCell.nextCell = pickedCell;
					neighbourCell.distance = startingCell + 1;
					neighbourCell.next_direction = direction;
				}
				
				if (!neighbourCell.isProcessed)
				{
					openNodes.push(neighbourCell);
					neighbourCell.isProcessed = true;
				}
			}
		}
		
		private function getStartNodes():Vector.<Cell> 
		{
			var openNodes : Vector.<Cell> = new Vector.<Cell>();
			
			// TARGET NODES ARE THE SURVIVORS
			for (var i:int = 0; i < model.surviors.length; i++)
			{
				var survivor : Survivor = model.surviors[i];
				
				var cell : Cell = this.cellGrid.getCell(survivor.row, survivor.col);
				cell.distance = 0;
				
				openNodes.push(cell);				
			}	
			
			return openNodes;
		}
	}
}