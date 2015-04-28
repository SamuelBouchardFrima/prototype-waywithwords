package com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud
{
	public class Composition
	{
		private var mWidgetList:Vector.<Widget>;
		
		internal function get WidgetList():Vector.<Widget>
		{
			return mWidgetList;
		}
		
		public function Composition(aWidgetList:Vector.<Widget> = null)
		{
			mWidgetList = (aWidgetList ? aWidgetList : new Vector.<Widget>);
		}
		
		public function Dispose():void
		{
			for (var i:int = 0, end:int = mWidgetList.length; i < end; ++i)
			{
				mWidgetList[i].Dispose();
			}
		}
	}
}