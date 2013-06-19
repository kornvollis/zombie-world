package massdefense.ui.tower 
{
	import com.greensock.TweenLite;
	import flash.geom.Point;
	import massdefense.assets.Assets;
	import massdefense.Utils;
	import starling.display.Image;
	import starling.display.Sprite;
	
	public class TowerSelection extends Sprite 
	{
		private var graphics : Image;
		
		
		public function TowerSelection() 
		{
			graphics = Assets.getImage("TowerSelection");
			addChild(graphics);
			Utils.centerPivot(graphics);
			
			graphics.width  = 140;
			graphics.height = 140;
			
			touchable = false;
			visible = false;
		}
		
		public function show() : void {
			//var position : Point = globalToLocal(new Point(posx, posy));
			this.visible = true;
			TweenLite.to(graphics, 0.4, { width: 34, height: 34 } );
		}
		
		public function hide() : void {
			this.visible = false;
			graphics.width  = 140;
			graphics.height = 140;
		}
		
	}

}