package massdefense.pathfinder 
{
	import massdefense.misc.Position;
	import massdefense.pathfinder.Node;

	public class Path 
	{
		
		private var nodes : Vector.<Node> = new Vector.<Node>();
		
		public function Path() {}
		
		public function getNode(index: uint) : Node {
			return nodes[index];
		}
		
		public function addNodeToTheEnd(node: Node) : void 
		{
			nodes.push(node);
		}
		
		public function print():void 
		{
			var pathString : String = "Path length: " + nodes.length;
			for (var i:int = 0; i < nodes.length; i++) 
			{
				pathString += " " + nodes[i].row + "," + nodes[i].col + "->"
			}
			pathString += "\n";
			trace(pathString);
		}
		
		public function getPositionAt(pathPosition:uint):Position
		{
			var node: Node = getNode(pathPosition);
			
			return node.getPosition();
		}
		
		public function isEndPosition(pathPosition:uint):Boolean 
		{
			var endPosition : Boolean = false;
			
			if (pathPosition == nodes.length) {
				endPosition = true;
			}
			
			return endPosition
		}
		
	}

}