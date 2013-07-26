package massdefense.units 
{
	import com.greensock.TweenMax;
	import flash.filters.GlowFilter;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import massdefense.assets.Assets;
	import massdefense.Factory;
	import massdefense.Game;
	import massdefense.misc.Position;
	import massdefense.pathfinder.Node;
	import massdefense.pathfinder.PathFinder;
	import massdefense.tests.creeptest.CreepTestFakeMain;
	import massdefense.Utils;
	import starling.animation.Juggler;
	import starling.core.Starling;
	import starling.display.Image;
	import starling.display.MovieClip;
	import starling.display.Sprite;
	import starling.events.Event;
	import starling.textures.Texture;
	
	public class Creep extends GameObject
	{
		public static const DIE         : String = "DIE";
		public static const RUN         : String = "RUN";
		public static const IDLE        : String = "IDLE";
		public static const ATTACK      : String = "ATTACK";
		
		private var _position         : Position   = new Position();
		private var _pathfinder       : PathFinder = null;
		
		public var type 			  : String = "";
		public var state			  : String = IDLE;
		public var speed              : int    = 90;
		public var rewardMoney        : int    = 5;
		public var maxHealth          : Number = 4;
		private var _health           : Number = 4;
		public var distanceFromTarget : Number;
		public var image			  : String = "";
		
		private var _row 			  : int;
		private var _col              : int;
		private var healthBar		  : HealthBar = new HealthBar();
		
		// ANIMATIONS
		private var runAnimation      : MovieClip;
		private var dieAnimation      : MovieClip;
		
		private var graphicsPointing  : String = "right";
		
		private var previousPosition  : Point = new Point;
		private var targetNode        : Node = null;
		
		public var slowEffect   : Number = 1;
		public var slowDuration : Number = 0;
		
		public function Creep() {}
		
		public function setPositionXY(x:Number , y:Number) : void 
		{			
			position.x = x;
			position.y = y;
			
			this.x = position.x;
			this.y = position.y;
		}
		
		public function setPositionRowCol(row:Number, col:Number):void 
		{
			setPositionXY(col * Node.NODE_SIZE + Node.NODE_SIZE * 0.5, row * Node.NODE_SIZE + Node.NODE_SIZE * 0.5);
		}
		
		override public function addGraphics():void 
		{
			var runTextures : Vector.<Texture> = Assets.getAtlas().getTextures(image + "_run");
			var dieTextures : Vector.<Texture> = Assets.getAtlas().getTextures(image + "_die");
			
			runAnimation = new MovieClip(runTextures);
			dieAnimation = new MovieClip(dieTextures);
			dieAnimation.loop = false;
			
			Utils.centerPivot(runAnimation);
			Utils.centerPivot(dieAnimation);
			
			addChild(runAnimation);
			addChild(dieAnimation);
			dieAnimation.visible = false;
			// animate it
			Starling.juggler.add(runAnimation);
			
			healthBar.x = -10;
			healthBar.y = -22;
			healthBar.addGraphics();
			addChild(healthBar);
			healthBar.visible = false;
			
			runAnimation.useHandCursor = true;
		}
		
		private function finishDieAnimation(e:Event):void 
		{			
			TweenMax.delayedCall(10, removeAniamtion);
		}
		
		private function removeAniamtion() : void {
			TweenMax.to(this, 2, { alpha:0, onComplete:removeFromStage});
		}
		
		private function removeFromStage() : void {
			this.removeFromParent(true);
		}
		
		public function update(passedTime : Number) : void 
		{
			switch (state) 
			{
				case IDLE: 
					findPath();
				break;
				case RUN: 
					run(passedTime);
				break;
				case DIE: 
					
				break;
				case ATTACK: 
					
				break;
				default:
			}
		}
		
		private function findPath():void 
		{
			if (pathfinder == null) return;
			
			if (pathfinder.nextNode(this.row, this.col) != null) {
				state = RUN;
			}
		}
		
		private function run(passedTime:Number):void 
		{
			setPreviousPosition(this.x, this.y); 
			//if (isAlive()) {
			//	if(distanceFromExit() > 0) {
			goToTheExit(passedTime);
			//	}
			setCreepFacing(previousPosition);
			//}
			
			if (distanceFromExit() < 1) {
				state = ATTACK;
			}
			
			/*
			if (slowDuration >= 0) {
				slowDuration -= passedTime;
			} else {
				slowEffect = 1;
			}
			*/
		}
		
		private function setCreepFacing(previousPosition:Point):void 
		{
			if (previousPosition.x > this.x && graphicsPointing == "right") {
				graphicsPointing = "left";
				runAnimation.scaleX = -1;
				dieAnimation.scaleX = -1;
			} else if (previousPosition.x < this.x && graphicsPointing == "left") {
				graphicsPointing = "right";
				runAnimation.scaleX = 1;
				dieAnimation.scaleX = 1;
			}
		}
		
		private function setPreviousPosition(x:Number, y:Number):void 
		{
			previousPosition.x = x;
			previousPosition.y = y;
		}
		
		private function isAlive():Boolean 
		{
			if (health > 0) return true;
			else return false;
		}
		
		private function goToTheExit(passedTime : Number):void 
		{
			if (pathfinder == null) return;
			
			if(targetNode == null || (targetNode.row == row && targetNode.col == col) ) {
				targetNode = pathfinder.nextNode(this.row, this.col);
			}
			goToTheNextNode(targetNode, passedTime);
		}
		
		private function goToTheNextNode(nextNode:Node, passedTime : Number):void 
		{
			if (nextNode != null) {
				var targetPosition : Position = targetNode.toPosition();
				position = Position.moveToPoint(this.position, targetPosition, this.speed * slowEffect, passedTime);
			}
		}
		
		public function distanceFromExit():uint 
		{
			var distance : uint = Node.INFINIT;
			
			if (pathfinder != null) {
				var node : Node = pathfinder.grid.getNode(this.row, this.col);
				distance = node.distance;
			}
			
			return distance;
		}
		
		public function isEscaped():Boolean 
		{
			var escaped : Boolean = false;
			if (distanceFromExit() == 0) {
				escaped = true;
			}
			return escaped;
		}
		
		public function slow(slowDuration:Number, slowEffect:Number):void 
		{
			if (slowDuration > 0 && slowEffect < 1) {
				if (slowEffect < this.slowEffect) {
					this.slowDuration = slowDuration;
					this.slowEffect= slowEffect;
				}
			}
			
		}
		
		public function get row():int 
		{
			return int(position.y / Node.NODE_SIZE);
		}
		
		public function set row(row:int):void 
		{
			position.y = row * Node.NODE_SIZE + Node.NODE_SIZE * 0.5;
			_row = row;
		}
		
		public function get col():int 
		{
			return int(position.x / Node.NODE_SIZE);
		}
		
		public function set col(col:int):void 
		{
			position.x = col * Node.NODE_SIZE + Node.NODE_SIZE * 0.5;
			_col = col;
		}
		
		public function get position():Position 
		{
			return _position;
		}
		
		public function set position(pos:Position):void 
		{
			_position = pos;
			this.x = pos.x;
			this.y = pos.y;
		}
		
		public function get health():Number 
		{
			return _health;
		}
		
		public function set health(value:Number):void 
		{
			_health = value;
			healthBar.setHpPercent(health / maxHealth);
			if (_health < maxHealth) healthBar.visible = true;
			
			if (health <= 0) die();
		}
		
		private function die():void 
		{
			state = DIE;
			runAnimation.visible = false;
			healthBar.visible = false;
			dieAnimation.visible = true;
			
			Starling.juggler.remove(runAnimation);
			Starling.juggler.add(dieAnimation);
			
			dieAnimation.addEventListener(Event.COMPLETE, finishDieAnimation);
		}
		
		public function get pathfinder():PathFinder 
		{
			return _pathfinder;
		}
		
		public function set pathfinder(value:PathFinder):void 
		{
			_pathfinder = value;
		}
	}

}