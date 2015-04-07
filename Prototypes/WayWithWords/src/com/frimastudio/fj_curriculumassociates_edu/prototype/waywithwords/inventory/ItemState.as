package com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.inventory
{
	public class ItemState
	{
		public static var NORMAL:ItemState = new ItemState(0, "NORMAL");
		public static var COLLECTED:ItemState = new ItemState(1, "COLLECTED");
		public static var USED:ItemState = new ItemState(2, "USED");
		
		private var mID:int;
		private var mDescription:String;
		
		public function get ID():int
		{
			return mID;
		}
		
		public function get Description():String
		{
			return mDescription;
		}
		
		public function ItemState(aID:int, aDescription:String)
		{
			mID = aID;
			mDescription = aDescription;
		}
	}
}