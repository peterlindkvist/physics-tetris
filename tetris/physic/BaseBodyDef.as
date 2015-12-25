package tetris.physic
{
	import Box2D.Collision.Shapes.b2PolyShape;
	import Box2D.Collision.Shapes.b2Shape;
	import Box2D.Collision.b2AABB;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2World;
	
	import flash.display.Sprite;
	import Box2D.Common.Math.b2Math;
	import flash.geom.Rectangle;
	
	public class BaseBodyDef extends b2BodyDef
	{
		private var world:b2World;
		private var doSleep:Boolean = true;
		private var containerSprite:Sprite;
		private var parts:Array;
		internal var color:uint;
		internal var body:b2Body;
		internal var bound:Rectangle;
		
		public function BaseBodyDef()
		{
			//parts = new Array();
		}
		
		public function draw():void
		{
			var m_sprite:Sprite = Main.m_sprite;
			bound = new Rectangle(100000, 100000, 0,0);
			
			for (var s:b2Shape = body.GetShapeList() ; s != null; s = s.GetNext())
			{
				var poly:b2PolyShape = s as b2PolyShape;
//				poly.
				var tV:b2Vec2 = b2Math.AddVV(poly.m_position, b2Math.b2MulMV(poly.m_R, poly.m_vertices[0])); //0->i
				
			
				if(tV.x < bound.x) bound.x = tV.x;
				if(tV.y < bound.y) bound.y = tV.y;
				if(tV.x > bound.width) bound.width = tV.x;
				if(tV.y > bound.height) bound.height = tV.y;
					
				m_sprite.graphics.lineStyle(1,0xFFFFFF,1);
				m_sprite.graphics.moveTo(tV.x, tV.y);
				m_sprite.graphics.beginFill(color,1);
				for (var j:int = 0; j < poly.m_vertexCount; ++j)
				{
					var v:b2Vec2 = b2Math.AddVV(poly.m_position, b2Math.b2MulMV(poly.m_R, poly.m_vertices[j]));
					if(v.x < bound.x) bound.x = v.x;
					if(v.y < bound.y) bound.y = v.y;
					if(v.x > bound.width) bound.width = v.x;
					if(v.y > bound.height) bound.height = v.y;
					m_sprite.graphics.lineTo(v.x, v.y);
				}
				m_sprite.graphics.lineTo(tV.x, tV.y);
				m_sprite.graphics.endFill();
			}
		}
		
		public function drawBound():void
		{
			var m_sprite:Sprite = Main.m_sprite;
			m_sprite.graphics.lineStyle(1,0xFF0000,1);
			m_sprite.graphics.moveTo(bound.x, bound.y);
			m_sprite.graphics.lineTo(bound.width, bound.y);
			m_sprite.graphics.lineTo(bound.width, bound.height);
			m_sprite.graphics.lineTo(bound.x, bound.height);
			m_sprite.graphics.lineTo(bound.x, bound.y);
		}
		
		public function setBody(b2body:b2Body):void
		{
			body = b2body;
		}
		
		public function update():void
		{
			draw();
			//drawBound();
		}
	}
}