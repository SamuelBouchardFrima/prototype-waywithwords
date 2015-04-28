package com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud.interactioninput
{
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.animation.Shaker;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.Asset;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud.RetractableWidget;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud.WidgetButton;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud.WidgetIconButton;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.keyboard.KeyboardManager;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.keyboard.KeyboardManagerEvent;
	import com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.util.Random;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	public class InteractionInputWidget extends RetractableWidget
	{
		private var mSelectedLetterSlots:Vector.<Point>;
		private var mSelectableLetterSlots:Vector.<Point>;
		private var mSelectableLetterSlotTiles:Vector.<Sprite>;
		private var mSelectedLetterList:Vector.<SelectableLetter>;
		private var mSelectableLetterList:Vector.<SelectableLetter>;
		private var mSubmitButton:WidgetButton;
		private var mEraseButton:WidgetButton;
		private var mLetterSelection:String;
		private var mCurrentWord:String;
		
		public function InteractionInputWidget(aRetractedAnchor:Point, aDeployedAnchor:Point)
		{
			super(aRetractedAnchor, aDeployedAnchor);
			
			graphics.lineStyle(1, 0xCCCCCC);
			graphics.moveTo(-65, -160);
			graphics.lineTo(665, -160);
			graphics.lineTo(665, 80);
			graphics.lineTo(-65, 80);
			graphics.lineTo(-65, -160);
			
			mSelectedLetterSlots = new Vector.<Point>();
			mSelectableLetterSlots = new Vector.<Point>();
			mSelectableLetterSlotTiles = new Vector.<Sprite>();
			mSelectedLetterList = new Vector.<SelectableLetter>();
			mSelectableLetterList = new Vector.<SelectableLetter>();
			mCurrentWord = "";
			
			var buttonRect:Rectangle = new Rectangle(-20, -20, 40, 40);
			
			mSubmitButton = new WidgetButton(">", buttonRect, 0x00CC00);
			mSubmitButton.x = 535;
			mSubmitButton.y = -90;
			mSubmitButton.addEventListener(MouseEvent.CLICK, OnSubmit);
			addChild(mSubmitButton);
			
			mEraseButton = new WidgetIconButton(Asset.EraserIconBitmap, buttonRect, 0xCC0000);
			mEraseButton.x = 585;
			mEraseButton.y = -90;
			mEraseButton.addEventListener(MouseEvent.CLICK, OnErase);
			addChild(mEraseButton);
			
			KeyboardManager.Instance.addEventListener(KeyboardManagerEvent.ERASE_LAST, OnEraseLast);
			KeyboardManager.Instance.addEventListener(KeyboardManagerEvent.ERASE_ALL, OnEraseAll);
			KeyboardManager.Instance.addEventListener(KeyboardManagerEvent.REQUEST_SUBMIT, OnRequestSubmit);
			KeyboardManager.Instance.addEventListener(KeyboardManagerEvent.TYPE, OnType);
		}
		
		override public function Dispose():void
		{
			ClearLetterLists();
			
			mSubmitButton.removeEventListener(MouseEvent.CLICK, OnSubmit);
			mEraseButton.removeEventListener(MouseEvent.CLICK, OnErase);
			
			KeyboardManager.Instance.removeEventListener(KeyboardManagerEvent.ERASE_LAST, OnEraseLast);
			KeyboardManager.Instance.removeEventListener(KeyboardManagerEvent.ERASE_ALL, OnEraseAll);
			KeyboardManager.Instance.removeEventListener(KeyboardManagerEvent.REQUEST_SUBMIT, OnRequestSubmit);
			KeyboardManager.Instance.removeEventListener(KeyboardManagerEvent.TYPE, OnType);
			
			super.Dispose();
		}
		
		public function SetLetterSelection(aLetterSelection:String):void
		{
			ClearLetterLists();
			
			mLetterSelection = aLetterSelection;
			
			var slotX:int;
			var tile:Sprite;
			var i:int, end:int;
			for (i = 0, end = aLetterSelection.length; i < end; ++i)
			{
				slotX = (85 * i) + 100;
				
				mSelectedLetterSlots.push(new Point(slotX, -90));
				mSelectableLetterSlots.push(new Point(slotX, 10));
				
				tile = new Sprite();
				tile.x = slotX;
				tile.y = 10;
				
				tile.graphics.lineStyle(0, 0x000000, 0);
				tile.graphics.beginFill(0xCCCCCC);
				tile.graphics.moveTo(-35, -35);
				tile.graphics.lineTo(35, -35);
				tile.graphics.lineTo(35, 35);
				tile.graphics.lineTo(-35, 35);
				tile.graphics.lineTo( -35, -35);
				tile.graphics.endFill();
				
				mSelectableLetterSlotTiles.push(tile);
				addChild(tile);
			}
			
			var remainingLetters:String = aLetterSelection;
			while (remainingLetters.length > 0)
			{
				i = Random.RangeInt(0, remainingLetters.length - 1);
				AddSelectableLetter(remainingLetters.charAt(i));
				remainingLetters = remainingLetters.substring(0, i) + remainingLetters.substr(i + 1);
			}
			
			RefreshCurrentWord();
		}
		
		public function InputError():void
		{
			var vector2:Point = new Point(0, 2);
			for (var i:int = 0, end:int = mSelectedLetterList.length; i < end; ++i)
			{
				new Shaker(mSelectedLetterList[i], 500, vector2);
			}
		}
		
		private function ClearLetterLists():void 
		{
			var i:int, end:int;
			
			for (i = 0, end = mSelectableLetterSlotTiles.length; i < end; ++i)
			{
				removeChild(mSelectableLetterSlotTiles[i]);
			}
			for (i = 0, end = mSelectedLetterList.length; i < end; ++i)
			{
				RemoveSelectedLetter(mSelectedLetterList[i], false);
			}
			for (i = 0, end = mSelectableLetterList.length; i < end; ++i)
			{
				if (mSelectableLetterList[i] != null)
				{
					RemoveSelectableLetter(mSelectableLetterList[i]);
				}
			}
			
			mSelectedLetterSlots.splice(0, mSelectedLetterSlots.length);
			mSelectableLetterSlots.splice(0, mSelectableLetterSlots.length);
			mSelectableLetterSlotTiles.splice(0, mSelectableLetterSlotTiles.length);
			mSelectedLetterList.splice(0, mSelectedLetterList.length);
			mSelectableLetterList.splice(0, mSelectableLetterList.length);
		}
		
		private function AddSelectedLetter(aCharacter:String, aIndex:int = -1):void
		{
			var slot:Point;
			var selectedLetter:SelectableLetter = new SelectableLetter(aCharacter);
			if (aIndex == -1 || aIndex >= mSelectedLetterList.length)
			{
				slot = mSelectedLetterSlots[mSelectedLetterList.length];
				mSelectedLetterList.push(selectedLetter);
			}
			else
			{
				slot = mSelectedLetterSlots[aIndex];
				mSelectedLetterList.splice(aIndex, 0, selectedLetter);
			}
			selectedLetter.x = slot.x;
			selectedLetter.y = slot.y;
			selectedLetter.addEventListener(SelectableLetterEvent.DRAGGED, OnLetterDragged);
			selectedLetter.addEventListener(SelectableLetterEvent.DROPPED, OnLetterDropped);
			selectedLetter.addEventListener(SelectableLetterEvent.SELECTED, OnLetterUnselected);
			addChild(selectedLetter);
		}
		
		private function AddSelectableLetter(aCharacter:String, aIndex:int = -1):void
		{
			var selectableLetter:SelectableLetter = new SelectableLetter(aCharacter);
			
			if (aIndex != -1 && mSelectableLetterList[aIndex] == null)
			{
				mSelectableLetterList[aIndex] = selectableLetter;
			}
			else
			{
				var emptySlot:Boolean;
				for (var i:int = 0, end:int = mSelectableLetterList.length; i < end && !emptySlot; ++i)
				{
					if (mSelectableLetterList[i] == null)
					{
						mSelectableLetterList[i] = selectableLetter;
						emptySlot = true;
					}
				}
				if (!emptySlot)
				{
					mSelectableLetterList.push(selectableLetter);
				}
			}
			
			var slot:Point = mSelectableLetterSlots[mSelectableLetterList.indexOf(selectableLetter)];
			selectableLetter.x = slot.x;
			selectableLetter.y = slot.y;
			selectableLetter.addEventListener(SelectableLetterEvent.DRAGGED, OnLetterDragged);
			selectableLetter.addEventListener(SelectableLetterEvent.DROPPED, OnLetterDropped);
			selectableLetter.addEventListener(SelectableLetterEvent.SELECTED, OnLetterSelected);
			addChild(selectableLetter);
		}
		
		private function RemoveSelectedLetter(aLetter:SelectableLetter, aAdjustList:Boolean = true):void
		{
			aLetter.removeEventListener(SelectableLetterEvent.DRAGGED, OnLetterDragged);
			aLetter.removeEventListener(SelectableLetterEvent.DROPPED, OnLetterDropped);
			aLetter.removeEventListener(SelectableLetterEvent.SELECTED, OnLetterUnselected);
			aLetter.Dispose();
			removeChild(aLetter);
			
			if (aAdjustList)
			{
				var i:int = mSelectedLetterList.indexOf(aLetter);
				mSelectedLetterList.splice(i, 1);
				for (var end:int = mSelectedLetterList.length; i < end; ++i)
				{
					mSelectedLetterList[i].x = mSelectedLetterSlots[i].x;
					mSelectedLetterList[i].y = mSelectedLetterSlots[i].y;
				}
			}
		}
		
		private function RemoveSelectableLetter(aLetter:SelectableLetter):void
		{
			aLetter.removeEventListener(SelectableLetterEvent.DRAGGED, OnLetterDragged);
			aLetter.removeEventListener(SelectableLetterEvent.DROPPED, OnLetterDropped);
			aLetter.removeEventListener(SelectableLetterEvent.SELECTED, OnLetterSelected);
			aLetter.Dispose();
			removeChild(aLetter);
			mSelectableLetterList[mSelectableLetterList.indexOf(aLetter)] = null;
		}
		
		private function SelectLetter(aLetter:SelectableLetter, aIndex:int = -1):void
		{
			var character:String = aLetter.Character;
			RemoveSelectableLetter(aLetter);
			AddSelectedLetter(character, aIndex);
			RefreshCurrentWord();
		}
		
		private function UnselectLetter(aLetter:SelectableLetter, aIndex:int = -1):void
		{
			var character:String = aLetter.Character;
			RemoveSelectedLetter(aLetter);
			AddSelectableLetter(character, aIndex);
			RefreshCurrentWord();
		}
		
		private function RefreshCurrentWord():void
		{
			mCurrentWord = "";
			for (var i:int = 0, end:int = mSelectedLetterList.length; i < end; ++i)
			{
				mCurrentWord += mSelectedLetterList[i].Character;
			}
		}
		
		private function OnSubmit(aEvent:MouseEvent):void
		{
			dispatchEvent(new InteractionInputEvent(InteractionInputEvent.SUBMIT, mCurrentWord));
		}
		
		private function OnErase(aEvent:MouseEvent):void
		{
			for (var i:int = 0, end:int = mSelectedLetterList.length; i < end; ++i)
			{
				AddSelectableLetter(mSelectedLetterList[i].Character);
				RemoveSelectedLetter(mSelectedLetterList[i], false);
			}
			mSelectedLetterList.splice(0, mSelectedLetterList.length);
			RefreshCurrentWord();
		}
		
		private function OnEraseLast(aEvent:KeyboardManagerEvent):void
		{
			if (!stage)
			{
				return;
			}
			
			if (mSelectedLetterList.length > 0)
			{
				AddSelectableLetter(mSelectedLetterList[mSelectedLetterList.length - 1].Character);
				RemoveSelectedLetter(mSelectedLetterList[mSelectedLetterList.length - 1], false);
			}
			mSelectedLetterList.splice(mSelectedLetterList.length - 1, 1);
			RefreshCurrentWord();
		}
		
		private function OnEraseAll(aEvent:KeyboardManagerEvent):void
		{
			if (!stage)
			{
				return;
			}
			
			for (var i:int = 0, end:int = mSelectedLetterList.length; i < end; ++i)
			{
				AddSelectableLetter(mSelectedLetterList[i].Character);
				RemoveSelectedLetter(mSelectedLetterList[i], false);
			}
			mSelectedLetterList.splice(0, mSelectedLetterList.length);
			RefreshCurrentWord();
		}
		
		private function OnRequestSubmit(aEvent:KeyboardManagerEvent):void
		{
			if (!stage)
			{
				return;
			}
			
			dispatchEvent(new InteractionInputEvent(InteractionInputEvent.SUBMIT, mCurrentWord));
			SetLetterSelection(mLetterSelection);
		}
		
		private function OnType(aEvent:KeyboardManagerEvent):void
		{
			if (!stage)
			{
				return;
			}
			
			for (var i:int = 0, end:int = mSelectableLetterList.length; i < end; ++i)
			{
				if (mSelectableLetterList[i])
				{
					if (mSelectableLetterList[i].Character.toLowerCase() == aEvent.Character.toLowerCase())
					{
						SelectLetter(mSelectableLetterList[i]);
						break;
					}
				}
			}
		}
		
		private function OnLetterDragged(aEvent:SelectableLetterEvent):void
		{
			var letter:SelectableLetter = aEvent.currentTarget as SelectableLetter;
			
			var i:int, end:int;
			if (letter.x >= mSelectedLetterSlots[0].x - 40 &&
				letter.x <= mSelectedLetterSlots[mSelectedLetterSlots.length - 1].x + 40 &&
				letter.y >= mSelectedLetterSlots[0].y - 40 &&
				letter.y <= mSelectedLetterSlots[0].y + 40)
			{
				// Finding the slot over which the letter is being dragged
				var slotIndex:int = -1;
				for (i = 0, end = mSelectedLetterSlots.length; i < end; ++i)
				{
					if (Math.abs(mSelectedLetterSlots[i].x - letter.x) <= 40)
					{
						slotIndex = i;
					}
				}
				
				// Finding the current index of the letter, if is is already part of the selected list
				var currentIndex:int = mSelectedLetterList.indexOf(letter);
				for (i = 0, end = mSelectedLetterList.length; i < end; ++i)
				{
					if (i == currentIndex)
					{
						continue;
					}
					
					if (currentIndex == -1 || i < currentIndex)
					{
						mSelectedLetterList[i].x = mSelectedLetterSlots[(i < slotIndex ? i : i + 1)].x;
					}
					else
					{
						mSelectedLetterList[i].x = mSelectedLetterSlots[(i > slotIndex ? i : i - 1)].x;
					}
					mSelectedLetterList[i].y = mSelectedLetterSlots[i].y;
				}
			}
			else
			{
				for (i = 0, end = mSelectedLetterList.length; i < end; ++i)
				{
					if (mSelectedLetterList[i] != letter)
					{
						mSelectedLetterList[i].x = mSelectedLetterSlots[i].x;
						mSelectedLetterList[i].y = mSelectedLetterSlots[i].y;
					}
				}
			}
		}
		
		private function OnLetterDropped(aEvent:SelectableLetterEvent):void
		{
			var letter:SelectableLetter = aEvent.currentTarget as SelectableLetter;
			var selected:Boolean = mSelectedLetterList.indexOf(letter) > -1;
			var slotIndex:int = -1, letterIndex:int = -1;
			var slot:Point;
			var i:int, end:int;
			
			if (letter.x >= mSelectedLetterSlots[0].x - 40 &&
				letter.x <= mSelectedLetterSlots[mSelectedLetterSlots.length - 1].x + 40 &&
				letter.y >= mSelectedLetterSlots[0].y - 40 &&
				letter.y <= mSelectedLetterSlots[0].y + 40)
			{
				// Finding the slot over which the letter is being dragged
				for (i = 0, end = mSelectedLetterSlots.length; i < end; ++i)
				{
					if (Math.abs(mSelectedLetterSlots[i].x - letter.x) <= 40)
					{
						slotIndex = i;
					}
				}
				
				if (!selected)
				{
					SelectLetter(letter, Math.min(slotIndex, mSelectedLetterList.length));
					return;
				}
				
				slotIndex = Math.min(slotIndex, mSelectedLetterList.length - 1);
				letterIndex = mSelectedLetterList.indexOf(letter);
				if (slotIndex == -1 || letterIndex == slotIndex)
				{
					slot = mSelectedLetterSlots[letterIndex];
				}
				else
				{
					mSelectedLetterList.splice(letterIndex, 1);
					mSelectedLetterList.splice(slotIndex, 0, letter);
					slot = mSelectedLetterSlots[slotIndex];
				}
			}
			else
			{
				if (selected)
				{
					if (letter.x >= mSelectableLetterSlots[0].x - 40 &&
						letter.x <= mSelectableLetterSlots[mSelectableLetterSlots.length - 1].x + 40 &&
						letter.y >= mSelectableLetterSlots[0].y - 40 &&
						letter.y <= mSelectableLetterSlots[0].y + 40)
					{
						// Finding the slot over which the letter is being dragged
						for (i = 0, end = mSelectableLetterSlots.length; i < end; ++i)
						{
							if (Math.abs(mSelectableLetterSlots[i].x - letter.x) <= 40)
							{
								slotIndex = i;
							}
						}
					}
					
					UnselectLetter(letter, slotIndex);
					return;
				}
				
				letterIndex = mSelectableLetterList.indexOf(letter);
				if (letter.x >= mSelectableLetterSlots[0].x - 40 &&
					letter.x <= mSelectableLetterSlots[mSelectableLetterSlots.length - 1].x + 40 &&
					letter.y >= mSelectableLetterSlots[0].y - 40 &&
					letter.y <= mSelectableLetterSlots[0].y + 40)
				{
					// Finding the slot over which the letter is being dragged
					for (i = 0, end = mSelectableLetterSlots.length; i < end; ++i)
					{
						if (Math.abs(mSelectableLetterSlots[i].x - letter.x) <= 40)
						{
							slotIndex = i;
						}
					}
					
					if (letterIndex != slotIndex)
					{
						mSelectableLetterList.splice(mSelectableLetterList.indexOf(letter), 1);
						mSelectableLetterList.splice(slotIndex, 0, letter);
					}
					
					slot = mSelectableLetterSlots[slotIndex];
					for (i = 0, end = mSelectableLetterList.length; i < end; ++i)
					{
						if (mSelectableLetterList[i] != null && mSelectableLetterList[i] != letter)
						{
							mSelectableLetterList[i].x = mSelectableLetterSlots[i].x;
						}
					}
				}
				else
				{
					slot = mSelectableLetterSlots[letterIndex];
				}
			}
			
			letter.x = slot.x;
			letter.y = slot.y;
			RefreshCurrentWord();
		}
		
		private function OnLetterSelected(aEvent:SelectableLetterEvent):void
		{
			SelectLetter(aEvent.currentTarget as SelectableLetter);
		}
		
		private function OnLetterUnselected(aEvent:SelectableLetterEvent):void
		{
			UnselectLetter(aEvent.currentTarget as SelectableLetter);
		}
	}
}