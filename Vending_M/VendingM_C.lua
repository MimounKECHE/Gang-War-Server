
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
  local Marker = createMarker(VendingSoda[k][1],VendingSoda[k][2],VendingSoda[k][3] - 1,"cylinder",0.5,255,0,0,100)
end
----
for k,v in pairs(HotDog)do
  local Marker = createMarker(HotDog[k][1],HotDog[k][2],HotDog[k][3] - 1,"cylinder",0.5,255,0,0,100)
end





local SellerPed = {
  {168,2229.5,-1742,13.60,0},
  {168,1589.69,-1286.09,17.5,180}
}

for k,v in pairs(SellerPed)do
  local Ped = createPed(SellerPed[k][1],SellerPed[k][2],SellerPed[k][3],SellerPed[k][4],SellerPed[k][5])
  setElementFrozen(Ped,true)
end

addEventHandler("onClientPedDamage",resourceRoot, function ()
    cancelEvent() 
end)

local function Control(sit)
  toggleControl("forwards",sit) 
  toggleControl("backwards",sit) 
  toggleControl("left",sit) 
  toggleControl("right",sit) 
end


addEvent("UseVendingM", true)
addEventHandler("UseVendingM", root,function(id)
  if id == "VendingSoda" then
    playSFX("script", 203, 0, false)
    setElementFrozen(localPlayer,true)
    Control(false)
    setTimer(setPedAnimation,200,1,localPlayer,"vending" ,"vend_use", -1, true, false, false, true,100)
    setTimer(setPedAnimation,2500,1,localPlayer,"vending" ,"vend_drink2_p", -1, true, false, false, true,100)
    setTimer(setPedAnimation,4500,1,localPlayer,nil ,nil , -1, true, false, false, true,100)
    setTimer(setElementFrozen,2000,1,localPlayer,false)
    setTimer(Control,2000,1,true)
  elseif id == "HotDog" then
    playSFX("script", 151, 0, false)
    setElementFrozen(localPlayer,true)
    Control(false)
    setTimer(setPedAnimation,200,1,localPlayer,"FOOD","EAT_Burger", -1, true, false, false, true,100)
    setTimer(setPedAnimation,3000,1,localPlayer,nil ,nil , -1, true, false, false, true,100)
    setTimer(setElementFrozen,3000,1,localPlayer,false)
    setTimer(Control,3000,1,true)
  end
end)