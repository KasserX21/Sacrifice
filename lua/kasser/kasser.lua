m = set
me = ease
f = func
fe = func_ease

local function modulo(a, b)
	return a - math.floor(a/b)*b;
end

definemod{'halo', 'haloradius', 'halorot', 'halohide', function(amt, radius, rotation, stealth, pn)
		local xpospercol = {}
		local zpospercol = {}
		local spospercol = {}

		rotation = rotation / 100 * 2 -- make it so 100 rotation = 1 full spin
		

		for col = 0,3 do
			local xpos = radius*math.sin((rotation+pn+(col/4))*math.pi)
			local zpos = radius*math.cos((rotation+pn+(col/4))*math.pi)
			local stealthpos = stealth*math.cos((rotation+pn+(col/4))*math.pi)
			
			xpospercol[col] = xpos
			zpospercol[col] = zpos
			spospercol[col] = stealthpos
		end

		return xpospercol[0], zpospercol[0], xpospercol[1], zpospercol[1], xpospercol[2], zpospercol[2], xpospercol[3], zpospercol[3], spospercol[0], spospercol[1], spospercol[2], spospercol[3]
	end,
	'movex0', 'movez0', 'movex1', 'movez1', 'movex2', 'movez2', 'movex3', 'movez3', 'stealth0', 'stealth1', 'stealth2', 'stealth3'}

xero.ax=-1

definemod{'dpadinner','dpadouter', function(inner,outer,pn)
    local xp = {{-inner,-outer},{0,0},{0,0},{inner,outer}}
    local yp = {{0,0},{inner,outer},{-inner,-outer},{0,0}}
    if P[pn] then
        for i=0,3 do
            P[pn]:SetXSpline(0,i,xp[i+1][2],-100,-1)
            P[pn]:SetXSpline(1,i,xp[i+1][1],600,-1)
            P[pn]:SetYSpline(0,i,yp[i+1][2],-100,-1)
            P[pn]:SetYSpline(1,i,yp[i+1][1],600,-1)
        end
    end
end}

definemod{'rotx','roty','rotz',function(xDegrees, yDegrees, zDegrees, plr)
            local function mindf_reverseRotation(angleX, angleY, angleZ)
                local sinX = math.sin(angleX);
                local cosX = math.cos(angleX);
                local sinY = math.sin(angleY);
                local cosY = math.cos(angleY);
                local sinZ = math.sin(angleZ);
                local cosZ = math.cos(angleZ);
                return { math.atan2(-cosX*sinY*sinZ-sinX*cosZ,cosX*cosY),
                        math.asin(-cosX*sinY*cosZ+sinX*sinZ),
                        math.atan2(-sinX*sinY*cosZ-cosX*sinZ,cosY*cosZ) }
            end
            local DEG_TO_RAD = math.pi / 180
            local angles = mindf_reverseRotation(xDegrees * DEG_TO_RAD, yDegrees * DEG_TO_RAD, zDegrees * DEG_TO_RAD)
            local rotationx,rotationy,rotationz=
                xDegrees,
                yDegrees,
                zDegrees
            local confusionxoffset,confusionyoffset,confusionzoffset=
                (angles[1]*100),
                (angles[2]*100),
                (angles[3]*100)

            return rotationx,rotationy,rotationz,confusionxoffset,confusionyoffset,confusionzoffset
        end,
        'rotationx','rotationy','rotationz','confusionxoffset','confusionyoffset','confusionzoffset'
    }

{'kaleidoS', function(kaleidoS)
	kaleido:GetShader():uniform1f('amount',kaleidoS)
end}
	

PP[3]:hidden(1)
PP[4]:hidden(1)

kaleido:hidden(0)
kal_aft:hidden(0)

-- modchart start

plr={1,2,3,4}
m{162,100,'arrowpath',700,'arrowpathgirth',25,'arrowpathdrawsize'}

plr={3,4}
m{162,50,'splinextype',50,'splineytype',75,'brake',100,'stealth',100,'dark',100,'spiralholds'}


