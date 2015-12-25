package tetris.physic
{
	import Box2D.Collision.Shapes.b2BoxDef;
	import Box2D.Collision.Shapes.b2CircleDef;
	import Box2D.Collision.Shapes.b2PolyDef;
	import Box2D.Common.Math.b2Mat22;
	import Box2D.Common.Math.b2Math;
	import Box2D.Dynamics.b2BodyDef;
	
	import TestBed.Test;
	
	import flash.display.Sprite;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import tetris.util.GameHelper;
	import tetris.model.TetrisModelLocator;
	import Box2D.Collision.b2AABB;
	import Box2D.Collision.Shapes.b2Shape;
	import Box2D.Collision.Shapes.b2PolyShape;
	import Box2D.Collision.b2Pair;
	import Box2D.Common.b2Settings;
	import Box2D.Dynamics.Joints.b2Joint;
	import Box2D.Dynamics.Joints.b2JointNode;
	
	public class GameGroup extends Test
	{
		private var border:BorderGroup;
		private var pieces:Array;
		private var cnt:int = 0;
		
		public function GameGroup()
		{
			init();
		}
		
		private function init():void
		{
			pieces = new Array();
			
			border = new BorderGroup(0, 0);
			border.setBody(m_world.CreateBody(border));
		}
		
		override public function Update():void
		{

			if(cnt % 50 == 0)
			{
				var piece:PieceGroup = new PieceGroup();
				piece.setBody(m_world.CreateBody(piece));
				pieces.push(piece);
			}
			cnt++;
			
			GameHelper.clear();
			
			m_sprite.graphics.clear()
			
			super.Update();
			
			border.update();
			for(var i:int = 0;i<pieces.length;i++)
			{
				pieces[i].update();
			}
			
			//drawSquare(100, 100);
			checkRow();
		}
		
		private function drawSquare(x:int, y:int):void
		{
			m_sprite.graphics.lineStyle(1, 0xFF0000, 1);
			m_sprite.graphics.moveTo(x,y);
			m_sprite.graphics.lineTo(x+10, y);
			m_sprite.graphics.lineTo(x+10, y+10);
			m_sprite.graphics.lineTo(x, y+10);
			m_sprite.graphics.lineTo(x, y);
		}
		
		public function checkRow():void
		{
			var model:TetrisModelLocator = TetrisModelLocator.getInstance();
			var cw:int = model.settings.cellWidth;
			var bodies:Array = new Array();
			for(var y:int = 0;y<model.settings.rows;y++)
			{
				var rowhit:Array = new Array();
				for(var x:int = 0;x<model.settings.cols;x++)
				{
					var posx:int = cw / 2 + x * cw;
					var posy:int = cw / 2 + y * cw;

					var testPVec:b2Vec2 = new b2Vec2();
					testPVec.Set(posx, posy);
					var aabb:b2AABB = new b2AABB();
					aabb.minVertex.Set(posx - 0.001, posy - 0.001);
					aabb.maxVertex.Set(posx + 0.001, posy + 0.001);
					
					// Query the world for overlapping shapes.
					var k_maxCount:int = 10;
					var shapes:Array = new Array();
					var count:int = m_world.Query(aabb, shapes, k_maxCount);
					var body:b2Body = null;
					for (var i:int = 0; i < count; ++i)
					{
						if (shapes[i].m_body.IsStatic() == false)
						{
							var inside:Boolean = shapes[i].TestPoint(testPVec);
							if (inside)
							{
								body = shapes[i].m_body;
								var exist:Boolean = false;
								for(var j  = 0;j<rowhit.length;j++)
								{
									if(rowhit[j] == shapes[i])
									{
										exist = true;
										break;
									} 
									
								}
								if(!exist) rowhit.push(shapes[i]);
								//drawSquare(posx - cw/4, posy-cw/4);
								break;
							}
						}
					}
				}
				
				if(rowhit.length == model.settings.cols)
				{
					//drawSquare(0, posy);
					//m_world.DestroyBody(body);
					//body = null;
//					body.Destroy();
					//body.Freeze();
					//body.Destroy();
					//body.m_shapeCount = 0;
					
					for(var k:int = 0;k<rowhit.length;k++)
					{
						var shape:b2PolyShape = rowhit[k];
						var piece:b2Body = shape.m_body;
						
						
						//for (var jj:b2JointNode = piece.m_jointList; jj; jj = jj.next){
						//	m_world.DestroyJoint(jj);
						//}

						piece.m_position.y = model.settings.rows * model.settings.cellWidth + 200;
					}
				} 
			}
		}
	}
}