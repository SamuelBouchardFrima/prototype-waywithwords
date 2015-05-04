package com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.scene
{
	import flash.events.Event;
	
	public class InteractiveObjectEvent extends Event
	{
		public static const STATE_CHANGE:String = "InteractiveObjectEvent::STATE_CHANGE";
		public static const STATE_BLOCK:String = "InteractiveObjectEvent::STATE_BLOCK";
		public static const INPUT_SUCCESS:String = "InteractiveObjectEvent::INPUT_SUCCESS";
		public static const INPUT_ERROR:String = "InteractiveObjectEvent::INPUT_ERROR";
		
		public var State:InteractiveObjectState;
		
		public function InteractiveObjectEvent(type:String, aState:InteractiveObjectState = null, bubbles:Boolean = false,
			cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			State = aState;
		}
		
		public override function clone():Event
		{
			return new InteractiveObjectEvent(type, State, bubbles, cancelable);
		}
		
		public override function toString():String
		{
			return formatToString("InteractiveObjectEvent", "type", "bubbles", "cancelable", "eventPhase");
		}
	}
}