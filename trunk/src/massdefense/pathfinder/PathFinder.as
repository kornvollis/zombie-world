package massdefense.pathfinder 
{
	import flash.events.EventDispatcher;
	import massdefense.misc.Position;
	import massdefense.pathfinder.Node;

	public class PathFinder extends EventDispatcher
	{
		private var _grid : Grid = null; 
		
		private var waveStartNodes : Vector.<Node> = new Vector.<Node>;
		
		public function PathFinder() : void {}
		
		public function calculateNodesDistances() : void {
			var nodeQue  : Vector.<Node> = grid.exitNodes();
			
			grid.resetDistances();
			
			while (nodeQue.length > 0)
			{
				var startingNode : Node = nodeQue.shift();
				
				expandNodeQueWithNewNodes(nodeQue, startingNode);
			}
		}
		
		public function isMazeBlocked(): Boolean {
			for (var i:int = 0; i < waveStartNodes.length ; i++) 
			{
				if (waveStartNodes[i].distance == Node.INFINIT) {
					return true;
				}
			}
			return false;
		}
		
		private function expandNodeQueWithNewNodes(nodeQue : Vector.<Node>, processedNode : Node):void 
		{
			if (processedNode != null) 
			{
				addLeftNode(nodeQue, processedNode);
				addRightNode(nodeQue, processedNode);
				addTopNode(nodeQue, processedNode);
				addBottomNode(nodeQue, processedNode);
			}
		}
		
		private function addLeftNode(nodeQue: Vector.<Node>, processedNode:Node):void 
		{
			var newNode : Node = _grid.leftNeighbourOfNode(processedNode);
			if(newNode != null && newNode.isExpandable()) {
				setNodeDistances(newNode, processedNode);
				nodeQue.push(newNode);
			}
		}
		
		private function addRightNode(nodeQue: Vector.<Node>, processedNode:Node):void 
		{
			var newNode : Node = _grid.rightNeighbourOfNode(processedNode);
			if(newNode != null && newNode.isExpandable()) {
				setNodeDistances(newNode, processedNode);
				nodeQue.push(newNode);
			}
		}
		
		private function addBottomNode(nodeQue: Vector.<Node>, processedNode:Node):void 
		{
			var newNode : Node = _grid.bottomNeighbourOfNode(processedNode);
			if(newNode != null && newNode.isExpandable()) {
				setNodeDistances(newNode, processedNode);
				nodeQue.push(newNode);
			}
		}
		
		private function addTopNode(nodeQue: Vector.<Node>, processedNode:Node):void 
		{
			var newNode : Node = _grid.topNeighbourOfNode(processedNode);
			if(newNode != null && newNode.isExpandable()) {
				setNodeDistances(newNode, processedNode);
				nodeQue.push(newNode);
			}
		}
		
		public function nextNode(row:int, col:int):Node 
		{
			var actualNode : Node = grid.getNode(row, col);
			
			if (actualNode == null) {
				throw new Error("grid.getNode(row,col)" + row + ", "+  col + " is null");
			}
			
			var targetNodes : Vector.<Node> = new Vector.<Node>;
			
			var neighbourLeft : Node = grid.leftNeighbourOfNode(actualNode);
			if (neighbourLeft != null && neighbourLeft.distance < actualNode.distance) {
				targetNodes.push(neighbourLeft);
			}
			
			var neighbourRight : Node = grid.rightNeighbourOfNode(actualNode);
			if (neighbourRight != null && neighbourRight.distance < actualNode.distance) {
				targetNodes.push(neighbourRight);
			}
			
			var neighbourBottom : Node = grid.bottomNeighbourOfNode(actualNode);
			if (neighbourBottom != null && neighbourBottom.distance < actualNode.distance) {
				targetNodes.push(neighbourBottom);
			}
			
			var neighbourTop : Node = grid.topNeighbourOfNode(actualNode);
			if (neighbourTop != null && neighbourTop.distance < actualNode.distance) {
				targetNodes.push(neighbourTop);
			}
			
			return getRandomNode(targetNodes);
		}
		
		public function addWaveStartNode(node:Node):void 
		{
			waveStartNodes.push(node);
		}
		
		private function getRandomNode(targetNodes:Vector.<Node>):Node 
		{
			if (targetNodes.length == 0) return null;
			if (targetNodes.length == 1) return targetNodes[0];
			
			var randomIndex : int = Math.floor(Math.random() * targetNodes.length);
			
			return targetNodes[randomIndex];
		}
		
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
		
		private function resetNodes() : void
		{
			for (var i : int = 0; i < _grid.rows; i++)
			{
				for (var  j:int  = 0; j < _grid.cols; j++)
				{
					var node : Node = _grid.getNode(i,j);
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
	}
}