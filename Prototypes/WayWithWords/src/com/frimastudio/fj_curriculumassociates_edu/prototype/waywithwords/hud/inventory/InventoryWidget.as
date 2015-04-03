package com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud.inventory
{
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud.RetractableWidget;
	import flash.display.Bitmap;
	import flash.geom.Point;
	
	public class InventoryWidget extends RetractableWidget
	{
		private var mIconList:Vector.<Bitmap>;
		
		public function InventoryWidget(aRetractedAnchor:Point, aDeployedAnchor:Point)
		{
			super(aRetractedAnchor, aDeployedAnchor);
			
			graphics.lineStyle(1, 0xCCCCCC);
			graphics.moveTo(-45, -45);
			graphics.lineTo(45, -45);
			graphics.lineTo(45, 130);
			graphics.lineTo(-45, 130);
			graphics.lineTo(-45, -45);
			
			mIconList = new Vector.<Bitmap>();
			
			AddIcon(Asset.MatBitmap);
			AddIcon(Asset.FanBitmap);
		}
		
		private function AddIcon(aAsset:Class):void
		{
			var icon:Bitmap = new aAsset();
			icon.x = 0 - (icon.width / 2);
			icon.y = mIconList.length * 85 - (icon.height / 2);
			mIconList.push(icon);
			addChild(icon);
		}
	}
}