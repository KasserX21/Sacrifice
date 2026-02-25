m = set
me = ease
f = func
fe = func_ease

local function modulo(a, b)
	return a - math.floor(a/b)*b;
end

xero.ax=-1

definemod {'dpadinner','dpadouter', function(inner,outer,pn)
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
	
	

PP[3]:hidden(1)
PP[4]:hidden(1)

-- modchart start

plr={1,2,3,4}
m{162,50,'arrowpath',300,'arrowpathgirth',25,'arrowpathdrawsize'}

plr={3,4}
m{162,50,'splinextype',50,'splineytype',50,'brake',100,'stealth',100,'dark'}


plr={1,2}
m{162,-100,'drawsizeback'}



m{162,1100,'dpadinner',50,'reverse',50,'flip',80,'brake',-100,'spiralholds',50,'mini'}
plr={1,2,3,4}
add{162,196-162,linear,720*1.5,'rotz'}
{196,32,linear,720/1.5,'rotz'}
{196,1,inQuad,720/32,'rotx'}
{197,32-1,linear,720-720/32,'rotx'}
{196,8,inOutSine,100,'y',100,'x'}
{196+8,8,inOutSine,-200,'y',100,'x'}
{196+16,8,inOutSine,200,'y',-300,'x'}
{196+24,8,inOutSine,-200,'y',0,'x'}
plr=2
m{162,45+90,'rotz'}

plr={3,4}
m{162,50,'reverse',50,'flip',-100,'spiralholds',50,'mini'}

me{192,4,linear,0,'stealth',0,'dark',35,'brake'}
f{192,function()
	PP[3]:hidden(0)
	PP[4]:hidden(0)
end}


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
	
	P[3]:SetZSpline(0,0,0,0,-1)
	P[3]:SetZSpline(0,1,0,0,-1)
	P[3]:SetZSpline(0,2,0,0,-1)
	P[3]:SetZSpline(0,3,0,0,-1)
	
	P[4]:SetZSpline(0,0,0,0,-1)
	P[4]:SetZSpline(0,1,0,0,-1)
	P[4]:SetZSpline(0,2,0,0,-1)
	P[4]:SetZSpline(0,3,0,0,-1)
	
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

plr={1,2,3,4}
reset{228}