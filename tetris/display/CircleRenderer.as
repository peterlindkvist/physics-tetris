package tetris.display
{
	import flash.display.Graphics;
	import flash.display.Shape;
	
	import de.polygonal.motor2.collision.shapes.ShapeSkeleton;
	
	public class CircleRenderer extends ShapeRenderer
	{
		public function CircleRenderer(shape:ShapeSkeleton) 
		{
			super(shape);
		}
		
		override protected function drawShape(g:Graphics):void
		{
			_style.applyLineStyle(g);
			
			var lx:Number = _shape.mx;
			var ly:Number = _shape.my;
			
			g.drawCircle(lx, ly, _shape.radius);
			
			var x0:Number = lx;
			var y0:Number = ly - _shape.radius;
			
			var x1:Number = lx;
			var y1:Number = ly - _shape.radius / 2;
			
			g.moveTo(x0, y0);
			g.lineTo(x1, y1);
		}
		
		override protected function drawProxy(g:Graphics):void
		{
			g.moveTo(_shape.xmin, _shape.ymin);
			g.lineTo(_shape.xmax, _shape.ymin);
			g.lineTo(_shape.xmax, _shape.ymax);
			g.lineTo(_shape.xmin, _shape.ymax);
			g.lineTo(_shape.xmin, _shape.ymin);
		}
	}
}
