package com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud.interactioninput
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	
	public class SelectableLetter extends Sprite
	{
		private var mCharacter:String;
		private var mSelected:Boolean;
		
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
			format.size = 80;
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
			
			addEventListener(MouseEvent.CLICK, OnClick);
		}
		
		public function Dispose():void
		{
			removeEventListener(MouseEvent.CLICK, OnClick);
		}
		
		private function OnClick(aEvent:MouseEvent):void
		{
			if (!mSelected)
			{
				Selected = true;
			}
		}
	}
}