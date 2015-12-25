package tetris.physic
{
	import Box2D.Collision.Shapes.b2BoxDef;
	import Box2D.Collision.Shapes.b2PolyShape;
	import Box2D.Collision.Shapes.b2Shape;
	import Box2D.Common.Math.b2Math;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2World;
	
	import flash.display.Sprite;
	import tetris.util.GameHelper;
	import tetris.model.TetrisModelLocator;
	
	public class PieceGroup extends BaseBodyDef
	{
		private var parts:Array;
		private var startx:int = 0;
		private var starty:int = -50;
		private var w:int;
	
		public function PieceGroup()
		{
			var model:TetrisModelLocator = TetrisModelLocator.getInstance();
			w = model.settings.cellWidth;
			parts = new Array();
			color = Math.random()*0xFFFFFF;
			
			var form:Array = getForm(Math.floor(Math.random()*6));
			for(var i:int = 0;i<form.length;i++)
			{
				var pos:Array = form[i];
				var part:b2BoxDef = new b2BoxDef();
				part.extents.Set(w/2, w/2);
				part.localPosition.Set(startx + pos[0]*w,starty + pos[1]*w);
				part.density = 2.0;
				
				parts.push(part);

				AddShape(part);
			}
		}
		
		public override function update():void
		{
			var part:b2BoxDef = parts[0];
			
			var rot:Number = Math.round(body.m_rotation*10)%Math.round(10*Math.PI/2);

			
			super.update();
			//trace((bound.x - bound.width)+":"+bound.x);
		}

		private function getForm(p_type:int):Array
		{
			//return [[0,0], [2,0]];
			switch(p_type)
			{
				case 0:return [[0,0],[1, 0],[2,0], [3,0]];				
				case 1:return [[0,0],[1, 0],[2,0], [2,1]];
				case 2:return [[0,1],[1, 1],[2,1], [2,0]];
				case 3:return [[0,0],[1, 0],[1,1], [0,1]];
				case 4:return [[0,0],[1, 0],[1,1], [2,1]];
				case 5:return [[0,1],[1, 1],[1,0], [2,0]];
			}
			
			return null;
		}
	}
}