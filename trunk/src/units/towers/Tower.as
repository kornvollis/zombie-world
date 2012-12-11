package units.towers
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.utils.Timer;
	import flashx.textLayout.formats.Float;
	import org.as3commons.collections.ArrayList;
	import units.Enemy;
	/**
	 * ...
	 * @author OML!
	 */
	public class Tower extends GameObject 
	{
		//public static const IDLE   : String = "idle";
		//public static const FIRING : String = "firing";
		//
		//Properties
		//public var damage : int = 1;
		//public var range  : int = 250;
		//public var bulletPerSec : int = 1;	
		//public var cost : int = 50;
		//
		//private var _target : GameObject = null;
		//
		//public var angle : Number = 0;
		//
		//public var rifleGraphics : MovieClip = new MovieClip;
		//public var isReloaded : Boolean = true;
		//
		//public var row : int;
		//public var col : int;
		//
		//private var _showRange : Boolean = true;
		//
		//private var rangeGraphics : Sprite = new Sprite;
		//
		//RELOAD TIEMR
		//private var reloadTimer : Timer;
		//
		//private var lastShotTime : Number = -1;
		//public  var removeCallBack:Function;
		//public  var targetList : ArrayList = new ArrayList();
		//
		//
		//public function Tower(row:int, col:int) 
		//{
			//state = IDLE;
			//RELOAD TIMER
			//var timerDelay : Number = 1000 / bulletPerSec;
			//var timerRepeatCount : int = 1;
			//
			//reloadTimer = new Timer(timerDelay, timerRepeatCount);
			//
			//reloadTimer.addEventListener(TimerEvent.TIMER, reload);
			//
			//this.row = row;
			//this.col = col;
			//
			//position.x = col * Constants.CELL_SIZE;
			//position.y = row * Constants.CELL_SIZE;
			//this.x = position.x;
			//this.y = position.y;
			//
			//this.graphics.beginFill(0x759933);
			//this.graphics.drawRect(0, 0, Constants.CELL_SIZE, Constants.CELL_SIZE);
			//
			//rifleGraphics.graphics.lineStyle(2, 0xFF0000);
			//rifleGraphics.graphics.lineTo(Constants.CELL_SIZE, 0);
			//
			//rifleGraphics.x = Constants.CELL_SIZE * 0.5;
			//rifleGraphics.y = Constants.CELL_SIZE * 0.5;
			//
			//Add range graphics
			//rangeGraphics.graphics.lineStyle(1, 0x00FF00, 0.3);
			//rangeGraphics.graphics.drawCircle(0, 0, range);
			//if (showRange) {
				//rangeGraphics.visible = true;
			//} else {
				//rangeGraphics.visible = false;
			//}
			//
			//addChild(rifleGraphics);
			//addChild(rangeGraphics);
			//
			//
			//CLICK LISTENER
			//this.addEventListener(MouseEvent.CLICK, onClick);
			//this.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMove);
		//}
		//
		//private function onMouseMove(e:MouseEvent):void 
		//{
			//if (removeCallBack != null && Factory.getInstance().clickState == Factory.REMOVE && Factory.mouseDown)
			//{
				//removeCallBack();
			//}
		//}
		//
		//public function onClick(e:MouseEvent):void 
		//{
			//if (removeCallBack != null && Factory.getInstance().clickState == Factory.REMOVE)
			//{
				//removeCallBack();
			//}
		//}
		//
		//private function reload(e:TimerEvent):void 
		//{
			//if (!isReloaded) isReloaded = true;
		//}
		//
		//override public function update() : void
		//{
			//if (targetList.size > 0 && target != null)
			//{				
				//if(target.state == Enemy.DEAD) {
					//target = findTarget();
					//return;
				//}
				//
				//IF enemy goes out of range then we looking for another enemy
				//if (Point.distance(target.position, position) > range)
				//{
					//target = null;
					//return;
				//}
				//
				//if (Enemy(target).isDeleted)
				//{
					//target = null;
					//return;
				//}
				//
				//var vect : Point = new Point;
				//vect.x = target.x - this.position.x;
				//vect.y = target.y - this.position.y;
				//
				//angle = Math.atan2(vect.y, vect.x) * 180 / Math.PI;
				//
				//rifleGraphics.rotation = angle;
				//
				//if (isReloaded) fire();
			//} else if (targetList.size > 0 && target == null) {
				//target = findTarget();
			//}
			//
		//}
		//
		//private function findTarget():Enemy 
		//{
			//for (var i:int = 0; i < targetList.size; i++) 
			//{
				//var enemy : Enemy = targetList.itemAt(i);
				//
				//if (Point.distance(enemy.position, this.position) < this.range) {
					//return enemy;
				//}
			//}
			//return null;
		//}
		//
		//private function fire():void 
		//{
			//if (target != null) {
				//Factory.getInstance().createProjectil(position.x + Constants.CELL_SIZE * 0.5, position.y + Constants.CELL_SIZE * 0.5, target);
				//isReloaded = false;
				//reloadTimer.start();
			//}
		//}
		//
		//public function get showRange():Boolean 
		//{
			//return _showRange;
		//}
		//
		//public function set showRange(visible:Boolean):void 
		//{
			//if (visible)
			//{
				//rangeGraphics.visible = visible;
			//} else {
				//rangeGraphics.visible = !visible;
			//}
			//
			//_showRange = visible;
		//}
		//
		//public function get target():GameObject 
		//{
			//return _target;
		//}
		//
		//public function set target(value:GameObject):void 
		//{
			//_target = value;
		//}
	}

}