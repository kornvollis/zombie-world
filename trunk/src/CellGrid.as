package  
{
	/*
	 * CellGrid contains the graphics for the CellGrid, and the cells for the pathfindig algorithm
	 */ 
	 
	public class CellGrid extends GameObject
	{			
		public var cells : Vector.<Vector.<Cell>> = new Vector.<Vector.<Cell>>();
		
		public function CellGrid() 
		{
			for (var  i:int  = 0; i < Constants.ROW_NUM; i++)
			{
				cells.push(new Vector.<Cell>());
			}
			
			//INIT CELLS
			for (i = 0; i < Constants.ROW_NUM; i++)
			{
				for (var  j:int  = 0; j < Constants.COL_NUM; j++)
				{
					cells[i][j] = new Cell;
					
					Cell(cells[i][j]).row = i;
					Cell(cells[i][j]).col = j;
				}				
			}
		}
		
		public function blockCell(row: int, col:int) : void
		{
			Cell(cells[row][col]).state = Cell.CLOSED;
		}
		
		
		public function isBlocked(row: int, col:int) : Boolean
		{
			if (row < 0 || col < 0 || col >= Constants.COL_NUM || row >= Constants.ROW_NUM) {
				throw(new Error("is blocked index problem"));
			}
			
			var cell :Cell = cells[row][col];
			if (cell.isProcessed)
			{
				return false;
			} else return true;
		}
		
		public function getCell(row : int, col : int) : Cell
		{
			if (cells[row][col] != null)
			{
				return cells[row][col];
			}
			
			throw(new Error("Cell null problem"));
		}
		
		public function hasLeftNeighbour(cell : Cell) : Boolean
		{
			if (cell.col > 0 && Cell(cells[cell.row][cell.col-1]).state == Cell.OPEN) return true;
			else return false;
		}
		
		public function hasRightNeighbour(cell : Cell) : Boolean
		{
			if (cell.col+1 < Constants.COL_NUM && Cell(cells[cell.row][cell.col+1]).state == Cell.OPEN) return true;
			else return false;
		}
		
		public function hasTopNeighbour(cell : Cell) : Boolean
		{
			if (cell.row > 0 && Cell(cells[cell.row-1][cell.col]).state == Cell.OPEN ) return true;
			else return false;
		}
		
		public function hasBottomNeighbour(cell : Cell) : Boolean
		{
			if (cell.row+1 < Constants.ROW_NUM && Cell(cells[cell.row+1][cell.col]).state == Cell.OPEN ) return true;
			else return false;
		}
		
		public function getLeftNeighbour(cell : Cell) : Cell
		{
			if (hasLeftNeighbour(cell)) {
				return cells[cell.row][cell.col - 1];
			} else {
				return null;
			}
		}
		
		public function getRightNeighbour(cell : Cell) : Cell
		{
			if (hasRightNeighbour(cell)) {
				return cells[cell.row][cell.col + 1];
			} else {
				return null;
			}
		}
		
		public function getTopNeighbour(cell : Cell) : Cell
		{
			if (hasTopNeighbour(cell)) {
				return cells[cell.row-1][cell.col];
			} else {
				return null;
			}
		}
		
		public function getBottomNeighbour(cell : Cell) : Cell
		{
			if (hasBottomNeighbour(cell)) {
				return cells[cell.row+1][cell.col];
			} else {
				return null;
			}
		}
	}
}