package com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud
{
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class Widget extends Sprite
	{
		protected var mAnchor:Point;
		
		public function Widget(aAnchor:Point)
		{
			mAnchor = aAnchor;
			
			x = mAnchor.x;
			y = mAnchor.y;
		}
	}
}