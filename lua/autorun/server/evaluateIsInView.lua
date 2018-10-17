-- Is an NPC lookins at u?

function checkIsInView(player, npc, fov)
  if !IsValid(npc) or !IsValid(npc) then return end
  if !npc:IsNPC() then return end
  if !fov then local fov = player:GetFOV() end
  
end
