package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.math.FlxMath;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import lime.app.Application;
import Achievements;
import editors.MasterEditorMenu;
import flixel.input.keyboard.FlxKey;

using StringTools;

class MainMenuState extends MusicBeatState
{
	public static var VsFuckBoiTrioVersion:String = '1.0.1 Patch'; //This is also used for Discord RPC
	public static var psychEngineVersion:String = '0.6.2'; //This is also used for Discord RPC
	public static var curSelected:Int = 0;

	var menuItems:FlxTypedGroup<FlxSprite>;
	private var camGame:FlxCamera;
	private var camAchievement:FlxCamera;
	
	var optionShit:Array<String> = [
		'story_mode',
		'freeplay',
		'credits',
		'options'
	];

	var bg:FlxSprite;
	var yScroll:Float;
	var magenta:FlxSprite;
	var daChoice:String;
	var camFollow:FlxObject;
	var camFollowPos:FlxObject;
	var debugKeys:Array<FlxKey>;

	var blackOut:FlxSprite;
	var yesOption:FlxSprite;
	var noOption:FlxSprite;
	var firstText:FlxText;
	var titleText:FlxText;

	override function create()
	{
		Paths.clearStoredMemory();
		Paths.clearUnusedMemory();
		#if MODS_ALLOWED
		Paths.pushGlobalMods();
		#end
		WeekData.loadTheFirstEnabledMod();

		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("In the Menus", null);
		#end
		debugKeys = ClientPrefs.copyKey(ClientPrefs.keyBinds.get('debug_1'));

		camGame = new FlxCamera();
		camAchievement = new FlxCamera();
		camAchievement.bgColor.alpha = 0;

		FlxG.cameras.reset(camGame);
		FlxG.cameras.add(camAchievement, false);
		FlxG.cameras.setDefaultDrawTarget(camGame, true);

		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		persistentUpdate = persistentDraw = true;

		yScroll = Math.max(0.05 - (0.05 * (optionShit.length - 4)), 0.1);
		bg = new FlxSprite( -50, -400);
		bg.frames = Paths.getSparrowAtlas('changingMenu/changingMenu-1');
		bg.animation.addByPrefix('story', 'storybg0', 24);
		bg.scrollFactor.set(0, 0);
		bg.setGraphicSize(Std.int(bg.width * 2));
		bg.updateHitbox();
		bg.screenCenter(X);
		bg.y = -100;
		add(bg);
		bg.animation.play('story');
		bg.antialiasing = ClientPrefs.globalAntialiasing;

		if (optionShit[curSelected] == 'story_mode')
			{
						bg.frames = Paths.getSparrowAtlas('changingMenu/changingMenu-1');
						bg.animation.addByPrefix('story', 'storybg0', 24);
						bg.scrollFactor.set(0, 0);
						bg.setGraphicSize(Std.int(bg.width * 2));
						bg.updateHitbox();
						bg.screenCenter(X);
						bg.y = -100;
						add(bg);
						bg.animation.play('story');
						bg.antialiasing = ClientPrefs.globalAntialiasing;
			}
		if (optionShit[curSelected] == 'freeplay')
			{
						bg.frames = Paths.getSparrowAtlas('changingMenu/changingMenu-2');
						bg.animation.addByPrefix('freeplay', 'freeplaybg0', 24);
						bg.scrollFactor.set(0, 0);
						bg.setGraphicSize(Std.int(bg.width * 2.20));
						bg.updateHitbox();
						bg.screenCenter(X);
						bg.screenCenter(Y);
						bg.x = -250;
						bg.y = -250;
						add(bg);
						bg.animation.play('freeplay');
						bg.antialiasing = ClientPrefs.globalAntialiasing;
			}
		if (optionShit[curSelected] == 'credits')
			{
						bg.frames = Paths.getSparrowAtlas('changingMenu/changingMenu-3');
						bg.animation.addByPrefix('credit', 'creditsbg0', 24);
						bg.scrollFactor.set(0, 0);
						bg.setGraphicSize(Std.int(bg.width * 2.50));
						bg.updateHitbox();
						bg.screenCenter(Y);
						bg.x = -2800;
						bg.y = -150;
						add(bg);
						bg.animation.play('credit');
						bg.antialiasing = ClientPrefs.globalAntialiasing;
			}
		if (optionShit[curSelected] == 'options')
			{
						bg.frames = Paths.getSparrowAtlas('changingMenu/changingMenu-4');
						bg.animation.addByPrefix('option', 'optionsbg0', 24);
						bg.scrollFactor.set(0, 0);
						bg.setGraphicSize(Std.int(bg.width * 2.50));
						bg.updateHitbox();
						bg.screenCenter(X);
						bg.y = -400;
						add(bg);
						bg.animation.play('option');
						bg.antialiasing = ClientPrefs.globalAntialiasing;
			}

		camFollow = new FlxObject(0, 0, 1, 1);
		camFollowPos = new FlxObject(0, 0, 1, 1);
		add(camFollow);
		add(camFollowPos);

		magenta = new FlxSprite(-80).loadGraphic(Paths.image('menuDesat'));
		magenta.scrollFactor.set(0, yScroll);
		magenta.setGraphicSize(Std.int(magenta.width * 1.175));
		magenta.updateHitbox();
		magenta.screenCenter();
		magenta.visible = false;
		magenta.antialiasing = ClientPrefs.globalAntialiasing;
		magenta.color = 0xFFfd719b;
		add(magenta);
		
		// magenta.scrollFactor.set();

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		var scale:Float = 1;
		/*if(optionShit.length > 6) {
			scale = 6 / optionShit.length;
		}*/

		for (i in 0...optionShit.length)
		{
			var offset:Float = 108 - (Math.max(optionShit.length, 4) - 4) * 80;
			var menuItem:FlxSprite = new FlxSprite(0, (i * 140)  + offset);
			menuItem.scale.x = scale;
			menuItem.scale.y = scale;
			menuItem.frames = Paths.getSparrowAtlas('mainmenu/menu_' + optionShit[i]);
			menuItem.animation.addByPrefix('idle', optionShit[i] + " basic", 24);
			menuItem.animation.addByPrefix('selected', optionShit[i] + " white", 24);
			menuItem.animation.play('idle');
			menuItem.ID = i;
			menuItem.screenCenter(X);
			menuItems.add(menuItem);
			var scr:Float = (optionShit.length - 4) * 0.135;
			if(optionShit.length < 6) scr = 0;
			menuItem.scrollFactor.set(0, scr);
			menuItem.antialiasing = ClientPrefs.globalAntialiasing;
			//menuItem.setGraphicSize(Std.int(menuItem.width * 0.58));
			menuItem.updateHitbox();
		}

		FlxG.camera.follow(camFollowPos, null, 1);

		
		var versionShit:FlxText = new FlxText(12, FlxG.height - 64, 0, "Vs FuckBoi Trio v" + VsFuckBoiTrioVersion, 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.PURPLE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);
		var versionShit:FlxText = new FlxText(12, FlxG.height - 44, 0, "Psych Engine v" + psychEngineVersion, 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.RED, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);
		var versionShit:FlxText = new FlxText(12, FlxG.height - 24, 0, "Friday Night Funkin' v" + Application.current.meta.get('version'), 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);

		// NG.core.calls.event.logEvent('swag').send();

		changeItem();

		#if ACHIEVEMENTS_ALLOWED
		Achievements.loadAchievements();
		var leDate = Date.now();
		if (leDate.getDay() == 5 && leDate.getHours() >= 18) {
			var achieveID:Int = Achievements.getAchievementIndex('friday_night_play');
			if(!Achievements.isAchievementUnlocked(Achievements.achievementsStuff[achieveID][2])) { //It's a friday night. WEEEEEEEEEEEEEEEEEE
				Achievements.achievementsMap.set(Achievements.achievementsStuff[achieveID][2], true);
				giveAchievement();
				ClientPrefs.saveSettings();
			}
		}
		#end

			FlxG.mouse.visible = true;
			blackOut = new FlxSprite(-639, -360).makeGraphic(FlxG.width, FlxG.height, 0xFF000000);
			blackOut.alpha = 0;
			add(blackOut);

			titleText = new FlxText(-630, -320, FlxG.width,
				"WARNING FOR STREAMERS",
				32);
			titleText.setFormat("PhantomMuff 1.5", 50, FlxColor.fromRGB(205, 0, 0), CENTER);
			titleText.alpha = 0;
			add(titleText);

			firstText = new FlxText(-650, -200, FlxG.width,
				"This Mod contains dialogue in story mode that may cause the game to crash if you're streaming the mod!\n
				If you do not want your game to crash when streaming, it is recommended to disable the dialogue in story mode!\n
				Would you like to keep dialogue turned on?\n
				Please select YES or NO with your cursor, to either keep dialogue on, or remove it entirely.\n
				PS: You can always re-enable / re-disable dialogue through the options menu [OPTIONS>GAMEPLAY].",
				25);
			firstText.setFormat("PhantomMuff 1.5", 25, FlxColor.WHITE, CENTER);
			firstText.alpha = 0;
			add(firstText);

			yesOption = new FlxSprite(-480, 190).loadGraphic(Paths.image('yes'));
			yesOption.antialiasing = ClientPrefs.globalAntialiasing;
			yesOption.scale.set(0.35, 0.35);
			yesOption.alpha = 0;
			yesOption.updateHitbox();
			add(yesOption);

			noOption = new FlxSprite(250, 190).loadGraphic(Paths.image('no'));
			noOption.antialiasing = ClientPrefs.globalAntialiasing;
			noOption.scale.set(0.35, 0.35);
			noOption.alpha = 0;
			noOption.updateHitbox();
			add(noOption);

		if (ClientPrefs.firstTime == false)
		{
			FlxTween.tween(blackOut, {alpha: 0.7}, 1.2, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(titleText, {alpha: 1}, 1.2, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(firstText, {alpha: 1}, 1.2, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(noOption, {alpha: 1}, 1.2, {ease: FlxEase.cubeInOut, type: PERSIST});
			FlxTween.tween(yesOption, {alpha: 1}, 1.2, {ease: FlxEase.cubeInOut, type: PERSIST});
		}

		super.create();
	}

	#if ACHIEVEMENTS_ALLOWED
	// Unlocks "Freaky on a Friday Night" achievement
	function giveAchievement() {
		add(new AchievementObject('friday_night_play', camAchievement));
		FlxG.sound.play(Paths.sound('confirmMenu'), 0.7);
		trace('Giving achievement "friday_night_play"');
	}
	#end

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
		if (ClientPrefs.firstTime == false)
		{
			if(FlxG.mouse.overlaps(yesOption))
				{
					if(FlxG.mouse.justPressed)
					{
						FlxG.sound.play(Paths.sound('scrollMenu'));
						ClientPrefs.dialogueWarning = true;
						ClientPrefs.firstTime = true;
						ClientPrefs.saveSettings();
						FlxTween.tween(blackOut, {alpha: 0}, 1.2, {ease: FlxEase.cubeInOut, type: PERSIST});
						FlxTween.tween(titleText, {alpha: 0}, 1.2, {ease: FlxEase.cubeInOut, type: PERSIST});
						FlxTween.tween(firstText, {alpha: 0}, 1.2, {ease: FlxEase.cubeInOut, type: PERSIST});
						FlxTween.tween(noOption, {alpha: 0}, 1.2, {ease: FlxEase.cubeInOut, type: PERSIST});
						FlxTween.tween(yesOption, {alpha: 0}, 1.2, {ease: FlxEase.cubeInOut, type: PERSIST});
					}
				}
			if(FlxG.mouse.overlaps(noOption))
				{
					if(FlxG.mouse.justPressed)
					{
						FlxG.sound.play(Paths.sound('scrollMenu'));
						ClientPrefs.dialogueWarning = false;
						ClientPrefs.firstTime = true;
						ClientPrefs.saveSettings();
						FlxTween.tween(blackOut, {alpha: 0}, 1.2, {ease: FlxEase.cubeInOut, type: PERSIST});
						FlxTween.tween(titleText, {alpha: 0}, 1.2, {ease: FlxEase.cubeInOut, type: PERSIST});
						FlxTween.tween(firstText, {alpha: 0}, 1.2, {ease: FlxEase.cubeInOut, type: PERSIST});
						FlxTween.tween(noOption, {alpha: 0}, 1.2, {ease: FlxEase.cubeInOut, type: PERSIST});
						FlxTween.tween(yesOption, {alpha: 0}, 1.2, {ease: FlxEase.cubeInOut, type: PERSIST});
					}
				}
		}
		if (ClientPrefs.firstTime == true)
		{
		FlxG.mouse.visible = false;
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
			if(FreeplayState.vocals != null) FreeplayState.vocals.volume += 0.5 * elapsed;
		}

		//var lerpVal:Float = CoolUtil.boundTo(elapsed * 7.5, 0, 1);
		//camFollowPos.setPosition(FlxMath.lerp(camFollowPos.x, camFollow.x, lerpVal), FlxMath.lerp(camFollowPos.y, camFollow.y, lerpVal));

		if (!selectedSomethin)
		{
			if (controls.UI_UP_P)
				{
					FlxG.sound.play(Paths.sound('scrollMenu'));
					changeItem(-1);
					if (optionShit[curSelected] == 'story_mode')
						{
									bg.frames = Paths.getSparrowAtlas('changingMenu/changingMenu-1');
									bg.animation.addByPrefix('story', 'storybg0', 24);
									bg.scrollFactor.set(0, 0);
									bg.setGraphicSize(Std.int(bg.width * 2));
									bg.updateHitbox();
									bg.screenCenter(X);
									bg.y = -100;
									add(bg);
									bg.animation.play('story');
									bg.antialiasing = ClientPrefs.globalAntialiasing;
						}
					if (optionShit[curSelected] == 'freeplay')
						{
									bg.frames = Paths.getSparrowAtlas('changingMenu/changingMenu-2');
									bg.animation.addByPrefix('freeplay', 'freeplaybg0', 24);
									bg.scrollFactor.set(0, 0);
									bg.setGraphicSize(Std.int(bg.width * 2.20));
									bg.updateHitbox();
									bg.screenCenter(X);
									bg.screenCenter(Y);
									bg.x = -250;
									bg.y = -250;
									add(bg);
									bg.animation.play('freeplay');
									bg.antialiasing = ClientPrefs.globalAntialiasing;
						}
					if (optionShit[curSelected] == 'credits')
						{
									bg.frames = Paths.getSparrowAtlas('changingMenu/changingMenu-3');
									bg.animation.addByPrefix('credit', 'creditsbg0', 24);
									bg.scrollFactor.set(0, 0);
									bg.setGraphicSize(Std.int(bg.width * 2.50));
									bg.updateHitbox();
									bg.screenCenter(X);
									bg.screenCenter(Y);
									bg.x = -2800;
									bg.y = -150;
									add(bg);
									bg.animation.play('credit');
									bg.antialiasing = ClientPrefs.globalAntialiasing;
						}
					if (optionShit[curSelected] == 'options')
						{
									bg.frames = Paths.getSparrowAtlas('changingMenu/changingMenu-4');
									bg.animation.addByPrefix('option', 'optionsbg0', 24);
									bg.scrollFactor.set(0, 0);
									bg.setGraphicSize(Std.int(bg.width * 2.50));
									bg.updateHitbox();
									bg.screenCenter(X);
									add(bg);
									bg.y = -400;
									bg.animation.play('option');
									bg.antialiasing = ClientPrefs.globalAntialiasing;
						}
				}
	
				if (controls.UI_DOWN_P)
				{
					FlxG.sound.play(Paths.sound('scrollMenu'));
					changeItem(1);
					if (optionShit[curSelected] == 'story_mode')
						{
									bg.frames = Paths.getSparrowAtlas('changingMenu/changingMenu-1');
									bg.animation.addByPrefix('story', 'storybg0', 24);
									bg.scrollFactor.set(0, 0);
									bg.setGraphicSize(Std.int(bg.width * 2));
									bg.updateHitbox();
									bg.screenCenter(X);
									bg.screenCenter(Y);
									bg.y = -100;
									add(bg);
									bg.animation.play('story');
									bg.antialiasing = ClientPrefs.globalAntialiasing;
						}
					if (optionShit[curSelected] == 'freeplay')
						{
									bg.frames = Paths.getSparrowAtlas('changingMenu/changingMenu-2');
									bg.animation.addByPrefix('freeplay', 'freeplaybg0', 24);
									bg.scrollFactor.set(0, 0);
									bg.setGraphicSize(Std.int(bg.width * 2.20));
									bg.updateHitbox();
									bg.screenCenter(X);
									bg.screenCenter(Y);
									bg.x = -250;
									bg.y = -250;
									add(bg);
									bg.animation.play('freeplay');
									bg.antialiasing = ClientPrefs.globalAntialiasing;
						}
					if (optionShit[curSelected] == 'credits')
						{
									bg.frames = Paths.getSparrowAtlas('changingMenu/changingMenu-3');
									bg.animation.addByPrefix('credit', 'creditsbg0', 24);
									bg.scrollFactor.set(0, 0);
									bg.setGraphicSize(Std.int(bg.width * 2.50));
									bg.updateHitbox();
									bg.screenCenter(X);
									bg.screenCenter(Y);
									bg.x = -2800;
									bg.y = -150;
									add(bg);
									bg.animation.play('credit');
									bg.antialiasing = ClientPrefs.globalAntialiasing;
						}
					if (optionShit[curSelected] == 'options')
						{
									bg.frames = Paths.getSparrowAtlas('changingMenu/changingMenu-4');
									bg.animation.addByPrefix('option', 'optionsbg0', 24);
									bg.scrollFactor.set(0, 0);
									bg.setGraphicSize(Std.int(bg.width * 2.50));
									bg.updateHitbox();
									bg.screenCenter(X);
									bg.screenCenter(Y);
									add(bg);
									bg.animation.play('option');
									bg.antialiasing = ClientPrefs.globalAntialiasing;
						}
				}

			if (controls.BACK)
			{
				selectedSomethin = true;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new TitleState());
			}

			if (controls.ACCEPT)
			{
				if (optionShit[curSelected] == 'donate')
				{
					CoolUtil.browserLoad('https://ninja-muffin24.itch.io/funkin');
				}
				else
				{
					selectedSomethin = true;
					FlxG.sound.play(Paths.sound('confirmMenu'));

					//if(ClientPrefs.flashing) FlxFlicker.flicker(magenta, 1.1, 0.15, false);

					menuItems.forEach(function(spr:FlxSprite)
					{
						if (curSelected != spr.ID)
						{
							FlxTween.tween(spr, {alpha: 0}, 0.4, {
								ease: FlxEase.quadOut,
								onComplete: function(twn:FlxTween)
								{
									spr.kill();
								}
							});
						}
						else
						{
							FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
							{
								var daChoice:String = optionShit[curSelected];

								switch (daChoice)
								{
									case 'story_mode':
										MusicBeatState.switchState(new StoryMenuState());
									case 'freeplay':
										MusicBeatState.switchState(new FreeplayState());
									#if MODS_ALLOWED
									case 'mods':
										MusicBeatState.switchState(new ModsMenuState());
									#end
									case 'awards':
										MusicBeatState.switchState(new AchievementsMenuState());
									case 'credits':
										MusicBeatState.switchState(new CreditsState());
									case 'options':
										LoadingState.loadAndSwitchState(new options.OptionsState());
								}
							});
						}
					});
				}
			}
			#if desktop
			else if (FlxG.keys.anyJustPressed(debugKeys))
			{
				selectedSomethin = true;
				MusicBeatState.switchState(new MasterEditorMenu());
			}
			#end
		}
	}
	
	menuItems.forEach(function(spr:FlxSprite)
		{
			spr.screenCenter(X);
			spr.x -= 260;
		});
	
		super.update(elapsed);
	}

	function changeItem(huh:Int = 0)
	{
		curSelected += huh;

		if (curSelected >= menuItems.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = menuItems.length - 1;

		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.animation.play('idle');
			spr.updateHitbox();

			if (spr.ID == curSelected)
			{
				spr.animation.play('selected');
				var add:Float = 0;
				if(menuItems.length > 4) {
					add = menuItems.length * 8;
				}
				camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y - add);
				spr.centerOffsets();
			}
		});
	}
}
