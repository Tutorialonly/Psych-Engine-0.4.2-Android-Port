local canDodge = false
local dodging = false
local dodgeTiming = 0.22625
local dodgeCooldown = 0
local sawBlades = {14, 70, 78, 103, 106, 128, 138, 142, 155, 168, 176, 190, 206, 219, 222, 274, 303, 338, 352, 359, 362, 370, 382, 398, 414, 422, 430, 438, 446, 454, 462, 470, 478, 490, 502, 530, 539, 546, 550, 559, 562, 570, 578, 582, 587, 594, 598, 603, 626, 634, 642, 646, 651, 658, 662, 667, 678, 686, 692, 697, 700, 716, 729, 732, 756, 770, 778, 786, 790, 794, 798, 806, 817, 820, 825, 830, 842, 846, 851, 854, 858, 862, 878, 890, 896, 906, 911, 914, 918, 922, 926, 946, 954, 958, 970, 974, 983, 986, 990, 998, 1007, 1010, 1018, 1022, 1026, 1029, 1034, 1042, 1046, 1050, 1058, 1066, 1069, 1074, 1083, 1086, 1094, 1102, 1110, 1126, 1134, 1142, 1150, 1166}
local DOSsawBlades = {30, 158, 286, 510, 590, 606, 654, 670, 773, 781, 1037, 1053, 1118}
local sawBladesBruh = {}
local x0, x1, x2, x3, strumLineY = 0, 0, 0, 0, 0
local introEnded = false

function introFade(strum)
    noteTweenAlpha("intro-alpha-player" .. strum, 7 - strum, 1, crochet / 250, "circOut")
    noteTweenAlpha("intro-alpha-opponent" .. strum, strum, 1, crochet / 250, "circOut")
    noteTweenY("intro-y-player" .. strum, 7 - strum, strumLineY, crochet / 250, "circOut")
    noteTweenY("intro-y-opponent" .. strum, strum, strumLineY, crochet / 250, "circOut")

    return true
end

function outroFade(strum)
    if strum >= 4 then
        noteTweenAlpha("intro-alpha-player" .. strum, strum, 0, crochet / 250, "circOut")
    else
        noteTweenAlpha("intro-alpha-opponent" .. strum, strum, 0, crochet / 250, "circOut")
    end

    return true
end

function addCameraZoom()
    setPropertyFromClass('FlxG', 'camera.zoom', getPropertyFromClass('FlxG', 'camera.zoom') + 0.015)
end

function addHudZoom()
    setProperty('camHUD.zoom', getProperty('camHUD.zoom') + 0.03)
end

function onSongStart()
    canDodge = true

    x0 = defaultPlayerStrumX0
    x1 = defaultPlayerStrumX1
    x2 = defaultPlayerStrumX2
    x3 = defaultPlayerStrumX3
    strumLineY = getProperty('strumLine.y')

    introFade(0)
end

function fastScale(spr, width)
    setGraphicSize(spr, math.floor(getProperty(spr .. '.width') * width))
end

function screenCenter(spr, axis)
    if axis == 'X' then
        local width = getProperty(spr .. '.width')
        setProperty(spr .. '.x', (screenWidth / 2) - (width / 2))
    elseif axis == 'Y' then
        local height = getProperty(spr .. '.height')
        setProperty(spr .. '.y', (screenHeight / 2) - (height / 2))
    elseif axis == 'XY' then
        local width = getProperty(spr .. '.width')
        local height = getProperty(spr .. '.height')
        setProperty(spr .. '.x', (screenWidth / 2) - (width / 2))
        setProperty(spr .. '.y', (screenHeight / 2) - (height / 2))
    end
end

