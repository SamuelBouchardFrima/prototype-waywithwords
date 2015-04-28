package com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.keyboard
{
	import flash.events.Event;
	
	public class KeyboardManagerEvent extends Event
	{
		public static const REQUEST_LEAVE:String = "KeyboardManagerEvent::REQUEST_LEAVE";
		public static const ERASE_LAST:String = "KeyboardManagerEvent::ERASE_LAST";
		public static const ERASE_ALL:String = "KeyboardManagerEvent::ERASE_ALL";
		public static const REQUEST_SUBMIT:String = "KeyboardManagerEvent::REQUEST_SUBMIT";
		public static const TYPE:String = "KeyboardManagerEvent::TYPE";
		
		private var mCharacter:String;
		
		public function get Character():String
		{
			return mCharacter;
		}
		
		public function KeyboardManagerEvent(type:String, aCharacter:String = null, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			mCharacter = aCharacter;
		}
		
		public override function clone():Event
		{
			return new KeyboardManagerEvent(type, mCharacter, bubbles, cancelable);
		}
		
		public override function toString():String
		{
			return formatToString("KeyboardManagerEvent", "type", "bubbles", "cancelable", "eventPhase");
		}
	}
}