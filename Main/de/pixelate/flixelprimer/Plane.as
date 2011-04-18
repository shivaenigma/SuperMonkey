package de.pixelate.flixelprimer
{
	import org.flixel.*;

	public class Plane extends FlxSprite
	{		
		[Embed(source="../../../assets/png/plane.png")] private var ImgPlane:Class;

		public function Plane(x: Number, y: Number):void
		{
			super(x, y, ImgPlane);
		}

		override public function update():void
		{			
	         if ( x > FlxG.width)
             {
                 // Out of the screen
                 kill();
                 Level1.currentNumberofLives--;
                 Level1.progressBar.x = (- Level1.totalNumberofLives + Level1.currentNumberofLives)
                         / Level1.totalNumberofLives * Level1.progressBarWidth;
             }
             super.update();
		}	
	}
}