function onCreate()
    makeAnimatedLuaSprite('kb_attack_alert', 'bonus/attack_alert_NEW', 0, 0)
    addAnimationByPrefix('kb_attack_alert', 'alert', 'kb_attack_animation_alert-single', 24, false)
    addAnimationByPrefix('kb_attack_alert', 'alertDOUBLE', 'kb_attack_animation_alert-double', 24, false)
    addAnimationByPrefix('kb_attack_alert', 'alertTRIPLE', 'kb_attack_animation_alert-triple', 24, false)
    addAnimationByPrefix('kb_attack_alert', 'alertCUADRUPLE', 'kb_attack_animation_alert-cuadruple-LMAO', 24, false)
    fastScale('kb_attack_alert', 1.5)
    setObjectCamera('kb_attack_alert', 'camHUD')
    screenCenter('kb_attack_alert', 'XY')
    addLuaSprite('kb_attack_alert')

    makeLuaSprite('justkidding', 'bonus/justkidding', 0, 0)
    setLuaSpriteScrollFactor('justkidding', 0.9, 0.9)
    addLuaSprite('justkidding', false)
    setProperty('justkidding.visible', false)


    makeAnimatedLuaSprite('kb_attack_saw', 'bonus/attackv6', -860, 615)
    addAnimationByPrefix('kb_attack_saw', 'fire', 'kb_attack_animation_fire', 24, false)
    addAnimationByPrefix('kb_attack_saw', 'prepare', 'kb_attack_animation_prepare', 24, false)
    fastScale('kb_attack_saw', 1.15)
    addLuaSprite('kb_attack_saw', true)
    setProperty('kb_attack_saw.visible', false)

    setProperty('deathBySawblade', false)
end

function fastSin(n)
    return math.sin(n * math.pi)
end

function dodge()
    dodging = true
    canDodge = false

    characterPlayAnim('bf', 'dodge', true)
    setProperty('bf.specialAnim', true)
    playSound('dodge01')

    runTimer('dodge', dodgeTiming)
end

function onUpdate(elapsed)
    local currentBeat = getSongPosition() / crochet

    if curBeat >= 512 and curBeat < 640 then
        local danced = getProperty('gf.danced')
        local angle = math.abs(fastSin(currentBeat))

        if danced then
            setProperty('camHUD.angle', 4 * angle)
        else
            setProperty('camHUD.angle', -4 * angle)
        end

        setProperty('kb_attack_alert.angle', -getProperty('camHUD.angle'))
    elseif curBeat >= 704 and curBeat < 832 then
        for i = 0, 7 do
            setStrumX(_G['defaultStrumX' .. i] + 10 * fastSin(currentBeat + i / 4), i)
            noteTweenX('noteTween' .. i, i, _G['defaultStrumX' .. i], crochet / 1000, 'sineOut')
        end

        setProperty('defaultCamZoom', 0.775)
    elseif introEnded then
        setProperty('defaultCamZoom', 0.8125)

        if getProperty('camHUD.angle') ~= 0 then
            setProperty('camHUD.angle', 0)
        end
    end

    local SPACE = keyJustPressed('space')
    if SPACE and not dodging and canDodge and not botPlay then
        dodge()
    end
end

function onTimerCompleted(tag)
    if tag == 'dodge' then
        dodging = false
        characterDance('bf')

        runTimer('dodgeCooldown', dodgeCooldown)
    elseif tag == 'dodgeCooldown' then
        canDodge = true
    elseif tag == 'checkDodging' then
        if canDodge and not dodging and not botPlay then
            setProperty('deathBySawblade', true)
            setProperty('health', 0)
        end
    end
end

function alert(prepare)
    playSound('alert', 1)
    objectPlayAnimation('kb_attack_alert', 'alert')

    if prepare then
        objectPlayAnimation('kb_attack_saw', 'prepare')
        setProperty('kb_attack_saw.offset.x', -333)
        setProperty('kb_attack_saw.visible', true)
    end
end

function attack()
    playSound('attack', 0.75)

    objectPlayAnimation('kb_attack_saw', 'fire')
    setProperty('kb_attack_saw.offset.x', 1600)
    setProperty('kb_attack_saw.visible', true)

    runTimer('checkDodging', 0.09)
end

function alertDOUBLE(prepare)
    playSound('alertALT', 1)
    objectPlayAnimation('kb_attack_alert', 'alertDOUBLE')

    if prepare then
        objectPlayAnimation('kb_attack_saw', 'prepare')
        setProperty('kb_attack_saw.offset.x', -333)
        setProperty('kb_attack_saw.visible', true)
    end
end

function attackDOUBLE()
    playSound('attack_alt02', 0.75)

    objectPlayAnimation('kb_attack_saw', 'fire')
    setProperty('kb_attack_saw.offset.x', 1600)
    setProperty('kb_attack_saw.visible', true)

    runTimer('checkDodging', 0.09)
end

function alert2(prepare)
    objectPlayAnimation('kb_attack_alert', 'alert')

    if prepare then
        objectPlayAnimation('kb_attack_saw', 'prepare')
        setProperty('kb_attack_saw.offset.x', -333)
        setProperty('kb_attack_saw.visible', true)
    end
end

