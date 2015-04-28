package com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.animation
{
	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class Animator
	{
		protected var mTarget:DisplayObject;
		protected var mDuration:int;
		protected var mTimer:Timer;
		
		public function Animator(aTarget:DisplayObject, aDuration:int)
		{
			mDuration = aDuration;
			mTarget = aTarget;
			
			mTarget.addEventListener(Event.ENTER_FRAME, OnEnterFrame);
			
			mTimer = new Timer(aDuration, 1);
			mTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnTimerComplete);
			mTimer.start();
		}
		
		protected function OnEnterFrame(aEvent:Event):void
		{
			throw new Error("OnEnterFrame is abstract and requires overriding.");
		}
		
		protected function OnTimerComplete(aEvent:TimerEvent):void
		{
			mTimer.stop();
			mTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, OnTimerComplete);
			
			mTarget.removeEventListener(Event.ENTER_FRAME, OnEnterFrame);
		}
	}
}