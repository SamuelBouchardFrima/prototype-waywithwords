package com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.scene
{
	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	public class InteractiveObject extends Sprite
	{
		protected var mStateList:Vector.<InteractiveObjectState>;
		protected var mState:InteractiveObjectState;
		protected var mStateBreadcrumb:Vector.<InteractiveObjectState>;
		protected var mDialogFormat:TextFormat;
		protected var mDialog:TextField;
		protected var mPicture:Bitmap;
		
		public function InteractiveObject(aStateList:Vector.<InteractiveObjectState>)
		{
			super();
			
			if (aStateList.length <= 0)
			{
				throw new Error("An InteractiveObject requires a non-empty state list to be created.");
			}
			
			mDialogFormat = new TextFormat();
			mDialogFormat.size = 40;
			
			mDialog = new TextField();
			mDialog.multiline = true;
			mDialog.wordWrap = true;
			mDialog.autoSize = TextFieldAutoSize.LEFT;
			mDialog.width = 450;
			mDialog.height = 200;
			mDialog.x = 120;
			mDialog.setTextFormat(mDialogFormat);
			mDialog.selectable = false;
			addChild(mDialog);
			
			mStateBreadcrumb = new Vector.<InteractiveObjectState>();
			mStateList = aStateList;
		}
		
		public function SetState(aID:int, aProgressBreadcrumb:Boolean = true):void
		{
			if (mStateList[aID] == mState)
			{
				return;
			}
			
			if (mPicture)
			{
				removeChild(mPicture);
			}
			
			if (mState != null && aProgressBreadcrumb)
			{
				mStateBreadcrumb.push(mState);
			}
			
			mState = mStateList[aID];
			mPicture = mState.Picture;
			addChild(mPicture);
			
			dispatchEvent(new InteractiveObjectEvent(InteractiveObjectEvent.STATE_CHANGE, mState.LetterSelection,
				mState.ShowInventory));
		}
		
		public function RewindDialog():void
		{
			if (mStateBreadcrumb.length <= 0)
			{
				return;
			}
			
			var id:int = mStateBreadcrumb.pop().ID;
			SetState(id, false);
		}
		
		public function HandleInput(aInput:String):void
		{
			throw new Error("InteractiveObject::HandleInput is an abstract method which requires overriding.");
		}
	}
}