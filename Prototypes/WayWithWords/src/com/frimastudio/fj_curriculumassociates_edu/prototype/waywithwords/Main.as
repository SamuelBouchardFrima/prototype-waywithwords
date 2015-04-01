package com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords
{
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud.Composition;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud.HUD;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud.interactioninput.InteractionInputEvent;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud.Widget;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud.interactioninput.InteractionInputWidget;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.scene.InteractiveObjectEvent;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.scene.InteractiveObjectState;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.scene.SamInteractiveObject;
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	
	public class Main extends Sprite
	{
		private var mSceneContainer:Sprite;
		private var mInputWidget:InteractionInputWidget;
		private var mSam:SamInteractiveObject;
		
		public function Main():void
		{
			stage != null ? Init() : addEventListener(Event.ADDED_TO_STAGE, Init);
		}
		
		private function Init(aEvent:Event = null):void
		{
			removeEventListener(Event.ADDED_TO_STAGE, Init);
			
			// entry point
			
			addChild(mSceneContainer = new Sprite());
			addChild(HUD.Instance as DisplayObject);
			
			mInputWidget = new InteractionInputWidget(new Point(100, stage.stageHeight + 120), new Point(100, stage.stageHeight - 100));
			mInputWidget.addEventListener(InteractionInputEvent.REWIND, OnRewindInteractionInput);
			mInputWidget.addEventListener(InteractionInputEvent.SUBMIT, OnSubmitInteractionInput);
			
			var widgetList:Vector.<Widget> = new Vector.<Widget>();
			widgetList.push(mInputWidget);
			
			var hudComposition:Composition = new Composition(widgetList);
			HUD.Instance.ChangeComposition(hudComposition);
			
			mSam = new SamInteractiveObject();
			mSam.x = 100;
			mSam.y = 100;
			mSam.addEventListener(InteractiveObjectEvent.STATE_CHANGE, OnSamStateChange);
			mSam.SetState(0);
			mSceneContainer.addChild(mSam);
		}
		
		private function Dispose():void
		{
			mInputWidget.removeEventListener(InteractionInputEvent.SUBMIT, OnSubmitInteractionInput);
		}
		
		private function OnRewindInteractionInput(aEvent:InteractionInputEvent):void
		{
			mSam.RewindDialog();
		}
		
		private function OnSubmitInteractionInput(aEvent:InteractionInputEvent):void
		{
			mSam.HandleInput(aEvent.Input);
		}
		
		private function OnSamStateChange(aEvent:InteractiveObjectEvent):void
		{
			mInputWidget.SetLetterSelection(aEvent.LetterSelection);
		}
	}
}