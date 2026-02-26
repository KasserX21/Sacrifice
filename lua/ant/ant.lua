-- your SHIT goes here:grin:


-- don't worry about this for now trust the process


set {124, 50, 'reverse', -50, 'flip'}
ease {124, 7, inSine, 50, 'flip', 360*4, 'rotz', -600, 'tiny'}
set {124, 1, 'xmod', 100, 'dark', 100, 'stealth1', 100, 'stealth2'}
ease {131, 0, (outElastic:params(20, .01)), -0, 'tiny', 3000, 'drunkspeed', 3000, 'tipsyspeed'}
ease {131, 1, flip(outElastic:params(20, .01)), -720, 'tiny'}
ease {131, 1, (outElastic:params(4, .01)), 0, 'dark',0, 'flip', 0, 'stealth1', 0, 'stealth2', 0 ,'reverse'}
notes = P1:GetNoteData(132,163)
set {131, 3.5, 'xmod'}

for i,v in pairs(notes) do
ease {v[1], 2, flip(linear), -75, 'wave', 75, 'brake'}
ease {v[1], 1, flip(outElastic:params(20, .01)), -120, 'tiny'}
ease {v[1], 1, flip(outElastic:params(20, .01)), 300, 'tanbumpy'}

end

ease {160, 3, flip(outCirc), 1200, 'drunk', 300, 'tipsy'}

ease {161, 1, (inCirc), 50, 'reverse', 50, 'flip'}
