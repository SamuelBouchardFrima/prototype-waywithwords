package com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.scene.transition
{
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.scene.Scene;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.scene.SceneManager;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class Transition extends Sprite
	{
		protected var mSceneIn:Scene;
		protected var mSceneOut:Scene;
		protected var mDuration:Number;
		protected var mStartTime:Number;
		protected var mChanged:Boolean;
		
		protected function get ElapsedTime():Number
		{
			return (new Date().getTime() - mStartTime);
		}
		
		public function Transition(aSceneIn:Scene, aSceneOut:Scene, aDuration:Number)
		{
			super();
			
			mSceneIn = aSceneIn;
			mSceneOut = aSceneOut;
			mDuration = aDuration;
		}
		
		public function Play():void
		{
			addEventListener(Event.ENTER_FRAME, OnEnterFrame);
			mStartTime = new Date().getTime();
			
			dispatchEvent(new TransitionEvent(TransitionEvent.TRANSITION_START));
		}
		
		protected function OnEnterFrame(aEvent:Event):void
		{
			throw new Error("OnEnterFrame is abstract and requires overriding.");
		}
		
		protected function ChangeScene():void
		{
			mChanged = true;
			
			dispatchEvent(new TransitionEvent(TransitionEvent.SCENE_CHANGE, mSceneOut));
		}
		
		protected function Stop():void
		{
			removeEventListener(Event.ENTER_FRAME, OnEnterFrame);
			
			dispatchEvent(new TransitionEvent(TransitionEvent.TRANSITION_END));
		}
	}
}