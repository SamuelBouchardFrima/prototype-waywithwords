package com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud
{
	public class Composition
	{
		private var mWidgetList:Vector.<Widget>;
		
		internal function get WidgetList():Vector.<Widget>
		{
			return mWidgetList;
		}
		
		public function Composition(aWidgetList:Vector.<Widget>)
		{
			mWidgetList = aWidgetList;
		}
	}
}