package com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud.navigation
{
	import flash.events.Event;
	
	public class NavigationEvent extends Event
	{
		public static const REWIND:String = "NavigationEvent::REWIND";
		
		public function NavigationEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		public override function clone():Event
		{
			return new NavigationEvent(type, bubbles, cancelable);
		}
		
		public override function toString():String
		{
			return formatToString("NavigationEvent", "type", "bubbles", "cancelable", "eventPhase");
		}
	}
}