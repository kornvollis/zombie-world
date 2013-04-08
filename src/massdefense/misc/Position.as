package massdefense.misc 
{
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author OMLI
	 */
	public class Position extends Point 
	{		
		public function Position() 
		{
			
		}
		
		static public function isDistanceBetweenLessThan(targetPosition:Position, currentPosition:Position, gap:Number):Boolean 
		{
			var isDistanceLess : Boolean = Position.distance(targetPosition, currentPosition) < gap;
			return isDistanceLess;
		}
		
		static public function distance(p1:Position, p2:Position):Number 
		{
			return Math.sqrt(Math.abs(p1.x - p2.x)*Math.abs(p1.x - p2.x)  + Math.abs(p1.y - p2.y)*Math.abs(p1.y - p2.y));
		}
		
		static public function moveToPoint(startPosition:Position, targetPosition:Position, speed:Number, passedTime:Number):Position 
		{
			var positionAfterMove : Position = new Position();
			positionAfterMove.x = targetPosition.x - startPosition.x;
			positionAfterMove.y = targetPosition.y - startPosition.y;
			
			positionAfterMove.normalize( 1 * speed * passedTime );
			
			positionAfterMove.x += startPosition.x;
			positionAfterMove.y += startPosition.y;
			
			return positionAfterMove;
		}
	}

}