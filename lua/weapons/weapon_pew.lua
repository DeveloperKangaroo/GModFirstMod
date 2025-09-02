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

function SWEP:EmitFunnySound()
    local sounds = {
        "vo/npc/male01/yeah02.wav",
        "vo/npc/female01/help01.wav",
        "ambient/explosions/explode_9.wav"
    }
    self:GetOwner():EmitSound(table.Random(sounds))
end

function SWEP:PrimaryAttack()
    if SERVER then
        self:EmitFunnySound()
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

        -- BOOM on touch
        ent:AddCallback("PhysicsCollide", function(collider, data)
            local explosion = ents.Create("env_explosion")
            explosion:SetPos(collider:GetPos())
            explosion:SetOwner(ply)
            explosion:Spawn()
            explosion:SetKeyValue("iMagnitude", "100")
            explosion:Fire("Explode", 0, 0)
            collider:Remove()
        end)
    end
end

function SWEP:SecondaryAttack()
    if SERVER then
        local ply = self:GetOwner()
        ply:SetVelocity(Vector(0, 0, 500)) -- yeet upward
        ply:EmitSound("npc/strider/strider_skewer1.wav")
    end
end