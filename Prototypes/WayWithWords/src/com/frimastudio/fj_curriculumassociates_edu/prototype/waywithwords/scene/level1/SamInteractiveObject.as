package com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.scene.level1
{
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.inventory.Inventory;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.inventory.Item;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.scene.InteractiveObject;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.scene.InteractiveObjectEvent;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.scene.InteractiveObjectState;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.scene.InteractiveObjectType;
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
			
			super(stateList, InteractiveObjectType.QUEST);
		}
		
		override public function SetState(aID:int, aProgressBreadcrumb:Boolean = true):void
		{
			super.SetState(aID, aProgressBreadcrumb);
			
			switch (mState.Name)
			{
				case "Petrified":
					mDialog.text = "I am ___.";
					break;
				case "Angry":
					mDialog.text = "I am Sam.\nAm I sad or mad?";
					break;
				case "HotTired":
					mDialog.text = "I am mad!\nI need a ___?";
					break;
				case "Hot":
					mDialog.text = "A mat for me!\nI need a ___?";
					break;
				case "Tired":
					mDialog.text = "A fan for me!\nI need a ___?";
					break;
				case "Happy":
					mDialog.text = "A mat for me!\nA fan for me!";
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
			switch (aInput)
			{
				case "Sam":
					SetState(1);
					break;
				case "a":
				case "am":
				case "at":
				case "mat":
					mDialog.text = "I am not " + aInput + ".\nI am ___.";
					DispatchTrivialStateChange();
					break;
				default:
					mDialog.text = "I am ___.";
					DispatchInputError();
					break;
			}
			mDialog.setTextFormat(mDialogFormat);
		}
		
		private function HandleInputFromAngryState(aInput:String):void
		{
			switch (aInput)
			{
				case "mad":
					SetState(2);
					break;
				case "sad":
					mDialog.text = "I am not sad!\nAm I mad?";
					DispatchTrivialStateChange();
					break;
				case "a":
				case "ad":
				case "am":
				case "as":
					mDialog.text = "I am not " + aInput + "!\nAm I sad or mad?";
					DispatchTrivialStateChange();
					break;
				default:
					mDialog.text = "Am I sad or mad?";
					DispatchInputError();
					break;
			}
			mDialog.setTextFormat(mDialogFormat);
		}
		
		private function HandleInputFromHotTiredState(aInput:String):void
		{
			switch (aInput)
			{
				case "mat":
					if (Inventory.Instance.HasItem(Item.MAT))
					{
						UseItem(Item.MAT);
						SetState(3);
					}
					else
					{
						mDialog.text = "I need a mat.\nYou do not have a mat.";
						DispatchTrivialStateChange();
						DispatchStateBlock();
					}
					break;
				case "fan":
					if (Inventory.Instance.HasItem(Item.FAN))
					{
						UseItem(Item.FAN);
						SetState(4);
					}
					else
					{
						mDialog.text = "I need a fan.\nYou do not have a fan.";
						DispatchTrivialStateChange();
						DispatchStateBlock();
					}
					break;
				case "a":
				case "am":
				case "an":
				case "ant":
				case "at":
				case "fat":
				case "man":
				case "tan":
					mDialog.text = "I do not need a " + aInput + ".\nI need a ___?";
					DispatchTrivialStateChange();
					break;
				default:
					mDialog.text = "I need a ___?";
					DispatchInputError();
					break;
			}
			mDialog.setTextFormat(mDialogFormat);
		}
		
		private function HandleInputFromHotState(aInput:String):void
		{
			switch (aInput)
			{
				case "fan":
					if (Inventory.Instance.HasItem(Item.FAN))
					{
						UseItem(Item.FAN);
						SetState(5);
						DispatchStateBlock();
					}
					else
					{
						mDialog.text = "I need a fan.\nYou do not have a fan.";
						DispatchTrivialStateChange();
						DispatchStateBlock();
					}
					break;
				case "a":
				case "am":
				case "an":
				case "ant":
				case "at":
				case "fat":
				case "man":
				case "mat":
				case "tan":
					mDialog.text = "I do not need a " + aInput + ".\nI need a ___?";
					DispatchTrivialStateChange();
					break;
				default:
					mDialog.text = "I need a ___?";
					DispatchInputError();
					break;
			}
			mDialog.setTextFormat(mDialogFormat);
		}
		
		private function HandleInputFromTiredState(aInput:String):void
		{
			switch (aInput)
			{
				case "mat":
					if (Inventory.Instance.HasItem(Item.MAT))
					{
						UseItem(Item.MAT);
						SetState(5);
						DispatchStateBlock();
					}
					else
					{
						mDialog.text = "I need a mat.\nYou do not have a mat.";
						DispatchTrivialStateChange();
						DispatchStateBlock();
					}
					break;
				case "a":
				case "am":
				case "an":
				case "ant":
				case "at":
				case "fan":
				case "fat":
				case "man":
				case "tan":
					mDialog.text = "I do not need a " + aInput + ".\nI need a ___?";
					DispatchTrivialStateChange();
					break;
				default:
					mDialog.text = "I need a ___?";
					DispatchInputError();
					break;
			}
			mDialog.setTextFormat(mDialogFormat);
		}
	}
}