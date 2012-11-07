package mvc 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	/**
	 * @author OML!
	 */
	public class GameController extends MovieClip
	{
		private var model : GameModel;
		
		private var mousePressed : Boolean = false;
		
		public function GameController(model : GameModel) 
		{
			this.model = model;
			//model.myStage.addEventListener(MouseEvent.CLICK, myClick);
		}
		
		public function myClick(e:MouseEvent):void 
		{
			/*
			//Just for the test			
			var row:int = (e.stageY-Constants.MAP_OFFSET_Y) / Constants.CELL_SIZE;
			var col:int = (e.stageX-Constants.MAP_OFFSET_X) / Constants.CELL_SIZE;	
			
			var cell : Cell = model.pathFinder.cellGrid.getCell(row, col);
			
			switch (Factory.getInstance().clickState) 
			{
				case Factory.WALL_BUILDER:				
					if (cell.boxOnIt == null)
					{
						Factory.getInstance().addBox(row, col);
					} else {
						Factory.getInstance().removeBox(row, col);
					}
				break;
				case Factory.ENEMY_SPAWNER:
					//Factory.getInstance().addEnemy(row, col, this.);
				break;
				case Factory.TOWER_BUILDER:
					Factory.getInstance().addTower(row, col, null);
				break;
				case Factory.REMOVE_BLOCK:
					Factory.getInstance().removeBox(row, col);
				break;
				case Factory.SELL_TOWER:
					if (cell.tower != null) {
						Factory.getInstance().sellTower(cell.tower);
					}
				break;
				default:
			}
			*/
		}
		
		public function mouseDown(e:MouseEvent):void 
		{
			mousePressed = true;
		}
		
		public function mouseMove(e:MouseEvent):void 
		{
			var row:int = e.stageY / Constants.CELL_SIZE;
			var col:int = e.stageX / Constants.CELL_SIZE;
			
			if (mousePressed && Factory.getInstance().clickState == Factory.BLOCK_BUILDER && row >=0 && row<Constants.ROW_NUM && col<Constants.COL_NUM )
			{
				var cell : Cell = model.pathFinder.cellGrid.getCell(row, col);
				
				if (cell.boxOnIt == null) 
				{
					Factory.getInstance().addBlock(row, col);
				}
			}
		}
		
		public function mouseUp(e:MouseEvent):void 
		{
			mousePressed = false;
		}
		
	}

}