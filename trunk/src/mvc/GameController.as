package mvc 
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	/**
	 * ...
	 * @author OML!
	 */
	public class GameController extends MovieClip
	{
		private var model : GameModel;
		
		public function GameController(model : GameModel) 
		{
			this.model = model;
			
			model.myStage.addEventListener(MouseEvent.CLICK, myClick);
		}
		
		private function myClick(e:MouseEvent):void 
		{
			//Just for the test			
			var row:int = e.stageY / Constants.GRID_SIZE;
			var col:int = e.stageX / Constants.GRID_SIZE;
			
			if (row <Constants.ROW_NUM && row >= 0 &&
				col < Constants.COL_NUM && col >= 0)
			{
				if (!model.map.cells[row][col].occupied)
				{
					model.addBox(row, col);
				} else {
					for (var i:int = 0; i < model.boxes.length; i++)
					{
						var box : Box = model.boxes[i];
						//if(box.cellX == col && box.cellY
					}
				}
			}
			
			model.pathFinder.findPath();
			model.needPathUpdate = true;
		}
		
	}

}