package massdefense.tests 
{
	import flash.display.Sprite;
	import flash.geom.Point;
	import starling.core.Starling;
	/**
	 * ...
	 * @author OMLI
	 */
	public class Test extends Sprite
	{
		private var mStarling:Starling;
		
		public function Test() 
		{
			
			mStarling = new Starling(TestCases, stage);
			mStarling.start();
			mStarling.showStats = false;
			
			
			/*
			var a:Array = [new Point(4, 4), new Point(10, 0), new Point(1, 23)];
			var a2:Array = a;
			var b : Point = a[2];
			
			//b.x = 300;
			a[1] = null;
			a.splice(1,1);
			
			trace("a: " + a);
			trace("a2: " + a[1]);
			trace(b);
			/*
			//a[2].x = 5;
			//a[2].y = 5;
			a[2] = new Point(7, 7);
			
			trace("a: " + a);
			trace("a2: " + a2);
			trace(b);
			*/
			
		}
		
	}

}