package massdefense.pathfinder 
{
	import flash.events.EventDispatcher;
	import massdefense.misc.Position;
	import massdefense.pathfinder.Node;

	public class PathFinder extends EventDispatcher
	{
		//PRIVATE
		private var _startNodes  : Vector.<Node> = new Vector.<Node>;
		private var _grid : Grid = null; 
		
		public function PathFinder() : void {
			
		}
		
		public function nextNode(row:int, col:int):Node 
		{
			var actualNode : Node = grid.getNodeAtRowCol(row, col);
			
			var targetNode : Node = null;
			
			var nextLeft : Node = grid.leftNeighbourOfNode(actualNode);
			if (nextLeft != null && nextLeft.distance < actualNode.distance) {
				targetNode = nextLeft;
			}
			
			var nextRight : Node = grid.rightNeighbourOfNode(actualNode);
			if (nextRight != null && nextRight.distance < actualNode.distance) {
				targetNode = nextRight;
			}
			
			var nextBottom : Node = grid.bottomNeighbourOfNode(actualNode);
			if (nextBottom != null && nextBottom.distance < actualNode.distance) {
				targetNode = nextBottom;
			}
			
			var nextTop : Node = grid.topNeighbourOfNode(actualNode);
			if (nextTop != null && nextTop.distance < actualNode.distance) {
				targetNode = nextTop;
			}
			
			return targetNode;
		}
		
		public function closeNodes(nodes : Vector.<Node>) : void {
			while(nodes.length > 0)
			{
				var node:Node = nodes.pop();
				node.close();
			}
		}
		
		public function setStartNodes(nodes : Vector.<Node>):void 
		{
			this._startNodes = nodes;
		}
		
		public function calculateNodesDistances() : void {			
			while (_startNodes.length > 0)
			{
				var startingNode : Node = _startNodes.shift();
				
				expandNodeQueWithNewNodes(startingNode);
			}
			_grid.print();
		}
		
		/*
		public function getRandomPathForNode(node : Node) : Path {
			var path : Path = new Path();
			
			if (node.distance == Node.INFINIT) return null;
			
			var currentNode : Node = node;
			
			while (currentNode.distance != 0) {
				path.addNodeToTheEnd(currentNode);
				currentNode = getNextRandomClosestNodeOf(currentNode);
			}
			path.addNodeToTheEnd(currentNode);
			
			return path;
		}
		*/
		
		private function getNextRandomClosestNodeOf(currentNode:Node):Node
		{
			var nextNodes : Vector.<Node> = new Vector.<Node>;
			var leftNode : Node = _grid.leftNeighbourOfNode(currentNode);
			
			if (leftNode != null && leftNode.distance < currentNode.distance) {
				nextNodes.push(leftNode);	
				
			}
			var rightNode : Node = _grid.rightNeighbourOfNode(currentNode);
			if (rightNode != null && rightNode.distance < currentNode.distance) {
				nextNodes.push(rightNode);	
			}
			var topNode : Node = _grid.topNeighbourOfNode(currentNode);
			if (topNode != null && topNode.distance < currentNode.distance) {
				nextNodes.push(topNode);	
			}
			var bottomNode : Node = _grid.bottomNeighbourOfNode(currentNode);
			if (bottomNode != null && bottomNode.distance < currentNode.distance) {
				nextNodes.push(bottomNode);	
			}
			
			var randomNum : int =  Math.floor(Math.random() * nextNodes.length);
			var nextNode : Node = nextNodes.splice(randomNum, 1)[0];
			
			return nextNode;
		}
		
		
		private function expandNodeQueWithNewNodes(processedNode : Node):void 
		{
			if(processedNode != null) {
				addLeftNode(processedNode);
				addRightNode(processedNode);
				addTopNode(processedNode);
				addBottomNode(processedNode);
			}
		}
		
		private function addLeftNode(processedNode:Node):void 
		{
			var newNode : Node = _grid.leftNeighbourOfNode(processedNode);
			if(newNode != null && newNode.isExpandable()) {
				setNodeDistances(newNode, processedNode);
				this._startNodes.push(newNode);
			}
		}
		
		private function addRightNode(processedNode:Node):void 
		{
			var newNode : Node = _grid.rightNeighbourOfNode(processedNode);
			if(newNode != null && newNode.isExpandable()) {
				setNodeDistances(newNode, processedNode);
				this._startNodes.push(newNode);
			}
		}
		
		private function addBottomNode(processedNode:Node):void 
		{
			var newNode : Node = _grid.bottomNeighbourOfNode(processedNode);
			if(newNode != null && newNode.isExpandable()) {
				setNodeDistances(newNode, processedNode);
				this._startNodes.push(newNode);
			}
		}
		
		private function addTopNode(processedNode:Node):void 
		{
			var newNode : Node = _grid.topNeighbourOfNode(processedNode);
			if(newNode != null && newNode.isExpandable()) {
				setNodeDistances(newNode, processedNode);
				this._startNodes.push(newNode);
			}
		}
		
		private function resetNodes() : void
		{
			for (var i : int = 0; i < _grid.rows; i++)
			{
				for (var  j:int  = 0; j < _grid.cols; j++)
				{
					var node : Node = _grid.getNodeAtRowCol(i,j);
					node.distance = Node.INFINIT;
				}
			}
		}
		
		private function setNodeDistances(newNode:Node, processedNode:Node):void 
		{
			newNode.distance = processedNode.distance + 1;
		}
		
		public function get grid():Grid 
		{
			return _grid;
		}
		
		public function set grid(value:Grid):void 
		{
			_grid = value;
		}
		
		public function get startNodes():Vector.<Node> 
		{
			return _startNodes;
		}
	}
}