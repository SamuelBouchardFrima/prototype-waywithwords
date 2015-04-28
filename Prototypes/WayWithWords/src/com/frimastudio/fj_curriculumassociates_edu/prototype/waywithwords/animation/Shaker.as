package com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.animation 
{
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.util.Random;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	
	public class Shaker extends Animator
	{
		protected var mVector2:Point;
		protected var mOrigin:Point;
		
		public function Shaker(aTarget:DisplayObject, aDuration:int, aVector2:Point)
		{
			super(aTarget, aDuration);
			
			mVector2 = aVector2;
			mOrigin = new Point(aTarget.x, aTarget.y);
		}
		
		override protected function OnEnterFrame(aEvent:Event):void
		{
			if (mTarget.x == mOrigin.x + mVector2.x && mTarget.y == mOrigin.y + mVector2.y)
			{
				mTarget.x = mOrigin.x - mVector2.x;
				mTarget.y = mOrigin.y - mVector2.y;
			}
			else if (mTarget.x == mOrigin.x - mVector2.x && mTarget.y == mOrigin.y - mVector2.y)
			{
				mTarget.x = mOrigin.x + mVector2.x;
				mTarget.y = mOrigin.y + mVector2.y;
			}
			else
			{
				var sign:int = Random.Sign();
				mTarget.x = mOrigin.x + (mVector2.x * sign);
				mTarget.y = mOrigin.y + (mVector2.y * sign);
			}
		}
		
		override protected function OnTimerComplete(aEvent:TimerEvent):void
		{
			mTarget.x = mOrigin.x;
			mTarget.y = mOrigin.y;
			
			super.OnTimerComplete(aEvent);
		}
	}
}