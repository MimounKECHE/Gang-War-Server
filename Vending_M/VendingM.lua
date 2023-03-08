
local VendingSoda = {
  {2326,-1646,14.80},
  {2060.10,-1898.5,13.60},
  {2353,-1357.19,24.39},
  {1929.59,-1772.5,13.5}
}

local HotDog = {
  {2229.30,-1740.19,13.60},
  {1589.69,-1288.10,17},
  {388.89,-2072.5,7.80},
  {1000.29,-1849.9,12.8}
}
---------------------------------------
for k,v in pairs(VendingSoda)do
  local Marker = createMarker(VendingSoda[k][1],VendingSoda[k][2],VendingSoda[k][3],"corona",0.5,255,0,0,0)
  setElementID(Marker,"VendingSoda")
end
----
for k,v in pairs(HotDog)do
  local Marker = createMarker(HotDog[k][1],HotDog[k][2],HotDog[k][3],"corona",1,255,0,0,0)
  setElementID(Marker,"HotDog")
end

------------------------------------------------

----------------------------------------------------------------------------------
--//////////////////////////////////////////////////////////////////////////////--
--//////////////////////////////////////////////////////////////////////////////--
----------------------------------------------------------------------------------
addEventHandler("onMarkerHit",resourceRoot,function (hitElement)
  if (getElementType( hitElement ) == "player") and (isPedInVehicle(hitElement) == false) then
  local Money = getPlayerMoney(hitElement)
  if Money >= 1 then
    local id = getElementID(source)
    setPedWeaponSlot(hitElement,0)
    local hp = getElementHealth(hitElement)
    hp = hp + 20
    setTimer(setElementHealth,2500,1,hitElement,hp)
    takePlayerMoney(hitElement,1)
    triggerClientEvent("UseVendingM",hitElement,id)
  else 
     -- exports ["info_Text"]:InfoText("أنت لا تملك ما يكفي من المال تحتاج الى 1 دولار",10000)
  end
  end
end)

