function fastScale(spr, width)
    setGraphicSize(spr, math.floor(getProperty(spr .. '.width') * width))
end

function onCreate()
    if not lowQuality then
        makeLuaSprite('errorBG', 'stage/streetError', -750, -145)
        setLuaSpriteScrollFactor('errorBG', 0.9, 0.9)
        addLuaSprite('errorBG', false)
        setProperty('errorBG.visible', false)

        makeLuaSprite('streetBGerror', 'stage/streetBackError', -750, -145)
        setLuaSpriteScrollFactor('streetBGerror', 0.9, 0.9)
        addLuaSprite('streetBGerror', false)
        setProperty('streetBGerror.visible', false)
    end

    makeLuaSprite('streetBG', 'stage/streetBack', -750, -145)
    setLuaSpriteScrollFactor('streetBG', 0.9, 0.9)
    addLuaSprite('streetBG', false)

    makeLuaSprite('streetFront', 'stage/streetFront', -820, 710)
    fastScale('streetFront', 1.15)
    setLuaSpriteScrollFactor('streetFront', 0.9, 0.9)
    addLuaSprite('streetFront', false)

    if not lowQuality then
        makeLuaSprite('streetFrontError', 'stage/streetFrontError', -820, 710)
        fastScale('streetFrontError', 1.15)
        setLuaSpriteScrollFactor('streetFrontError', 0.9, 0.9)
        addLuaSprite('streetFrontError', false)
        setProperty('streetFrontError.visible', false)
    end

    makeAnimatedLuaSprite('qt_tv01', 'stage/TV_V5', -62, 540)
    addAnimationByPrefix('qt_tv01', 'idle', 'TV_Idle', 24, true)
    addAnimationByPrefix('qt_tv01', 'eye', 'TV_brutality', 24, true)
    addAnimationByPrefix('qt_tv01', 'error', 'TV_Error', 24, true)
    addAnimationByPrefix('qt_tv01', '404', 'TV_Bluescreen', 24, true)
    addAnimationByPrefix('qt_tv01', 'alert', 'TV_Attention', 32, false)
    addAnimationByPrefix('qt_tv01', 'watch', 'TV_Watchout', 24, true)
    addAnimationByPrefix('qt_tv01', 'drop', 'TV_Drop', 24, true)
    addAnimationByPrefix('qt_tv01', 'sus', 'TV_sus', 24, true)
    addAnimationByPrefix('qt_tv01', 'drop', 'TV_Drop', 24, true)
    addAnimationByPrefix('qt_tv01', 'instructions', 'TV_Instructions-Normal', 24, true)
    addAnimationByPrefix('qt_tv01', 'gl', 'TV_GoodLuck', 24, true)
    fastScale('qt_tv01', 1.2)
    setLuaSpriteScrollFactor('qt_tv01', 0.89, 0.89)
    addLuaSprite('qt_tv01', false)
    objectPlayAnimation('qt_tv01', 'idle')

    if not lowQuality and songName == 'Censory Overload' then
        makeAnimatedLuaSprite('qt_gas01', 'stage/Gas_Release', -1900, -700)
        addAnimationByPrefix('qt_gas01', 'burst', 'Gas_Release', 38, false)
        addAnimationByPrefix('qt_gas01', 'burstALT', 'Gas_Release', 49, false)
        addAnimationByPrefix('qt_gas01', 'burstFAST', 'Gas_Release', 76, false)
        fastScale('qt_gas01', 2.5)
        setLuaSpriteScrollFactor('qt_gas01', 0, 0)
        setProperty('qt_gas01.alpha', 0.72)
        setProperty('qt_gas01.angle', -31)
        addLuaSprite('qt_gas01', true)
        setProperty('qt_gas01.visible', false)

        makeAnimatedLuaSprite('qt_gas02', 'stage/Gas_Release', -50, -700)
        addAnimationByPrefix('qt_gas02', 'burst', 'Gas_Release', 38, false)
        addAnimationByPrefix('qt_gas02', 'burstALT', 'Gas_Release', 49, false)
        addAnimationByPrefix('qt_gas02', 'burstFAST', 'Gas_Release', 76, false)
        fastScale('qt_gas02', 2.5)
        setLuaSpriteScrollFactor('qt_gas02', 0, 0)
        setProperty('qt_gas02.alpha', 0.72)
        setProperty('qt_gas02.angle', 31)
        addLuaSprite('qt_gas02', true)
        setProperty('qt_gas02.visible', false)
    end
