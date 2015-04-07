package com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.scene
{
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.inventory.Inventory;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.inventory.Item;
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
		protected var mOwnedItemList:Vector.<Bitmap>;
		
		public function get State():InteractiveObjectState
		{
			return mState;
		}
		
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
			
			mOwnedItemList = new Vector.<Bitmap>();
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
			if (mPicture)
			{
				addChild(mPicture);
				addChild(mDialog);
			}
			
			dispatchEvent(new InteractiveObjectEvent(InteractiveObjectEvent.STATE_CHANGE, mState));
		}
		
		protected function DispatchTrivialStateChange():void 
		{
			dispatchEvent(new InteractiveObjectEvent(InteractiveObjectEvent.STATE_CHANGE, mState));
			dispatchEvent(new InteractiveObjectEvent(InteractiveObjectEvent.ENABLE_REWIND, mState));
		}
		
		public function ResetToCurrentState():void
		{
			SetState(mState.ID);
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
		
		protected function UseItem(aItem:Item):void
		{
			Inventory.Instance.UseItem(aItem);
			
			var item:Bitmap;
			switch (aItem)
			{
				case Item.MAT:
					item = new Asset.MatIconBitmap();
					break;
				case Item.FAN:
					item = new Asset.FanIconBitmap();
					break;
				default:
					break;
			}
			
			item.x = 120 + (mOwnedItemList.length * 85);
			item.y = 130;
			addChild(item);
			mOwnedItemList.push(item);
		}
	}
}