package massdefense.ui 
{
	import massdefense.assets.Assets;
	import massdefense.level.Level;
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	
	public class TimeControll extends Sprite 
	{
		public static const ON_STEP_CLICK : String = "ON_STEP_CLICK";
		public static const START_GAME_EVENT : String = "ON_PLAY_CLICK";
		public static const ON_PAUSE_CLICK : String = "ON_PAUSE_CLICK";
		
		private var play : Button;
		private var pause : Button;
		private var step : Button;
		
		private var level : Level;
		
		public function TimeControll(level : Level = null) 
		{
			this.level = level;
			
			play = new Button(Assets.getTexture("PlayButton"));
			pause = new Button(Assets.getTexture("PauseButton"));
			step = new Button(Assets.getTexture("StepButton"));
			
			pause.x = 30;
			step.x = 60;
			
			addChild(play);
			addChild(pause);
			addChild(step);
			
			pause.addEventListener(Event.TRIGGERED, onPauseClick);
			play.addEventListener(Event.TRIGGERED, onStartClick);
			step.addEventListener(Event.TRIGGERED, onStepClick);
			
			step.enabled = false;
		}
		
		private function onStepClick(e:Event):void 
		{
			var event : Event = new Event(TimeControll.ON_STEP_CLICK);
			dispatchEvent(event);
		}
		
		private function onStartClick(e:Event):void 
		{
			var event : Event = new Event(TimeControll.START_GAME_EVENT);
			dispatchEvent(event);
		}
		
		private function onPauseClick(e:Event):void 
		{
			var event : Event = new Event(TimeControll.ON_PAUSE_CLICK);
			dispatchEvent(event);
			step.enabled = !step.enabled;
		}
		
	}

}