plr={1,2}
m{162,-100,'drawsizeback'}
me{164,2,outCubic,-200,'z'}
{192,4,inOutQuad,0,'z'}

m{162,122.7,'kaleidoS'}
add{162,68,inOutExpo,3,'kaleidoS'}

m{162,1100,'dpadinner',50,'reverse',50,'flip',80,'brake',-100,'spiralholds',50,'mini'}
plr={1,2,3,4}
add{162,196-162,linear,720*1.5,'rotz'}
{196,32,linear,720/1.5,'rotz'}
{196,1,inQuad,-720/32,'rotx'}
{197,32-1-4,linear,-720+720/32-90,'rotx'}
me{196,4,linear,0,'y',0,'x',150,'z'}
{196+4,4,linear,-0,'y',0,'x',125,'z'}
{196+8,4,linear,-0,'y',-0,'x',100,'z'}
{196+12,4,linear,0,'y',-0,'x',75,'z'}
{196+16,4,linear,0,'y',0,'x',0,'z'}
plr={1,2}
me{196,4,linear,100,'brake'}
plr={1,2,3,4}
me{196,4,linear,-100,'drawsizeback'}


-- hide{196, 32, plr = 1, column = {0}}
-- {196, 32, plr = 2, column = {1}}
-- {196, 32, plr = 3, column = {3}}
-- {196, 32, plr = 4, column = {2}}

fe{162,196-162,linear,0,90,function(p)
	KaleidoGroupLayer:rotationz(p)
end}
{196,32,linear,90,360,function(p)
	KaleidoGroupLayer:rotationz(p)
	kaleidoGradient:texcoordvelocity(0,-0.1+p/1000)
end}

plr=2
m{162,45+180,'rotz'}

plr={3,4}
m{162,50,'reverse',50,'flip',-100,'spiralholds',50,'mini'}
plr=4
add{162,1,instant,180,'rotz'}
plr={3,4}
me{192,4,linear,0,'stealth',0,'dark',35,'brake'}
f{192,function()
	PP[3]:hidden(0)
	PP[4]:hidden(0)
end}

for i=166,191 do
	plr={1,2,3,4}
	me{i,2,flip(outExpo),-500,'tiny'}
end

me{164,2,flip(outExpo),-500,'tiny'}
{171.5,2,flip(outCirc),-1000,'tinyy'}
{176.25,1,flip(outCirc),-1000,'tinyx'}
{178.25,1,flip(outCirc),-1000,'tinyy'}
{179.25,1,flip(outCirc),-700,'tinyx'}
{179.5,1,flip(outCirc),-700,'tinyy'}
{179.75,1,flip(outCirc),-700,'tinyx'}
{180.5,2,flip(outCirc),-1000,'tinyy'}
{186.25,1,flip(outCirc),-1000,'tinyx'}
{188.25,1,flip(outCirc),-1000,'tinyy'}
{189.25,1,flip(outCirc),-1000,'tinyy'}


