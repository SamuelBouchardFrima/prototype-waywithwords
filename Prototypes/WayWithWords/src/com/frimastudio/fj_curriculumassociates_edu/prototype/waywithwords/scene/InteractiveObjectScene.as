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
		private var mNavigationWidget:NavigationWidget;
		private var mInputWidget:InteractionInputWidget;
		private var mInventoryWidget:InventoryWidget;
		protected var mInteractiveObject:InteractiveObject;
		
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
			mInteractiveObject.SetState(0);
			addChild(mInteractiveObject);
		}
		
		override public function Dispose():void
		{
			mNavigationWidget.removeEventListener(NavigationEvent.REWIND, OnRewind);
			mNavigationWidget.removeEventListener(NavigationEvent.LEAVE, OnLeave);
			mInputWidget.removeEventListener(InteractionInputEvent.SUBMIT, OnSubmitInteractionInput);
			
			super.Dispose();
		}
		
		private function OnRewind(aEvent:NavigationEvent):void
		{
			mInteractiveObject.RewindDialog();
		}
		
		private function OnLeave(aEvent:NavigationEvent):void
		{
			SceneManager.Instance.LeaveScene(this);
		}
		
		private function OnSubmitInteractionInput(aEvent:InteractionInputEvent):void
		{
			mInteractiveObject.HandleInput(aEvent.Input);
		}
		
		private function OnStateChange(aEvent:InteractiveObjectEvent):void
		{
			mInputWidget.SetLetterSelection(aEvent.LetterSelection);
		}
	}
}