function alertDOUBLE2(prepare)
    objectPlayAnimation('kb_attack_alert', 'alertDOUBLE')

    if prepare then
        objectPlayAnimation('kb_attack_saw', 'prepare')
        setProperty('kb_attack_saw.offset.x', -333)
        setProperty('kb_attack_saw.visible', true)
    end
end

function bruh()
    playSound('bruh', 1)
        objectPlayAnimation('justkidding', 'justkidding')
end

function pincerPrepare(strum, goAway)
    local strumX = getPropertyFromGroup('strumLineNotes', (strum + 4) % 8, 'x')
    local strumY = getPropertyFromGroup('strumLineNotes', (strum + 4) % 8, 'y')

    removeLuaSprite('pincer' .. (strum % 4), true)
    makeLuaSprite('pincer' .. (strum % 4), 'bonus/pincer-open', strumX, strumY)
    setLuaSpriteScrollFactor('pincer' .. (strum % 4), 0, 0)
    setObjectCamera('pincer' .. (strum % 4), 'camHUD')
    addLuaSprite('pincer' .. (strum % 4), true)

    if downscroll then
        setProperty('pincer' .. (strum % 4) .. '.angle', 270)
        setProperty('pincer' .. (strum % 4) .. '.offset.x', 192)
        setProperty('pincer' .. (strum % 4) .. '.offset.y', -75)
        setProperty('pincer' .. (strum % 4) .. '.visible', true)
    else
        setProperty('pincer' .. (strum % 4) .. '.angle', 90)
        setProperty('pincer' .. (strum % 4) .. '.offset.x', 218)
        setProperty('pincer' .. (strum % 4) .. '.offset.y', 240)
        setProperty('pincer' .. (strum % 4) .. '.visible', true)
    end

    if downscroll then
        if not goAway then
            setProperty('pincer' .. (strum % 4) .. '.y', strumY + 500)
            doTweenY('pincer' .. strum .. '-enter', 'pincer' .. (strum % 4), strumY, crochet / 500, 'elasticOut')
        else
            doTweenY('pincer' .. strum .. '-leaving', 'pincer' .. (strum % 4), strumY + 500, crochet / 500, 'bounceIn')
        end
    else
        if not goAway then
            setProperty('pincer' .. (strum % 4) .. '.y', strumY - 500)
            doTweenY('pincer' .. strum .. '-enter', 'pincer' .. (strum % 4), strumY, crochet / 500, 'elasticOut')
        else
            doTweenY('pincer' .. strum .. '-leaving', 'pincer' .. (strum % 4), strumY - 500, crochet / 500, 'bounceIn')
        end
    end
end

function onTweenCompleted(tag)
    if tag == 'pincer0-leaving' then
        setProperty('pincer0.visible', false)
        removeLuaSprite('pincer0', true)
    elseif tag == 'pincer1-leaving' then
        setProperty('pincer1.visible', false)
        removeLuaSprite('pincer1', true)
    elseif tag == 'pincer2-leaving' then
        setProperty('pincer2.visible', false)
        removeLuaSprite('pincer2', true)
    elseif tag == 'pincer3-leaving' then
        setProperty('pincer3.visible', false)
        removeLuaSprite('pincer3', true)
    elseif tag == 'pincer4-leaving' then
        setProperty('pincer0.visible', false)
        removeLuaSprite('pincer0', true)
    end
end

function pincerGrab(pincer)
    pincer = pincer % 4

    local x = getProperty('pincer' .. pincer .. '.x')
    local y = getProperty('pincer' .. pincer .. '.y')

    removeLuaSprite('pincer' .. pincer, true)
    makeLuaSprite('pincer' .. pincer, 'bonus/pincer-close', x, y)
    setLuaSpriteScrollFactor('pincer' .. pincer, 0, 0)
    setObjectCamera('pincer' .. pincer, 'camHUD')

    if downscroll then
        setProperty('pincer' .. pincer .. '.angle', 270)
        setProperty('pincer' .. pincer .. '.offset.x', 192)
        setProperty('pincer' .. pincer .. '.offset.y', -75)
    else
        setProperty('pincer' .. pincer .. '.angle', 90)
        setProperty('pincer' .. pincer .. '.offset.x', 218)
        setProperty('pincer' .. pincer .. '.offset.y', 240)
    end

    addLuaSprite('pincer' .. pincer, true)
    setProperty('pincer' .. pincer .. '.visible', true)
end

