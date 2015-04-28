package com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud.inventory
{
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud.RetractableWidget;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.inventory.Inventory;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.inventory.InventoryEvent;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.inventory.Item;
	import flash.display.Bitmap;
	import flash.geom.Point;
	
	public class InventoryWidget extends RetractableWidget
	{
		private var mIconList:Vector.<Bitmap>;
		
		public function InventoryWidget(aRetractedAnchor:Point, aDeployedAnchor:Point)
		{
			super(aRetractedAnchor, aDeployedAnchor);
			
			graphics.lineStyle(1, 0xCCCCCC);
			graphics.moveTo(-45, -120);
			graphics.lineTo(45, -120);
			graphics.lineTo(45, 140);
			graphics.lineTo(-45, 140);
			graphics.lineTo(-45, -120);
			graphics.moveTo(-45, -40);
			graphics.lineTo(45, -40);
			
			var inventoryIcon:Bitmap = new Asset.InventoryIconBitmap();
			inventoryIcon.width = inventoryIcon.height = 60;
			inventoryIcon.x = -30;
			inventoryIcon.y = -110;
			addChild(inventoryIcon);
			
			mIconList = new Vector.<Bitmap>();
			
			AddIcon(Asset.MatIconBitmap, Inventory.Instance.HasItem(Item.MAT));
			AddIcon(Asset.FanIconBitmap, Inventory.Instance.HasItem(Item.FAN));
			
			Inventory.Instance.addEventListener(InventoryEvent.RESET, OnReset);
			Inventory.Instance.addEventListener(InventoryEvent.ITEM_ADDED, OnItemAdded);
			Inventory.Instance.addEventListener(InventoryEvent.ITEM_USED, OnItemUsed);
		}
		
		override public function Dispose():void
		{
			Inventory.Instance.removeEventListener(InventoryEvent.RESET, OnReset);
			Inventory.Instance.removeEventListener(InventoryEvent.ITEM_ADDED, OnItemAdded);
			Inventory.Instance.removeEventListener(InventoryEvent.ITEM_USED, OnItemUsed);
			
			super.Dispose();
		}
		
		private function AddIcon(aAsset:Class, aCollected:Boolean):void
		{
			var icon:Bitmap = new aAsset();
			icon.x = 0 - (icon.width / 2);
			icon.y = mIconList.length * 85 - (icon.height / 2);
			mIconList.push(icon);
			if (aCollected)
			{
				addChild(icon);
			}
		}
		
		private function OnReset(aEvent:InventoryEvent):void
		{
			for (var i:int = 0, end:int = mIconList.length; i < end; ++i)
			{
				mIconList[i].alpha = 1;
				if (contains(mIconList[i]))
				{
					removeChild(mIconList[i]);
				}
			}
		}
		
		private function OnItemAdded(aEvent:InventoryEvent):void
		{
			addChild(mIconList[aEvent.EventItem.ID]);
		}
		
		private function OnItemUsed(aEvent:InventoryEvent):void
		{
			mIconList[aEvent.EventItem.ID].alpha = 0.5;
		}
	}
}