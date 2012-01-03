package  
{
	/**
	 * ...
	 * @author OML!
	 */

	public class  Cell
	{
		public static const LEFT_NEXT   : int = 0;
		public static const RIGHT_NEXT  : int = 1;
		public static const TOP_NEXT    : int = 2;
		public static const BOTTOM_NEXT : int = 3;		
		
		public var occupied : Boolean = false;
		
		public var row : int;
		public var col : int;
		
		public var nextCell : Cell = null;
		public var distance : int = 99999;
		
		public var isOpen : Boolean = true;
		
		public var next_direction : int = -1;
		
		public function Cell(row:int, col:int) 
		{
			super();
			
			this.row = row;
			this.col = col;
		}
		
	}

}