f{192,function()
    P[3]:SetXSpline(0,0,64/1.5,-0,-1)
    P[3]:SetYSpline(0,0,64/1.5,-0,-1)
	P[3]:SetXSpline(0,1,-64/1.5,-0,-1)
    P[3]:SetYSpline(0,1,64/1.5,-0,-1)
	P[3]:SetXSpline(0,2,64/1.5,-0,-1)
    P[3]:SetYSpline(0,2,-64/1.5,-0,-1)
	P[3]:SetXSpline(0,3,-64/1.5,-0,-1)
    P[3]:SetYSpline(0,3,-64/1.5,-0,-1)
	
	P[4]:SetXSpline(0,0,64/1.5,-100,-1)
    P[4]:SetYSpline(0,0,64/1.5,-100,-1)
	P[4]:SetXSpline(0,1,-64/1.5,-100,-1)
    P[4]:SetYSpline(0,1,64/1.5,-100,-1)
	P[4]:SetXSpline(0,2,64/1.5,-100,-1)
    P[4]:SetYSpline(0,2,-64/1.5,-100,-1)
	P[4]:SetXSpline(0,3,-64/1.5,-100,-1)
    P[4]:SetYSpline(0,3,-64/1.5,-100,-1)
	
	P[3]:SetZSpline(0,0,0,100,-1)
	P[3]:SetZSpline(0,1,0,100,-1)
	P[3]:SetZSpline(0,2,0,100,-1)
	P[3]:SetZSpline(0,3,0,100,-1)
	
	P[4]:SetZSpline(0,0,0,-100,-1)
	P[4]:SetZSpline(0,1,0,-100,-1)
	P[4]:SetZSpline(0,2,0,-100,-1)
	P[4]:SetZSpline(0,3,0,-100,-1)
	
	P[3]:SetZSpline(1,0,700,800,-1)
	P[3]:SetZSpline(1,1,700,800,-1)
	P[3]:SetZSpline(1,2,700,800,-1)
	P[3]:SetZSpline(1,3,700,800,-1)
	
	P[4]:SetZSpline(1,0,-700,800,-1)
	P[4]:SetZSpline(1,1,-700,800,-1)
	P[4]:SetZSpline(1,2,-700,800,-1)
	P[4]:SetZSpline(1,3,-700,800,-1)
	
	P[3]:SetXSpline(1,0,200,800,-1)
    P[3]:SetYSpline(1,0,200,800,-1)
	P[3]:SetXSpline(1,1,-200,800,-1)
    P[3]:SetYSpline(1,1,200,800,-1)
	P[3]:SetXSpline(1,2,200,800,-1)
    P[3]:SetYSpline(1,2,-200,800,-1)
	P[3]:SetXSpline(1,3,-200,800,-1)
    P[3]:SetYSpline(1,3,-200,800,-1)
	
	P[4]:SetXSpline(1,0,200,800,-1)
    P[4]:SetYSpline(1,0,200,800,-1)
	P[4]:SetXSpline(1,1,-200,800,-1)
    P[4]:SetYSpline(1,1,200,800,-1)
	P[4]:SetXSpline(1,2,200,800,-1)
    P[4]:SetYSpline(1,2,-200,800,-1)
	P[4]:SetXSpline(1,3,-200,800,-1)
    P[4]:SetYSpline(1,3,-200,800,-1)
	
	for pn=1,4 do
		P[pn]:SetStealthSpline(0,-1,0,400,-1)
		P[pn]:SetStealthSpline(1,-1,100,800,-1)
	end
end}

f{228,function()
	P[3]:SetZSpline(0,0,0,0,-1)
	P[3]:SetZSpline(0,1,0,0,-1)
	P[3]:SetZSpline(0,2,0,0,-1)
	P[3]:SetZSpline(0,3,0,0,-1)
	
	P[4]:SetZSpline(0,0,0,0,-1)
	P[4]:SetZSpline(0,1,0,0,-1)
	P[4]:SetZSpline(0,2,0,0,-1)
	P[4]:SetZSpline(0,3,0,0,-1)
	
	P[3]:SetZSpline(1,0,0,0,-1)
	P[3]:SetZSpline(1,1,0,0,-1)
	P[3]:SetZSpline(1,2,0,0,-1)
	P[3]:SetZSpline(1,3,0,0,-1)
	
	P[4]:SetZSpline(1,0,-0,0,-1)
	P[4]:SetZSpline(1,1,-0,0,-1)
	P[4]:SetZSpline(1,2,-0,0,-1)
	P[4]:SetZSpline(1,3,-0,0,-1)
	
	for pn=1,4 do
		P[pn]:SetStealthSpline(0,-1,0,400,-1)
		P[pn]:SetStealthSpline(1,-1,0,800,-1)
	end
end}

plr={1,2,3,4}
reset{228}

