package massdefense 
{
	import massdefense.assets.Assets;
	import massdefense.pathfinder.Node;
	import massdefense.units.Units;
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class Block extends Sprite 
	{
		private var _row : int = 0;
		private var _col : int = 0;
		
		public var type : String = "";
		public var cost : int = 0;
		
		public function Block() 
		{
			
		}
		
		public function init(row:int, col:int, type : String) : void 
		{
			this.row = row;
			this.col = col;
			
			//var blockProps : XMLList = Units..units.block.(@type == type).children();
			var blockProps : XMLList = null;
			
			for each(var property : XML in blockProps) 
			{
				var propName  : String = property.localName();
				var propValue : Object = property;
				this[propName] = propValue;
			}
		}
		
		public function addGraphics():void 
		{
			this.x = col * Node.NODE_SIZE; 
			this.y = row * Node.NODE_SIZE;
			
			var image : Image = Assets.getImage("Block01");
			addChild(image);
		}
		
		public function get row():int 
		{
			return _row;
		}
		
		public function set row(value:int):void 
		{
			_row = value;
		}
		
		public function get col():int 
		{
			return _col;
		}
		
		public function set col(value:int):void 
		{
			_col = value;
		}
		
	}

}