package
{
	import flash.display.Sprite;
	import tetris.view.GameContainer;
	import General.Input;
	import flash.display.StageAlign;
	import flash.display.Stage;
	import flash.display.StageScaleMode;
	
	public class Main extends Sprite
	{
		private var game:GameContainer;
		static public var m_sprite:Sprite;
		public var m_input:Input;
		
		public function Main()
		{
			stage.align = StageAlign.TOP_LEFT;
			stage.scaleMode = StageScaleMode.NO_SCALE;
			
			init();
		}
		
		private function init():void
		{
			m_sprite = this;
			m_sprite.x = 100;
			m_sprite.y = 100;
			m_input = new Input(m_sprite);
			
			game = new GameContainer();
			
			addChild(game);
		}
	}
}