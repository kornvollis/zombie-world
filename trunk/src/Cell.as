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
		
		//Survivors on it
		public var survivors : Vector.<Survivor> = new Vector.<Survivor>();
		
		//Cell's gridposition
		public var row : int;
		public var col : int;
		
		//Cell's middle position
		public var middle_x : Number;
		public var middle_y : Number;
		
		public var nextCell : Cell = null;
		public var distance : int = 99999;
		
		public var isOpen : Boolean = true;
		
		public var next_direction : int = -1;
		
		public function Cell(row:int, col:int) 
		{
			super();
			
			this.middle_x = (col * Constants.GRID_SIZE) + Constants.GRID_SIZE / 2;
			this.middle_y = (row * Constants.GRID_SIZE) + Constants.GRID_SIZE / 2;
			
			this.row = row;
			this.col = col;
		}
		
		public function hasSurvivor() : Boolean
		{
			if (survivors.length > 0) return true;
			else return false;
		}
		
		public function giveMeASurvivor() : Survivor
		{
			if (survivors.length > 0)
			{
				return survivors[0];
			} else {
				return null;
			}
		}
		
		public function removeSurvivor(survivor : Survivor):void 
		{
			var index : int = this.survivors.indexOf(survivor);
			this.survivors.splice(index, 1);
		}
		
		public function addSurvivor(survivor : Survivor):void 
		{
			this.survivors.push(survivor);
		}
	}

}