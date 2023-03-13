
local Timer
local Col = createColSphere(0,0,0,2)
local TXT

function dxDrawTextOnElement(TheElement,text,height,distance,R,G,B,alpha,size,font,...)
	local x, y, z = getElementPosition(TheElement)
	local x2, y2, z2 = getCameraMatrix()
	local distance = distance or 20
	local height = height or 1
  
		local sx, sy = getScreenFromWorldPosition(x, y, z+height)
		if(sx) and (sy) then
			local distanceBetweenPoints = getDistanceBetweenPoints3D(x, y, z, x2, y2, z2)
			if(distanceBetweenPoints < distance) then
				dxDrawText(text, sx+2, sy+2, sx, sy, tocolor(R or 255, G or 255, B or 255, alpha or 255), (size or 1)-(distanceBetweenPoints / distance), font or "arial", "center", "center")
			end
		end
end

addEventHandler('onClientResourceStart', resourceRoot,function()
  local txd1 = engineLoadTXD('tags_larifa.txd',true) 
  engineImportTXD(txd1, 1526) 
  local txd2 = engineLoadTXD('tags_laseville.txd',true)  
  engineImportTXD(txd2, 1528)
end)


function SprayUse()
    local slot = getPedWeaponSlot(localPlayer)
    if slot == 9 then
      Timer = setTimer(triggerServerEvent,3000,1,"StartTage",localPlayer)
    end
end
bindKey("mouse1", "down",SprayUse ) 


function SprayStopUse()
  local slot = getPedWeaponSlot(localPlayer)
  if slot == 9 and isTimer(Timer) then
    killTimer(Timer)
  end
end
bindKey("mouse1", "up",SprayStopUse ) 


addEvent("SprayCompleted", true)
addEventHandler("SprayCompleted", root,function()
    playSFX("genrl", 52, 18, false)
end)



addEvent("GivPlayerName", true)
addEventHandler("GivPlayerName", root,function(Name)
  TXT = Name
end)


addEventHandler("onClientColShapeHit",resourceRoot,function(hitElement)
  if (getElementType( hitElement ) == "player") and (isPedInVehicle(hitElement) == false) then
    local x,y,z = getElementPosition(source)
    setElementPosition(Col,x ,y,z)
  end
end)

addEventHandler("onClientRender", getRootElement(), 
function()
	dxDrawTextOnElement(Col, TXT, 1, 15, 255, 255, 255, 255, 1, "default-bold-small",false)
end)