function movePincerX(pincer, toX)
    pincer = pincer % 4

    doTweenX('pincer' .. pincer .. '-moveX', 'pincer' .. pincer, toX, crochet / 500, 'circInOut')
    noteTweenX('strum' .. (pincer + 4) .. '-moveX', pincer + 4, toX, crochet / 500, 'circInOut')

    return true
end

function movePincerY(pincer, toY)
    pincer = pincer % 4

    doTweenY('pincer' .. pincer .. '-moveY', 'pincer' .. pincer, toY, crochet / 500, 'circInOut')
    noteTweenY('strum' .. (pincer + 4) .. '-moveY', pincer + 4, toY, crochet / 500, 'circInOut')

    return true
end

function rotatePincer(pincer, toAngle)
    -- pincer = pincer % 4
    pincer = (pincer % 4) + 4

    local oldAngle = 90
    if downscroll then
        oldAngle = 270
    end

    -- doTweenAngle('pincer' .. pincer .. '-rotate', 'pincer' .. pincer, toAngle + oldAngle, crochet / 500, 'circInOut')
    noteTweenAngle('strum' .. pincer .. '-rotate', pincer, toAngle, crochet / 500, 'circInOut')

    return true
end

function resetToOriginalX(strum)
    strum = strum % 4

    if strum == 0 then
        movePincerX(strum, x0)
    elseif strum == 1 then
        movePincerX(strum, x1)
    elseif strum == 2 then
        movePincerX(strum, x2)
    elseif strum == 3 then
        movePincerX(strum, x3)
    end

    return true
end

function resetToOriginalY(strum)
    strum = strum % 4

    movePincerY(strum, strumLineY)

    return true
end

function resetToOriginalAngle(strum)
    strum = strum % 4

    rotatePincer(strum, 0)

    return true
end

function onStepHit()
    if curStep == 32 then
        introFade(1)
    elseif curStep == 64 then
        introFade(2)
    elseif curStep == 96 then
        introFade(3)
    elseif curStep >= 120 and not introEnded then
        for i = 0, 3 do
            introFade(i)
        end

        introEnded = true
    elseif curStep == 4352 then
        outroFade(2)
    elseif curStep == 4384 then
        outroFade(3)
    elseif curStep == 4416 then
        outroFade(0)
    elseif curStep == 4448 then
        outroFade(1)
    elseif curStep == 4480 then
        outroFade(6)
    elseif curStep == 4512 then
        outroFade(7)
    elseif curStep == 4544 then
        outroFade(4)
    elseif curStep == 4576 then
        outroFade(5)
    end
end

