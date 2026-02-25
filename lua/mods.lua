if not P1 or not P2 then
	backToSongWheel('Two Player Mode Required')
	return
end

-- judgment / combo proxies
for pn = 1, 2 do
	setupJudgeProxy(PJ[pn], P[pn]:GetChild('Judgment'), pn)
	setupJudgeProxy(PC[pn], P[pn]:GetChild('Combo'), pn)
end
-- player proxies
for pn = 1, #PP do
	PP[pn]:SetTarget(P[pn])
	P[pn]:hidden(1)
end

function RealFOV(fov)
	return 360 / math.pi * math.atan(math.tan(math.pi * fov / 360) * SCREEN_WIDTH / SCREEN_HEIGHT * 0.75)
end

require('ant.ant')
require('kasser.kasser')
require('Ant/proxywall')

-- your code goes here here:
setdefault{2, 'xmod', 100, 'zbuffer', 100, 'receptorzbuffer', 100, 'dizzyholds', 100, 'stealthpastreceptors', 100,'scrollspeedmult',100, 'halgun', 100, 'disablemines', 100, 'modtimer',100,'cover'}
card{4, 68, 'intro', 1, {0.5, 0.5, 0.5, 1}}