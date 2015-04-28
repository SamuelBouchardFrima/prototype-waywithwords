package com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud.navigation
{
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.animation.Resizer;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud.DisablableWidgetButton;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud.RetractableWidget;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud.WidgetButton;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.keyboard.KeyboardManager;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.keyboard.KeyboardManagerEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class NavigationWidget extends RetractableWidget
	{
		private var mLeaveButton:WidgetButton;
		
		public function NavigationWidget(aRetractedAnchor:Point, aDeployedAnchor:Point)
		{
			super(aRetractedAnchor, aDeployedAnchor);
			
			var buttonRect:Rectangle = new Rectangle(-20, -20, 40, 40);
			
			mLeaveButton = new WidgetButton("<", buttonRect, 0xFFCC00);
			mLeaveButton.x = 0;
			mLeaveButton.y = 0;
			mLeaveButton.addEventListener(MouseEvent.CLICK, OnLeave);
			addChild(mLeaveButton);
			
			KeyboardManager.Instance.addEventListener(KeyboardManagerEvent.REQUEST_LEAVE, OnRequestLeave);
		}
		
		override public function Dispose():void
		{
			mLeaveButton.removeEventListener(MouseEvent.CLICK, OnLeave);
			
			KeyboardManager.Instance.removeEventListener(KeyboardManagerEvent.REQUEST_LEAVE, OnRequestLeave);
			
			super.Dispose();
		}
		
		public function StateBlocked():void
		{
			new Resizer(mLeaveButton, 1200, 1.08);
		}
		
		private function OnLeave(aEvent:MouseEvent):void
		{
			dispatchEvent(new NavigationEvent(NavigationEvent.LEAVE));
		}
		
		private function OnRequestLeave(aEvent:KeyboardManagerEvent):void
		{
			if (!stage)
			{
				return;
			}
			
			dispatchEvent(new NavigationEvent(NavigationEvent.LEAVE));
		}
	}
}