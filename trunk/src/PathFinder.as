package  
{
	import mvc.GameModel;
	/**
	 * ...
	 * @author OML!
	 */
	public class PathFinder 
	{
		private var cells : Vector.<Vector.<Cell>>;		
		private var model : GameModel;
		private var openNodes:Vector.<Cell> = null;
		
		public function PathFinder(gameModel : GameModel) : void
		{
			cells = gameModel.map.cells;
			this.model = gameModel;
			
			//INIT PATH
			model.needPathUpdate = true;
			findPath();
			model.needPathUpdate = true;
			
			for (var i : int = 0; i < Constants.ROW_NUM; i++)
			{
				for (var  j:int  = 0; j < Constants.COL_NUM; j++)
				{
					trace(model.map.cells[i][j].nextCell);
				}
			}
			
		}
		
		private function ResetNodes() : void
		{
			for (var i : int = 0; i < Constants.ROW_NUM; i++)
			{
				for (var  j:int  = 0; j < Constants.COL_NUM; j++)
				{
					model.map.cells[i][j].distance = 99999;
					model.map.cells[i][j].next_direction = -1;
					model.map.cells[i][j].isOpen = true;
					model.map.cells[i][j].nextCell = null;
				}
			}
		}
		
		public function findPath() : void 
		{
			ResetNodes();
			// 1. Get starting open nodes
			openNodes = getStartNodes();
			
			while (openNodes.length > 0)
			{
				var pickedCell : Cell = openNodes.shift();
				
				processNeighbour(model.map.getLeftNeighbour(pickedCell),pickedCell,Cell.RIGHT_NEXT);
				processNeighbour(model.map.getRightNeighbour(pickedCell),pickedCell,Cell.LEFT_NEXT);
				processNeighbour(model.map.getTopNeighbour(pickedCell),pickedCell,Cell.BOTTOM_NEXT);
				processNeighbour(model.map.getBottomNeighbour(pickedCell), pickedCell,Cell.TOP_NEXT);
				
				pickedCell.isOpen = false;
				
			}
		}	
		
		private function processNeighbour(neighbourCell:Cell,pickedCell:Cell, direction:int):void 
		{
			if (neighbourCell != null && openNodes != null)
			{
				if (neighbourCell.distance > pickedCell.distance + 1)
				{
					if (pickedCell == null) throw(new Error("kakak"));
					neighbourCell.nextCell = pickedCell;
					neighbourCell.distance = pickedCell + 1;
					neighbourCell.next_direction = direction;
				}
				
				if (neighbourCell.isOpen)
				{
					openNodes.push(neighbourCell);
					neighbourCell.isOpen = false;
				}
			}
		}
		
		private function getStartNodes():Vector.<Cell> 
		{
			var openNodes : Vector.<Cell> = new Vector.<Cell>();
			
			// TARGET NODES ARE THE SURVIVORS
			for (var i:int = 0; i < model.surviors.length; i++)
			{
				var cell : Cell = model.map.getCell(model.surviors[i].cellY, model.surviors[i].cellX);
				cell.distance = 0;
				cell.nextCell = cell;
				
				openNodes.push(cell);				
			}	
			
			return openNodes;
		}
	}
}