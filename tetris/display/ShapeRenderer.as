package tetris.display
{
	import de.polygonal.motor2.collision.shapes.ShapeSkeleton;
	import de.polygonal.motor2.collision.shapes.BoxShape;
	import de.polygonal.ds.GraphNode;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.display.Graphics;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class ShapeRenderer extends Sprite
	{
		protected var _x0:Number, _x1:Number;
		protected var _y0:Number, _y1:Number;
		protected var _r0:Number, _r1:Number;
		
		public var _shape:ShapeSkeleton;
		protected var _style:Style;
		protected var _tf:TextField;
		
		protected var $canvas:Sprite;
		
		public function ShapeRenderer(shape:ShapeSkeleton) 
		{
			_shape = shape;
			init();
		}
		
		public function get style():Style { return _style.copy(); }
		public function set style(s:Style):void
		{
			_style.paste(s);
			draw();
		}
		
		protected function init():void
		{
			_x0 = _x1 = _y0 = _y1 = _r0 = _r1 = 0;
			
			_style = new Style();
			_style.lineClr = 0xC0C0C0;
			
			addChild($canvas = new Sprite());
		}
		
		public function update():void
		{
			_x0 = _x1; _x1 = _shape.body.x;
			_y0 = _y1; _y1 = _shape.body.y;
			_r0 = _r1; _r1 = _shape.body.r;
		}
		
		public function render(alpha:Number):void
		{
			//lerp between previous and current state
			//state = s1 * alpha + s0 * (1 - alpha)
			var t:Number = 1 - alpha;
			var xInterp:Number = _x1 * alpha + _x0 * t;
			var yInterp:Number = _y1 * alpha + _y0 * t;
			var rInterp:Number = _r1 * alpha + _r0 * t;
			
			//move to world space
			$canvas.x = xInterp;
			$canvas.y = yInterp;
			$canvas.rotation = rInterp * 57.295780;
			
			$canvas.alpha = _shape.body.isSleeping() ? .5 : 1;
		}
		
		public function draw():void
		{
			var g:Graphics = $canvas.graphics;
			
			g.clear();
			
			var shapeClr:uint = 0x282828;
			
			_style.lineClr = shapeClr;
			_style.lineAlpha = 1;
			_style.lineThickness = 1;
			_style.applyLineStyle(g, false, "normal", "none", "miter");
			
			drawShape(g);
			
			_style.lineClr = shapeClr;
			_style.lineAlpha = 1;
			_style.lineThickness = 2;
			_style.fillAlpha = 1
			_style.fillClr = 0xFFFFFF
			_style.applyLineStyle(g, false, "normal", "none", "miter");
			
			drawModelVertices(g);
		}
		
		/**
		 * hook, override for implementation
		 */
		protected function drawShape(canvas:Graphics):void { }
		
		protected function drawModelVertices(canvas:Graphics):void {};
		public function drawWorldVertices(canvas:Graphics):void {};
		
		protected function drawModelNormals(canvas:Graphics):void {};
		protected function drawWorldNormals(canvas:Graphics):void {};
		
		protected function drawPoints(canvas:Graphics):void {}
		
		protected function drawModelEdges(canvas:Graphics):void { };
		protected function drawWorldEdges(canvas:Graphics):void { };
		
		protected function drawVertexIndices(canvas:Graphics):void { };
		protected function drawProxy(canvas:Graphics):void { };
	}
}
