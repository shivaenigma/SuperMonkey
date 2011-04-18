package de.pixelate.flixelprimer
{
import org.flixel.*;

public class RedBird extends FlxSprite
{
    [Embed(source="../../../assets/png/redbird.png")] private var ImgRedBird:Class;

    public var _bombs:FlxGroup;
    // No of bombs this bird is allowed to drop
    public var noOfBombs:Number;
    public var treeGroup:FlxGroup;


    public function RedBird(x: Number, y: Number,bombs:FlxGroup):void
    {
        _bombs = bombs;
        noOfBombs = Math.random()  + 1;
        super(x, y, ImgRedBird);


        treeGroup = new FlxGroup;
        // Doing deep copy of original group
        for each(var tree:FlxSprite in (Level1._trees as FlxGroup).members)
            treeGroup.add(tree);
    }

    override public function update():void
    {
        var tree:FlxSprite;
        if (noOfBombs >0)
        {
            for each(tree in treeGroup.members)
            {
                // Take a toss whether to drop a bomb on a tree or not
                if (x> tree.x + tree.width/3  && x< tree.x +tree.width *2/3)
                {
                    treeGroup.remove(tree,true);
                    if (Math.random() > 0.5)
                    {
                        // Spawn the bomb
                        noOfBombs--;
                        var bombInstance:BirdBomb = new BirdBomb(x,y+height);
                        bombInstance.acceleration.y = Bandar._gravity/2;
                        _bombs.add(bombInstance);
                    }
                    break;
                }
            }
        }
        super.update();
    }
}
}