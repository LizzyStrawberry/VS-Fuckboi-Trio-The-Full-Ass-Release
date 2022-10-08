package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.effects.FlxFlicker;
import lime.app.Application;
import flixel.addons.transition.FlxTransitionableState;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;

class FlashingState extends MusicBeatState
{
	public static var leftState:Bool = false;

	var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('flashingstatebg'));
	var warnText:FlxText;
	override function create()
	{
		super.create();

		bg.alpha = 0;
		FlxTween.tween(bg, { alpha: 0.4 }, 3);
		add(bg);

		warnText = new FlxText(0, 0, FlxG.width,
			"Hey there!\n
			This Mod contains Flashing Lights and Shaders that could cause the 'not so good stuff', like seizures.\n
			So press ENTER to disable them!\n
			Or ESCAPE to ignore me :(.\n
			Well come on! I don't have all day, you gotta make a choice!\n
			-Definitely written by TheRandomFiend, and not Strawberry.",
			32);
		warnText.setFormat("VCR OSD Mono", 32, FlxColor.WHITE, CENTER);
		warnText.screenCenter(Y);
		warnText.alpha = 0;
		FlxTween.tween(warnText, { alpha: 1 }, 3);
		add(warnText);
	}

	override function update(elapsed:Float)
	{
		if(!leftState) {
			var back:Bool = controls.BACK;
			if (controls.ACCEPT || back) {
				leftState = true;
				FlxTransitionableState.skipNextTransIn = true;
				FlxTransitionableState.skipNextTransOut = true;
				if(!back) {
					ClientPrefs.flashing = false;
					ClientPrefs.shaders = false;
					ClientPrefs.saveSettings();
					FlxG.sound.play(Paths.sound('confirmMenu'));
					FlxTween.tween(bg, { alpha: 0 }, 1);
					FlxFlicker.flicker(warnText, 1, 0.1, false, true, function(flk:FlxFlicker) {
						new FlxTimer().start(0.5, function (tmr:FlxTimer) {
							MusicBeatState.switchState(new TitleState());
						});
					});
				} else {
					FlxG.sound.play(Paths.sound('cancelMenu'));
					FlxTween.tween(bg, { alpha: 0 }, 1);
					FlxTween.tween(warnText, {alpha: 0}, 1, {
						onComplete: function (twn:FlxTween) {
							MusicBeatState.switchState(new TitleState());
						}
					});
				}
			}
		}
		super.update(elapsed);
	}
}
