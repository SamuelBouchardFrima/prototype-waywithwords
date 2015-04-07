package com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.scene
{
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud.Composition;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud.interactioninput.InteractionInputEvent;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud.interactioninput.InteractionInputWidget;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud.inventory.InventoryWidget;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud.navigation.NavigationEvent;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud.navigation.NavigationWidget;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud.Widget;
	import flash.geom.Point;
	
	public class InteractiveObjectScene extends Scene
	{
		protected var mNavigationWidget:NavigationWidget;
		protected var mInputWidget:InteractionInputWidget;
		protected var mInventoryWidget:InventoryWidget;
		protected var mInteractiveObject:InteractiveObject;
		
		public function get MainObject():InteractiveObject
		{
			return mInteractiveObject;
		}
		
		public function InteractiveObjectScene()
		{
			super();
			
			mNavigationWidget = new NavigationWidget(new Point(50, -50), new Point(50, 50));
			mNavigationWidget.addEventListener(NavigationEvent.REWIND, OnRewind);
			mNavigationWidget.addEventListener(NavigationEvent.LEAVE, OnLeave);
			
			mInputWidget = new InteractionInputWidget(new Point(100, 600 + 120), new Point(100, 600 - 100));
			mInputWidget.addEventListener(InteractionInputEvent.SUBMIT, OnSubmitInteractionInput);
			
			mInventoryWidget = new InventoryWidget(new Point(800 + 150, 150), new Point(800 - 80, 150));
			
			var widgetList:Vector.<Widget> = new Vector.<Widget>();
			widgetList.push(mNavigationWidget);
			widgetList.push(mInputWidget);
			widgetList.push(mInventoryWidget);
			
			mHudComposition = new Composition(widgetList);
			
			mInteractiveObject.x = 60;
			mInteractiveObject.y = 100;
			mInteractiveObject.addEventListener(InteractiveObjectEvent.STATE_CHANGE, OnStateChange);
			mInteractiveObject.addEventListener(InteractiveObjectEvent.ENABLE_REWIND, OnEnableRewind);
			mInteractiveObject.SetState(0);
			addChild(mInteractiveObject);
			
			mNavigationWidget.RewindDisabled = true;
		}
		
		override public function Dispose():void
		{
			mNavigationWidget.removeEventListener(NavigationEvent.REWIND, OnRewind);
			mNavigationWidget.removeEventListener(NavigationEvent.LEAVE, OnLeave);
			mInputWidget.removeEventListener(InteractionInputEvent.SUBMIT, OnSubmitInteractionInput);
			mInteractiveObject.removeEventListener(InteractiveObjectEvent.STATE_CHANGE, OnStateChange);
			mInteractiveObject.removeEventListener(InteractiveObjectEvent.ENABLE_REWIND, OnEnableRewind);
			
			super.Dispose();
		}
		
		protected function OnRewind(aEvent:NavigationEvent):void
		{
			mInteractiveObject.ResetToCurrentState();
			mNavigationWidget.RewindDisabled = true;
		}
		
		protected function OnLeave(aEvent:NavigationEvent):void
		{
			SceneManager.Instance.LeaveScene(this);
		}
		
		protected function OnSubmitInteractionInput(aEvent:InteractionInputEvent):void
		{
			mInteractiveObject.HandleInput(aEvent.Input);
		}
		
		protected function OnStateChange(aEvent:InteractiveObjectEvent):void
		{
			mInputWidget.SetLetterSelection(aEvent.State.LetterSelection);
			mNavigationWidget.RewindDisabled = true;
		}
		
		protected function OnEnableRewind(aEvent:InteractiveObjectEvent):void
		{
			mNavigationWidget.RewindDisabled = false;
		}
	}
}