package;

#if desktop
import Discord.DiscordClient;
#end
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.tweens.FlxEase;
import flixel.effects.FlxFlicker;
import lime.app.Application;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flash.text.TextField;
import lime.utils.Assets;
import flixel.addons.transition.FlxTransitionableState;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.input.keyboard.FlxKey;

class BiosState extends MusicBeatState
{
	//Before any of you say 'OmG ThIs dUde sUckS aT cOdInggGgGg', I'm still learning lmao, I'm still on my way to learn more efficient ways of coding, but for now, have this lmao
	public static var curSelected:Int = 0;

	var optionShit:Array<String> = [
		'fiend',
		'shadow',
		'weegee',
		'maxx',
		'faye',
		'shade',
		'liz',
		'fiendScrewed',
		'Su-Bf'

	];

	var bg:FlxSprite;
	var titleText:FlxText;
	var desc:FlxText;
	var char:FlxSprite;
	var textBG:FlxSprite;
	var textBGMain:FlxSprite;
	var Text:FlxText;
	var titleBG:FlxSprite;
	var num:Int = 0;
	override function create()
	{
		#if desktop
		// Updating Discord Rich Presence
		DiscordClient.changePresence("Viewing Character Bios", null);
		#end

		//persistentUpdate = persistentDraw = true;
		bg = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		bg.color = 0xFFe1e1e1;
		bg.alpha = 0.5;
		add(bg);

		textBG = new FlxSprite(0, FlxG.height - 726).makeGraphic(FlxG.width, 46, 0xFF000000);
		textBG.alpha = 0.6;
		add(textBG);

		Text = new FlxText(textBG.x + 1000, textBG.y + 8, FlxG.width + 1000, "VS Fuckboi Trio  |  Main Cast  |  VS Fuckboi Trio  |  Main Cast  |  VS Fuckboi Trio  |   Main Cast ", 24);
		Text.setFormat(Paths.font("PhantomMuff.ttf"), 24, FlxColor.WHITE, RIGHT);
		Text.scrollFactor.set();
		add(Text);
	
		FlxTween.tween(Text, {x: textBG.x - 2500}, 10.2, {ease: FlxEase.linear, type: LOOPING});

		textBGMain = new FlxSprite(0, 175).makeGraphic(FlxG.width - 400, 1000, 0xFF000000);
		textBGMain.alpha = 0.6;
		add(textBGMain);

		titleBG = new FlxSprite(100, 95).makeGraphic(FlxG.width - 630, 75, 0xFF000000);
		titleBG.alpha = 0.6;
		add(titleBG);

		titleText = new FlxText(-220, 90, FlxG.width,
			"This is a test",
			72);
		titleText.setFormat(Paths.font("PhantomMuff.ttf"), 72, FlxColor.WHITE, CENTER);
		add(titleText);

		desc = new FlxText(-230, 200, FlxG.width,
			"This will only appear if i\ndon't have any text\nset for the characters.\nWe'll be checking the amount of space\nI can use to add these descriptions in.\nI should theoretically have enough\nspace to type this much stuff.\n#fortniteforlife lmao",
			52);
		desc.setFormat(Paths.font("PhantomMuff.ttf"), 36, FlxColor.WHITE, CENTER);
		add(desc);

		char = new FlxSprite(860, 0);
		char.frames = Paths.getSparrowAtlas('CharacterBios/FiendBios');//here put the name of the xml
		char.animation.addByPrefix('idle1', 'idle0', 24);
		char.animation.play('idle1');//you can rename the anim however you want to
		char.scrollFactor.set(0, 0);
		char.flipX = true;//this is for flipping it to look left instead of right you can make it however you want
		char.antialiasing = ClientPrefs.globalAntialiasing;
		add(char);
		char.updateHitbox();

		if (optionShit[curSelected] == 'fiend')
			{
				char.frames = Paths.getSparrowAtlas('CharacterBios/FiendBios');//here put the name of the xml
				char.animation.addByPrefix('idle1', 'idle0', 24);
				char.animation.play('idle1');//you can rename the anim however you want to
				char.scrollFactor.set(0, 0);
				char.x = 860;
				char.y = 40;
				char.scale.x = 1;
				char.scale.y = 1;

				titleText.text = "Fiend";
				titleText.setFormat(Paths.font("PhantomMuff.ttf"), 72, FlxColor.WHITE, CENTER);
				titleText.color = 0xFF71334d;

				Text.text = "VS Fuckboi Trio  |  Main Cast  |  VS Fuckboi Trio  |   Main Cast  |  VS Fuckboi Trio  |   Main Cast ";

				desc.text = "- Was Created in 2019\nand went through many redesigns.
						\n- He's 15 years old,\nand does stupid shit like\ntrying to find the Golden Turkey\nor making salt milk.
						\n- He likes to draw,\nand hate his friends /j.
						\n- Was Created by TheRandomFiend.";
				char.flipX = true;//this is for flipping it to look left instead of right you can make it however you want
				char.antialiasing = ClientPrefs.globalAntialiasing;
				add(char);
				char.updateHitbox();

				FlxTween.color(bg, 2, 0xFFe1e1e1, 0xFF71334d, {ease: FlxEase.cubeInOut, type: PERSIST});
			}

			if (optionShit[curSelected] == 'weegee')
				{
					char.frames = Paths.getSparrowAtlas('CharacterBios/WeegeeBios');//here put the name of the xml
					char.animation.addByPrefix('idle7', 'weegie0', 24);//on 'idle normal' change it to your xml one
					char.animation.play('idle7');//you can rename the anim however you want to
					char.scrollFactor.set();
					char.x = 890;
					char.y = 90;
					char.scale.x = 1;
					char.scale.y = 1;
	
					titleText.text = "Weegee";
					titleText.setFormat(Paths.font("PhantomMuff.ttf"), 72, FlxColor.WHITE, CENTER);
					titleText.color = 0xFF4ee75b;
	
					Text.text = "VS Fuckboi Trio  |  Main Cast  |  VS Fuckboi Trio  |   Main Cast  |  VS Fuckboi Trio  |   Main Cast ";
	
					desc.text = "- Was Created by WeegeeDude.
					\n- His favourite console is the Wii U,\nand if you disagree,\nhe'll personally assasinate you. /j
					\n- To this day, we still await to learn\nabout Weegee's date of creation.";
					char.flipX = true;//this is for flipping it to look left instead of right you can make it however you want
					char.antialiasing = ClientPrefs.globalAntialiasing;
					add(char);
					char.updateHitbox();

					FlxTween.color(bg, 2, 0xFFe1e1e1, 0xFF4ee75b, {ease: FlxEase.cubeInOut, type: PERSIST});
			}

		if (optionShit[curSelected] == 'shadow')
			{
				char.frames = Paths.getSparrowAtlas('CharacterBios/ShadowBios');//here put the name of the xml
				char.animation.addByPrefix('idle2', 'idle0', 24);//on 'idle normal' change it to your xml one
				char.animation.play('idle2');//you can rename the anim however you want to
				char.scrollFactor.set();
				char.x = 920;
				char.y = 70;
				char.scale.x = 1;
				char.scale.y = 1;

				titleText.text = "Shadow";
				titleText.setFormat(Paths.font("PhantomMuff.ttf"), 72, FlxColor.WHITE, CENTER);
				titleText.color = 0xFF9d03ad;

				Text.text = "VS Fuckboi Trio  |  Main Cast  |  VS Fuckboi Trio  |   Main Cast  |  VS Fuckboi Trio  |   Main Cast ";

				desc.text = "- Was Created in Late 2019 - Early 2020\nfor a [Cancelled] fangame called\n 'Five Nights at Randoms'.
				\n- He's dead, yet his brain is still functioning,\nhence the wires on him.
				\n- He has Anger issues [smh],\n so don't mess with him.
				\n- Was Created by TheShadowGames854.";
				char.flipX = true;//this is for flipping it to look left instead of right you can make it however you want
				char.antialiasing = ClientPrefs.globalAntialiasing;
				add(char);
				char.updateHitbox();

				FlxTween.color(bg, 2, 0xFFe1e1e1, 0xFF9d03ad, {ease: FlxEase.cubeInOut, type: PERSIST});
		}

		if (optionShit[curSelected] == 'Su-Bf')
			{
				num = FlxG.random.int(0, 3);
				char.frames = Paths.getSparrowAtlas('CharacterBios/SU-BFBios');//here put the name of the xml
				if (num == 3)
					{
						char.animation.addByPrefix('idle9', 'SU-BFBios BF Angy0', 24);//on 'idle normal' change it to your xml one
						char.animation.play('idle9');//you can rename the anim however you want to
					}
				if (num != 3)
					{
					char.animation.addByPrefix('idle8', 'BF idle dance0', 24);//on 'idle normal' change it to your xml one
					char.animation.play('idle8');//you can rename the anim however you want to
					}
				char.scrollFactor.set();
				char.x = 890;
				char.y = 250;
				char.scale.x = 1;
				char.scale.y = 1;

				titleText.text = "(SU) Boyfriend";
				titleText.setFormat(Paths.font("PhantomMuff.ttf"), 72, FlxColor.WHITE, CENTER);
				titleText.color = 0xFF66ffff;

				Text.text = "VS Fuckboi Trio  |  Extras  |  VS Fuckboi Trio  |  Extras  |  VS Fuckboi Trio  |  Extras ";

				desc.text = "- Was Created in 2021, on the 2nd\nUpdate of 'VS The Dark Star'.
				\n- To match Strawberry's Style,\nhe was drawn from scratch like this.
				\n- He has a second pissed/scared variation,\n and the hair is a bit longer.
				\n-'VS the Dark Star is a very old mod,\n and I knew very little to no coding\n plz don't make fun of me :('";
				char.flipX = false;//this is for flipping it to look left instead of right you can make it however you want
				char.antialiasing = ClientPrefs.globalAntialiasing;
				add(char);
				char.updateHitbox();

				FlxTween.color(bg, 2, 0xFFe1e1e1, 0xFF66ffff, {ease: FlxEase.cubeInOut, type: PERSIST});
		}

		if (optionShit[curSelected] == 'fiendScrewed')
			{
				char.frames = Paths.getSparrowAtlas('CharacterBios/Fiend_ScrewedBios');//here put the name of the xml
				char.animation.addByPrefix('idle3', 'idle0', 24);//on 'idle normal' change it to your xml one
				char.animation.play('idle3');//you can rename the anim however you want to
				char.scrollFactor.set();
				char.x = 920;
				char.y = 50;
				char.scale.x = 1;
				char.scale.y = 1;

				titleText.text = "Fiend (Screwed)";
				titleText.setFormat(Paths.font("PhantomMuff.ttf"), 72, FlxColor.WHITE, CENTER);
				titleText.color = 0xFF4a122c;

				Text.text = "VS Fuckboi Trio  |  Extras  |  VS Fuckboi Trio  |  Extras  |  VS Fuckboi Trio  |  Extras ";

				desc.text = "- Was Created during the development\nof this mod.
				\n- Shadow would be controlling\n both Fiend and Weegee in Screwed mode,\n as a different timeline would occur.
				\n- Sadly, the idea got scrapped\nmid way through development,\n and he's now used in the You Can't Run Cover.
				\n- 'He still looks good tho' -Strawberry 2022";
				char.flipX = true;//this is for flipping it to look left instead of right you can make it however you want
				char.antialiasing = ClientPrefs.globalAntialiasing;
				add(char);
				char.updateHitbox();

				FlxTween.color(bg, 2, 0xFFe1e1e1, 0xFF4a122c, {ease: FlxEase.cubeInOut, type: PERSIST});
		}

		if (optionShit[curSelected] == 'faye')
			{
				char.frames = Paths.getSparrowAtlas('CharacterBios/FayeBios');//here put the name of the xml
				char.animation.addByPrefix('idle4', 'faye idle0', 24);//on 'idle normal' change it to your xml one
				char.animation.play('idle4');//you can rename the anim however you want to
				char.scrollFactor.set();
				char.x = 860;
				char.y = 180;
				char.scale.x = 1;
				char.scale.y = 1;

				titleText.text = "Faye";
				titleText.setFormat(Paths.font("PhantomMuff.ttf"), 72, FlxColor.WHITE, CENTER);
				titleText.color = 0xFFe7fff7;

				Text.text = "VS Fuckboi Trio  |  Girlfriend Skins  |  VS Fuckboi Trio  |  Girlfriend Skins  |  VS Fuckboi Trio  |  Girlfriend Skins ";

				desc.text = "- Was Created in 2022 by Maxx.
				\n- She's 20 years old,\n is an alcoholic, and\nworks as a stripper.
				\n- She's Fiend's Genderbent Version\n(Fiend Bailed her out of prison\nafter she had a car crash)
				\n- Fiend liked this idea from the start,\nand is now canon.";
				char.flipX = false;//this is for flipping it to look left instead of right you can make it however you want
				char.antialiasing = ClientPrefs.globalAntialiasing;
				add(char);
				char.updateHitbox();

				FlxTween.color(bg, 2, 0xFFe1e1e1, 0xFFe7fff7, {ease: FlxEase.cubeInOut, type: PERSIST});
		}

		if (optionShit[curSelected] == 'maxx')
			{
				char.frames = Paths.getSparrowAtlas('CharacterBios/MaxxBios');//here put the name of the xml
				char.animation.addByPrefix('idle5', 'maxx idle0', 24);//on 'idle normal' change it to your xml one
				char.animation.play('idle5');//you can rename the anim however you want to
				char.scrollFactor.set();
				char.x = 920;
				char.y = 30;
				char.scale.x = 0.7;
				char.scale.y = 0.7;

				titleText.text = "Maxx";
				titleText.setFormat(Paths.font("PhantomMuff.ttf"), 72, FlxColor.WHITE, CENTER);
				titleText.color = 0xFF7b92b5;

				Text.text = "VS Fuckboi Trio  |  Girlfriend Skins  |  VS Fuckboi Trio  |  Girlfriend Skins  |  VS Fuckboi Trio  |  Girlfriend Skins ";

				desc.text = "- She was the 4th member of\nthe Fuckboi Group.
						\n- She was an amazing friend\nto Fiend, Shadow and Weegee, and she\nwas very respectfully treated.
						\n- Sadly some things end sooner than normal.
						\n- Thank you Maxx.\n#FuckboiForLife.";
				char.flipX = false;//this is for flipping it to look left instead of right you can make it however you want
				char.antialiasing = ClientPrefs.globalAntialiasing;
				add(char);
				char.updateHitbox();

				FlxTween.color(bg, 2, 0xFFe1e1e1, 0xFF7b92b5, {ease: FlxEase.cubeInOut, type: PERSIST});
		}

		if (optionShit[curSelected] == 'shade')
			{
				char.frames = Paths.getSparrowAtlas('CharacterBios/ShadeBios');//here put the name of the xml
				char.animation.addByPrefix('idle10', 'shade idle0', 24);//on 'idle normal' change it to your xml one
				char.animation.play('idle10');//you can rename the anim however you want to
				char.scrollFactor.set();
				char.x = 850;
				char.y = 90;
				char.scale.x = 0.9;
				char.scale.y = 0.9;

				titleText.text = "Shade";
				titleText.setFormat(Paths.font("PhantomMuff.ttf"), 72, FlxColor.WHITE, CENTER);
				titleText.color = 0xFF9d03ad;

				Text.text = "VS Fuckboi Trio  |  Girlfriend Skins  |  VS Fuckboi Trio  |  Girlfriend Skins  |  VS Fuckboi Trio  |  Girlfriend Skins ";

				desc.text = "- Was Created in 2022 by Maxx.
				\n- She was created as a\nsurprise for Shadow, who didn't know\n how to feel about it, but\neventually liked it.
				\n- She's 20 years old,\nand dating Shadow in-game.
				\n- She also smokes weed :]";
				char.flipX = false;//this is for flipping it to look left instead of right you can make it however you want
				char.antialiasing = ClientPrefs.globalAntialiasing;
				add(char);
				char.updateHitbox();

				FlxTween.color(bg, 2, 0xFFe1e1e1, 0xFF9d03ad, {ease: FlxEase.cubeInOut, type: PERSIST});
		}

		if (optionShit[curSelected] == 'liz')
			{
				char.frames = Paths.getSparrowAtlas('CharacterBios/LizGFBios');//here put the name of the xml
				char.animation.addByPrefix('idle6', 'GF Dancing Beat0', 24);//on 'idle normal' change it to your xml one
				char.animation.play('idle6');//you can rename the anim however you want to
				char.scrollFactor.set();
				char.x = 740;
				char.y = 30;
				char.scale.x = 0.9;
				char.scale.y = 0.9;

				titleText.text = "Liz (Eliza)";
				titleText.setFormat(Paths.font("PhantomMuff.ttf"), 72, FlxColor.WHITE, CENTER);
				titleText.color = 0xFFff66f0;

				Text.text = "VS Fuckboi Trio  |  Girlfriend Skins  |  VS Fuckboi Trio  |  Girlfriend Skins  |  VS Fuckboi Trio  |  Girlfriend Skins ";

				desc.text = "- Was Created at late 2016 | Officially\nGot Named and finalized in 2019
				\n- She's not included in the Fuckboi\nGang!
				\n- She's thicc, and if you disagree,\nshe'll send her mini self after you\n to kill you /joke
				\n- Was Created by Lizzy Strawberry\n [Coder of this mod]";
				char.flipX = false;//this is for flipping it to look left instead of right you can make it however you want
				char.antialiasing = ClientPrefs.globalAntialiasing;
				add(char);
				char.updateHitbox();

				FlxTween.color(bg, 2, 0xFFe1e1e1, 0xFFff66f0, {ease: FlxEase.cubeInOut, type: PERSIST});
		}
		
		changeItem();

		super.create();
	}

