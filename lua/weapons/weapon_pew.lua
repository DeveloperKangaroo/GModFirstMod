if SERVER then AddCSLuaFile() end

SWEP.PrintName = "Debug Gun"
SWEP.Author = "Chaos Crew"
SWEP.Instructions = "Left click for LOL"
SWEP.Category = "My Cool Weapons"

SWEP.Spawnable = true
SWEP.Base = "weapon_base"

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"

function SWEP:PrimaryAttack()
    if SERVER then
        local ply = self:GetOwner()
        ply:ChatPrint("You fired the Debug Gun!")
        ply:EmitSound("ambient/alarms/klaxon1.wav")
    end
end
