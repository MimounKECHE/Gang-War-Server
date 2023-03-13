-------------------------الماركر للدخول و الخروج --------------------------------------

local BaseMark = {
  {2528.0,-1289.50,1030.60,"cylinder",0,0,0,100,"Short",2},
  {2580.89,-1285.30,1043.3,"cylinder",0,0,0,100,"Short",2},
  {2521.1,-1281.8,1053.7,"cylinder",0,0,0,100,"Short",2},
  
  {2541.30,-1304,1025.099,"corona",0,0,0,100,"OutMark",2},
  
  {1900.400,-1127.09,23.70,"cylinder",160,32,240,100,"InMark",0},
  {2498.5,-1684.59,12.5,"cylinder",0,255,0,100,"InMark",0}
} 


for i, v in pairs(BaseMark) do
  local Marker = createMarker(BaseMark[i][1],BaseMark[i][2],BaseMark[i][3],BaseMark[i][4],1,BaseMark[i][5],BaseMark[i][6],BaseMark[i][7],BaseMark[i][8])
  setElementID(Marker,BaseMark[i][9])
  setElementInterior(Marker,BaseMark[i][10])
end

--///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////--

----------------اذا دخل اللاعب في واحد من الماركر---------------------------

function getPlayerTeamName(Player)
  local TeamName
  local playerTeam = getPlayerTeam(Player)
  if playerTeam then
    TeamName = getTeamName(playerTeam)
    return TeamName
  else
    return false
  end
end

addEventHandler("onMarkerHit",resourceRoot,function (hitElement)
  if (getElementType( hitElement ) == "player") and (isPedInVehicle(hitElement) == false) then
    local id = getElementID(source)
    local TeamName = getPlayerTeamName(hitElement)
    local r,g,b,a = getMarkerColor(source)
      if id == "Short" then
        triggerClientEvent("ShowPlayerMap",hitElement)
      elseif id == "OutMark" then
        if TeamName == "Ballas" then
          setElementInterior(hitElement,0,1896.19,-1126.80,24.39)
        elseif TeamName == "Grove Street" then
          setElementInterior(hitElement,0,2503.19,-1683.5,13.5)
        end
        setElementDimension(hitElement,0)
      elseif (id == "InMark") and ((TeamName == "Ballas" and g == 32) or (TeamName == "Grove Street" and g == 255)) then
        triggerClientEvent("ShowPlayerMap",hitElement)
      else
       triggerClientEvent("InfoText",hitElement,"لا يمكنك الدخول الى هنا انت لست من العصابة",10000)
      end
    end
end)
----------------------------------------------------------------


-------------------بعد ان يختار اللاعب مكان السبون-------------------------

local BaseSpawnMeta = {
    [1] = {BaseSpawn = {2579.10,-1300.5,1061}},
    [2] = {BaseSpawn = {2529.19,-1286,1054.59}},
    [3] = {BaseSpawn = {2574.19,-1301.69,1044.09}},
    [4] = {BaseSpawn = {2527.10,-1294.09,1031.40}},
    [5] = {BaseSpawn = {2543.39,-1304,1025.09}}
}


addEvent("SpawnInBase", true)
addEventHandler("SpawnInBase", root,function(loc)
  local TeamName = getPlayerTeamName(source)
  local Dimension
  if TeamName == "Ballas" then
    Dimension = 2
  elseif TeamName == "Grove Street" then
    Dimension = 1
  end
  local BaseSpawn = BaseSpawnMeta[loc].BaseSpawn
  setElementPosition(source,BaseSpawn[1],BaseSpawn[2],BaseSpawn[3])
  setElementInterior(source,2)
  setElementDimension(source,Dimension)
end)