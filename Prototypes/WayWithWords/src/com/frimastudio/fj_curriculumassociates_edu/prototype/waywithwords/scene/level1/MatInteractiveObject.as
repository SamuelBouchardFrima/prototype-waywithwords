package com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.scene.level1
{
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.inventory.Inventory;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.inventory.Item;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.scene.InteractiveObject;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.scene.InteractiveObjectEvent;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.scene.InteractiveObjectState;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.scene.InteractiveObjectType;
	
	public class MatInteractiveObject extends InteractiveObject
	{
		public function MatInteractiveObject()
		{
			var stateList:Vector.<InteractiveObjectState> = new Vector.<InteractiveObjectState>();
			stateList.push(new InteractiveObjectState(0, "Petrified", new Asset.MatObjectBitmap(), "tnam"));
			stateList.push(new InteractiveObjectState(1, "Collected"));
			
			super(stateList, InteractiveObjectType.COLLECTABLE);
		}
		
		override public function SetState(aID:int, aProgressBreadcrumb:Boolean = true):void
		{
			super.SetState(aID, aProgressBreadcrumb);
			
			switch (mState.Name)
			{
				case "Petrified":
					mDialog.text = "I am a ___.";
					break;
				case "Collected":
					mDialog.text = "I am a mat.";
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
			switch (aInput)
			{
				case "mat":
					DispatchInputSuccess();
					Inventory.Instance.AddItem(Item.MAT);
					SetState(1);
					DispatchStateBlock();
					break;
				case "a":
				case "am":
				case "an":
				case "ant":
				case "at":
				case "man":
				case "tan":
					DispatchInputSuccess();
					mDialog.text = "I am not a " + aInput + ".\nI am a ___.";
					DispatchTrivialStateChange();
					break;
				default:
					mDialog.text = "I am a ___.";
					DispatchInputError();
					break;
			}
			mDialog.setTextFormat(mDialogFormat);
		}
	}
}