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
	import com.greensock.easing.Bounce;
	import com.greensock.TweenLite;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	
	public class InteractionInputWidget extends RetractableWidget
	{
		private var mSelectedLetterSlots:Vector.<Point>;
		private var mSelectedLetterSlotTiles:Vector.<LetterSlotTile>;
		private var mSelectableLetterSlots:Vector.<Point>;
		private var mSelectableLetterSlotTiles:Vector.<LetterSlotTile>;
		private var mSelectedLetterList:Vector.<SelectableLetter>;
		private var mSelectableLetterList:Vector.<SelectableLetter>;
		private var mSubmitButton:WidgetButton;
		private var mEraseButton:WidgetButton;
		private var mLetterSelection:String;
		private var mCurrentWord:String;
		private var mSelectableIdleAnimTimer:Timer;
		
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
			mSelectedLetterSlotTiles = new Vector.<LetterSlotTile>();
			mSelectableLetterSlots = new Vector.<Point>();
			mSelectableLetterSlotTiles = new Vector.<LetterSlotTile>();
			mSelectedLetterList = new Vector.<SelectableLetter>();
			mSelectableLetterList = new Vector.<SelectableLetter>();
			mCurrentWord = "";
			
			var buttonRect:Rectangle = new Rectangle(-20, -20, 40, 40);
			
			mSubmitButton = new WidgetButton(">", buttonRect, 0xCCCCCC);
			mSubmitButton.x = 535;
			mSubmitButton.y = -90;
			mSubmitButton.addEventListener(MouseEvent.CLICK, OnSubmit);
			addChild(mSubmitButton);
			
			mEraseButton = new WidgetIconButton(Asset.EraserIconBitmap, buttonRect, 0xCCCCCC);
			mEraseButton.x = 585;
			mEraseButton.y = -90;
			mEraseButton.addEventListener(MouseEvent.CLICK, OnErase);
			addChild(mEraseButton);
			
			mSelectableIdleAnimTimer = new Timer(4000, 0);
			mSelectableIdleAnimTimer.addEventListener(TimerEvent.TIMER, OnSelectableIdleAnimTimer);
			mSelectableIdleAnimTimer.start();
			
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
			
			mSelectableIdleAnimTimer.stop();
			mSelectableIdleAnimTimer.removeEventListener(TimerEvent.TIMER, OnSelectableIdleAnimTimer);
			
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
			var tile:LetterSlotTile;
			var i:int, end:int;
			for (i = 0, end = aLetterSelection.length; i < end; ++i)
			{
				slotX = (85 * i) + 100;
				
				mSelectedLetterSlots.push(new Point(slotX, -90));
				mSelectableLetterSlots.push(new Point(slotX, 10));
				
				tile = new LetterSlotTile();
				tile.x = slotX;
				tile.y = -90;
				tile.StartPulseAnim(i * 100);
				addChild(tile);
				mSelectedLetterSlotTiles.push(tile);
				
				tile = new LetterSlotTile();
				tile.x = slotX;
				tile.y = 10;
				tile.Show();
				addChild(tile);
				mSelectableLetterSlotTiles.push(tile);
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
			
			RefreshButtonColor();
			RefreshSlotTile();
		}
		
		private function AddSelectedLetter(aCharacter:String, aIndex:int = -1, aOrigin:Point = null):void
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
			if (aOrigin)
			{
				TweenLite.fromTo(selectedLetter, 0.2, { x:aOrigin.x }, { x:slot.x, overwrite:true, ease:Bounce.easeOut });
				selectedLetter.y = slot.y;
			}
			else
			{
				selectedLetter.x = slot.x;
				selectedLetter.y = slot.y;
			}
			selectedLetter.addEventListener(SelectableLetterEvent.DRAGGED, OnLetterDragged);
			selectedLetter.addEventListener(SelectableLetterEvent.DROPPED, OnLetterDropped);
			selectedLetter.addEventListener(SelectableLetterEvent.SELECTED, OnLetterUnselected);
			addChild(selectedLetter);
		}
		
		private function AddSelectableLetter(aCharacter:String, aIndex:int = -1, aOrigin:Point = null):void
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
			if (aOrigin)
			{
				TweenLite.fromTo(selectableLetter, 0.2, { x:aOrigin.x }, { x:slot.x, overwrite:true, ease:Bounce.easeOut });
				selectableLetter.y = slot.y;
			}
			else
			{
				selectableLetter.x = slot.x;
				selectableLetter.y = slot.y;
			}
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
			
			RefreshButtonColor();
			RefreshSlotTile();
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
			var position:Point = new Point(aLetter.x, aLetter.y);
			RemoveSelectableLetter(aLetter);
			AddSelectedLetter(character, aIndex, position);
			
			RefreshCurrentWord();
			RefreshButtonColor();
			RefreshSlotTile();
		}
		
		private function UnselectLetter(aLetter:SelectableLetter, aIndex:int = -1):void
		{
			var character:String = aLetter.Character;
			var position:Point = new Point(aLetter.x, aLetter.y);
			RemoveSelectedLetter(aLetter);
			AddSelectableLetter(character, aIndex, position);
			
			RefreshCurrentWord();
			RefreshButtonColor();
			RefreshSlotTile();
		}
		
		private function RefreshCurrentWord():void
		{
			mCurrentWord = "";
			for (var i:int = 0, end:int = mSelectedLetterList.length; i < end; ++i)
			{
				mCurrentWord += mSelectedLetterList[i].Character;
			}
		}
		
		private function RefreshButtonColor():void
		{
			mSubmitButton.ButtonColor = (mSelectedLetterList.length > 0 ? 0x00CC00 : 0xCCCCCC);
			mEraseButton.ButtonColor = (mSelectedLetterList.length > 0 ? 0xCC0000 : 0xCCCCCC);
		}
		
		private function RefreshSlotTile():void
		{
			var i:int, end:int;
			if (mSelectedLetterList.length > 0)
			{
				for (i = 0, end = mSelectedLetterSlotTiles.length; i < end; ++i)
				{
					if (i < mSelectedLetterList.length)
					{
						mSelectedLetterSlotTiles[i].Show();
					}
					else
					{
						mSelectedLetterSlotTiles[i].Hide();
					}
				}
			}
			else
			{
				for (i = 0, end = mSelectedLetterSlotTiles.length; i < end; ++i)
				{
					mSelectedLetterSlotTiles[i].StartPulseAnim(i * 100);
				}
			}
		}
		
		private function OnSelectableIdleAnimTimer(aEvent:TimerEvent):void
		{
			var availableList:Vector.<SelectableLetter> = new Vector.<SelectableLetter>();
			for (var i:int = 0, end:int = mSelectableLetterList.length; i < end; ++i)
			{
				if (mSelectableLetterList[i] != null)
				{
					availableList.push(mSelectableLetterList[i]);
				}
			}
			
			if (availableList.length > 0)
			{
				var letter:SelectableLetter = Random.FromList(availableList) as SelectableLetter;
				new Shaker(letter, 500, new Point(0, 2));
			}
		}
		
		private function OnSubmit(aEvent:MouseEvent):void
		{
			if (mSelectedLetterList.length <= 0)
			{
				return;
			}
			
			dispatchEvent(new InteractionInputEvent(InteractionInputEvent.SUBMIT, mCurrentWord));
		}
		
		private function OnErase(aEvent:MouseEvent):void
		{
			if (mSelectedLetterList.length <= 0)
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
			RefreshButtonColor();
			RefreshSlotTile();
		}
		
		private function OnEraseLast(aEvent:KeyboardManagerEvent):void
		{
			if (!stage || mSelectedLetterList.length <= 0)
			{
				return;
			}
			
			AddSelectableLetter(mSelectedLetterList[mSelectedLetterList.length - 1].Character);
			RemoveSelectedLetter(mSelectedLetterList[mSelectedLetterList.length - 1], false);
			mSelectedLetterList.splice(mSelectedLetterList.length - 1, 1);
			
			RefreshCurrentWord();
			RefreshButtonColor();
			RefreshSlotTile();
		}
		
		private function OnEraseAll(aEvent:KeyboardManagerEvent):void
		{
			if (!stage || mSelectedLetterList.length <= 0)
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
			RefreshButtonColor();
			RefreshSlotTile();
		}
		
		private function OnRequestSubmit(aEvent:KeyboardManagerEvent):void
		{
			if (!stage || mSelectedLetterList.length <= 0)
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
			
			var letterPosition:Point;
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
					
					letterPosition =  new Point(0, mSelectedLetterSlots[i].y);
					
					if (currentIndex == -1 || i < currentIndex)
					{
						letterPosition.x = mSelectedLetterSlots[(i < slotIndex ? i : i + 1)].x;
					}
					else
					{
						letterPosition.x = mSelectedLetterSlots[(i > slotIndex ? i : i - 1)].x;
					}
					TweenLite.to(mSelectedLetterList[i], 0.2, { x:letterPosition.x, overwrite:true, ease:Bounce.easeOut } );
					mSelectedLetterList[i].y = letterPosition.y;
				}
			}
			else
			{
				for (i = 0, end = mSelectedLetterList.length; i < end; ++i)
				{
					if (mSelectedLetterList[i] != letter)
					{
						letterPosition = new Point(mSelectedLetterSlots[i].x, mSelectedLetterSlots[i].y);
						TweenLite.to(mSelectedLetterList[i], 0.2, { x:letterPosition.x, overwrite:true, ease:Bounce.easeOut } );
						mSelectedLetterList[i].y = letterPosition.y;
					}
				}
			}
			
			var offset:int = (mSelectedLetterList.indexOf(letter) == -1 ? 1 : 0);
			for (i = 0, end = mSelectedLetterSlotTiles.length; i < end; ++i)
			{
				if (i < mSelectedLetterList.length + offset)
				{
					mSelectedLetterSlotTiles[i].Show();
				}
				else
				{
					mSelectedLetterSlotTiles[i].Hide();
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
					
					if (slotIndex != -1)
					{
						slot = mSelectableLetterSlots[slotIndex];
					}
					for (i = 0, end = mSelectableLetterList.length; i < end; ++i)
					{
						if (mSelectableLetterList[i] != null && mSelectableLetterList[i] != letter)
						{
							TweenLite.to(mSelectableLetterList[i], 0.2, { x:mSelectableLetterSlots[i].x, overwrite:true, ease:Bounce.easeOut } );
						}
					}
				}
				else
				{
					slot = mSelectableLetterSlots[letterIndex];
				}
			}
			
			if (slot)
			{
				TweenLite.to(letter, 0.2, { x:slot.x, y:slot.y, overwrite:true, ease:Bounce.easeOut } );
			}
			
			RefreshCurrentWord();
			RefreshButtonColor();
			RefreshSlotTile();
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