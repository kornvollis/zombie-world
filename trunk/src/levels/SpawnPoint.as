package levels 
{
	/**
	 * ...
	 * @author OML!
	 */
	public class SpawnPoint extends GameObject 
	{
		public var row: int;
		public var col: int;
		//public var labelIconText : Label = new Label();
		
		//FOR COMBO BOX
		public var data : SpawnPoint;
		public var label : String;
		public var icon : Object;
		
		public function SpawnPoint(row : int , col : int) 
		{
			this.col = col;
			this.row = row;
			
			data = this;
			label = "R/C: "  + row + "/" + col;
			
			getPosition().x = col * Constants.CELL_SIZE + Constants.CELL_SIZE / 2;
			getPosition().y = row * Constants.CELL_SIZE + Constants.CELL_SIZE / 2;
			
			this.x = getPosition().x;
			this.y = getPosition().y;
			
			//TMEP GRAPHICS
			
			//this.graphics.lineStyle(3,0x009900);
			//this.graphics.drawCircle(0, 0, Constants.CELL_SIZE / 2);
			//this.graphics.drawCircle(0, 0, 8);
			//this.graphics.drawCircle(0, 0, 4);
				
			
			//labelIconText.x = getPosition().x - 15;
			//labelIconText.y = getPosition().y + 9;
			//
			//labelIconText.text = row + "/" + col ;			
		}		
	}

}