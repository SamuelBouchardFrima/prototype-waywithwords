package com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.scene.transition
{
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.scene.Scene;
	import flash.events.Event;
	
	public class TransitionEvent extends Event
	{
		public static const TRANSITION_START:String = "TransitionEvent::TRANSITION_START";
		public static const SCENE_CHANGE:String = "TransitionEvent::SCENE_CHANGE";
		public static const TRANSITION_END:String = "TransitionEvent::TRANSITION_END";
		
		private var mSceneOut:Scene;
		
		public function get SceneOut():Scene
		{
			return mSceneOut;
		}
		
		public function TransitionEvent(type:String, aSceneOut:Scene = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			mSceneOut = aSceneOut;
		}
		
		public override function clone():Event
		{
			return new TransitionEvent(type, mSceneOut, bubbles, cancelable);
		}
		
		public override function toString():String
		{
			return formatToString("TransitionEvent", "type", "bubbles", "cancelable", "eventPhase");
		}
	}
}