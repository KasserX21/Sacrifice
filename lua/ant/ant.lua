-- your SHIT goes here:grin:


-- don't worry about this for now trust the process

notes = P1:GetNoteData(132,163)
set {132, 3, 'xmod'}
for i,v in pairs(notes) do
ease {v[1], 2.5, flip(outCirc), -200, 'wave', 100, 'brake'}
ease {v[1], 1, flip(outElastic:params(8.,.3)), -450, 'tinyx'}

end

