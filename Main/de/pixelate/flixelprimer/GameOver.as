/**
 * Created by ${PRODUCT_NAME}.
 * User: shiva
 * Date: 18/4/11
 * Time: 9:01 PM
 * To change this template use File | Settings | File Templates.
 */
package de.pixelate.flixelprimer {

import org.flixel.*;

public class GameOver extends FlxState {
        override public function create():void
    {
           FlxG.quake.start(0.02);
        var _gameOverText:FlxText = new FlxText(0, FlxG.height / 2, FlxG.width,
                "GAME OVER\n PRESS ENTER TO RESTART");
        _gameOverText.setFormat(null, 16, 0xFF597137, "center");
        add(_gameOverText);
    }
    override public function update():void
    {
        if (FlxG.keys.ENTER)
        {
        Globals.currentNumberofLives = 5;
        FlxG.score = 0;
        FlxG.state = new Level1;
        }
   }
}
}
