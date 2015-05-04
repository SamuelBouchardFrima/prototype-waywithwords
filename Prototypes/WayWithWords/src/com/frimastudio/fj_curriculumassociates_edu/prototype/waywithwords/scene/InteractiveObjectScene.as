package com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.scene
{
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud.Composition;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud.interactioninput.InteractionInputEvent;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud.interactioninput.InteractionInputWidget;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud.inventory.InventoryWidget;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud.navigation.NavigationEvent;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud.navigation.NavigationWidget;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud.Widget;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.scene.transition.BlackFadeTransition;
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
			mInteractiveObject.addEventListener(InteractiveObjectEvent.STATE_BLOCK, OnStateBlock);
			mInteractiveObject.addEventListener(InteractiveObjectEvent.INPUT_SUCCESS, OnInputSuccess);
			mInteractiveObject.addEventListener(InteractiveObjectEvent.INPUT_ERROR, OnInputError);
			mInteractiveObject.SetState(0);
			addChild(mInteractiveObject);
		}
		
		override public function Dispose():void
		{
			mNavigationWidget.removeEventListener(NavigationEvent.LEAVE, OnLeave);
			mInputWidget.removeEventListener(InteractionInputEvent.SUBMIT, OnSubmitInteractionInput);
			mInteractiveObject.removeEventListener(InteractiveObjectEvent.STATE_CHANGE, OnStateChange);
			mInteractiveObject.removeEventListener(InteractiveObjectEvent.STATE_BLOCK, OnStateBlock);
			mInteractiveObject.removeEventListener(InteractiveObjectEvent.INPUT_SUCCESS, OnInputSuccess);
			mInteractiveObject.removeEventListener(InteractiveObjectEvent.INPUT_ERROR, OnInputError);
			
			super.Dispose();
		}
		
		protected function OnLeave(aEvent:NavigationEvent):void
		{
			SceneManager.Instance.ShowTransition(new BlackFadeTransition(this, null, 500));
		}
		
		protected function OnSubmitInteractionInput(aEvent:InteractionInputEvent):void
		{
			mInteractiveObject.HandleInput(aEvent.Input);
		}
		
		protected function OnStateChange(aEvent:InteractiveObjectEvent):void
		{
			mInputWidget.SetLetterSelection(aEvent.State.LetterSelection);
		}
		
		protected function OnStateBlock(aEvent:InteractiveObjectEvent):void
		{
			mNavigationWidget.StateBlocked();
		}
		
		protected function OnInputSuccess(aEvent:InteractiveObjectEvent):void
		{
			mInputWidget.InputSuccess();
		}
		
		protected function OnInputError(aEvent:InteractiveObjectEvent):void
		{
			mInputWidget.InputError();
		}
	}
}