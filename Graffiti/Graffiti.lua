
local PlayerIn = {}

local TagMeta = {
    ["Ballas"]={TagId = 1524},
    ["Grove Street"]={TagId = 1528}
}

local AllTags = getElementsByType("object",resourceRoot)

for i, v in pairs(AllTags) do
  local x,y,z = getElementPosition(AllTags[i])
  local xr,yr,zr = getElementRotation(AllTags[i])
  destroyElement(AllTags[i])
  local Tag = createObject(1526,x,y,z,xr,yr,zr,true)
  local ColSphere = createColSphere(x,y,z,2)
  setElementParent(ColSphere,Tag)
  setElementID(ColSphere,"")
  --local blip = createBlipAttachedTo(ColSphere,0,1,255,0,0,100,10,300)
end


addEventHandler("onColShapeHit",resourceRoot,function(hitElement)
  if (getElementType( hitElement ) == "player") and (isPedInVehicle(hitElement) == false) then
    local ColSphere = source
    PlayerIn[hitElement] = ColSphere
    local Tag = getElementParent(ColSphere)
    local TagId = getElementID(Tag)
    triggerClientEvent("GivPlayerName",hitElement,TagId)
  end
end)

addEventHandler("onColShapeLeave",resourceRoot,function(hitElement)
  if (getElementType( hitElement ) == "player") and (isPedInVehicle(hitElement) == false) then
    PlayerIn[hitElement] = nil
  end
end)

addEvent("StartTage", true)
addEventHandler("StartTage", getRootElement(), function ()
    if PlayerIn[source] ~= nil then
      local ColSphere = PlayerIn[source]
      TageTeam = getElementID(ColSphere)
      local playerTeam = getPlayerTeam(source)
      local playerTeamName = getTeamName(playerTeam)
      if (playerTeamName ~= TageTeam) and (playerTeamName == "Ballas" or playerTeamName == "Grove Street") then
        local Tag = getElementParent(ColSphere)
        local TagId = TagMeta[playerTeamName].TagId
        local PlayerName = getPlayerName(source)
        setElementID(Tag,PlayerName)
        setElementModel(Tag,TagId)
        setElementID(ColSphere,playerTeamName)
        triggerClientEvent("SprayCompleted",source)
        local Stars = getPlayerWantedLevel(source)
        if Stars == 0 then
          setPlayerWantedLevel(source,1)
        end
      end
    end
end)