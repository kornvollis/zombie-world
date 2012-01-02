package  
{
	/**
	 * ...
	 * @author OML!
	 */

	public class  Cell
	{
		public var occupied : Boolean = false;
		
		public var row : int;
		public var col : int;
		
		public var nextCell : Cell = null;
		public var distance : int = 99999;
		
		public var isOpen : Boolean = true;
		
		public function Cell(row:int, col:int) 
		{
			super();
			
			this.row = row;
			this.col = col;
		}
		
	}

}