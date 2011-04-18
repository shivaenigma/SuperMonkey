package de.pixelate.flixelprimer
{
	import org.flixel.*;

	public class BirdBomb extends FlxSprite
	{		
		[Embed(source="../../../assets/png/Bomb.png")] private var ImgBomb:Class


		public function BirdBomb(x: Number, y: Number):void
		{
			super(x, y, ImgBomb);
		}

		override public function update():void
		{
	        super.update();
		}	
	}
}