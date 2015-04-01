package com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud
{
	import flash.geom.Point;
	
	public class RetractableWidget extends Widget
	{
		protected var mRetractedAnchor:Point;
		private var mRetracted:Boolean;
		
		public function get Retracted():Boolean
		{
			return mRetracted;
		}
		
		public function set Retracted(aValue:Boolean):void
		{
			mRetracted = aValue;
			
			if (mRetracted)
			{
				x = mRetractedAnchor.x;
				y = mRetractedAnchor.y;
			}
			else
			{
				x = mAnchor.x;
				y = mAnchor.y;
			}
		}
		
		public function RetractableWidget(aRetractedAnchor:Point, aDeployedAnchor:Point)
		{
			super(aDeployedAnchor);
			
			mRetractedAnchor = aRetractedAnchor;
		}
	}
}