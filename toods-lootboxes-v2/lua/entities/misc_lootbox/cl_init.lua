include( "shared.lua" )
include( "autorun/sh_wosconfig.lua" )

surface.CreateFont( "BlahBlah2", {
	font = "a Absolute Empire",
	extended = false,
	size = 20,
	weight = 1000,
    shadow = true,
    outline = false
} )

function ENT:Draw()

    self:DrawModel()

    local EntPos = self:GetPos()
    local ang = self:GetAngles()
    ang:RotateAroundAxis( ang:Forward(), 90 )
    ang:RotateAroundAxis( ang:Up(), 90 )
    ang.y = LocalPlayer():EyeAngles().y - 90
    if LocalPlayer():GetPos():DistToSqr( self:GetPos() ) < 512 * 512 then
        cam.Start3D2D( EntPos + Vector( 0, 0, 10 ), Angle( 0, ang.y, 90 ), .15 )
            draw.RoundedBox( 5, - 180, - 300, 350, 50, Color( 0, 0, 0, 245 ) )
            draw.DrawText( self.PrintName, "BlahBlah2", 0, - 285, Color( 180, 80, 0, 255 ), TEXT_ALIGN_CENTER )
        cam.End3D2D()
    end
end