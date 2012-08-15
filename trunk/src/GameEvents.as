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
		static public const ZOMBIE_REACHED_EXIT : String = "zombieReachedExit";
		static public const REDRAW_EXIT_POINTS : String = "redrawExitPoints";
		static public const COIN_CHANGED : String = "COIN_CHANGED";
  
		
		// TURRET SELL CLICK
		static public const TURRET_SELL_EVENT : String = "TURRET_SELL_EVENT";
		static public const UI_MESSAGE:String = "uiMessage";
		
		public var data : Object;
		
		public function GameEvents(type:String, bubbles:Boolean=false, cancelable:Boolean=false):void
		{
			//we call the super class Event
            super(type, bubbles, cancelable);
		}
	}

}