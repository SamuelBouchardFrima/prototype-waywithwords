package com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.scene
{
	public class InteractiveObjectType
	{
		public static var QUEST:InteractiveObjectType = new InteractiveObjectType(0, "QUEST");
		public static var COLLECTABLE:InteractiveObjectType = new InteractiveObjectType(1, "COLLECTABLE");
		
		private var mId:int;
		private var mDescription:String;
		
		public function get Id():int
		{
			return mId;
		}
		
		public function get Description():String
		{
			return mDescription;
		}
		
		public function InteractiveObjectType(aId:int, aDescription:String)
		{
			mId = aId;
			mDescription = aDescription;
		}
	}
}