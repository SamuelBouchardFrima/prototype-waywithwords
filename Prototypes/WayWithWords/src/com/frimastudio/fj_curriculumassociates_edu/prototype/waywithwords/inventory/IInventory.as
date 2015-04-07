package com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.inventory
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public interface IInventory extends IEventDispatcher
	{
		function AddItem(aItem:Item):void;
		function HasItem(aItem:Item):Boolean;
		function UseItem(aItem:Item):void;
	}
}