end

function onSongStart()
    if songName == 'Termination' then
        objectPlayAnimation('qt_tv01', 'instructions', true)
    end
end

function onUpdate(elapsed)
    if songName == 'Censory Overload' then
        if curBeat >= 8 then
            setProperty('qt_gas01.visible', true)
            setProperty('qt_gas02.visible', true)
        end

        if curBeat == 64 then
            objectPlayAnimation('qt_tv01', 'eye')
        elseif curBeat == 80 then
            objectPlayAnimation('qt_tv01', 'idle')
        elseif curBeat == 240 then
            objectPlayAnimation('qt_tv01', 'drop')
        elseif curBeat == 432 then
            objectPlayAnimation('qt_tv01', 'idle')
        elseif curBeat == 558 then
            objectPlayAnimation('qt_tv01', 'eye')
        elseif curBeat == 560 then
            objectPlayAnimation('qt_tv01', 'idle')
        elseif curBeat >= 702 and curBeat < 704 then
            objectPlayAnimation('qt_tv01', 'error')
        elseif curBeat >= 704 and curBeat < 832 then
            objectPlayAnimation('qt_tv01', '404')
        elseif curBeat == 960 then
            objectPlayAnimation('qt_tv01', 'idle')
        end
    elseif songName == 'Termination' then
        if curStep >= 64 and curStep <= 120 then
            objectPlayAnimation('qt_tv01', 'gl')
        elseif curStep >= 120 and curStep < 128 then
            objectPlayAnimation('qt_tv01', 'idle')
        elseif curStep == 1280 then
            objectPlayAnimation('qt_tv01', 'idle')
        elseif curStep == 1760 then
            objectPlayAnimation('qt_tv01', 'watch')
        elseif curStep == 1792 then
            objectPlayAnimation('qt_tv01', 'idle')
        elseif curStep == 2560 then
            objectPlayAnimation('qt_tv01', 'eye')
        elseif curStep == 2808 then
            objectPlayAnimation('qt_tv01', 'error')
        elseif curStep >= 2816 and curStep < 3328 then
            objectPlayAnimation('qt_tv01', '404')
        elseif curStep >= 4352 then
            objectPlayAnimation('qt_tv01', 'idle')
        end
    end
end

function onBeatHit()
    if songName == 'Censory Overload' then
        if curBeat >= 80 and curBeat <= 208 then
            if curBeat % 16 == 0 and not lowQuality then
                objectPlayAnimation('qt_gas01', 'burst')
                objectPlayAnimation('qt_gas02', 'burst')
            end
        elseif curBeat >= 304 and curBeat <= 432 then
            if curBeat ~= 432 then
                objectPlayAnimation('qt_tv01', 'alert', true)
            end

            if curBeat % 8 == 0 and not lowQuality then
                objectPlayAnimation('qt_gas01', 'burstALT')
                objectPlayAnimation('qt_gas02', 'burstALT')
            end
        elseif curBeat >= 560 and curBeat <= 688 then
            if curBeat % 4 == 0 and not lowQuality then
                objectPlayAnimation('qt_gas01', 'burstFAST')
                objectPlayAnimation('qt_gas02', 'burstFAST')
            end
        elseif curBeat >= 832 and curBeat <= 960 then
            if curBeat ~= 960 then
                objectPlayAnimation('qt_tv01', 'alert', true)
            end

            if curBeat % 4 == 2 and not lowQuality then
                objectPlayAnimation('qt_gas01', 'burstFAST')
                objectPlayAnimation('qt_gas02', 'burstFAST')
            end
        elseif curBeat == 702 and not lowQuality then
            objectPlayAnimation('qt_gas01', 'burst')
            objectPlayAnimation('qt_gas02', 'burst')
        end
    elseif songName == 'Termination' then
        if curBeat >= 192 and curBeat < 320 then
            objectPlayAnimation('qt_tv01', 'alert', true)
        elseif curBeat >= 512 and curBeat < 640 then
            objectPlayAnimation('qt_tv01', 'alert', true)
        elseif curBeat >= 832 and curBeat <= 1088 then
            objectPlayAnimation('qt_tv01', 'alert', true)
        end
    end
end