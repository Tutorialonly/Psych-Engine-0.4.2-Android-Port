local blueScreened = false

function onEvent(event, value1, value2)
    if event == 'Change Screen' then
        if songName == 'Censory Overload' and lowQuality then return end

        if value1 == 'error' then
            blueScreened = false

            setProperty('streetBG.visible', false)
            setProperty('streetBGerror.visible', true)
            setProperty('errorBG.visible', false)
            setProperty('streetFrontError.visible', false)

            cameraShake('camGame', 0.0075, crochet / 500)
        elseif value1 == 'blue' then
            blueScreened = true

            setProperty('streetBG.visible', false)
            setProperty('streetBGerror.visible', false)
            setProperty('errorBG.visible', true)
            setProperty('streetFrontError.visible', true)

            triggerEvent('Change Character', 'gf', 'gf-404')
            triggerEvent('Change Character', 'dad', 'robot-404')
            triggerEvent('Change Character', 'bf', 'bf-404')
        else
            blueScreened = false

            setProperty('streetBG.visible', true)
            setProperty('streetBGerror.visible', false)
            setProperty('errorBG.visible', false)
            setProperty('streetFrontError.visible', false)

            triggerEvent('Change Character', 'gf', 'gf')
            triggerEvent('Change Character', 'dad', 'robot')
            triggerEvent('Change Character', 'bf', 'bf')
        end
    end
end

function onStepHit()
    if blueScreened and curStep % 2 == 0 then
        characterPlayAnim('gf', 'scared', true)
    end
end