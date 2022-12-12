ENT.Type = "anim"
ENT.Base = "base_gmodentity"
ENT.PrintName = "Jailer Panel"
ENT.Category = "[SWRP] Jailer System"

ENT.Spawnable = true 
RkhoraJailPanel = RkhoraJailPanel or {}
RkhoraJailPanel.MinorInfractions = {
    ["Loitering"] = 5,
    ["Theft"] = 10,
}
RkhoraJailPanel.ModerateInfractions = {
    ["Trespassing"] = 55,
    ["Resisting Arrest"] = 7,
    ["Assault"] = 5,
    ["Defective Behaviour"] = 10,
    ["Exessive Force"] = 5,
    ["Interfering with CG Activity"] = 5,
    ["Disregard of Company/Citizenry Safety"] = 10,
    ["Abuse of equipment"] = 5,
    ["Rioting"] = 10,
}
RkhoraJailPanel.MajorInfractions = {
    ["Conspiracy with members of criminal organizations"] = 10,
    ["Arson"] = 15,
    ["Insubordination"] = 10,
    ["Manslaughter"] = 10,
    ["Murder"] = 20,
    ["Attempted Murder"] = 15,
    ["Prison Break"] = 20,
    ["Possession Of Drugs"] = 5,
    ["Tampering"] = 5,
    ["Espionage"] = 20,
    ["Treason"] = 15,
    ["Rebellion"] = 15,
    ["Attempted arson"] = 10,
    ["Warcrime"] = 25,

}
tms = {
    [TEAM_CGENLISTED] = true,
}

