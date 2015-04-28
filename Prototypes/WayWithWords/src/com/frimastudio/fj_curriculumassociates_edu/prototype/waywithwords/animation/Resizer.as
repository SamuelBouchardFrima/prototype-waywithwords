package com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.animation 
{
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.util.Random;
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	
	public class Resizer extends Animator
	{
		protected var mStrength:Number;
		protected var mOrigin:Point;
		
		public function Resizer(aTarget:DisplayObject, aDuration:int, aStrength:Number)
		{
			super(aTarget, aDuration);
			
			mStrength = aStrength;
			mOrigin = new Point(mTarget.scaleX, mTarget.scaleY);
		}
		
		override protected function OnEnterFrame(aEvent:Event):void
		{
			if (mTarget.scaleX == mOrigin.x * mStrength && mTarget.scaleY == mOrigin.y * mStrength)
			{
				mTarget.scaleX = mOrigin.x / mStrength;
				mTarget.scaleY = mOrigin.y / mStrength;
			}
			else if (mTarget.scaleX == mOrigin.x / mStrength && mTarget.scaleY == mOrigin.y / mStrength)
			{
				mTarget.scaleX = mOrigin.x * mStrength;
				mTarget.scaleY = mOrigin.y * mStrength;
			}
			else
			{
				if (Random.Bool())
				{
					mTarget.scaleX = mOrigin.x * mStrength;
					mTarget.scaleY = mOrigin.y * mStrength;
				}
				else
				{
					mTarget.scaleX = mOrigin.x / mStrength;
					mTarget.scaleY = mOrigin.y / mStrength;
				}
			}
		}
		
		override protected function OnTimerComplete(aEvent:TimerEvent):void
		{
			mTarget.scaleX = mOrigin.x;
			mTarget.scaleY = mOrigin.y;
			
			super.OnTimerComplete(aEvent);
		}
	}
}