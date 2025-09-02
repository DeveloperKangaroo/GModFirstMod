if SERVER then
    AddCSLuaFile()
end

SWEP.PrintName = "Pew Gun"
SWEP.Author = "Me"
SWEP.Instructions = "Left click to pew"
SWEP.Spawnable = true

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"

function SWEP:PrimaryAttack()
    if SERVER then
        local ply = self:GetOwner()
        local ent = ents.Create("prop_physics")
        if not IsValid(ent) then return end
        ent:SetModel("models/props_junk/PopCan01a.mdl")
        ent:SetPos(ply:GetShootPos() + ply:GetAimVector() * 50)
        ent:Spawn()
        local phys = ent:GetPhysicsObject()
        if IsValid(phys) then
            phys:ApplyForceCenter(ply:GetAimVector() * 1000)
        end
    end
end
