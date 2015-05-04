package com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.keyboard
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.ui.Keyboard;
	
	public class KeyboardManager extends EventDispatcher implements IKeyboardManager
	{
		private static var mInstance:KeyboardManager = new KeyboardManager();
		
		public static function get Instance():IKeyboardManager
		{
			return mInstance;
		}
		
		private var mKeyboardDispatcher:Stage;
		
		public function set KeyboardDispatcher(aValue:Stage):void
		{
			mKeyboardDispatcher = aValue;
			mKeyboardDispatcher.addEventListener(KeyboardEvent.KEY_DOWN, OnKeyDown);
			mKeyboardDispatcher.addEventListener(MouseEvent.MOUSE_UP, OnMouseUp);
		}
		
		public function KeyboardManager(aTarget:IEventDispatcher = null)
		{
			super(aTarget);
			
			if (mInstance)
			{
				throw new Error("KeyboardManager is a singleton not intended for instantiation. Use KeyboardManager.Instance instead.");
			}
		}
		
		public function Dispose():void
		{
			if (mKeyboardDispatcher)
			{
				mKeyboardDispatcher.removeEventListener(KeyboardEvent.KEY_DOWN, OnKeyDown);
				mKeyboardDispatcher.removeEventListener(MouseEvent.MOUSE_UP, OnMouseUp);
			}
		}
		
		private function OnKeyDown(aEvent:KeyboardEvent):void
		{
			switch (aEvent.keyCode)
			{
				case Keyboard.ESCAPE:
					dispatchEvent(new KeyboardManagerEvent(KeyboardManagerEvent.REQUEST_LEAVE));
					break;
				case Keyboard.BACKSPACE:
					dispatchEvent(new KeyboardManagerEvent(KeyboardManagerEvent.ERASE_LAST));
					break;
				case Keyboard.DELETE:
					dispatchEvent(new KeyboardManagerEvent(KeyboardManagerEvent.ERASE_ALL));
					break;
				case Keyboard.ENTER:
					dispatchEvent(new KeyboardManagerEvent(KeyboardManagerEvent.REQUEST_SUBMIT));
					break;
				default:
					dispatchEvent(new KeyboardManagerEvent(KeyboardManagerEvent.TYPE, String.fromCharCode(aEvent.charCode)));
					break;
			}
		}
		
		private function OnMouseUp(aEvent:MouseEvent):void
		{
			mKeyboardDispatcher.focus = mKeyboardDispatcher;
		}
	}
}