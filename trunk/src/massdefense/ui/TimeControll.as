package massdefense.ui 
{
	import massdefense.assets.Assets;
	import massdefense.level.Level;
	import starling.display.Button;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.events.TouchEvent;
	
	/**
	 * ...
	 * @author OMLI
	 */
	public class TimeControll extends Sprite 
	{
		private var play : Button;
		private var pause : Button;
		private var step : Button;
		
		private var level : Level;
		
		public function TimeControll(level : Level) 
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
			play.addEventListener(Event.TRIGGERED, onPlayClick);
			step.addEventListener(Event.TRIGGERED, onStepClick);
			
			step.enabled = false;
		}
		
		private function onStepClick(e:Event):void 
		{
			level.stepFrames = Level.STEP_FRAMES;
		}
		
		private function onPlayClick(e:Event):void 
		{
			level.play();
		}
		
		private function onPauseClick(e:Event):void 
		{
			level.pause();
			if (step.enabled) step.enabled = false;
			else step.enabled = true;
		}
		
	}

}