package com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud.interactioninput
{
	import flash.events.Event;
	
	public class SelectableLetterEvent extends Event
	{
		public static const SELECTED:String = "SelectableLetterEvent::SELECTED";
		public static const UNSELECTED:String = "SelectableLetterEvent::UNSELECTED";
		
		public function SelectableLetterEvent(type:String, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
		}
		
		public override function clone():Event
		{
			return new SelectableLetterEvent(type, bubbles, cancelable);
		}
		
		public override function toString():String
		{
			return formatToString("SelectableLetterEvent", "type", "bubbles", "cancelable", "eventPhase");
		}
	}
}