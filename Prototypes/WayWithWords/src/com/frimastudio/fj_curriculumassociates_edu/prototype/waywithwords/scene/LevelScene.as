package com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.scene
{
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud.activity.ActivityWidget;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud.Composition;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud.inventory.InventoryWidget;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud.Widget;
	import flash.display.Sprite;
	import flash.geom.Point;
	
	public class LevelScene extends Scene
	{
		protected var mActivityWidget:ActivityWidget;
		protected var mInventoryWidget:InventoryWidget;
		
		public function LevelScene()
		{
			super();
			
			mActivityWidget = new ActivityWidget(new Point(50, -50), new Point(50, 50));
			
			mInventoryWidget = new InventoryWidget(new Point(800 + 150, 150), new Point(800 - 80, 150));
			
			var widgetList:Vector.<Widget> = new Vector.<Widget>();
			widgetList.push(mActivityWidget);
			widgetList.push(mInventoryWidget);
			
			mHudComposition = new Composition(widgetList);
		}
	}
}