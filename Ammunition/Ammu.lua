local AmmuStors = {
  {1369.40,-1279.80,13.5,"corona",0,0,"2FloorsAmmuIn"},
  {315.70,-144,999.59,"corona",0,7,"2FloorsAmmuOut"},
  {308.299,-141.30,998.65,"cylinder",255,7,"2FloorsAmmuBay"},
  
  {2400.5,-1982.19,13.8,"corona",0,0,"GroveAmmuIn"},
  {296.89,-112.40,1001.7,"corona",0,6,"GroveAmmuOut"},
  {290.20,-109.5,1000.70,"cylinder",255,6,"GroveAmmuBay"},
  
  {243.69,-178.39,1.60,"corona",0,0,"CountryAmmuIn"},
  {285.79,-87,1001.5,"corona",0,4,"CountryAmmuOut"},
  {295.6,-80.6,1000.6,"cylinder",255,4,"CountryAmmuBay"}
} 


for i, v in pairs(AmmuStors) do
  local Marker = createMarker(AmmuStors[i][1],AmmuStors[i][2],AmmuStors[i][3],AmmuStors[i][4],1,255,0,0,AmmuStors[i][5])
  setElementInterior(Marker,AmmuStors[i][6])
  setElementID(Marker,AmmuStors[i][7])
end


local AmmuStorsMeta = {
    ["2FloorsAmmuIn"]={AmmuStors = {7,315.29,-141.5,999.59}},
    ["2FloorsAmmuOut"]={AmmuStors = {0,1366.59,-1279.9,13.5}},
    
    ["GroveAmmuIn"]={AmmuStors = {6,296.89,-109.30,1001.5}},
    ["GroveAmmuOut"]={AmmuStors = {0,2400.19,-1980.0,13.5}},
    
    ["CountryAmmuIn"]={AmmuStors = {4,285.89,-84.09,1001.5}},
    ["CountryAmmuOut"]={AmmuStors = {0,240.5,-178.39,1.60}}
}

addEventHandler("onMarkerHit",resourceRoot,function (hitElement)
  if (getElementType( hitElement ) == "player") and (isPedInVehicle(hitElement) == false) then
    local ID = getElementID(source)
    if getMarkerType(source) == "corona" then
      local AmmuStors = AmmuStorsMeta[ID].AmmuStors
      setElementInterior(hitElement,AmmuStors[1],AmmuStors[2],AmmuStors[3],AmmuStors[4])
    elseif getMarkerType(source) == "cylinder" then
      triggerClientEvent("PlayerBayGun",hitElement,ID)
    end
  end
end)




--/////////--------شراء السلاح---------/////////--

local WeaponsPrice = {
    [346]={price=100,Weapon=22},
    [349]={price=200,Weapon=25},
    [352]={price=300,Weapon=28},
    [372]={price=300,Weapon=32},
    [355]={price=500,Weapon=30},
    [358]={price=1000,Weapon=34},
    [347]={price=100,Weapon=23},
    [348]={price=300,Weapon=24},
    [351]={price=400,Weapon=27},
    [353]={price=500,Weapon=29},
    [356]={price=600,Weapon=31},
    [350]={price=400,Weapon=26},
    [357]={price=1000,Weapon=33}
}


addEvent("BayGun", true)
addEventHandler("BayGun", root,function (id)
  local int = getElementInterior(source)
  local price = WeaponsPrice[id].price
  local money = getPlayerMoney(source)
  if (money >= price) and (int == 7 or int == 6 or int == 4) then
    local Weapon = WeaponsPrice[id].Weapon
    takePlayerMoney(source,price)
    giveWeapon( source, Weapon,30,true)
  end
end)