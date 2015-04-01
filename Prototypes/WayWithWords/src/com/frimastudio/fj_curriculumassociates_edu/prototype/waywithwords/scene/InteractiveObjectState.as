package com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.scene
{
	import flash.display.Bitmap;
	
	public class InteractiveObjectState
	{
		private var mID:int;
		private var mName:String;
		private var mPicture:Bitmap;
		private var mLetterSelection:String;
		
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
		
		public function InteractiveObjectState(aID:int, aName:String, aPicture:Bitmap, aLetterSelection:String = "")
		{
			if (isNaN(aID) || aName == null || aName == "" || aPicture == null)
			{
				throw new Error("An InteractiveObjectState requires proper ID, name and picture reference.");
			}
			
			mID = aID;
			mName = aName;
			mPicture = aPicture;
			mLetterSelection = aLetterSelection;
		}
	}
}