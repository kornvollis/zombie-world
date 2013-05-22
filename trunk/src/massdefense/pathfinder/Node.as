package massdefense.pathfinder 
{
	import massdefense.Game;
	import massdefense.misc.Position;
	/**
	 * ...
	 * @author OMLI
	 */
	public class Node 
	{
		public static const  NODE_SIZE : uint = 32;
		public static const INFINIT : int = 999999;
		
		private var _row  : uint;
		private var _col  : uint;
		private var _open  : Boolean = true;
		private var _exit : Boolean = false;
		public var distance : int = INFINIT;
		
		
		public function Node()
		{
			
		}
		
		public function toPosition() : Position {
			var pos : Position = new Position();
			
			pos.x = this.col * NODE_SIZE + NODE_SIZE   * 0.5;
			pos.y = this.row * NODE_SIZE  + NODE_SIZE   * 0.5;
			
			return pos;
		}
		
		public function equals(node:Node):Boolean {
			if (this.row == node.row && this.col == node.col) {
				return true;
			} else {
				return false;
			}
		}
		
		public function close() : void {
			this._open = false;
			this.distance = INFINIT;
		}
		
		public function open() : void {
			this._open = true;
		}
		
		public function toString() : String {
			return "r/c:" + this.row + "," + this.col;
		}
		
		public function isOpen() : Boolean
		{
			return this._open;
		}
		
		public function isExpandable():Boolean
		{
			if (distance == INFINIT && isOpen()) {
				return true;
			} else return false;
		}
		
		public function get row():uint
		{
			return _row;
		}
		
		public function set row(value:uint):void 
		{
			_row = value;
		}
		
		public function get col():uint
		{
			return _col;
		}
		
		public function set col(value:uint):void 
		{
			_col = value;
		}
		
		public function get exit():Boolean 
		{
			return _exit;
		}
		
		public function set exit(value:Boolean):void 
		{
			if (value == true) { distance = 0 };
			_exit = value;
		}
		
	}

}