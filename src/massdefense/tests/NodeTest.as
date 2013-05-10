package massdefense.tests 
{
	import flexunit.framework.Assert;
	import massdefense.misc.Position;
	import massdefense.pathfinder.Node;
	/**
	 * ...
	 * @author OMLI
	 */
	public class NodeTest 
	{
		private var node : Node;
		
		[Before]
		public function initNode(): void {
			node = new Node();
		}
		[Test]
		public function base():void {
			Assert.assertEquals(Node.INFINIT, node.distance);
			Assert.assertEquals(0, node.row);
			Assert.assertEquals(0, node.col);
			Assert.assertEquals(true, node.isOpen());
		}
		[Test]
		public function testIsExpandable():void {
			Assert.assertEquals(true, node.isExpandable());
			
			node.distance = 3;
			Assert.assertEquals(false, node.isExpandable());
			
			node.distance = Node.INFINIT;
			node.close();
			Assert.assertEquals(false, node.isExpandable());
		}
		[Test]
		public function positionTest():void {
		    var position : Position = node.toPosition();
			
			Assert.assertEquals(Node.NODE_SIZE * 0.5, position.x );
			Assert.assertEquals(Node.NODE_SIZE * 0.5, position.y );		
		}
		[Test]
		public function positionTest2():void {
			node.row = 5;
			node.col = 2;
			
			var position : Position = node.toPosition();
			
			Assert.assertEquals(Node.NODE_SIZE *2 +  Node.NODE_SIZE * 0.5, position.x);
			Assert.assertEquals(Node.NODE_SIZE *5 + Node.NODE_SIZE * 0.5, position.y);
		}
		[Test]
		public function testEquals():void  {
			var node2: Node =  new Node();
			
			Assert.assertTrue(node.equals(node2));
			
			node2.row = 3;
			Assert.assertFalse(node.equals(node2));
			
		}
	}

}