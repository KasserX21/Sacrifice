


Square:xy(scx,scy)
Squares:fov(140)
definemod {"Punch", "punchRot", "Spiral", 'depth', 'rotasx', 'red', 'blue', 'green', 'alphas', 'punchz', function(full, rots, Spiraldirection, depth, rotsx, colorr, colorb, colorg,alpha,zmove)
Squares:SetDrawFunction(xero(function(self)
    local beat=GAMESTATE:GetSongBeat()
    local square = Square
rot = 0
rotx = 0

    for z = 1,depth do

            local zpos = z*.20
            local rotationzs = rots+rot*(Spiraldirection/100)
            local rotationxs = rotsx+rotx
            square:Draw()  
            square:zoom(zpos*full)
			square:z((zpos*zmove/z)*1000)
			square:diffuse(z/((depth/12)+1)*colorr/100,colorg/100,z/((depth/12)+1)*colorb/100, alpha/100)
            square:rotationz(rotationzs)
            square:rotationx(rotationxs)
            rot = rot + 10


    end

end))
end}

set {0, -0, 'spiral', 10, 'alphas', 65, 'red', 0, 'green', 72, 'blue'}
ease {0, 4, outCirc, 40, 'depth', 0.8, 'punch', 90, 'spiral', -0, 'punchz'}
