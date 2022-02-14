function onCreate()
	for i = 0, getProperty('unspawnNotes.length')-1 do
		if getPropertyFromGroup('unspawnNotes', i, 'noteType') == 'kb_note' then
			setPropertyFromGroup('unspawnNotes', i, 'texture', 'kb_note'); --Change texture
			setPropertyFromGroup('unspawnNotes', i, 'hitHealth', '0'); --Default value is: 0.1, health gained on hit
			setPropertyFromGroup('unspawnNotes', i, 'missHealth', '2'); --Default value is: 0,01, health lost on miss
			setPropertyFromGroup('unspawnNotes', i, 'hitCausesMiss', false);
			
			if getPropertyFromGroup('unspawnNotes', i, 'mustPress') then --Doesn't let Dad/Opponent notes get ignored
				setPropertyFromGroup('unspawnNotes', i, 'ignoreNote', false); --Miss has no penalties
			end
		end
	end
	--debugPrint('Script started!')
end

-- Function called when you hit a note (after note hit calculations)
-- id: The note member id, you can get whatever variable you want from this note, example: "getPropertyFromGroup('notes', id, 'strumTime')"
-- noteData: 0 = Left, 1 = Down, 2 = Up, 3 = Right
-- noteType: The note type string/tag
-- isSustainNote: If it's a hold note, can be either true or false
function goodNoteHit(id, noteData, noteType, isSustainNote)
	if noteType == 'kb_note' then
		setProperty('health', getProperty('health')-0);
		characterPlayAnim('boyfriend', 'dodge', true);
		setProperty('boyfriend.specialAnim', true);
		ghostmisses = ghostmisses + 1;
		ghostmisses = ghostmisses + 1;
		if health <= 0 then
		end
	end
end

function noteMiss(id, noteData, noteType, isSustainNote)
	if noteType == 'kb_note' then
		makeAnimatedLuaSprite('saw', 'sawkillanimation', 0, 0)
		addAnimationByPrefix('saw', 'move', 'kb_attack_animation_kill_moving', 24, true)
		addLuaSprite('saw', true)
		objectPlayAnimation('saw', 'move')
	end
end