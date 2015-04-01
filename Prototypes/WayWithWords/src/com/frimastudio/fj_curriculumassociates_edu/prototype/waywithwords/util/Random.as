package com.frimastudio.fj_curriculumassociates_edu.prototype.waywithwords.util
{
	public class Random
	{
		public static function Range(aMin:Number, aMax:Number):Number
		{
			return aMin + Math.floor(Math.random() * (aMax - aMin + 1));
		}
		
		public static function RangeInt(aMin:int, aMax:int):int
		{
			return Range(aMin, aMax) as int;
		}
		
		public function Random()
		{
			throw new Error("Random is a static class not intended for instantiation.");
		}
	}
}