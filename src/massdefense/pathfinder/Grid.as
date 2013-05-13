package massdefense.pathfinder 
{
	import massdefense.pathfinder.Node;
	import starling.display.Image;
	/**
	 * ...
	 * @author OMLI
	 */
	public class Grid 
	{
		public var rows : uint;
		public var cols : uint;
		
		private var nodes : Vector.<Vector.<Node>> = new Vector.<Vector.<Node>>();
		
		public function Grid(rows : uint, cols: uint) 
		{
			this.rows = rows;	this.cols = cols;
			
			initNodeMatrix();
			initNodes();
		}
		
		private function initNodeMatrix():void 
		{
			for (var  i:int  = 0; i < this.rows; i++)
			{
				nodes.push(new Vector.<Node>());
			}
		}
		
		private function initNodes():void 
		{
			for (var i : int = 0; i < rows; i++)
			{
				for (var  j:int  = 0; j < cols; j++)
				{
					createNodeAtRowCol(i, j);
				}				
			}
		}
		
		private function createNodeAtRowCol(row:uint, col:uint):void 
		{
			var node : Node = new Node();
			node.row = row;
			node.col = col;
			
			nodes[row][col] = node;
		}
		
		public function exitNodes():Vector.<Node> 
		{
			var nodes : Vector.<Node> = new Vector.<Node>();
			for (var i : int = 0; i < rows; i++)
			{
				for (var  j:int  = 0; j < cols; j++)
				{
					var node : Node = getNode(i, j);
					if (node.exit) {
						nodes.push(node);
					}
				}
			}
			return nodes;
		}
		
		public function getNode(row:uint, col:uint):Node {
			if (row > rows - 1 || col > cols - 1) return null;
			if (row < 0        || col < 0       ) return null;
			
			return nodes[row][col];
		}
		
		public function isNodeOpenAtRowCol(row:uint, col:uint):Boolean {
			return getNode(row, col).isOpen();
		}		
		
		public function leftNeighbourOfNode(node:Node) : Node 
		{
			return getNode(node.row, node.col - 1);
		}
		
		public function rightNeighbourOfNode(node:Node) : Node 
		{
			return getNode(node.row, node.col + 1);
		}
		
		public function topNeighbourOfNode(node:Node) : Node 
		{
			return getNode(node.row-1, node.col);
		}
		
		public function bottomNeighbourOfNode(node:Node) : Node 
		{
			return getNode(node.row+1, node.col);
		}
		
		public function print():void 
		{
			var line : String = "      ";
			
			for (var j:int = 0; j < cols; j++) 
			{
				var colNum : String = "     " + j + ".";
				colNum  = colNum .slice(colNum .length - 5, colNum .length);
				line += colNum;
			}
			line += "\n\n";
			
			for (var i:int = 0; i < rows; i++) 
			{
				var rowNum : String = "    " + i;
				rowNum = rowNum.slice(rowNum.length - 3, rowNum.length);
				line += rowNum + ". ";
				
				for (j = 0; j < cols; j++) 
				{
					var currentNode : Node = getNode(i, j);
					var distance : String = "X";
					if(currentNode.distance != Node.INFINIT) {
						distance = currentNode.distance.toString();
					}
					
					var nodeDistance : String = "     " + distance;
					nodeDistance = nodeDistance.slice(nodeDistance.length - 5, nodeDistance.length);
					line += nodeDistance;
					
				}
				line += "\n";
			}
			trace(line);
		}
	}

}