package massdefense.tests.creeptest 
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	import massdefense.misc.SimpleGraphics;
	import massdefense.pathfinder.Grid;
	import massdefense.pathfinder.Node;
	import massdefense.pathfinder.Path;
	import massdefense.pathfinder.PathFinder;
	import massdefense.units.Creep;
	import starling.display.Image;
	import starling.display.Sprite;
	import starling.events.EnterFrameEvent;
	import starling.textures.Texture;
	/**
	 * ...
	 * @author OMLI
	 */
	public class CreepTestFakeMain  extends Sprite
	{
		private var pathfinder : PathFinder = new PathFinder();
		private var grid:Grid;
		public static const ROW_NUM : uint = 10;
		public static const COL_NUM : uint = 25;
		public static const CELL_SIZE : uint = 32;
		public static const MAP_WIDTH : uint = CELL_SIZE * COL_NUM;
		public static const MAP_HEIGHT : uint = CELL_SIZE * ROW_NUM;
		public var creep:Creep;
		
		
		
		public function CreepTestFakeMain() 
		{
			addChild(SimpleGraphics.drawGrid(ROW_NUM, COL_NUM, CELL_SIZE, 1));
			
			testCase_01();
			
			//init();
		}
		
		private function testCase_01():void 
		{
			grid = new Grid(10, 15);			
			pathfinder.grid = grid;	
			
			addChild(SimpleGraphics.drawGrid(10, 15, 32));
			
			var startNodes : Vector.<Node> = new Vector.<Node>;
			startNodes.push(grid.getNode(9, 1));
			pathfinder.setStartNodes(startNodes);
			
			var closedNodes : Vector.<Node> = new Vector.<Node>;
			closedNodes.push(grid.getNode(0, 5));
			addChild(SimpleGraphics.drawXatRowCol(0, 5, 32));
			
			closedNodes.push(grid.getNode(5, 0));
			addChild(SimpleGraphics.drawXatRowCol(5, 0, 32));
			
			closedNodes.push(grid.getNode(5, 1));
			addChild(SimpleGraphics.drawXatRowCol(5, 1, 32));
			
			closedNodes.push(grid.getNode(5, 2));
			addChild(SimpleGraphics.drawXatRowCol(5, 2, 32));
			
			closedNodes.push(grid.getNode(5, 3));
			addChild(SimpleGraphics.drawXatRowCol(5, 3, 32));
			
			pathfinder.closeNodes(closedNodes);
			
			pathfinder.calculateNodesDistances();
			
			initCreep();
			
		}
		
		private function update(event:EnterFrameEvent):void 
		{
			creep.update(event.passedTime);	
		}
		
		private function initCreep():void 
		{
			creep = new Creep();
			creep.setPositionXY(16, 16);
			creep.setPositionRowCol(1, 2);
			/*
			var fakePath : Path = new Path();
			var n1 : Node = new Node();
			n1.row = 0;
			n1.col = 0;
			var n2 : Node = new Node();
			n2.row = 0;
			n2.col = 1;
			var n3 : Node = new Node();
			n3.row = 0;
			n3.col = 2;
			var n4 : Node = new Node();
			n4.row = 1;
			n4.col = 2;
			var n5 : Node = new Node();
			n5.row = 2;
			n5.col = 3;
			var n6 : Node = new Node();
			n6.row = 3;
			n6.col = 3;
			
			fakePath.addNodeToTheEnd(n1);
			fakePath.addNodeToTheEnd(n2);
			fakePath.addNodeToTheEnd(n3);
			fakePath.addNodeToTheEnd(n4);
			fakePath.addNodeToTheEnd(n5);
			fakePath.addNodeToTheEnd(n6);
			
			creep.path = fakePath;
			*/
			
			var node : Node = grid.getNode(0, 0);
			var path : Path = pathfinder.getRandomPathForNode(node);
			creep.path = path;
			
			
			
			addChild(creep);
			
			addEventListener(EnterFrameEvent.ENTER_FRAME, update);
		}		
	}

}