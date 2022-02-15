function fastScale(spr, width)
    setGraphicSize(spr, math.floor(getProperty(spr .. '.width') * width))
end

function onCreate()
    makeLuaSprite('bg', 'stage/streetBackCute', -750, -145)
    setLuaSpriteScrollFactor('bg', 0.9, 0.9)
    addLuaSprite('bg', false)

    makeLuaSprite('streetFront', 'stage/streetFrontCute', -820, 710)
    fastScale('streetFront', 1.15)
    setLuaSpriteScrollFactor('streetFront', 0.9, 0.9)
    addLuaSprite('streetFront', false)

    if songName == 'Cessation' then
        makeAnimatedLuaSprite('qt_tv01', 'stage/TV_V4', -62, 540)
        addAnimationByPrefix('qt_tv01', 'idle', 'TV_Idle', 24, true)
        addAnimationByPrefix('qt_tv01', 'alert', 'TV_Attention', 28, false)
        addAnimationByPrefix('qt_tv01', 'sus', 'TV_sus', 24, true)
        addAnimationByPrefix('qt_tv01', 'heart', 'TV_End', 24, false)
        fastScale('qt_tv01', 1.2)
        setLuaSpriteScrollFactor('qt_tv01', 0.89, 0.89)
        addLuaSprite('qt_tv01', false)
        objectPlayAnimation('qt_tv01', 'heart', true)
    else
        makeLuaSprite('qt_tv01', 'stage/TV_V2_off', -62, 540)
        fastScale('qt_tv01', 1.2)
        setLuaSpriteScrollFactor('qt_tv01', 0.89, 0.89)
        addLuaSprite('qt_tv01', false)
    end

    close(true)
end