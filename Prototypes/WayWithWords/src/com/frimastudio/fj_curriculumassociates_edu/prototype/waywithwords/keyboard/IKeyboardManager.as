package com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.keyboard
{
	import flash.display.Stage;
	import flash.events.IEventDispatcher;
	
	public interface IKeyboardManager extends IEventDispatcher
	{
		function set KeyboardDispatcher(aValue:Stage):void;
	}
}