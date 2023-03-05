--------------------علامة الدخول و الخروج--------------------------
local Restaurants = {
  {2105.80,-1806.46,13.80,0,"PizzIn"},
  {372.35,-134,1001.70,5,"PizzOut"},
  {2419.5,-1509,24,0,"CluckinIn"},
  {364.89,-12,1001.90,9,"CluckinOut"},
  {810.20,-1616.20,13.5,0,"BurgerIn"},
  {362.70,-75.40,1001.5,10,"BurgerOut"}
} 

for i, v in pairs(Restaurants) do
  local Marker = createMarker(Restaurants[i][1],Restaurants[i][2],Restaurants[i][3],"corona",1,0,0,0,0)
  setElementInterior(Marker,Restaurants[i][4])
  setElementID(Marker,Restaurants[i][5])
end


local RestauraMeta = {
    ["PizzIn"]={Restaura = {5,372.20,-132.10,1001.5}},
    ["PizzOut"]={Restaura = {0,2104,-1806.5,13.60}},
    ["CluckinIn"]={Restaura = {9,364.70,-9.3,1001.9}},
    ["CluckinOut"]={Restaura = {0,2421.19,-1508.90,24}},
    ["BurgerIn"]={Restaura = {10,364.60,-73.90,1001.5}},
    ["BurgerOut"]={Restaura = {0,813.59,-1616.30,13.60}}
}

addEventHandler("onMarkerHit",resourceRoot,function (hitElement)
    local ID = getElementID(source)
    if getMarkerType(source) == "corona" then
      local Restaura = RestauraMeta[ID].Restaura
      setElementInterior(hitElement,Restaura[1],Restaura[2],Restaura[3],Restaura[4])
    end
end)

-----------------------------علامة الاكل---------------------
local MarkerEat = {
  {372.70,-119,1000.55,5,"PizzEat1"},
  {376.70,-119,1000.55,5,"PizzEat2"},
  {368.10,-6.25,1000.9,9,"CluckinEat"},
  {376.5,-67.80,1000.60,10,"BurgerEat"}
} 
----------
for i, v in pairs(MarkerEat) do
  local Marker = createMarker(MarkerEat[i][1],MarkerEat[i][2],MarkerEat[i][3],"cylinder",1,255,0,0,100)
  setElementInterior(Marker,MarkerEat[i][4])
  setElementID(Marker,MarkerEat[i][5])
end


----------------------------عند دخول الماركر --------------------------

addEventHandler("onMarkerHit",resourceRoot,function (hitElement)
  local MarkerID = getElementID(source)
  outputChatBox(MarkerID)
  if getMarkerType(source) == "cylinder" then
    local int = getElementInterior(hitElement)
    local money = getPlayerMoney(hitElement)
    if money >= 10 and (int == 5 or int == 9 or int == 10) then
      triggerClientEvent("PlayerEatInRestaurant",hitElement,MarkerID)
      setPedWeaponSlot(hitElement,0)
      setElementHealth(hitElement,100)
      takePlayerMoney(hitElement,10)
    end
  end
end)
---------------------------------------------------------------