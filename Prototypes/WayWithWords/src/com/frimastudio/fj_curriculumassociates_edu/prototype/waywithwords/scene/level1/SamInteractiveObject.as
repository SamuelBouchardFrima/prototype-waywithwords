package com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.scene.level1
{
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.inventory.Inventory;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.inventory.Item;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.scene.InteractiveObject;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.scene.InteractiveObjectEvent;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.scene.InteractiveObjectState;
	import flash.display.Bitmap;
	
	public class SamInteractiveObject extends InteractiveObject
	{
		public function SamInteractiveObject()
		{
			var stateList:Vector.<InteractiveObjectState> = new Vector.<InteractiveObjectState>();
			stateList.push(new InteractiveObjectState(0, "Petrified", new Asset.Sam00Bitmap(), "aSmt"));
			stateList.push(new InteractiveObjectState(1, "Angry", new Asset.Sam02Bitmap(), "dmas"));
			stateList.push(new InteractiveObjectState(2, "HotTired", new Asset.Sam03Bitmap(), "tnamf", true));
			stateList.push(new InteractiveObjectState(3, "Hot", new Asset.Sam04Bitmap(), "tnamf", true));
			stateList.push(new InteractiveObjectState(4, "Tired", new Asset.Sam05Bitmap(), "tnamf", true));
			stateList.push(new InteractiveObjectState(5, "Happy", new Asset.Sam06Bitmap()));
			
			super(stateList);
		}
		
		override public function SetState(aID:int, aProgressBreadcrumb:Boolean = true):void
		{
			super.SetState(aID, aProgressBreadcrumb);
			
			switch (mState.Name)
			{
				case "Petrified":
					mDialog.text = "The boy is turned stone.\nWhat is his name?";
					break;
				case "Angry":
					mDialog.text = "I am Sam.\nI am sad or mad?";
					break;
				case "HotTired":
					mDialog.text = "I am mad!\nWhat do I need?";
					break;
				case "Hot":
					mDialog.text = "A mat for me!\nWhat else do I need?";
					break;
				case "Tired":
					mDialog.text = "A fan for me!\nWhat else do I need?";
					break;
				case "Happy":
					mDialog.text = "A mat and a fan for me.\nThank you very much!";
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
				case "Angry":
					HandleInputFromAngryState(aInput);
					break;
				case "HotTired":
					HandleInputFromHotTiredState(aInput);
					break;
				case "Hot":
					HandleInputFromHotState(aInput);
					break;
				case "Tired":
					HandleInputFromTiredState(aInput);
					break;
				default:
					break;
			}
		}
		
		private function HandleInputFromPetrifiedState(aInput:String):void
		{
			if (aInput == "Sam")
			{
				SetState(1);
			}
			else
			{
				mDialog.text = "It is not his name.\nWhat is his name?";
				DispatchTrivialStateChange();
			}
			mDialog.setTextFormat(mDialogFormat);
		}
		
		private function HandleInputFromAngryState(aInput:String):void
		{
			if (aInput == "mad")
			{
				SetState(2);
			}
			else if (aInput == "sad")
			{
				mDialog.text = "I am not sad!\nI am mad?";
				DispatchTrivialStateChange();
			}
			else
			{
				mDialog.text = "I am sad or mad?";
				DispatchTrivialStateChange();
			}
			mDialog.setTextFormat(mDialogFormat);
		}
		
		private function HandleInputFromHotTiredState(aInput:String):void
		{
			if (aInput == "mat")
			{
				if (Inventory.Instance.HasItem(Item.MAT))
				{
					UseItem(Item.MAT);
					SetState(3);
				}
				else
				{
					mDialog.text = "Yes, I need a mat.\nDo you have one?";
					DispatchTrivialStateChange();
				}
			}
			else if (aInput == "fan")
			{
				if (Inventory.Instance.HasItem(Item.FAN))
				{
					UseItem(Item.FAN);
					SetState(4);
				}
				else
				{
					mDialog.text = "Yes, I need a fan.\nDo you have one?";
					DispatchTrivialStateChange();
				}
			}
			else
			{
				mDialog.text = "I don't need that!\nWhat else do I need?";
				DispatchTrivialStateChange();
			}
			mDialog.setTextFormat(mDialogFormat);
		}
		
		private function HandleInputFromHotState(aInput:String):void
		{
			if (aInput == "fan")
			{
				if (Inventory.Instance.HasItem(Item.FAN))
				{
					UseItem(Item.FAN);
					SetState(5);
				}
				else
				{
					mDialog.text = "Yes, I need a fan.\nDo you have one?";
					DispatchTrivialStateChange();
				}
			}
			else
			{
				mDialog.text = "I don't need that!\nWhat else do I need?";
				DispatchTrivialStateChange();
			}
			mDialog.setTextFormat(mDialogFormat);
		}
		
		private function HandleInputFromTiredState(aInput:String):void
		{
			if (aInput == "mat")
			{
				if (Inventory.Instance.HasItem(Item.MAT))
				{
					UseItem(Item.MAT);
					SetState(5);
				}
				else
				{
					mDialog.text = "Yes, I need a mat.\nDo you have one?";
					DispatchTrivialStateChange();
				}
			}
			else
			{
				mDialog.text = "I don't need that!\nWhat else do I need?";
				DispatchTrivialStateChange();
			}
			mDialog.setTextFormat(mDialogFormat);
		}
	}
}