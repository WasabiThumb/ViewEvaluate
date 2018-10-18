-- Is an NPC lookins at u?
local range = 26000
local defaultMinBrightness = 0.75
local checkFrequencyMS = 500
local npcOmitList = {}
local npcExceptions = {}
local NPCFovExceptions = {}
local includeSents = false;

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

hook.Add("InitPostEntity", "startNPCCheckTimer", function()
  timer.Create("PerNPCVisibilityCheck", checkFrequencyMS, 0, function()
    local npcs = ents.FindByClass("npc_*")
    if includesents then
      local sents = ents.FindByClass("sent_*")
      table.Add(npcs, sents)
    end
    for _,v in pairs(npcs) do
      if !IsValid(v) then continue end
      for _,p in pairs(ents.FindInSphere(v:GetPos(), range)) do
        if !IsValid(p) then continue end
        if !p:IsPlayer() then continue end
        local fov = nil;
        if NPCFovExceptions[v] then fov = NPCFovExceptions[v] end
        if checkIsInView(p, v, fov) then
          -- Do luminosity check here
        end
      end
    end
  end )
end )
