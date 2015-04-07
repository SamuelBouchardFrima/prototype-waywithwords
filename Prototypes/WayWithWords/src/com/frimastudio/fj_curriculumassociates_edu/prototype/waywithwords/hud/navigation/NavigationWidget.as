package com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud.navigation
{
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud.RetractableWidget;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud.WidgetButton;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	public class NavigationWidget extends RetractableWidget
	{
		private var mRewindButton:WidgetButton;
		private var mLeaveButton:WidgetButton;
		
		public function NavigationWidget(aRetractedAnchor:Point, aDeployedAnchor:Point)
		{
			super(aRetractedAnchor, aDeployedAnchor);
			
			var buttonRect:Rectangle = new Rectangle( -20, -20, 40, 40);
			
			mRewindButton = new WidgetButton("<", buttonRect, 0xCCCC00);
			mRewindButton.x = 0;
			mRewindButton.y = 0;
			mRewindButton.addEventListener(MouseEvent.CLICK, OnRewind);
			addChild(mRewindButton);
			
			mLeaveButton = new WidgetButton("X", buttonRect, 0xCC0000);
			mLeaveButton.x = 700;
			mLeaveButton.y = 0;
			mLeaveButton.addEventListener(MouseEvent.CLICK, OnLeave);
			addChild(mLeaveButton);
		}
		
		private function OnRewind(aEvent:MouseEvent):void
		{
			dispatchEvent(new NavigationEvent(NavigationEvent.REWIND));
		}
		
		private function OnLeave(aEvent:MouseEvent):void
		{
			dispatchEvent(new NavigationEvent(NavigationEvent.LEAVE));
		}
	}
}