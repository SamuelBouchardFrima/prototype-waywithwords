package com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.inventory
{
	import flash.events.Event;
	
	public class InventoryEvent extends Event
	{
		public static const ITEM_ADDED:String = "InventoryEvent::ITEM_ADDED";
		
		public var EventItem:Item;
		
		public function InventoryEvent(type:String, aItem:Item, bubbles:Boolean=false, cancelable:Boolean=false)
		{
			super(type, bubbles, cancelable);
			
			EventItem = aItem;
		}
		
		public override function clone():Event
		{
			return new InventoryEvent(type, EventItem, bubbles, cancelable);
		}
		
		public override function toString():String
		{
			return formatToString("InventoryEvent", "type", "bubbles", "cancelable", "eventPhase");
		}
	}
}