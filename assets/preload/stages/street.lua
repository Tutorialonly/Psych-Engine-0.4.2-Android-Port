function onCreate()
    makeLuaSprite('bg', 'stage/streetBack', -750, -145)
    setLuaSpriteScrollFactor('bg', 0.9, 0.9)
    addLuaSprite('bg', false)

    makeLuaSprite('streetFront', 'stage/streetFront', -820, 710)
    scaleObject('streetFront', 1.15, 1.15)
    setLuaSpriteScrollFactor('streetFront', 0.9, 0.9)
    addLuaSprite('streetFront', false)

    makeAnimatedLuaSprite('qt_tv01', 'stage/TV_V5', -62, 540)
    addAnimationByPrefix('qt_tv01', 'idle', 'TV_Idle', 24, true)
    addAnimationByPrefix('qt_tv01', 'alert', 'TV_Attention', 26, false)
    addAnimationByPrefix('qt_tv01', 'eye', 'TV_brutality', 24, true)
    addAnimationByPrefix('qt_tv01', 'eyeLeft', 'TV_eyeLeft', 24, false)
    addAnimationByPrefix('qt_tv01', 'eyeRight', 'TV_eyeRight', 24, false)
    scaleObject('qt_tv01', 1.2, 1.2)
    setLuaSpriteScrollFactor('qt_tv01', 0.89, 0.89)
    addLuaSprite('qt_tv01', false)
    objectPlayAnimation('qt_tv01', 'idle')
end

function beatHit()
    if curBeat == 190 or curBeat == 191 or curBeat == 224 then
        objectPlayAnimation('qt_tv01', 'eye')
    elseif curBeat >= 192 and curStep <= 895 then
        objectPlayAnimation('qt_tv01', 'alert')
    elseif curBeat == 225 then
        objectPlayAnimation('qt_tv01', 'idle')
    end
end