if SERVER then
    AddCSLuaFile()
end

SWEP.PrintName = "Pew Gun"
SWEP.Author = "You + Friend"
SWEP.Instructions = "Left click to pew"
SWEP.Spawnable = true

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"

function SWEP:PrimaryAttack()
    if SERVER then
        local ply = self:GetOwner()
        local tr = ply:GetEyeTrace()

        -- create fire effect
        local effect = EffectData()
        effect:SetOrigin(tr.HitPos)
        util.Effect("FireImpact", effect)

        -- actually ignite entity
        if IsValid(tr.Entity) then
            tr.Entity:Ignite(5, 0) -- 5 seconds
        end

        ply:EmitSound("ambient/fire/mtov_flame2.wav")
        self:SetNextPrimaryFire(CurTime() + 0.1)
    end
end
