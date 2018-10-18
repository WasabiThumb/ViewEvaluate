-- reports lumocity from client

net.Receive("gimmeLumocityPlox", function(len, ply)
  local luminocity = math.Clamp((render.GetLightColor(LocalPlayer():GetPos())*Vector(255,255,255)):Length()+ ((LocalPlayer():FlashlightIsOn() and 1 or 0)*100),0,255)
  net.Start("okLumocityBaka")
  net.WriteInt(lumocity, 32)
  net.SendToServer()
end )
