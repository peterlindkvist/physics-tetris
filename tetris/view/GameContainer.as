package tetris.view
{
	import Box2D.Collision.b2AABB;
	import Box2D.Dynamics.b2World;
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import tetris.model.TetrisModelLocator;
	import tetris.physic.BorderGroup;
	import tetris.physic.GameGroup;
	import tetris.physic.PieceGroup;
	import tetris.physic.PieceParticle;
	import Box2D.Common.Math.b2Vec2;
	import General.Input;
	
	public class GameContainer extends Sprite
	{
		private var displaylist:Array;
		private var model:TetrisModelLocator;
		private var border:BorderGroup;
		private var game:GameGroup;
		
		public function GameContainer()
		{
			init();
		}
		
		private function init():void
		{
			model = TetrisModelLocator.getInstance();
			
			game = new GameGroup();
			
			game.Update();
			
			start();
		}
		
		private function start():void
		{
			addEventListener(Event.ENTER_FRAME, run);
		}
		
		private function stop():void
		{
			removeEventListener(Event.ENTER_FRAME, run);
		}
		
		private function run(e:Event):void
		{
			game.Update();
			Input.update();
		}
	}
}