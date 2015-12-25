package tetris.display
{
	import flash.display.Graphics;
	
	public class Style
	{
		public var drawLine:Boolean;
		public var drawFill:Boolean;
		
		public var lineClr:uint;
		public var fillClr:uint;
		
		public var lineAlpha:Number;
		public var fillAlpha:Number;
		
		public var lineThickness:Number;
		
		public function Style(lineClr:uint = 0, fillClr:uint = 0xffffff,
			lineAlpha:Number = 1, fillAlpha:Number = 0, lineThickness:Number = 0)
		{
			drawLine = true;
			drawFill = true;
			
			this.lineClr = lineClr;
			this.fillClr = fillClr;
			
			this.lineAlpha = lineAlpha;
			this.fillAlpha = fillAlpha;
			
			this.lineThickness = lineThickness;
		}
		
		public function applyLineStyle(canvas:Graphics, pixelHinting:Boolean = false, scaleMode:String = "normal", caps:String = null, joints:String = null, miterLimit:Number = 3):void
		{
			if (drawLine)
				canvas.lineStyle(lineThickness, lineClr, lineAlpha, pixelHinting, scaleMode, caps, joints, miterLimit);
		}
		
		public function applyFill(canvas:Graphics, end:Boolean = false):void
		{
			if (!drawFill) return;
			
			if (end)
				canvas.endFill();
			else
				canvas.beginFill(fillClr, fillAlpha);
		}
		
		public function setLineRGBA(r:int, g:int, b:int, a:int = 1):void
		{
			lineClr = r << 16 | g << 8 | b;
			lineAlpha = a;
		}
		
		public function setFillRGBA(r:int, g:int, b:int, a:int = 1):void
		{
			fillClr = r << 16 | g << 8 | b;
			fillAlpha = a;
		}
		
		public function copy():Style
		{
			var s:Style = new Style(lineClr, fillClr, lineAlpha, fillAlpha, lineThickness);
			s.drawLine = drawLine;
			s.drawFill = drawFill;
			return s;
		}
		
		public function paste(s:Style):void
		{
			drawLine = s.drawLine;
			drawFill = s.drawFill;
			
			lineClr = s.lineClr;
			fillClr = s.fillClr;
			lineAlpha = s.lineAlpha;
			fillAlpha = s.fillAlpha;
			lineThickness = s.lineThickness;
		}
	}
}