function onBeatHit()
    if curBeat == 320 then
        pincerPrepare(2, false)
    elseif curBeat == 322 then
        pincerGrab(2)

        if downscroll then
            movePincerY(2, strumLineY - 25)
        else
            movePincerY(2, strumLineY + 25)
        end
    elseif curBeat == 324 then
        pincerPrepare(2, true)
	elseif curBeat == 336 then
        pincerPrepare(0, false)
        pincerPrepare(2, false)
    elseif curBeat == 338 then
        pincerGrab(0)
        pincerGrab(2)
        resetToOriginalY(2)

        movePincerX(0, x0 - 30)

        if downscroll then
            movePincerY(0, strumLineY - 25)
        else
            movePincerY(0, strumLineY + 25)
        end
	elseif curBeat == 340 then
        pincerPrepare(2, true)
        pincerPrepare(0, true)
	elseif curBeat == 352 then
        pincerPrepare(0, false)
        pincerPrepare(3, false)
        pincerPrepare(1, false)
	elseif curBeat == 354 then
        pincerGrab(0)
        pincerGrab(3)
        pincerGrab(1)

        resetToOriginalX(0)
        resetToOriginalY(0)

        movePincerX(3, x3 + 55)
        movePincerX(1, x1 + 10)

        if downscroll then
            movePincerY(1, strumLineY - 25)
            movePincerY(3, strumLineY - 25)
        else
            movePincerY(1, strumLineY + 25)
            movePincerY(3, strumLineY + 25)
        end
	elseif curBeat == 356 then
        pincerPrepare(0, true)
        pincerPrepare(3, true)
        pincerPrepare(1, true)
	elseif curBeat == 368 then
        pincerPrepare(0, false)
        pincerPrepare(1, false)
        pincerPrepare(2, false)
        pincerPrepare(3, false)
    elseif curBeat == 370 then
        pincerGrab(0)
        pincerGrab(1)
        pincerGrab(2)
        pincerGrab(3)

        resetToOriginalX(1)
        resetToOriginalX(3)

        movePincerX(0, x0 - 25)
        movePincerX(3, x3 + 25)

        if downscroll then
            rotatePincer(0, 40)
            movePincerY(0, strumLineY - 25)
            movePincerY(1, strumLineY + 15)
            movePincerY(2, strumLineY + 15)
            movePincerY(3, strumLineY - 25)
            rotatePincer(3, -40)
        else
            rotatePincer(0, -40)
            movePincerY(0, strumLineY + 25)
            movePincerY(1, strumLineY - 15)
            movePincerY(2, strumLineY - 15)
            movePincerY(3, strumLineY + 25)
            rotatePincer(3, 40)
        end
    elseif curBeat == 372 then
        pincerPrepare(0, true)
        pincerPrepare(1, true)
        pincerPrepare(2, true)
        pincerPrepare(3, true)
	elseif curBeat == 382 then
        pincerPrepare(0, false)
        pincerPrepare(3, false)
	elseif curBeat == 384 then
        pincerGrab(0)
        pincerGrab(3)

        resetToOriginalAngle(0)
        resetToOriginalAngle(3)

        movePincerY(0, strumLineY + 75)
        movePincerY(3, strumLineY - 75)
	elseif curBeat == 388 then
        movePincerX(0, x3)
        movePincerX(3, x0)
	elseif curBeat == 392 then
        movePincerY(0, strumLineY)
        movePincerY(3, strumLineY)
	elseif curBeat == 396 then
        pincerPrepare(0, true)
        pincerPrepare(1, false)
        pincerPrepare(2, false)
        pincerPrepare(3, true)
	elseif curBeat == 400 then
        pincerGrab(1)
        pincerGrab(2)

        movePincerY(1, strumLineY + 75)
        movePincerY(2, strumLineY - 75)
	elseif curBeat == 404 then
        movePincerX(1, x2)
        movePincerX(2, x1)
	elseif curBeat == 408 then
        movePincerY(1, strumLineY)
        movePincerY(2, strumLineY)
	elseif curBeat == 412 then
        pincerPrepare(1, true)
        pincerPrepare(2, true)
	elseif curBeat == 448 then
        resetToOriginalX(0)
        resetToOriginalX(1)
        resetToOriginalX(2)
        resetToOriginalX(3)
	elseif curBeat == 510 then
        pincerPrepare(4, false)

        if middlescroll then
            pincerPrepare(7, false)
        else
            pincerPrepare(3, false)
        end
	elseif curBeat == 512 then
        pincerGrab(4)

        if middlescroll then
            pincerGrab(7)
        else
            pincerGrab(3)
        end
	elseif curBeat == 640 then
        pincerPrepare(4, true)

        if middlescroll then
            pincerPrepare(7, true)
        else
            pincerPrepare(3, true)
        end
    end

    for i = 1, 124 do -- aqui esta el famoso script para las sierras (no me lo roben)114
        local saw = sawBlades[i]

        if saw - curBeat == 2 then
            alert(true)
        elseif saw - curBeat == 1 then
            alert(false)
        elseif saw - curBeat == 0 then
            if botPlay then
                dodge()
            end

            attack()
        end
    end

    for i = 1, 13 do -- aqui esta el famoso script para las sierras (no me lo roben)114
        local sawDOUBLES = DOSsawBlades[i]

        if sawDOUBLES - curBeat == 2 then
            alertDOUBLE2(true)
            alert2(true)
            playSound('alert', 1)
        elseif sawDOUBLES - curBeat == 1 then
            alert2(false)
            alertDOUBLE2(false)
            playSound('alertALT', 1)
        elseif sawDOUBLES - curBeat == 0 then
            if botPlay then
                dodge()
            end

                attack()
        elseif sawDOUBLES - curBeat == -1 then
            if botPlay then
                dodge()
            end

                attackDOUBLE()
        end
    end

    for i = 1, 53 do -- aqui esta el famoso script para las sierras bruh(no me lo roben)
        local sawBruh = sawBladesBruh[i]

        if sawBruh - curBeat == 2 then
            alertDOUBLE2(true)
            alert2(true)
            playSound('alert', 1)
        elseif sawBruh - curBeat == 1 then
            alert2(false)
            alertDOUBLE2(false)
            playSound('alertALT', 1)
        elseif sawBruh - curBeat == 0 then
            if botPlay then
                dodge()
            end

            bruh()
        end
    end
end