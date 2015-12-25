package tetris.display
{
	import de.polygonal.motor2.collision.shapes.PolyShape;
	import de.polygonal.motor2.math.V2C;
	import de.polygonal.ds.GraphNode;
	import de.polygonal.utils.DrawLib;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.Font;
	import flash.text.TextFormat;
	
	import de.polygonal.motor2.collision.shapes.ShapeSkeleton;
	
	public class PolyRenderer extends ShapeRenderer
	{
		public function PolyRenderer(shape:ShapeSkeleton) 
		{
			super(shape);
		}
		
		override protected function drawPoints(canvas:Graphics):void
		{
			var v:V2C = _shape.worldVertexChain;
			while (true)
			{
				canvas.beginFill(0xFFFF00, 1);
				canvas.drawRect(v.x - 2, v.y - 2, 4, 4);
				canvas.endFill();
				
				if (v.eol) break;
				v = v.next;
			}
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
		
		override protected function drawWorldNormals(canvas:Graphics):void
		{
			var xmid:Number, ymid:Number;
			
			var v:V2C = _shape.worldVertexChain;
			var n:V2C = _shape.worldNormalChain;
			
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
		
		protected override function drawProxy(g:Graphics):void
		{
			g.moveTo(_shape.xmin, _shape.ymin);
			g.lineTo(_shape.xmax, _shape.ymin);
			g.lineTo(_shape.xmax, _shape.ymax);
			g.lineTo(_shape.xmin, _shape.ymax);
			g.lineTo(_shape.xmin, _shape.ymin);
		}
		
		override protected function drawShape(canvas:Graphics):void
		{
			canvas.lineStyle(2, 0x72ADDE, .5);
			
			var verts:Array = PolyShape(_shape).getOBBVertexList();
			var v0:V2C = verts[0];
			
			canvas.moveTo(v0.x, v0.y);
			for (var i:int = 1; i < verts.length; i++)
				canvas.lineTo(verts[i].x, verts[i].y);
			canvas.lineTo(v0.x, v0.y);
			
			var ex:Number = _shape.ex;
			var ey:Number = _shape.ey;
		}
	}
}
