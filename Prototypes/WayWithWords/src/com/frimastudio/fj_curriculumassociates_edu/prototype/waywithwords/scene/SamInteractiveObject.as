package com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.scene
{
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.Asset;
	
	public class SamInteractiveObject extends InteractiveObject
	{
		public function SamInteractiveObject()
		{
			var stateList:Vector.<InteractiveObjectState> = new Vector.<InteractiveObjectState>();
			stateList.push(new InteractiveObjectState(0, "Petrified", new Asset.Sam00Bitmap(), "aSmt"));
			stateList.push(new InteractiveObjectState(1, "Angry", new Asset.Sam02Bitmap(), "dmas"));
			stateList.push(new InteractiveObjectState(2, "HotTired", new Asset.Sam03Bitmap(), "mtanf"));
			stateList.push(new InteractiveObjectState(3, "Hot", new Asset.Sam04Bitmap(), "mtanf"));
			stateList.push(new InteractiveObjectState(4, "Tired", new Asset.Sam05Bitmap(), "mtanf"));
			stateList.push(new InteractiveObjectState(5, "Happy", new Asset.Sam06Bitmap()));
			
			super(stateList);
		}
		
		override public function SetState(aID:int, aProgressBreadcrumb:Boolean = true):void
		{
			super.SetState(aID, aProgressBreadcrumb);
			
			switch (mState.Name)
			{
				case "Petrified":
					mDialog.text = "That boy is petrified. Can you find his name to awake him?";
					break;
				case "Angry":
					mDialog.text = "Thanks for awaking me! I don't feel well. Can you help me by naming my emotion?";
					break;
				case "HotTired":
					mDialog.text = "That's it! It's probably because I'm sweaty and tired, though. Do you have anything to help me?";
					break;
				case "Hot":
					mDialog.text = "Thanks! I'm still sweaty, though. Do you have anything to help me?";
					break;
				case "Tired":
					mDialog.text = "Thanks! I'm still tired, though. Do you have anything to help me?";
					break;
				case "Happy":
					mDialog.text = "Thanks! I'm ready to join you in your quest!";
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
				mDialog.text = "That doesn't seem to be his name. Can you find his name to awake him?";
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
				mDialog.text = "I'm not sad! Can you help me by naming my emotion?";
			}
			else
			{
				mDialog.text = "I don't understand. I don't feel well. Can you help me by naming my emotion?";
			}
			mDialog.setTextFormat(mDialogFormat);
		}
		
		private function HandleInputFromHotTiredState(aInput:String):void
		{
			if (aInput == "mat")
			{
				SetState(3);
			}
			else if (aInput == "fan")
			{
				SetState(4);
			}
			else
			{
				mDialog.text = "I don't understand. I'm sweaty and tired, though. Do you have anything to help me?";
			}
			mDialog.setTextFormat(mDialogFormat);
		}
		
		private function HandleInputFromHotState(aInput:String):void
		{
			if (aInput == "fan")
			{
				SetState(5);
			}
			else
			{
				mDialog.text = "I don't understand. I'm still sweaty, though. Do you have anything to help me?";
			}
			mDialog.setTextFormat(mDialogFormat);
		}
		
		private function HandleInputFromTiredState(aInput:String):void
		{
			if (aInput == "mat")
			{
				SetState(5);
			}
			else
			{
				mDialog.text = "I don't understand. I'm still tired, though. Do you have anything to help me?";
			}
			mDialog.setTextFormat(mDialogFormat);
		}
	}
}