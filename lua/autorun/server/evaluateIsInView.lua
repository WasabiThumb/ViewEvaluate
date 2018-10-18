-- Is an NPC lookins at u?
local range = 26000
local defaultMinBrightness = 0.75

function checkIsInView(player, npc, fov)
  if !IsValid(npc) or !IsValid(npc) then return false end
  if !npc:IsNPC() then return false end
  if !player:IsPlayer() then return false end
  if !fov then local fov = player:GetFOV() end
  local dir = npc:GetAimVector():GetNormalized()
  local preliminary = util.TraceLine({
      start = npc:EyePos(),
      endpos = player:GetPos() + player:GetForward()*-1 + player:GetUp()*-1,
      filter = {npc}
    })
  if !(preliminary.Entity == player) then return false end
  local thoseinview = ents.FindInCone(npc:EyePos(), dir, range, (fov/2))
  if table.HasValue(thoseinview, player) then return true end else return false end
end

function checkIsVisibleToNPC(player, npc, lumosity)
  local npcMin = defaultMinBrightness
  if npcExceptions[npc:GetClass()] then npcMin = npcExceptions[npc:GetClass()] end
  if lumosity >= npcMin then return true else return false end
end
