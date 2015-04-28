package com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.hud
{
	import flash.display.Bitmap;
	import flash.geom.Rectangle;
	
	public class WidgetIconButton extends WidgetButton
	{
		public function WidgetIconButton(aAsset:Class, aRect:Rectangle, aColor:int=0xFFFFFF)
		{
			super("", aRect, aColor);
			
			var icon:Bitmap = new aAsset();
			icon.width = Math.min(icon.width, aRect.width);
			icon.height = Math.min(icon.height, aRect.height);
			icon.scaleX = icon.scaleY = Math.min(icon.scaleX, icon.scaleY);
			icon.x = icon.width * -0.5;
			icon.y = icon.height * -0.5;
			addChild(icon);
		}
	}
}