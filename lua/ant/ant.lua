-- your SHIT goes here:grin:

-- halo thing
definemod {
    'halo', 'haloradius', 'halorot', function(amt, radius, rotation, pn)
        local xpospercol = {}
        local zpospercol = {}

        rotation = rotation / 100 * 2 -- make it so 100 rotation = 1 full spin

        for col = 0,3 do
            local xpos = radius*math.sin((rotation+pn+(col/4))*math.pi)
            local zpos = radius*math.cos((rotation+pn+(col/4))*math.pi)
            xpospercol[col] = xpos
            zpospercol[col] = zpos
        end

        return xpospercol[0], zpospercol[0], xpospercol[1], zpospercol[1], xpospercol[2], zpospercol[2], xpospercol[3], zpospercol[3]
    end,
    'movex0', 'movez0', 'movex1', 'movez1', 'movex2', 'movez2', 'movex3', 'movez3'

}


-- don't worry about this for now trust the process

valflip = 1
set {124, 50, 'reverse', -0, 'flip', 100, 'halo'}
ease {124, 7, inSine, 50, 'flip', 360*4, 'rotz', -600, 'tiny'}
set {124, 1, 'xmod', 100, 'dark', 100, 'stealth1', 100, 'stealth2'}
ease {131, 0, (outElastic:params(20, .01)), -0, 'tiny', -100, 'drunkspeed', -100, 'tipsyspeed', 0 ,'rotz'}
ease {131, 1, flip(outElastic:params(20, .01)), -480, 'tiny'}
ease {131, 1, (outElastic:params(4, .01)), 0, 'dark', 0, 'flip', 0, 'stealth1', 0, 'stealth2', 0 ,'reverse'}
notes = P1:GetNoteData(132,163)
set {131, 2, 'xmod'}

for i,v in pairs(notes) do
ease {v[1], 1, flip(linear), -50, 'wave', 50, 'brake'}
if  v[1] <  139 then

if v[1]%2 == 0 then 
ease {v[1]-1, 1, inCirc, 400, 'movez', plr = 2}
ease {v[1], 0, inCirc, -800, 'movez', plr = 1}
ease {v[1], 1, outCirc, -800, 'drunk', 300, 'tipsy', 100, 'orient', plr = 2}
ease {v[1], 1, outCirc, 100, 'dark', 100, 'Stealth', plr = 2}
ease {v[1], 1, outCirc, -0, 'drunk', 0, 'tipsy', 0, 'orient', plr = 1}
ease {v[1], 1, outCirc, 0, 'dark', 0, 'Stealth', plr = 1}

else
ease {v[1]-1, 1, inCirc, 400, 'movez', plr = 1}
ease {v[1], 0, inCirc, -800, 'movez', plr = 2}
ease {v[1], 1, outCirc, 800, 'drunk', -300, 'tipsy', 100, 'orient', plr = 1}
ease {v[1], 1, outCirc, 100, 'dark', 100, 'Stealth', plr = 1}
ease {v[1], 1, outCirc, -0, 'drunk', 0, 'tipsy', 0, 'orient', plr = 2}
ease {v[1], 1, outCirc, 0, 'dark', 0, 'Stealth', plr = 2}

end
end

if v[1] == 139 then
ease {v[1]-1, 1, inCirc, 0, 'movez', plr = 1}
end

valflip = -valflip
end

plr = {1,2}

ease {156, 2, (bounce), 200, 'zoomy', 50, 'zoomx', 45, 'rotationx'}

ease {158, 2, (bounce), 50, 'zoomy', 200, 'zoomx', -45, 'rotationx'}


ease {160, 2.5, flip(outCirc), 1200, 'drunk', 800, 'tipsy'}

ease {161, 1, (inCirc), 50, 'reverse', 50, 'flip'}


