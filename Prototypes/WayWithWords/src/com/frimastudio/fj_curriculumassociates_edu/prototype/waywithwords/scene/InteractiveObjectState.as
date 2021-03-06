package com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.scene
{
	import flash.display.Bitmap;
	
	public class InteractiveObjectState
	{
		private var mID:int;
		private var mName:String;
		private var mPicture:Bitmap;
		private var mLetterSelection:String;
		private var mShowInventory:Boolean;
		
		public function get ID():int
		{
			return mID;
		}
		
		public function get Name():String
		{
			return mName;
		}
		
		public function get Picture():Bitmap
		{
			return mPicture;
		}
		
		public function get LetterSelection():String
		{
			return mLetterSelection;
		}
		
		public function get ShowInventory():Boolean
		{
			return mShowInventory;
		}
		
		public function InteractiveObjectState(aID:int, aName:String, aPicture:Bitmap = null, aLetterSelection:String = "",
			aShowInventory:Boolean = false)
		{
			if (isNaN(aID) || aName == null || aName == "")
			{
				throw new Error("An InteractiveObjectState requires proper ID and name.");
			}
			
			mID = aID;
			mName = aName;
			mPicture = aPicture;
			mLetterSelection = aLetterSelection;
			mShowInventory = aShowInventory;
		}
	}
}