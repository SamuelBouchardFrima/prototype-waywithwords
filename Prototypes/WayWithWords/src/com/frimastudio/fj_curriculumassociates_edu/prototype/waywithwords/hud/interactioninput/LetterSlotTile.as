package com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud.interactioninput
{
	import com.greensock.easing.Strong;
	import com.greensock.TweenLite;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	
	public class LetterSlotTile extends Sprite
	{
		private var mTile:Sprite;
		private var mPulseTimer:Timer;
		private var mDelay:Number;
		
		public function LetterSlotTile()
		{
			super();
			
			mTile = new Sprite();
			mTile.graphics.lineStyle(0, 0x000000, 0);
			mTile.graphics.beginFill(0xCCCCCC);
			mTile.graphics.moveTo(-35, -35);
			mTile.graphics.lineTo(35, -35);
			mTile.graphics.lineTo(35, 35);
			mTile.graphics.lineTo(-35, 35);
			mTile.graphics.lineTo(-35, -35);
			mTile.graphics.endFill();
			
			mPulseTimer = new Timer(3000);
			mPulseTimer.addEventListener(TimerEvent.TIMER, OnPulseTimer);
		}
		
		public function Dispose():void
		{
			mPulseTimer.stop();
			mPulseTimer.removeEventListener(TimerEvent.TIMER, OnPulseTimer);
		}
		
		public function Show():void
		{
			mPulseTimer.stop();
			mTile.alpha = 1;
			
			addChild(mTile);
		}
		
		public function Hide():void
		{
			if (contains(mTile))
			{
				removeChild(mTile);
			}
			
			mPulseTimer.stop();
			mTile.alpha = 1;
		}
		
		public function StartPulseAnim(aDelay:Number):void
		{
			Show();
			
			mTile.alpha = 0;
			mDelay = aDelay / 1000;
			mPulseTimer.start();
		}
		
		private function OnPulseTimer(aEvent:TimerEvent):void
		{
			if (!stage)
			{
				return;
			}
			
			TweenLite.to(mTile, 0.8, { alpha:1, ease:Strong.easeIn, delay:mDelay, onComplete:OnFadeInComplete });
		}
		
		private function OnFadeInComplete():void
		{
			TweenLite.to(mTile, 0.8, { alpha:0, ease:Strong.easeOut });
		}
	}
}