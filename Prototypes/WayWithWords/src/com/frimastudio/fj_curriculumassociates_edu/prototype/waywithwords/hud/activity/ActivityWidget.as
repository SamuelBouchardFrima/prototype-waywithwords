package com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud.activity
{
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud.RetractableWidget;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud.WidgetIconButton;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.inventory.Inventory;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.scene.level1.Level1;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.scene.SceneManager;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.scene.transition.BlackFadeTransition;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class ActivityWidget extends RetractableWidget
	{
		private var mResetButton:WidgetIconButton;
		
		public function ActivityWidget(aRetractedAnchor:Point, aDeployedAnchor:Point)
		{
			super(aRetractedAnchor, aDeployedAnchor);
			
			var buttonRect:Rectangle = new Rectangle(-20, -20, 40, 40);
			
			mResetButton = new WidgetIconButton(Asset.ResetIconBitmap, buttonRect, 0xCC0000);
			mResetButton.x = 0;
			mResetButton.y = 0;
			mResetButton.addEventListener(MouseEvent.CLICK, OnReset);
			addChild(mResetButton);
		}
		
		override public function Dispose():void
		{
			super.Dispose();
		}
		
		private function OnReset(aEvent:MouseEvent):void
		{
			Level1.Instance.Reset();
			Inventory.Instance.Reset();
			SceneManager.Instance.ShowTransition(new BlackFadeTransition(SceneManager.Instance.CurrentScene, Level1.Instance.LevelScene, 2000));
		}
	}
}