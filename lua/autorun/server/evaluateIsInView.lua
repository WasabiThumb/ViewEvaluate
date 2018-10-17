-- Is an NPC lookins at u?

function checkIsInView(player, npc, fov)
  if !IsValid(npc) or !IsValid(npc) then return false end
  if !npc:IsNPC() then return false end
  if !player:IsPlayer() then return false end
  if !fov then local fov = player:GetFOV() end
  local dir = npc:GetAimVector():GetNormalized()
  local preliminary = util.TraceLine({
      start = npc:EyePos(),
      endpos = player:GetPos() + player:GetForward()*-50 + player:GetUp()*12,
      filter = {npc}
    })
  if !(preliminary.Entity == player) then return false end
  local thoseinview = ents.FindInCone(npc:EyePos(), dir, 261888, (fov/2))
  if table.HasValue(thoseinview, player) then return true end else return false end
end
