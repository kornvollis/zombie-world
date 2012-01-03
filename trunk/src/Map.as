package  
{
	/*
	 * Map contains the graphics for the map, and the cells for the pathfindig algorithm
	 */ 
	 
	public class Map extends GameObject
	{			
		public var cells : Vector.<Vector.<Cell>> = new Vector.<Vector.<Cell>>();
		
		public function Map() 
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
					cells[i][j] = new Cell(i,j);
				}				
			}
			
			drawGrid();
		}
		
		private function drawGrid() : void
		{
			this.graphics.lineStyle(1, 0x000000, 1.0);
			for ( var i:int = 0; i < Constants.SCREEN_WIDTH / Constants.GRID_SIZE; i++)
			{
				this.graphics.moveTo(Constants.GRID_SIZE + Constants.GRID_SIZE*i, 0); 
				this.graphics.lineTo(Constants.GRID_SIZE + Constants.GRID_SIZE*i, Constants.SCREEN_HEIGHT); 
			}
			
			for ( i = 0; i < Constants.SCREEN_HEIGHT / Constants.GRID_SIZE; i++)
			{
				this.graphics.moveTo(0, Constants.GRID_SIZE + Constants.GRID_SIZE*i); 
				this.graphics.lineTo(Constants.SCREEN_WIDTH, Constants.GRID_SIZE + Constants.GRID_SIZE*i); 
			}
		}
	
		public function isBlocked(row: int, col:int) : Boolean
		{
			if (row < 0 || col < 0 || col >= Constants.COL_NUM || row >= Constants.ROW_NUM) {
				throw(new Error("is blocked index problem"));
			}
			
			var cell :Cell = cells[row][col];
			if (cell.isOpen)
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
			if (cell.col > 0 && !cells[cell.row][cell.col-1].occupied ) return true;
			else return false;
		}
		
		public function hasRightNeighbour(cell : Cell) : Boolean
		{
			if (cell.col+1 < Constants.COL_NUM && !cells[cell.row][cell.col+1].occupied) return true;
			else return false;
		}
		
		public function hasTopNeighbour(cell : Cell) : Boolean
		{
			if (cell.row > 0 && !cells[cell.row-1][cell.col].occupied) return true;
			else return false;
		}
		
		public function hasBottomNeighbour(cell : Cell) : Boolean
		{
			if (cell.row+1 < Constants.ROW_NUM && !cells[cell.row+1][cell.col].occupied) return true;
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