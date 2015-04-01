package com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.scene
{
	import flash.events.Event;
	
	public class InteractiveObjectEvent extends Event
	{
		public static const STATE_CHANGE:String = "InteractiveObjectEvent::STATE_CHANGE";
		
		public var LetterSelection:String;
		
		public function InteractiveObjectEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		public override function clone():Event
		{
			return new InteractiveObjectEvent(type, bubbles, cancelable);
		}
		
		public override function toString():String
		{
			return formatToString("InteractiveObjectEvent", "type", "bubbles", "cancelable", "eventPhase");
		}
	}
}