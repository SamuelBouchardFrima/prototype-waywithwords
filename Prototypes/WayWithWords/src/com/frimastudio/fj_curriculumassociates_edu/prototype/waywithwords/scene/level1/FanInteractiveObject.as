package com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.scene.level1
{
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.inventory.Inventory;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.inventory.Item;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.scene.InteractiveObject;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.scene.InteractiveObjectEvent;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.scene.InteractiveObjectState;
	
	public class FanInteractiveObject extends InteractiveObject
	{
		public function FanInteractiveObject()
		{
			var stateList:Vector.<InteractiveObjectState> = new Vector.<InteractiveObjectState>();
			stateList.push(new InteractiveObjectState(0, "Petrified", new Asset.FanObjectBitmap(), "tnaf"));
			stateList.push(new InteractiveObjectState(1, "Collected"));
			
			super(stateList);
		}
		
		override public function SetState(aID:int, aProgressBreadcrumb:Boolean = true):void
		{
			super.SetState(aID, aProgressBreadcrumb);
			
			switch (mState.Name)
			{
				case "Petrified":
					mDialog.text = "The object is turned stone.\nWhat is its name?";
					break;
				case "Collected":
					mDialog.text = "It is a fan.";
					break;
				default:
					break;
			}
			mDialog.setTextFormat(mDialogFormat);
		}
		
		override public function HandleInput(aInput:String):void
		{
			switch (mState.Name)
			{
				case "Petrified":
					HandleInputFromPetrifiedState(aInput);
					break;
				default:
					break;
			}
		}
		
		private function HandleInputFromPetrifiedState(aInput:String):void
		{
			if (aInput == "fan")
			{
				Inventory.Instance.AddItem(Item.FAN);
				SetState(1);
			}
			else
			{
				mDialog.text = "It is not its name.\nWhat is its name?";
				dispatchEvent(new InteractiveObjectEvent(InteractiveObjectEvent.STATE_CHANGE, mState.LetterSelection,
					mState.ShowInventory));
			}
			mDialog.setTextFormat(mDialogFormat);
		}
	}
}