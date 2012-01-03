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
			model.needUpdate = true;
			InitPathFinder();
			model.needUpdate = true;
		}
		
		private function InitPathFinder() : void 
		{
			// 1. Get starting open nodes
			openNodes = getStartNodes();
			
			while (openNodes.length > 0)
			//for (var i:int = 0; i < 1000;i++)
			{
				//trace("kakas - " + openNodes.length);
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
				if (neighbourCell.nextCell == null || neighbourCell.distance > pickedCell.distance + 1)
				{
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
				var cell : Cell = new Cell(model.surviors[i].cellY, model.surviors[i].cellX);
				cell.distance = 0;
				cell.nextCell = cell;
				
				openNodes.push(cell);				
			}	
			
			return openNodes;
		}
	}
}