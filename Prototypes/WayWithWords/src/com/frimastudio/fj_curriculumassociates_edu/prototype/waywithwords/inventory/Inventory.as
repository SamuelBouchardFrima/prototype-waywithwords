package com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.inventory
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	
	public class Inventory extends EventDispatcher implements IInventory
	{
		private static var sInstance:Inventory = new Inventory();
		
		public static function get Instance():IInventory
		{
			return sInstance;
		}
		
		private var mItemList:Vector.<Item>;
		
		public function Inventory(target:IEventDispatcher = null)
		{
			super(target);
			
			if (sInstance != null)
			{
				throw new Error("Inventory is a singleton. Use \"Inventory.Instance\" instead.");
			}
			
			mItemList = new Vector.<Item>();
		}
		
		public function Reset():void
		{
			mItemList.splice(0, mItemList.length);
			dispatchEvent(new InventoryEvent(InventoryEvent.RESET));
		}
		
		public function AddItem(aItem:Item):void
		{
			if (!HasItem(aItem))
			{
				mItemList.push(aItem);
				aItem.State = ItemState.COLLECTED;
				dispatchEvent(new InventoryEvent(InventoryEvent.ITEM_ADDED, aItem));
			}
		}
		
		public function HasItem(aItem:Item):Boolean
		{
			return mItemList.indexOf(aItem) > -1;
		}
		
		public function UseItem(aItem:Item):void
		{
			if (HasItem(aItem))
			{
				if (aItem.State != ItemState.USED)
				{
					aItem.State = ItemState.USED;
					dispatchEvent(new InventoryEvent(InventoryEvent.ITEM_USED, aItem));
				}
			}
		}
	}
}