for pn=1,4 do
	for col = 0,3 do
		P[pn]:SetNumPathGradientPoints(col,4)
		
		P[pn]:SetPathGradientColor(0,col,1,1,0,0)
		P[pn]:SetPathGradientPoint(0,col,.25)
		P[pn]:SetPathGradientColor(1,col,.67,.6,0,1)
		P[pn]:SetPathGradientPoint(1,col,2)
		P[pn]:SetPathGradientColor(2,col,.67,.6,0,.7)
		P[pn]:SetPathGradientPoint(2,col,4)
		P[pn]:SetPathGradientColor(3,col,1,1,0,0)
		P[pn]:SetPathGradientPoint(3,col,5)
	end
end

f{360,function()
	for pn=1,4 do
		P[pn]:SetStealthSpline(0,-1,0,400,-1)
		P[pn]:SetStealthSpline(1,-1,100,500,-1)
		
		for col = 0,3 do
			P[pn]:SetNumPathGradientPoints(col,8)
			
			P[pn]:SetPathGradientColor(0,col,1,1,1,0)
			P[pn]:SetPathGradientPoint(0,col,-5)
			P[pn]:SetPathGradientColor(1,col,1,1,1,.6)
			P[pn]:SetPathGradientPoint(1,col,-4)
			P[pn]:SetPathGradientColor(2,col,1,.6,.0,.6)
			P[pn]:SetPathGradientPoint(2,col,-1)
			P[pn]:SetPathGradientColor(3,col,1,.6,0,0)
			P[pn]:SetPathGradientPoint(3,col,-.5)
			P[pn]:SetPathGradientColor(4,col,1,.6,0,0)
			P[pn]:SetPathGradientPoint(4,col,.25)
			P[pn]:SetPathGradientColor(5,col,1,.6,.0,.7)
			P[pn]:SetPathGradientPoint(5,col,2)
			P[pn]:SetPathGradientColor(6,col,.6,1,1,.7)
			P[pn]:SetPathGradientPoint(6,col,4)
			P[pn]:SetPathGradientColor(7,col,.6,1,1,0)
			P[pn]:SetPathGradientPoint(7,col,5)
		end
	end
	
	
end}

plr={1,2}
m{360,200,'haloradius',200,'halo',50,'flip',100,'centered'}
plr=3
m{360,1400,'dpadinner',50,'reverse',50,'flip',100,'brake',90,'rotx',-0*3.5,'movez',45,'rotz',20,'scrollspeedmult'}
plr=4
m{360,390/2,'dpadouter',50,'reverse',50,'flip',50,'boost',90,'rotx',-0*3.5,'movez',0,'rotz'}
plr=2
m{360,100,'reverse',100,'centered'}
plr={1,2,3,4}
m{360,50,'mini',75,'scrollspeedmult',100,'arrowpath',500,'arrowpathgirth',-100,'drawsizeback',100,'arrowpathdrawsizeback'}

plr=1
add{360,72,linear,400,'halorot'}
plr=2
add{360,72,linear,400,'halorot'}
plr=3
add{360,72,linear,360*4,'rotz'}
plr=4
add{360,72,linear,360*4,'rotz'}
plr={1,2,3,4}
add{400-32,64,inQuad,720,'rotx'}

chorus_cube:hidden(1)
f{360,function()
	chorus_cube:hidden(0)
end}

-- Did Unc Snap on that Sacrifice?
-- I wonder where I stole this code from

definemod {'spacesize', function(lol)
 textureSize = lol/2
end}
definemod {'wallspin', function(lol)
 insideOut = 180+lol
end}

definemod {'wallspinz', function(lol)

wall1:rotationz(lol)
wall2:rotationz(lol)
wall3:rotationz(lol)
floor:rotationz(lol)

end}

wall1:ztest(1)
wall1:SetTextureFiltering(true)
wall3:ztest(1)
wall3:SetTextureFiltering(true)

wall2:ztest(1)
wall2:SetTextureFiltering(true)
chorus_cube:zbuffer(1)


