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
set {0, 2, 'xmod'}
plr = 1

set {124, 50, 'reverse', -0, 'flip', 100, 'halo'}
ease {124, 7, inSine, 50, 'flip', 360*4, 'rotz', -600, 'tiny'}
set {124, 1, 'xmod', 100, 'dark', 100, 'stealth1', 100, 'stealth2'}
ease {131, 0, (outElastic:params(20, .01)), -0, 'tiny', -100, 'drunkspeed', -100, 'tipsyspeed', 0 ,'rotz'}
ease {131, 1, flip(outElastic:params(20, .01)), -480, 'tiny'}
ease {131, 1, (outElastic:params(4, .01)), 0, 'dark', 0, 'flip', 0, 'stealth1', 0, 'stealth2'}
ease {131, 1, bounce, 0 ,'reverse'}
ease {131, 1, outSine, 50 ,'flip'}

plr = 2
ease {128, 4, flip(outSine), 0, 'xmod', -300, 'tipsy', 25, 'orient', 600, 'drunk', 25, 'stealth',  plr = 2}
ease {128, 0, (outSine), 500, 'drunkspeed', 100, 'tipsyspeed', plr = 2}
ease {124, 0, (outSine), 500, 'dark', 100, 'tipsyspeed', plr = 2}
ease {131, 1, outSine, 50 ,'flip'}
ease {131, 1, outSine, 50 ,'reverse'}

hide {124, 8, col = {0,1,2,3}}
notes = P1:GetNoteData(120,163)
plr = {1,2}
set {131, 2, 'xmod'}
for i = 132, 143, 1 do

ease {i, 1, bounce, 50-(50*valflip), 'reverse'}
ease {i, 1, bounce, 0, 'flip'}
ease {i, 1, flip(outCirc), -300, 'tiny'}

valflip = -valflip
end
ease {132, 1, flip(outCirc), 50, 'tiny'}

for i = 132, 143, 4 do

ease {i, 2, bounce, 45, 'rotationx'}
ease {i+2, 2, bounce, -45, 'rotationx'}
ease {i, 4, bounce, 80*valflip, 'skewx'}
valflip = -valflip
add {i, 5, outSine, 360*2, 'roty'}


end

for i,v in pairs(notes) do
    if v[1] < 148 then 
ease {v[1], 2, flip(linear), -50, 'wave', 50, 'brake'}
    end
ease {v[1], 1, flip(outElastic:params(20,0.3)), -80, 'tinyx'}
ease {v[1], 1, flip(outCirc), 800, 'zoomz'}
ease {v[1], 1, flip(outCirc), -3200, 'tinyz'}

add {v[1], 2, outCirc,  180, 'punchRot'}
ease {v[1], 1, flip(linear), 0, 'punch', 30, 'alphas', 80, 'depth'}




end
ease {144, 2, bounce, 0, 'reverse', 100, 'flip', 300, 'drunk', -45, 'skewx', 120, 'spiralx', 120, 'pulse'}
ease {146, 2, bounce, 0, 'reverse', 100, 'flip', plr = 1}
ease {146, 2, bounce, 100, 'reverse', 0, 'flip', plr = 2}
ease {146, 2, outSine, 100, 'sudden', 0, 'dark', 1.25, 'xmod'}
for i = 148, 159, 1 do

ease {i, 1, bounce, 0, 'reverse', plr = 1}
ease {i, 1, bounce, 100, 'reverse', plr = 2}

ease {i, 1, bounce, 0, 'flip'}

ease {i, 1, flip(outCirc), -300, 'tiny'}

valflip = -valflip
end
for i = 148, 159, 2 do
ease {i, 1, outCirc, 100, 'stealth0', 0, 'stealth1', 100, 'stealth2', 0, 'stealth3', plr = 1}
ease {i+1, 1, outCirc, 0, 'stealth0', 100, 'stealth1', 0, 'stealth2', 100, 'stealth3', plr = 1}

ease {i+1, 1, outCirc, 100, 'stealth0', 0, 'stealth1', 100, 'stealth2', 0, 'stealth3', plr = 2}
ease {i, 1, outCirc, 0, 'stealth0', 100, 'stealth1', 0, 'stealth2', 100, 'stealth3', plr = 2}

valflip = -valflip
end
for i = 148, 160-4, 4 do


ease {i, 4, bounce, 80*valflip, 'skewx'}
valflip = -valflip
add {i, 2, outSine, 180, 'rotx'}
add {i+2, 2, outSine, 180, 'rotx'}


end

plr = {1,2}

ease {156, 2, (bounce), 200, 'zoomy', 50, 'zoomx', 45, 'rotationx'}

ease {158, 2, (bounce), 50, 'zoomy', 200, 'zoomx', -45, 'rotationx'}


ease {160, 2.5, flip(outCirc), 1200, 'drunk', 800, 'tipsy'}

ease {161, 1, (inCirc), 50, 'reverse', 50, 'flip'}


