package com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud
{
	import flash.display.Sprite;
	
	public class HUD extends Sprite implements IHUD
	{
		private static var sInstance:HUD = new HUD();
		
		public static function get Instance():IHUD
		{
			return sInstance;
		}
		
		private var mCurrentComposition:Composition;
		
		public function HUD()
		{
			if (sInstance != null)
			{
				throw new Error("HUD is a singleton. Use \"HUD.Instance\" instead.");
			}
		}
		
		public function ChangeComposition(aComposition:Composition):void
		{
			var i:int, end:int;
			
			// handle removal of previous composition
			for (i = numChildren - 1, end = 0; i >= end; --i)
			{
				removeChildAt(i);
			}
			
			// handle application of new composition
			mCurrentComposition = aComposition;
			for (i = 0, end = mCurrentComposition.WidgetList.length; i < end; ++i)
			{
				addChild(mCurrentComposition.WidgetList[i]);
			}
		}
	}
}