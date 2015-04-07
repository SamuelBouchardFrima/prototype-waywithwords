package com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud
{
	import flash.geom.Rectangle;
	
	public class DisablableWidgetButton extends WidgetButton
	{
		private var mRect:Rectangle;
		private var mColor:int;
		private var mDisabledColor:int;
		private var mDisabled:Boolean;
		
		public function get Disabled():Boolean
		{
			return mDisabled;
		}
		public function set Disabled(aValue:Boolean):void
		{
			mDisabled = aValue;
			
			graphics.beginFill(mDisabled ? mDisabledColor : mColor);
			graphics.lineStyle(2);
			graphics.drawRect(mRect.x, mRect.y, mRect.width, mRect.height);
			graphics.endFill();
		}
		
		public function DisablableWidgetButton(aLabel:String, aRect:Rectangle, aColor:int=0xFFFFFF, aDisabledColor:int=0xCCCCCC)
		{
			super(aLabel, aRect, aColor);
			
			mRect = aRect;
			mColor = aColor;
			mDisabledColor = aDisabledColor;
		}
	}
}