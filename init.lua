AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include("shared.lua")
util.AddNetworkString("jailerpanel_open")
util.AddNetworkString("ArrestButton_Press")



function ENT:Initialize()
    
    self:SetModel("models/lt_c/holo_wall_unit.mdl")
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_VPHYSICS)
    self:SetUseType(SIMPLE_USE)
    local phys = self:GetPhysicsObject()

    if phys:IsValid() then
         
        phys:Wake()
        
    end
    
end
function ENT:Use(a, c)
     net.Start("jailerpanel_open") 
     net.Send(c)     
end

net.Receive("ArrestButton_Press",function(len, sender)
    
    if not sender:IsAdmin() then return end
    
    local jailPanel = nil
    for k, ent in ipairs(ents.FindInSphere(sender:GetPos(), 200)) do
        if not IsValid(ent) then continue end
        if ent:GetClass() ~= "jailersystem" then continue end
        jailPanel = ent
        print("Jailer tings ")
        break
        
    end
    if not IsValid(jailPanel) then return end
    local target = nil
    for k, ply in ipairs(ents.FindInSphere(jailPanel:GetPos(), 400)) do
        if not IsValid(ply) then continue end
        if not ply:IsPlayer() then continue end
        print("ply tings ")
        local cuffed, cuffs = ply:IsHandcuffed()
        if not (cuffed and IsValid(cuffs)) then continue end
        cuffs:GetKidnapper() -- Returns the player who is dragging the cuffed player, or nil if nobody is dragging 
        print("player for loop ")
        target = ply
        break
    end
    
    local ply = net.ReadEntity()
    local arrestTimes = net.ReadInt(32)
    target:arrest(arrestTimes*60)
    print("SS button works")
end)