package com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud.interactioninput
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	
	public class SelectableLetter extends Sprite
	{
		//private static const DRAG_SPEED:Number = 10;
		
		private var mCharacter:String;
		private var mSelected:Boolean;
		private var mDragOrigin:Point;
		private var mDragAim:Point;
		private var mEnableClickTimer:Timer;
		
		public function get Character():String
		{
			return mCharacter;
		}
		
		public function get Selected():Boolean
		{
			return mSelected;
		}
		
		public function set Selected(aValue:Boolean):void
		{
			mSelected = aValue;
			
			graphics.beginFill(mSelected ? 0xCCCCCC : 0xFFFFFF);
			graphics.lineStyle(2);
			graphics.drawRect(-40, -40, 80, 80);
			graphics.endFill();
			
			var event:String = mSelected ? SelectableLetterEvent.SELECTED : SelectableLetterEvent.UNSELECTED;
			dispatchEvent(new SelectableLetterEvent(event));
		}
		
		public function SelectableLetter(aCharacter:String)
		{
			if (aCharacter.length != 1)
			{
				throw new Error("Unable to create a SelectableLetter from anything else " +
					"than a single character. \"" + aCharacter + "\" is not a valid argument.");
			}
			
			mCharacter = aCharacter;
			
			graphics.beginFill(0xFFFFFF);
			graphics.lineStyle(2);
			graphics.drawRect(-40, -40, 80, 80);
			graphics.endFill();
			
			var format:TextFormat = new TextFormat();
			format.size = 60;
			format.bold = true;
			format.align = "center";
			
			var field:TextField = new TextField();
			field.width = 80;
			field.height = 80;
			field.x = -40;
			field.y = -40;
			field.text = mCharacter;
			field.setTextFormat(format);
			field.selectable = false;
			addChild(field);
			
			mEnableClickTimer = new Timer(33, 1);
			mEnableClickTimer.addEventListener(TimerEvent.TIMER_COMPLETE, OnTimerComplete);
			
			addEventListener(MouseEvent.MOUSE_DOWN, OnMouseDown);
			addEventListener(MouseEvent.CLICK, OnClick);
		}
		
		public function Dispose():void
		{
			if (mEnableClickTimer)
			{
				mEnableClickTimer.stop();
				mEnableClickTimer.removeEventListener(TimerEvent.TIMER_COMPLETE, OnTimerComplete);
			}
			
			removeEventListener(Event.ENTER_FRAME, OnEnterFrame);
			removeEventListener(MouseEvent.MOUSE_DOWN, OnMouseDown);
			removeEventListener(MouseEvent.CLICK, OnClick);
			if (stage)
			{
				stage.removeEventListener(MouseEvent.MOUSE_MOVE, OnMouseMove);
				stage.removeEventListener(MouseEvent.MOUSE_UP, OnMouseUp);
			}
		}
		
		private function DelayStartDrag():void
		{
			mDragOrigin = new Point(parent.mouseX, parent.mouseY);
			
			stage.addEventListener(MouseEvent.MOUSE_MOVE, OnMouseMove);
		}
		
		private function StartDrag():void
		{
			mDragOrigin = null;
			mDragAim = new Point(x, y);
			
			parent.addChild(this);
			
			addEventListener(Event.ENTER_FRAME, OnEnterFrame);
			removeEventListener(MouseEvent.CLICK, OnClick);
			stage.addEventListener(MouseEvent.MOUSE_UP, OnMouseUp);
			
			dispatchEvent(new SelectableLetterEvent(SelectableLetterEvent.DRAGGED));
		}
		
		private function UpdateDragAim():void
		{
			var distance:Point = new Point(parent.mouseX, parent.mouseY).subtract(mDragAim);
			mDragAim.x += distance.x / 2;
			mDragAim.y += distance.y / 2;
		}
		
		private function UpdateDrag():void
		{
			var distance:Point = mDragAim.subtract(new Point(x, y));
			x += distance.x / 2;
			y += distance.y / 2;
			
			dispatchEvent(new SelectableLetterEvent(SelectableLetterEvent.DRAGGED));
		}
		
		private function StopDrag():void
		{
			removeEventListener(Event.ENTER_FRAME, OnEnterFrame);
			stage.removeEventListener(MouseEvent.MOUSE_MOVE, OnMouseMove);
			mEnableClickTimer.start();
			
			mDragAim = null;
			
			dispatchEvent(new SelectableLetterEvent(SelectableLetterEvent.DROPPED));
		}
		
		private function EnableClickListener():void
		{
			addEventListener(MouseEvent.CLICK, OnClick);
		}
		
		private function Select():void
		{
			if (!mSelected)
			{
				Selected = true;
			}
		}
		
		private function OnMouseDown(aEvent:MouseEvent):void
		{
			DelayStartDrag();
		}
		
		private function OnMouseMove(aEvent:MouseEvent):void
		{
			if (mDragOrigin != null)
			{
				if (new Point(parent.mouseX, parent.mouseY).subtract(mDragOrigin).length > 10)
				{
					StartDrag();
				}
			}
			else
			{
				UpdateDragAim();
			}
		}
		
		private function OnEnterFrame(aEvent:Event):void
		{
			UpdateDrag();
		}
		
		private function OnMouseUp(aEvent:MouseEvent):void
		{
			StopDrag();
		}
		
		private function OnTimerComplete(aEvent:TimerEvent):void
		{
			mEnableClickTimer.stop();
			EnableClickListener();
		}
		
		private function OnClick(aEvent:MouseEvent):void
		{
			Select();
		}
	}
}