chorus_cube:zoom(1):z(100):zoomz(0.35)
chorus_cube:SetDrawFunction(function()
	wall1:rotationx(0)
	wall1:x(0)
	wall1:zoom(0.25)
	wall1:y(0)
	wall1:z(textureSize)
	wall1:rotationy(0 + insideOut)
	wall1:Draw()
	
	wall2:x(textureSize)
	wall2:y(0)
	wall2:zoom(0.25)
	wall2:z(0)
	wall2:rotationy(-90 + insideOut)
	wall2:Draw()
	
	wall1:x(0)
	wall1:y(0)
	wall1:z(-textureSize)
	wall1:rotationy(180 + insideOut)
	wall1:Draw()
	
	wall3:x(-textureSize)
	wall3:y(0)
	wall3:z(0)
	wall3:zoom(0.25)
	wall3:rotationy(90 + insideOut)
	wall3:Draw()
	
	
	floor:x(0)
	floor:y(-textureSize)
	floor:z(0)
	floor:rotationy(0)
	floor:rotationx(-90+insideOut)
	floor:Draw()
	floor:zoom(0.25)
	
	floor:x(0)
	floor:y(textureSize)
	floor:z(0)
	floor:rotationy(0)
	floor:rotationx(90+insideOut)
	floor:Draw()
end)

chorus_cube:xy(scx,scy)
chorus_cube:z(175)

definemod {'cuberotx', 'cuberoty', 'cuberotz', 'cubex', 'cubey', 'cubezoom', 'cubezoomy', function(rotsx,rotsy,rotsz,movx,movy,zoomc,zoomcy)
	chorus_cube:rotationx(rotsx)
	chorus_cube:rotationy(rotsy)
	chorus_cube:rotationz(rotsz)
	chorus_cube:x(scx+movx)
	chorus_cube:y(scy+movy)
	chorus_cube:zoom(zoomc/100)
	chorus_cube:zoomy(zoomcy/100)
end}

set{360,64,'spacesize',50,'cubezoomy',50,'cubezoom',0,'cuberoty'}

if not slumpo then
	add{360,72,linear,-360*4,'cuberoty'}
	{400-32,64,inQuad,720,'cuberotx'}
end

if slumpo then
	add{364,8,inOutQuad,30,'cuberotz'}
	{372,8,inOutQuad,-60,'cuberotz'}
	{380,8,inOutQuad,90,'cuberotz'}
	{388,8,inOutQuad,-120,'cuberotz'}
	{396,8,inOutQuad,150,'cuberotz'}
	{404,8,inOutQuad,-180,'cuberotz'}
	{412,8,inOutQuad,210,'cuberotz'}
	{420,8,inOutQuad,-240,'cuberotz'}
	{400-32,64,inQuad,720,'cuberotx'}
	plr={3,4}
	add{364,8,inOutQuad,-45,'roty'}
	{372,8,inOutQuad,90,'roty'}
	{380,8,inOutQuad,-135,'roty'}
	{388,8,inOutQuad,180,'roty'}
	{396,8,inOutQuad,-225,'roty'}
	{404,8,inOutQuad,270,'roty'}
	{412,8,inOutQuad,-315,'roty'}
	{420,8,inOutQuad,360,'roty'}
	{428,4,inQuad,720,'roty'}
	plr={1,2}
	add{364,8,inOutQuad,45,'rotz'}
	{372,8,inOutQuad,-90,'rotz'}
	{380,8,inOutQuad,135,'rotz'}
	{388,8,inOutQuad,-180,'rotz'}
	{396,8,inOutQuad,225,'rotz'}
	{404,8,inOutQuad,-270,'rotz'}
	{412,8,inOutQuad,315,'rotz'}
	{420,8,inOutQuad,-360,'rotz'}
	{428,4,inQuad,720,'rotz'}
	plr={1,2,3,4}
	add{400-32,64,linear,720,'rotx'}
	
end

reset{432}

