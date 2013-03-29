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
		public var maxRow : uint;
		public var maxCol : uint;
		
		private var nodes : Vector.<Vector.<Node>> = new Vector.<Vector.<Node>>();

		public function Grid(row : uint, col: uint) 
		{
			this.maxRow = row;	this.maxCol = col;
			
			initNodeMatrix();
			initNodes();
		}
		
		public function closeNode(node: Node):void {
			node.close();
		}
		
		public function openNode(node: Node):void {
			node.open();
		}
		
		public function getLeftNeighbourOfNode(node:Node) : Node 
		{
			if (node.col > 0) return getNodeAtRowCol(node.row, node.col - 1);
			return null;
		}
		
		public function getRightNeighbourOfNode(cell:Node) : Node 
		{
			if (cell.col < maxCol-1) return getNodeAtRowCol(cell.row, cell.col + 1);
			return null;
		}
		
		public function getTopNeighbourOfNode(cell:Node) : Node 
		{
			if (cell.row > 0) return getNodeAtRowCol(cell.row-1, cell.col);
			return null;
		}
		
		public function getBottomNeighbourOfNode(cell:Node) : Node 
		{
			if (cell.row < maxRow-1) return getNodeAtRowCol(cell.row+1, cell.col);
			return null;
		}
		
		private function initNodes():void 
		{
			for (var i : int = 0; i < maxRow; i++)
			{
				for (var  j:int  = 0; j < maxCol; j++)
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
		
		private function initNodeMatrix():void 
		{
			for (var  i:int  = 0; i < this.maxRow; i++)
			{
				nodes.push(new Vector.<Node>());
			}
		}
		
		public function isNodeOpenAtRowCol(row:uint, col:uint):Boolean {
			return getNodeAtRowCol(row, col).isOpen();
		}		
		
		public function getNodeAtRowCol(row:uint, col:uint):Node {
			return nodes[row][col];
		}
		
		public function print():void 
		{
			var line : String = "      ";
			
			for (var j:int = 0; j < maxCol; j++) 
			{
				var colNum : String = "     " + j + ".";
				colNum  = colNum .slice(colNum .length - 5, colNum .length);
				line += colNum;
			}
			line += "\n\n";
			
			for (var i:int = 0; i < maxRow; i++) 
			{
				var rowNum : String = "    " + i;
				rowNum = rowNum.slice(rowNum.length - 3, rowNum.length);
				line += rowNum + ". ";
				
				for (j = 0; j < maxCol; j++) 
				{
					var currentNode : Node = getNodeAtRowCol(i, j);
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