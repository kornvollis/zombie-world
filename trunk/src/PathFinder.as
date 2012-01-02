package  
{
	import mvc.GameModel;
	/**
	 * ...
	 * @author OML!
	 */
	public class PathFinder 
	{
		private var target_nodes : Node;
		
		private var cells : Vector.<Vector.<Cell>>;
		
		private var model : GameModel;
		
		public function PathFinder(gameModel : GameModel) : void
		{
			cells = gameModel.map.cells;
			this.model = gameModel;
		}
		
		public function generatePath() : void 
		{
			//Open Nodes			
			var openNodes : Vector.<Cell> = new Vector.<Cell>();
			
			//INIT Start Nodes
			for (var i:int = 0; i < model.surviors.length; i++)
			{
				var cell : Cell = new Cell(model.surviors[i].cellY, model.surviors[i].cellX);
				cell.distance = 0;
				cell.nextCell = cell;
				
				openNodes.push(cell);				
			}		
			
			for (i = 0; i < 3; i++)
			{
				var pickedCell : Cell = openNodes.pop();
				
				//LEFT
				if (pickedCell.col - 1 > 0)
				{
					if (cells[pickedCell.row][pickedCell.col - 1].distance > pickedCell.distance+1)
					{
						cells[pickedCell.row][pickedCell.col - 1].distance = pickedCell.distance;
						cells[pickedCell.row][pickedCell.col - 1].nextCell = pickedCell;
					}
					
					if (cells[pickedCell.row][pickedCell.col - 1].isOpen)
					{
						openNodes.push(cells[pickedCell.row][pickedCell.col - 1]);
					}
				}
				//RIGHT
				if (pickedCell.col + 1 < Constants.COL_NUM)
				{
					if (cells[pickedCell.row][pickedCell.col + 1].distance > pickedCell.distance+1)
					{
						cells[pickedCell.row][pickedCell.col + 1].distance = pickedCell.distance;
						cells[pickedCell.row][pickedCell.col + 1].nextCell = pickedCell;
					}
					
					if (cells[pickedCell.row][pickedCell.col + 1].isOpen)
					{
						openNodes.push(cells[pickedCell.row][pickedCell.col + 1]);
					}
				}
				//TOP
				if (pickedCell.row + 1 > Constants.ROW_NUM)
				{
					if (cells[pickedCell.row][pickedCell.row + 1].distance > pickedCell.distance+1)
					{
						cells[pickedCell.row][pickedCell.row + 1].distance = pickedCell.distance;
						cells[pickedCell.row][pickedCell.row + 1].nextCell = pickedCell;
					}
					
					if (cells[pickedCell.row][pickedCell.row + 1].isOpen)
					{
						openNodes.push(cells[pickedCell.row][pickedCell.row + 1);
					}
				}
				//BOTTOM
				if (pickedCell.row - 1 > 0)
				{
					if (cells[pickedCell.row][pickedCell.row - 1].distance > pickedCell.distance+1)
					{
						cells[pickedCell.row][pickedCell.row - 1].distance = pickedCell.distance;
						cells[pickedCell.row][pickedCell.row - 1].nextCell = pickedCell;
					}
					
					if (cells[pickedCell.row][pickedCell.row - 1].isOpen)
					{
						openNodes.push(cells[pickedCell.row][pickedCell.row - 1]);
					}
				}
				
				pickedCell.isOpen = false;
			}
			
		}
	}
}