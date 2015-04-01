package com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud.interactioninput
{
	import flash.events.Event;
	
	public class InteractionInputEvent extends Event
	{
		public static const REWIND:String = "InteractionInputEvent::REWIND";
		public static const SUBMIT:String = "InteractionInputEvent::SUBMIT";
		
		public var Input:String;
		
		public function InteractionInputEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		public override function clone():Event
		{
			return new InteractionInputEvent(type, bubbles, cancelable);
		}
		
		public override function toString():String
		{
			return formatToString("InteractionInputEvent", "type", "bubbles", "cancelable", "eventPhase");
		}
	}
}