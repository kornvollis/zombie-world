package  
{
	/**
	 * ...
	 * @author OML!
	 */
	public class Map extends GameObject
	{
		private var map_width : int = 600;
		private var map_height : int = 420;
		
		private var grid_size : int = 15;
		
		
		public function Map() 
		{
			//TODO kiszedni csak teszt
			this.graphics.lineStyle(2, 0x990000, 1.0);
			this.graphics.drawRect(1, 1, map_width, map_height);
			drawGrid();
			
		}
		
		private function drawGrid() 
		{
			this.graphics.lineStyle(1, 0x000000, 1.0);
			for ( var i:int = 0; i < map_width / grid_size; i++)
			{
				this.graphics.moveTo(grid_size + grid_size*i, 0); 
				this.graphics.lineTo(grid_size + grid_size*i, map_height); 
			}
			
			for ( i = 0; i < map_height / grid_size; i++)
			{
				this.graphics.moveTo(0, grid_size + grid_size*i); 
				this.graphics.lineTo(map_width, grid_size + grid_size*i); 
			}
		}
	}
}