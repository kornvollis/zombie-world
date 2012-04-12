package  
{
	import flash.geom.Point;
	/**
	 * ...
	 * @author OML!
	 */

	public class  Cell
	{
		public static const OPEN   : String = "OPEN";
		public static const CLOSED : String = "CLOSED";
		
		public static const NULL_NEXT   : int = -1;
		public static const LEFT_NEXT   : int = 0;
		public static const RIGHT_NEXT  : int = 1;
		public static const TOP_NEXT    : int = 2;
		public static const BOTTOM_NEXT : int = 3;
		
		public var occupied : Boolean = false;
		
		//Survivors on it
		//public var survivors : Vector.<Survivor> = new Vector.<Survivor>();
		
		//CELL STATUS
		public var state : String = Cell.OPEN;
		
		//Cell's gridposition
		private var _row : int;
		private var _col : int;
		
		//Cell's world position center position
		public var middle : Point = new Point();
		
		//public var nextCell : Cell = null;
		public var distance : int = 99999;
		
		//For the path finder algorithm
		public var isProcessed : Boolean = false;
		
		public var next_direction : int = Cell.NULL_NEXT;
		public var next_alternate_direction : int = Cell.NULL_NEXT;
		
		public var size : int = Constants.CELL_SIZE; 
		
		public function Cell() 
		{
			super();
		}
		
		public function get row():int 
		{
			return _row;
		}
		
		public function set row(value:int):void 
		{
			_row = value;
			this.middle.y = (value * size) + size * 0.5;
		}
		
		public function get col():int 
		{
			return _col;
		}
		
		public function set col(value:int):void 
		{
			_col = value;
			this.middle.x = (value * size) + size * 0.5;
		}
	}

}