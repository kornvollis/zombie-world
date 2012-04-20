package  
{
	import flash.display.Bitmap;
	import flash.events.Event;
	
	/**
	 * ...
	 * @author OML!
	 */
	public class GameEvents extends Event
	{
		// the event type ON_ADD_CONTACT is used when a contact is added to our list
        public static const LIFE_LOST : String = "lifeLost";
		static public const ZOMBIE_REACHED_EXIT:String = "zombieReachedExit";
		static public const REDRAW_EXIT_POINTS:String = "redrawExitPoints";
  
		public var data : Object;
		
		public function GameEvents(type:String, bubbles:Boolean=false, cancelable:Boolean=false):void
		{
			//we call the super class Event
            super(type, bubbles, cancelable);
		}
	}

}