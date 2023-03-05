

function MedUse()
 local slot = getPedWeaponSlot(source)
 if slot == 10 then
  takeWeapon(source,11)
  setElementHealth(source,100)
 end
end
addEvent("MedUse", true)
addEventHandler("MedUse", root, MedUse)