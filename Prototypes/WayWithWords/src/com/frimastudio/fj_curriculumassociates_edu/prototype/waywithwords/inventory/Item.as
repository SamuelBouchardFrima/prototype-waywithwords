package com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.inventory
{
	public class Item 
	{
		public static var MAT:Item = new Item(0, "MAT", "mat");
		public static var FAN:Item = new Item(1, "FAN", "fan");
		
		private var mID:int;
		private var mDescription:String;
		private var mWord:String;
		private var mState:ItemState;
		
		public function get ID():int
		{
			return mID;
		}
		
		public function get Description():String
		{
			return mDescription;
		}
		
		public function get Word():String
		{
			return mWord;
		}
		
		public function get State():ItemState
		{
			return mState;
		}
		public function set State(aValue:ItemState):void
		{
			mState = aValue;
		}
		
		public function Item(aID:int, aDescription:String, aWord:String)
		{
			mID = aID;
			mDescription = aDescription;
			mWord = aWord;
			mState = ItemState.NORMAL;
		}
	}
}