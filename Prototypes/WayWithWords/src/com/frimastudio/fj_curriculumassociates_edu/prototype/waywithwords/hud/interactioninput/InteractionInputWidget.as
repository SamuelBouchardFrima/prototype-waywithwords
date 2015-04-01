package com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud.interactioninput
{
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud.RetractableWidget;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud.WidgetButton;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.util.Random;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class InteractionInputWidget extends RetractableWidget
	{
		private var mWordFieldFormat:TextFormat;
		private var mCurrentWordField:TextField;
		private var mRewindButton:WidgetButton;
		private var mSubmitButton:WidgetButton;
		private var mEraseButton:WidgetButton;
		private var mSelectableLetterList:Vector.<SelectableLetter>;
		
		public function InteractionInputWidget(aRetractedAnchor:Point, aDeployedAnchor:Point, aLetterSelection:String = "")
		{
			super(aRetractedAnchor, aDeployedAnchor);
			
			mWordFieldFormat = new TextFormat();
			mWordFieldFormat.size = 40;
			mWordFieldFormat.bold = true;
			
			mCurrentWordField = new TextField();
			mCurrentWordField.x = 200;
			mCurrentWordField.y = -110;
			mCurrentWordField.width = 200;
			mCurrentWordField.height = 40;
			mCurrentWordField.selectable = false;
			mCurrentWordField.text = "";
			mCurrentWordField.setTextFormat(mWordFieldFormat);
			addChild(mCurrentWordField);
			
			var buttonRect:Rectangle = new Rectangle( -20, -20, 40, 40);
			
			mRewindButton = new WidgetButton("<", buttonRect, 0xCCCC00);
			mRewindButton.x = 50;
			mRewindButton.y = -90;
			mRewindButton.addEventListener(MouseEvent.CLICK, OnRewind);
			addChild(mRewindButton);
			
			mSubmitButton = new WidgetButton(">", buttonRect, 0x00CC00);
			mSubmitButton.x = 500;
			mSubmitButton.y = -90;
			mSubmitButton.addEventListener(MouseEvent.CLICK, OnSubmit);
			addChild(mSubmitButton);
			
			mEraseButton = new WidgetButton("X", buttonRect, 0xCC0000);
			mEraseButton.x = 550;
			mEraseButton.y = -90;
			mEraseButton.addEventListener(MouseEvent.CLICK, OnErase);
			addChild(mEraseButton);
			
			SetLetterSelection(aLetterSelection);
		}
		
		public function SetLetterSelection(aLetterSelection:String):void
		{
			var i:int, end:int;
			
			var unscrambledList:Vector.<SelectableLetter> = new Vector.<SelectableLetter>();
			for (i = 0, end = aLetterSelection.length; i < end; ++i)
			{
				unscrambledList.push(new SelectableLetter(aLetterSelection.charAt(i)));
			}
			
			if (mSelectableLetterList)
			{
				for (i = 0, end = mSelectableLetterList.length; i < end; ++i)
				{
					mSelectableLetterList[i].removeEventListener(SelectableLetterEvent.SELECTED, OnLetterSelected);
					removeChild(mSelectableLetterList[i]);
				}
			}
			
			mSelectableLetterList = new Vector.<SelectableLetter>();
			var index:int;
			while (unscrambledList.length > 0)
			{
				index = Random.RangeInt(0, unscrambledList.length - 1);
				mSelectableLetterList.push(unscrambledList.splice(index, 1)[0]);
			}
			
			for (i = 0, end = mSelectableLetterList.length; i < end; ++i)
			{
				mSelectableLetterList[i].x = (i * (mSelectableLetterList[i].width + 5)) -
					((mSelectableLetterList[i].width + 5) * end / 2) + 350;
				addChild(mSelectableLetterList[i]);
				mSelectableLetterList[i].addEventListener(SelectableLetterEvent.SELECTED, OnLetterSelected);
			}
		}
		
		public function Dispose():void
		{
			mSubmitButton.removeEventListener(MouseEvent.CLICK, OnSubmit);
			mEraseButton.removeEventListener(MouseEvent.CLICK, OnErase);
			for (var i:int = 0, end:int = mSelectableLetterList.length; i < end; ++i)
			{
				mSelectableLetterList[i].removeEventListener(SelectableLetterEvent.SELECTED, OnLetterSelected);
			}
		}
		
		private function OnRewind(aEvent:MouseEvent):void
		{
			dispatchEvent(new InteractionInputEvent(InteractionInputEvent.REWIND));
			Erase();
		}
		
		private function OnSubmit(aEvent:MouseEvent):void
		{
			var event:InteractionInputEvent = new InteractionInputEvent(InteractionInputEvent.SUBMIT);
			event.Input = mCurrentWordField.text;
			dispatchEvent(event);
			Erase();
		}
		
		private function OnErase(aEvent:MouseEvent):void
		{
			Erase();
		}
		
		private function Erase():void
		{
			mCurrentWordField.text = "";
			for (var i:int = 0, end:int = mSelectableLetterList.length; i < end; ++i)
			{
				mSelectableLetterList[i].Selected = false;
			}
		}
		
		private function OnLetterSelected(aEvent:SelectableLetterEvent):void
		{
			var selectableLetter:SelectableLetter = aEvent.currentTarget as SelectableLetter;
			var character:String = selectableLetter.Character;
			
			mCurrentWordField.appendText(character);
			mCurrentWordField.setTextFormat(mWordFieldFormat);
		}
	}
}