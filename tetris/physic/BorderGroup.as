package tetris.physic
{
	import Box2D.Collision.Shapes.b2BoxDef;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2World;
	import tetris.model.TetrisModelLocator;
	
	public class BorderGroup extends BaseBodyDef
	{
		private var left:b2BoxDef;
		private var right:b2BoxDef;
		private var bottom:b2BoxDef;
		private const b:int = 15;

		public function BorderGroup(x:int, y:int)
		{
			var model:TetrisModelLocator = TetrisModelLocator.getInstance();
			var cw:int = model.settings.cellWidth;
			var wallWidth:int = model.settings.wallWidth / 2;

			var width:int = cw * model.settings.cols / 2;
			var height:int = cw * model.settings.rows / 2;
			
			var xoff:int = x + width /2;
			var yoff:int = y + height /2;
			
			color = 0x123456;
			
			left = new b2BoxDef();
			left.extents.Set(wallWidth, height);
			left.localPosition.Set(x - wallWidth,y + height);
			AddShape(left);

			right = new b2BoxDef();
			right.extents.Set(wallWidth, height);
			right.localPosition.Set(x + width*2 + wallWidth, y + height);
			AddShape(right);
			
			bottom = new b2BoxDef();
			bottom.extents.Set(width + wallWidth*2, wallWidth);
			bottom.localPosition.Set(x+width, y + 2*height+wallWidth);
			AddShape(bottom);
		}
	}
}