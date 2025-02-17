package actors.enemies;

import flixel.math.FlxPoint;
import flixel.group.FlxGroup.FlxTypedGroup;

class KnightEnemy extends Enemy {

    private static var WIDTH(default, never):Int = 32;
    private static var HEIGHT(default, never):Int = 32;
    private static var HIT_BOX_WIDTH(default, never):Float = 20;
    private static var HIT_BOX_HEIGHT(default, never):Float = 32;
    private static var OFFSET_X(default, never):Float = 6;
    private static var OFFSET_Y(default, never):Float = 0;
    private static var HEALTH(default, never):Float = 2;

    public static var DAMAGE(default, never):Float = 2;
    public static var SWORDS(default, never):FlxTypedGroup<SwordProjectile> = new FlxTypedGroup<SwordProjectile>();
    public static var ATTACK_SPEED(default, never):Float = 1.5;

    public function new(X:Float, Y:Float) {
        super(X, Y, REGULAR, WIDTH, HEIGHT, HIT_BOX_WIDTH, HIT_BOX_HEIGHT, OFFSET_X, OFFSET_Y, HEALTH);
        addAnimations();
        attackTimer = 0;
    }

    /**
	 * Helper function that initializes the graphics and scale the sprite.
     * @author Matt Lippelman
	 */
    private override function initializeGraphics():Void {
        loadGraphic(AssetPaths.Knight__png, true, WIDTH, HEIGHT);
        offset.set(OFFSET_X, OFFSET_Y);
        setGraphicSize(WIDTH * 2, HEIGHT * 2);
        width = HIT_BOX_WIDTH;
        height = HIT_BOX_HEIGHT;
    }

    /**
	 * Helper function to add animations
     * @author Matt Lippelman
	 */
    private function addAnimations():Void {
        animation.add(Enemy.DOWN, [0, 1, 0, 3], 6, true);
        animation.add(Enemy.LEFT_RIGHT, [0, 1, 0, 3], 6, true);
        animation.add(Enemy.UP, [6, 7, 6, 8], 6, true);
        animation.add(Enemy.ATTACK, [0, 4, 0], 6, false);
        animation.add(Enemy.TAKING_DAMAGE, [0, 5, 0], 6, false);
    }

    override public function attack(elapsed:Float) {
        if (attackTimer <= 0) {
            var sword:SwordProjectile = SWORDS.recycle(SwordProjectile);
            sword.setDirection(playerPosition, new FlxPoint(this.x, this.y));
            sword.fire();
            attackTimer = ATTACK_SPEED;
        } else {
            attackTimer -= elapsed;
        }
    }
}