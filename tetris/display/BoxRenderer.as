package tetris.display
{
	import de.polygonal.motor2.collision.shapes.BoxShape;
	import de.polygonal.motor2.math.V2C;
	import flash.display.Graphics;
	import flash.display.Shape;
	
	import de.polygonal.motor2.collision.shapes.ShapeSkeleton;
	
	public class BoxRenderer extends ShapeRenderer
	{
		public function BoxRenderer(shape:ShapeSkeleton) 
		{
			super(shape);
		}
		
		override protected function drawModelVertices(canvas:Graphics):void
		{
			var v:V2C = _shape.modelVertexChain;
			
			canvas.moveTo(v.x, v.y);
			while (true)
			{
				canvas.lineTo(v.x, v.y);
				if (v.eol)
				{
					canvas.lineTo(v.next.x, v.next.y);
					break;
				}
				v = v.next;
			}
		}
		
		override public function drawWorldVertices(canvas:Graphics):void
		{
			
			_shape.toWorldSpace();
			var v:V2C = _shape.worldVertexChain;
			
			canvas.moveTo(v.x, v.y);
			while (true)
			{
				canvas.lineTo(v.x, v.y);
				if (v.eol) break;
				v = v.next;
			}
			v = v.next;
			canvas.lineTo(v.x, v.y);
		}
		
		override protected function drawWorldNormals(canvas:Graphics):void
		{
			var xmid:Number, ymid:Number;
			
			var v:V2C = _shape.worldVertexChain;
			var n:V2C = _shape.worldNormalChain;
			
			canvas.moveTo(v.x, v.y);
			
			var t:Number = 0;
			
			while (true)
			{
				xmid = v.x + (v.next.x - v.x) * .5;
				ymid = v.y + (v.next.y - v.y) * .5;
				
				canvas.moveTo(xmid, ymid);
				canvas.lineTo(xmid + n.x * 12, ymid + n.y * 12);
				
				t++;
				
				if (v.eol) break;
				
				v = v.next;
				n = n.next;
			}
		}
		
		override protected function drawProxy(g:Graphics):void
		{
			g.moveTo(_shape.xmin, _shape.ymin);
			g.lineTo(_shape.xmax, _shape.ymin);
			g.lineTo(_shape.xmax, _shape.ymax);
			g.lineTo(_shape.xmin, _shape.ymax);
			g.lineTo(_shape.xmin, _shape.ymin);
		}
		
		override protected function drawModelNormals(canvas:Graphics):void
		{
			var xmid:Number, ymid:Number;
			
			var v:V2C = _shape.modelVertexChain;
			var n:V2C = _shape.modelNormalChain;
			
			canvas.moveTo(v.x, v.y);
			
			while (true)
			{
				xmid = v.x + (v.next.x - v.x) * .5;
				ymid = v.y + (v.next.y - v.y) * .5;
				
				canvas.moveTo(xmid, ymid);
				canvas.lineTo(xmid + n.x * 12, ymid + n.y * 12);
				
				if (v.eol) break;
				
				v = v.next;
				n = n.next;
			}
		}
	}
}