	override function update(elapsed:Float)
	{
			if (FlxG.keys.justPressed.BACKSPACE)
			{
				persistentUpdate = false;
				FlxG.sound.play(Paths.sound('cancelMenu'));
				MusicBeatState.switchState(new CreditsState());
			}

			if (FlxG.keys.justPressed.LEFT || FlxG.keys.justPressed.A)
			{
				changeItem(-1);
				if (optionShit[curSelected] == 'fiend')
				{
					char.frames = Paths.getSparrowAtlas('CharacterBios/FiendBios');//here put the name of the xml
					char.animation.addByPrefix('idle1', 'idle0', 24);
					char.animation.play('idle1');//you can rename the anim however you want to
					char.scrollFactor.set(0, 0);
					char.x = 860;
					char.y = 40;
					char.scale.x = 1;
					char.scale.y = 1;

					titleText.text = "Fiend";
					titleText.setFormat(Paths.font("PhantomMuff.ttf"), 72, FlxColor.WHITE, CENTER);
					titleText.color = 0xFF71334d;

					Text.text = "VS Fuckboi Trio  |  Main Cast  |  VS Fuckboi Trio  |   Main Cast  |  VS Fuckboi Trio  |   Main Cast ";

					desc.text = "- Was Created in 2019\nand went through many redesigns.
						\n- He's 15 years old,\nand does stupid shit like\ntrying to find the Golden Turkey\nor making salt milk.
						\n- He likes to draw,\nand hate his friends /j.
						\n- Was Created by TheRandomFiend.";
					char.flipX = true;//this is for flipping it to look left instead of right you can make it however you want
					char.antialiasing = ClientPrefs.globalAntialiasing;
					add(char);
					char.updateHitbox();

					FlxTween.color(bg, 2, 0xFF9d03ad, 0xFF71334d, {ease: FlxEase.cubeInOut, type: PERSIST});
				}

				if (optionShit[curSelected] == 'weegee')
					{
						char.frames = Paths.getSparrowAtlas('CharacterBios/WeegeeBios');//here put the name of the xml
						char.animation.addByPrefix('idle7', 'weegie0', 24);//on 'idle normal' change it to your xml one
						char.animation.play('idle7');//you can rename the anim however you want to
						char.scrollFactor.set();
						char.x = 890;
						char.y = 90;
						char.scale.x = 1;
						char.scale.y = 1;
		
						titleText.text = "Weegee";
						titleText.setFormat(Paths.font("PhantomMuff.ttf"), 72, FlxColor.WHITE, CENTER);
						titleText.color = 0xFF4ee75b;
		
						Text.text = "VS Fuckboi Trio  |  Main Cast  |  VS Fuckboi Trio  |   Main Cast  |  VS Fuckboi Trio  |   Main Cast ";
		
						desc.text = "- Was Created by WeegeeDude.
						\n- His favourite console is the Wii U,\nand if you disagree,\nhe'll personally assasinate you. /j
						\n- To this day, we still await to learn\nabout Weegee's date of creation.";
						char.flipX = true;//this is for flipping it to look left instead of right you can make it however you want
						char.antialiasing = ClientPrefs.globalAntialiasing;
						add(char);
						char.updateHitbox();
						
						FlxTween.color(bg, 2, 0xFF7b92b5, 0xFF4ee75b, {ease: FlxEase.cubeInOut, type: PERSIST});
				}
			
				if (optionShit[curSelected] == 'shadow')
				{
					char.frames = Paths.getSparrowAtlas('CharacterBios/ShadowBios');//here put the name of the xml
					char.animation.addByPrefix('idle2', 'idle0', 24);//on 'idle normal' change it to your xml one
					char.animation.play('idle2');//you can rename the anim however you want to
					char.scrollFactor.set();
					char.x = 920;
					char.y = 70;
					char.scale.x = 1;
					char.scale.y = 1;

					titleText.text = "Shadow";
					titleText.setFormat(Paths.font("PhantomMuff.ttf"), 72, FlxColor.WHITE, CENTER);
					titleText.color = 0xFF9d03ad;

					Text.text = "VS Fuckboi Trio  |  Main Cast  |  VS Fuckboi Trio  |   Main Cast  |  VS Fuckboi Trio  |   Main Cast ";

					desc.text = "- Was Created in Late 2019 - Early 2020\nfor a [Cancelled] fangame called\n 'Five Nights at Randoms'.
					\n- He's dead, yet his brain is still functioning,\nhence the wires on him.
					\n- He has Anger issues [smh],\n so don't mess with him.
					\n- Was Created by TheShadowGames854.";
					char.flipX = true;//this is for flipping it to look left instead of right you can make it however you want
					char.antialiasing = ClientPrefs.globalAntialiasing;
					add(char);
					char.updateHitbox();

					FlxTween.color(bg, 2, 0xFF4ee75b, 0xFF9d03ad, {ease: FlxEase.cubeInOut, type: PERSIST});
				}

				if (optionShit[curSelected] == 'Su-Bf')
					{
						num = FlxG.random.int(0, 3);
						char.frames = Paths.getSparrowAtlas('CharacterBios/SU-BFBios');//here put the name of the xml
						if (num == 3)
							{
								char.animation.addByPrefix('idle9', 'SU-BFBios BF Angy0', 24);//on 'idle normal' change it to your xml one
								char.animation.play('idle9');//you can rename the anim however you want to
							}
						if (num != 3)
							{
							char.animation.addByPrefix('idle8', 'BF idle dance0', 24);//on 'idle normal' change it to your xml one
							char.animation.play('idle8');//you can rename the anim however you want to
							}
						char.scrollFactor.set();
						char.x = 890;
						char.y = 250;
						char.scale.x = 1;
						char.scale.y = 1;
		
						titleText.text = "(SU) Boyfriend";
						titleText.setFormat(Paths.font("PhantomMuff.ttf"), 72, FlxColor.WHITE, CENTER);
						titleText.color = 0xFF66ffff;
		
						Text.text = "VS Fuckboi Trio  |  Extras  |  VS Fuckboi Trio  |  Extras  |  VS Fuckboi Trio  |  Extras ";
		
						desc.text = "- Was Created in 2021, on the 2nd\nUpdate of 'VS The Dark Star'.
						\n- To match Strawberry's Style,\nhe was drawn from scratch like this.
						\n- He has a second pissed/scared variation,\n and the hair is a bit longer.
						\n-'VS the Dark Star is a very old mod,\n and I knew very little to no coding\n plz don't make fun of me :('";
						char.flipX = false;//this is for flipping it to look left instead of right you can make it however you want
						char.antialiasing = ClientPrefs.globalAntialiasing;
						add(char);
						char.updateHitbox();

						FlxTween.color(bg, 2, 0xFF71334d, 0xFF66ffff, {ease: FlxEase.cubeInOut, type: PERSIST});
				}

				if (optionShit[curSelected] == 'fiendScrewed')
				{
					char.frames = Paths.getSparrowAtlas('CharacterBios/Fiend_ScrewedBios');//here put the name of the xml
					char.animation.addByPrefix('idle3', 'idle0', 24);//on 'idle normal' change it to your xml one
					char.animation.play('idle3');//you can rename the anim however you want to
					char.scrollFactor.set();
					char.x = 920;
					char.y = 50;
					char.scale.x = 1;
					char.scale.y = 1;

					titleText.text = "Fiend (Screwed)";
					titleText.setFormat(Paths.font("PhantomMuff.ttf"), 72, FlxColor.WHITE, CENTER);
					titleText.color = 0xFF4a122c;

					Text.text = "VS Fuckboi Trio  |  Extras  |  VS Fuckboi Trio  |  Extras  |  VS Fuckboi Trio  |  Extras ";

					desc.text = "- Was Created during the development\nof this mod.
					\n- Shadow would be controlling\n both Fiend and Weegee in Screwed mode,\n as a different timeline would occur.
					\n- Sadly, the idea got scrapped\nmid way through development,\n and he's now used in the You Can't Run Cover.
					\n- 'He still looks good tho' -Strawberry 2022";
					char.flipX = true;//this is for flipping it to look left instead of right you can make it however you want
					char.antialiasing = ClientPrefs.globalAntialiasing;
					add(char);
					char.updateHitbox();

					FlxTween.color(bg, 2, 0xFF66ffff, 0xFF4a122c, {ease: FlxEase.cubeInOut, type: PERSIST});
				}

				if (optionShit[curSelected] == 'faye')
					{
						char.frames = Paths.getSparrowAtlas('CharacterBios/FayeBios');//here put the name of the xml
						char.animation.addByPrefix('idle4', 'faye idle0', 24);//on 'idle normal' change it to your xml one
						char.animation.play('idle4');//you can rename the anim however you want to
						char.scrollFactor.set();
						char.x = 860;
						char.y = 180;
						char.scale.x = 1;
						char.scale.y = 1;
		
						titleText.text = "Faye";
						titleText.setFormat(Paths.font("PhantomMuff.ttf"), 72, FlxColor.WHITE, CENTER);
						titleText.color = 0xFFe7fff7;

						Text.text = "VS Fuckboi Trio  |  Girlfriend Skins  |  VS Fuckboi Trio  |  Girlfriend Skins  |  VS Fuckboi Trio  |  Girlfriend Skins ";
		
						desc.text = "- Was Created in 2022 by Maxx.
						\n- She's 20 years old,\n is an alcoholic, and\nworks as a stripper.
						\n- She's Fiend's Genderbent Version\n(Fiend Bailed her out of prison\nafter she had a car crash)
						\n- Fiend liked this idea from the start,\nand is now canon.";
						char.flipX = false;//this is for flipping it to look left instead of right you can make it however you want
						char.antialiasing = ClientPrefs.globalAntialiasing;
						add(char);
						char.updateHitbox();

						FlxTween.color(bg, 2, 0xFF9d03ad, 0xFFe7fff7, {ease: FlxEase.cubeInOut, type: PERSIST});
				}

				if (optionShit[curSelected] == 'maxx')
				{
					char.frames = Paths.getSparrowAtlas('CharacterBios/MaxxBios');//here put the name of the xml
					char.animation.addByPrefix('idle5', 'maxx idle0', 24);//on 'idle normal' change it to your xml one
					char.animation.play('idle5');//you can rename the anim however you want to
					char.scrollFactor.set();
					char.x = 920;
					char.y = 30;
					char.scale.x = 0.7;
					char.scale.y = 0.7;

					titleText.text = "Maxx";
					titleText.setFormat(Paths.font("PhantomMuff.ttf"), 72, FlxColor.WHITE, CENTER);
					titleText.color = 0xFF7b92b5;

					Text.text = "VS Fuckboi Trio  |  Girlfriend Skins  |  VS Fuckboi Trio  |  Girlfriend Skins  |  VS Fuckboi Trio  |  Girlfriend Skins ";

					desc.text = "- She was the 4th member of\nthe Fuckboi Group.
						\n- She was an amazing friend\nto Fiend, Shadow and Weegee, and she\nwas very respectfully treated.
						\n- Sadly some things end sooner than normal.
						\n- Thank you Maxx.\n#FuckboiForLife.";
					char.flipX = false;//this is for flipping it to look left instead of right you can make it however you want
					char.antialiasing = ClientPrefs.globalAntialiasing;
					add(char);
					char.updateHitbox();

					FlxTween.color(bg, 2, 0xFFe7fff7, 0xFF7b92b5, {ease: FlxEase.cubeInOut, type: PERSIST});
				}

				if (optionShit[curSelected] == 'shade')
					{
						char.frames = Paths.getSparrowAtlas('CharacterBios/ShadeBios');//here put the name of the xml
						char.animation.addByPrefix('idle10', 'shade idle0', 24);//on 'idle normal' change it to your xml one
						char.animation.play('idle10');//you can rename the anim however you want to
						char.scrollFactor.set();
						char.x = 850;
						char.y = 90;
						char.scale.x = 0.9;
						char.scale.y = 0.9;
		
						titleText.text = "Shade";
						titleText.setFormat(Paths.font("PhantomMuff.ttf"), 72, FlxColor.WHITE, CENTER);
						titleText.color = 0xFF9d03ad;
		
						Text.text = "VS Fuckboi Trio  |  Girlfriend Skins  |  VS Fuckboi Trio  |  Girlfriend Skins  |  VS Fuckboi Trio  |  Girlfriend Skins ";
		
						desc.text = "- Was Created in 2022 by Maxx.
						\n- She was created as a\nsurprise for Shadow, who didn't know\n how to feel about it, but\neventually liked it.
						\n- She's 20 years old,\nand dating Shadow in-game.
						\n- She also smokes weed :]";
						char.flipX = false;//this is for flipping it to look left instead of right you can make it however you want
						char.antialiasing = ClientPrefs.globalAntialiasing;
						add(char);
						char.updateHitbox();
		
						FlxTween.color(bg, 2, 0xFFff66f0, 0xFF9d03ad, {ease: FlxEase.cubeInOut, type: PERSIST});
				}

				if (optionShit[curSelected] == 'liz')
				{
					char.frames = Paths.getSparrowAtlas('CharacterBios/LizGFBios');//here put the name of the xml
					char.animation.addByPrefix('idle6', 'GF Dancing Beat0', 24);//on 'idle normal' change it to your xml one
					char.animation.play('idle6');//you can rename the anim however you want to
					char.scrollFactor.set();
					char.x = 740;
					char.y = 30;
					char.scale.x = 0.9;
					char.scale.y = 0.9;

					titleText.text = "Liz (Eliza)";
					titleText.setFormat(Paths.font("PhantomMuff.ttf"), 72, FlxColor.WHITE, CENTER);
					titleText.color = 0xFFff66f0;

					Text.text = "VS Fuckboi Trio  |  Girlfriend Skins  |  VS Fuckboi Trio  |  Girlfriend Skins  |  VS Fuckboi Trio  |  Girlfriend Skins ";

					desc.text = "- Was Created at late 2016 | Officially\nGot Named and finalized in 2019
					\n- She's not included in the Fuckboi\nGang!
					\n- She's thicc, and if you disagree,\nshe'll send her mini self after you\n to kill you /joke
					\n- Was Created by Lizzy Strawberry\n [Coder of this mod]";
					char.flipX = false;//this is for flipping it to look left instead of right you can make it however you want
					char.antialiasing = ClientPrefs.globalAntialiasing;
					add(char);
					char.updateHitbox();

					FlxTween.color(bg, 2, 0xFF4a122c, 0xFFff66f0, {ease: FlxEase.cubeInOut, type: PERSIST});
				}
			}
			
			if (FlxG.keys.justPressed.RIGHT || FlxG.keys.justPressed.D)
			{
				changeItem(1);
				if (optionShit[curSelected] == 'fiend')
					{
						char.frames = Paths.getSparrowAtlas('CharacterBios/FiendBios');//here put the name of the xml
						char.animation.addByPrefix('idle1', 'idle0', 24);
						char.animation.play('idle1');//you can rename the anim however you want to
						char.scrollFactor.set(0, 0);
						char.x = 860;
						char.y = 40;
						char.scale.x = 1;
						char.scale.y = 1;
	
						titleText.text = "Fiend";
						titleText.setFormat(Paths.font("PhantomMuff.ttf"), 72, FlxColor.WHITE, CENTER);
						titleText.color = 0xFF71334d;

						Text.text = "VS Fuckboi Trio  |  Main Cast  |  VS Fuckboi Trio  |   Main Cast  |  VS Fuckboi Trio  |   Main Cast ";
	
						desc.text = "- Was Created in 2019\nand went through many redesigns.
						\n- He's 15 years old,\nand does stupid shit like\ntrying to find the Golden Turkey\nor making salt milk.
						\n- He likes to draw,\nand hate his friends /j.
						\n- Was Created by TheRandomFiend.";
						char.flipX = true;//this is for flipping it to look left instead of right you can make it however you want
						char.antialiasing = ClientPrefs.globalAntialiasing;
						add(char);
						char.updateHitbox();

						FlxTween.color(bg, 2, 0xFF66ffff, 0xFF71334d, {ease: FlxEase.cubeInOut, type: PERSIST});
					}

					if (optionShit[curSelected] == 'weegee')
						{
							char.frames = Paths.getSparrowAtlas('CharacterBios/WeegeeBios');//here put the name of the xml
							char.animation.addByPrefix('idle7', 'weegie0', 24);//on 'idle normal' change it to your xml one
							char.animation.play('idle7');//you can rename the anim however you want to
							char.scrollFactor.set();
							char.x = 890;
							char.y = 90;
							char.scale.x = 1;
							char.scale.y = 1;
			
							titleText.text = "Weegee";
							titleText.setFormat(Paths.font("PhantomMuff.ttf"), 72, FlxColor.WHITE, CENTER);
							titleText.color = 0xFF4ee75b;
			
							Text.text = "VS Fuckboi Trio  |  Main Cast  |  VS Fuckboi Trio  |   Main Cast  |  VS Fuckboi Trio  |   Main Cast ";
			
							desc.text = "- Was Created by WeegeeDude.
						\n- His favourite console is the Wii U,\nand if you disagree,\nhe'll personally assasinate you. /j
						\n- To this day, we still await to learn\nabout Weegee's date of creation.";
							char.flipX = true;//this is for flipping it to look left instead of right you can make it however you want
							char.antialiasing = ClientPrefs.globalAntialiasing;
							add(char);
							char.updateHitbox();

							FlxTween.color(bg, 2, 0xFF9d03ad, 0xFF4ee75b, {ease: FlxEase.cubeInOut, type: PERSIST});
					}
				
					if (optionShit[curSelected] == 'shadow')
					{
						char.frames = Paths.getSparrowAtlas('CharacterBios/ShadowBios');//here put the name of the xml
						char.animation.addByPrefix('idle2', 'idle0', 24);//on 'idle normal' change it to your xml one
						char.animation.play('idle2');//you can rename the anim however you want to
						char.scrollFactor.set();
						char.x = 920;
						char.y = 70;
						char.scale.x = 1;
						char.scale.y = 1;
	
						titleText.text = "Shadow";
						titleText.setFormat(Paths.font("PhantomMuff.ttf"), 72, FlxColor.WHITE, CENTER);
						titleText.color = 0xFF9d03ad;

						Text.text = "VS Fuckboi Trio  |  Main Cast  |  VS Fuckboi Trio  |   Main Cast  |  VS Fuckboi Trio  |   Main Cast ";
	
						desc.text = "- Was Created in Late 2019 - Early 2020\nfor a [Cancelled] fangame called\n 'Five Nights at Randoms'.
						\n- He's dead, yet his brain is still functioning,\nhence the wires on him.
						\n- He has Anger issues [smh],\n so don't mess with him.
						\n- Was Created by TheShadowGames854.";
						char.flipX = true;//this is for flipping it to look left instead of right you can make it however you want
						char.antialiasing = ClientPrefs.globalAntialiasing;
						add(char);
						char.updateHitbox();
						FlxTween.color(bg, 2, 0xFF71334d, 0xFF9d03ad, {ease: FlxEase.cubeInOut, type: PERSIST});
					}

					if (optionShit[curSelected] == 'Su-Bf')
						{
							num = FlxG.random.int(0, 3);
							char.frames = Paths.getSparrowAtlas('CharacterBios/SU-BFBios');//here put the name of the xml
							if (num == 3)
								{
									char.animation.addByPrefix('idle9', 'SU-BFBios BF Angy0', 24);//on 'idle normal' change it to your xml one
									char.animation.play('idle9');//you can rename the anim however you want to
								}
							if (num != 3)
								{
								char.animation.addByPrefix('idle8', 'BF idle dance0', 24);//on 'idle normal' change it to your xml one
								char.animation.play('idle8');//you can rename the anim however you want to
								}
							char.scrollFactor.set();
							char.x = 890;
							char.y = 250;
							char.scale.x = 1;
							char.scale.y = 1;
			
							titleText.text = "(SU) Boyfriend";
							titleText.setFormat(Paths.font("PhantomMuff.ttf"), 72, FlxColor.WHITE, CENTER);
							titleText.color = 0xFF66ffff;
			
							Text.text = "VS Fuckboi Trio  |  Extras  |  VS Fuckboi Trio  |  Extras  |  VS Fuckboi Trio  |  Extras ";
			
							desc.text = "- Was Created in 2021, on the 2nd\nUpdate of 'VS The Dark Star'.
							\n- To match Strawberry's Style,\nhe was drawn from scratch like this.
							\n- He has a second pissed/scared variation,\n and the hair is a bit longer.
							\n-'VS the Dark Star is a very old mod,\n and I knew very little to no coding\n plz don't make fun of me :('";
							char.flipX = false;//this is for flipping it to look left instead of right you can make it however you want
							char.antialiasing = ClientPrefs.globalAntialiasing;
							add(char);
							char.updateHitbox();

							FlxTween.color(bg, 2, 0xFF4a122c, 0xFF66ffff, {ease: FlxEase.cubeInOut, type: PERSIST});
					}
	
					if (optionShit[curSelected] == 'fiendScrewed')
					{
						char.frames = Paths.getSparrowAtlas('CharacterBios/Fiend_ScrewedBios');//here put the name of the xml
						char.animation.addByPrefix('idle3', 'idle0', 24);//on 'idle normal' change it to your xml one
						char.animation.play('idle3');//you can rename the anim however you want to
						char.scrollFactor.set();
						char.x = 920;
						char.y = 50;
						char.scale.x = 1;
						char.scale.y = 1;
	
						titleText.text = "Fiend (Screwed)";
						titleText.setFormat(Paths.font("PhantomMuff.ttf"), 72, FlxColor.WHITE, CENTER);
						titleText.color = 0xFF4a122c;

						Text.text = "VS Fuckboi Trio  |  Extras  |  VS Fuckboi Trio  |  Extras  |  VS Fuckboi Trio  |  Extras ";
	
						desc.text = "- Was Created during the development\nof this mod.
						\n- Shadow would be controlling\n both Fiend and Weegee in Screwed mode,\n as a different timeline would occur.
						\n- Sadly, the idea got scrapped\nmid way through development,\n and he's now used in the You Can't Run Cover.
						\n- 'He still looks good tho' -Strawberry 2022";
						char.flipX = true;//this is for flipping it to look left instead of right you can make it however you want
						char.antialiasing = ClientPrefs.globalAntialiasing;
						add(char);
						char.updateHitbox();

						FlxTween.color(bg, 2, 0xFFff66f0, 0xFF4a122c, {ease: FlxEase.cubeInOut, type: PERSIST});
					}
	
					if (optionShit[curSelected] == 'faye')
						{
							char.frames = Paths.getSparrowAtlas('CharacterBios/FayeBios');//here put the name of the xml
							char.animation.addByPrefix('idle4', 'faye idle0', 24);//on 'idle normal' change it to your xml one
							char.animation.play('idle4');//you can rename the anim however you want to
							char.scrollFactor.set();
							char.x = 860;
							char.y = 180;
							char.scale.x = 1;
							char.scale.y = 1;
			
							titleText.text = "Faye";
							titleText.setFormat(Paths.font("PhantomMuff.ttf"), 72, FlxColor.WHITE, CENTER);
							titleText.color = 0xFFe7fff7;

							Text.text = "VS Fuckboi Trio  |  Girlfriend Skins  |  VS Fuckboi Trio  |  Girlfriend Skins  |  VS Fuckboi Trio  |  Girlfriend Skins ";
			
							desc.text = "- Was Created in 2022 by Maxx.
							\n- She's 20 years old,\n is an alcoholic, and\nworks as a stripper.
							\n- She's Fiend's Genderbent Version\n(Fiend Bailed her out of prison\nafter she had a car crash)
							\n- Fiend liked this idea from the start,\nand is now canon.";
							char.flipX = false;//this is for flipping it to look left instead of right you can make it however you want
							char.antialiasing = ClientPrefs.globalAntialiasing;
							add(char);
							char.updateHitbox();

							FlxTween.color(bg, 2, 0xFF7b92b5, 0xFFe7fff7, {ease: FlxEase.cubeInOut, type: PERSIST});
					}
	
					if (optionShit[curSelected] == 'maxx')
					{
						char.frames = Paths.getSparrowAtlas('CharacterBios/MaxxBios');//here put the name of the xml
						char.animation.addByPrefix('idle5', 'maxx idle0', 24);//on 'idle normal' change it to your xml one
						char.animation.play('idle5');//you can rename the anim however you want to
						char.scrollFactor.set();
						char.x = 920;
						char.y = 30;
						char.scale.x = 0.7;
						char.scale.y = 0.7;
	
						titleText.text = "Maxx";
						titleText.setFormat(Paths.font("PhantomMuff.ttf"), 72, FlxColor.WHITE, CENTER);
						titleText.color = 0xFF7b92b5;

						Text.text = "VS Fuckboi Trio  |  Girlfriend Skins  |  VS Fuckboi Trio  |  Girlfriend Skins  |  VS Fuckboi Trio  |  Girlfriend Skins ";
	
						desc.text = "- She was the 4th member of\nthe Fuckboi Group.
						\n- She was an amazing friend\nto Fiend, Shadow and Weegee, and she\nwas very respectfully treated.
						\n- Sadly some things end sooner than normal.
						\n- Thank you Maxx.\n#FuckboiForLife.";
						char.flipX = false;//this is for flipping it to look left instead of right you can make it however you want
						char.antialiasing = ClientPrefs.globalAntialiasing;
						add(char);
						char.updateHitbox();

						FlxTween.color(bg, 2, 0xFF4ee75b, 0xFF7b92b5, {ease: FlxEase.cubeInOut, type: PERSIST});
					}

					if (optionShit[curSelected] == 'shade')
						{
							char.frames = Paths.getSparrowAtlas('CharacterBios/ShadeBios');//here put the name of the xml
							char.animation.addByPrefix('idle10', 'shade idle0', 24);//on 'idle normal' change it to your xml one
							char.animation.play('idle10');//you can rename the anim however you want to
							char.scrollFactor.set();
							char.x = 850;
							char.y = 90;
							char.scale.x = 0.9;
							char.scale.y = 0.9;
			
							titleText.text = "Shade";
							titleText.setFormat(Paths.font("PhantomMuff.ttf"), 72, FlxColor.WHITE, CENTER);
							titleText.color = 0xFF9d03ad;
			
							Text.text = "VS Fuckboi Trio  |  Girlfriend Skins  |  VS Fuckboi Trio  |  Girlfriend Skins  |  VS Fuckboi Trio  |  Girlfriend Skins ";
			
							desc.text = "- Was Created in 2022 by Maxx.
							\n- She was created as a\nsurprise for Shadow, who didn't know\n how to feel about it, but\neventually liked it.
							\n- She's 20 years old,\nand dating Shadow in-game.
							\n- She also smokes weed :]";
							char.flipX = false;//this is for flipping it to look left instead of right you can make it however you want
							char.antialiasing = ClientPrefs.globalAntialiasing;
							add(char);
							char.updateHitbox();
			
							FlxTween.color(bg, 2, 0xFFe7fff7, 0xFF9d03ad, {ease: FlxEase.cubeInOut, type: PERSIST});
					}
	
					if (optionShit[curSelected] == 'liz')
					{
						char.frames = Paths.getSparrowAtlas('CharacterBios/LizGFBios');//here put the name of the xml
						char.animation.addByPrefix('idle6', 'GF Dancing Beat0', 24);//on 'idle normal' change it to your xml one
						char.animation.play('idle6');//you can rename the anim however you want to
						char.scrollFactor.set();
						char.x = 740;
						char.y = 30;
						char.scale.x = 0.9;
						char.scale.y = 0.9;
	
						titleText.text = "Liz (Eliza)";
						titleText.setFormat(Paths.font("PhantomMuff.ttf"), 72, FlxColor.WHITE, CENTER);
						titleText.color = 0xFFff66f0;

						Text.text = "VS Fuckboi Trio  |  Girlfriend Skins  |  VS Fuckboi Trio  |  Girlfriend Skins  |  VS Fuckboi Trio  |  Girlfriend Skins ";
	
						desc.text = "- Was Created at late 2016 | Officially\nGot Named and finalized in 2019
						\n- She's not included in the Fuckboi\nGang!
						\n- She's thicc, and if you disagree,\nshe'll send her mini self after you\n to kill you /joke
						\n- Was Created by Lizzy Strawberry\n [Coder of this mod]";
						char.flipX = false;//this is for flipping it to look left instead of right you can make it however you want
						char.antialiasing = ClientPrefs.globalAntialiasing;
						add(char);
						char.updateHitbox();

						FlxTween.color(bg, 2, 0xFF9d03ad, 0xFFff66f0, {ease: FlxEase.cubeInOut, type: PERSIST});
					}
			}

		super.update(elapsed);
	}

	function changeItem(huh:Int = 0)
		{
			curSelected += huh;
	
			if (curSelected >= optionShit.length)
				curSelected = 0;
			if (curSelected < 0)
				curSelected = optionShit.length - 1;
		}
	
}
