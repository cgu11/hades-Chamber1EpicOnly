--[[
    Chamber1EpicOnly v1.0
    Authors:
        cgull (Discord: cgull#4469)
    Makes the first boon reward offer only Epic rewards, in Chamber 1 only.
]]
ModUtil.RegisterMod("Chamber1EpicOnly")

local config = {
    Enabled = true
}
Chamber1EpicOnly.Config = config
Chamber1EpicOnly.EpicsGivenFlag = false
Chamber1EpicOnly.RarityOverride = {
    Rare = 0,
    Epic = 1.0,
    Heroic = 0,
    Legendary = 0,
}

ModUtil.WrapBaseFunction("SetTraitsOnLoot", function( baseFunc, loot )    
    if Chamber1EpicOnly.Config.Enabled and 
       not Chamber1EpicOnly.EpicsGivenFlag and
       loot.GodLoot and CurrentRun.RunDepthCache == 1.0 then

        Chamber1EpicOnly.EpicsGivenFlag = true 

        loot.OverriddenRarityChances = loot.RarityChances
        loot.RarityChances = Chamber1EpicOnly.RarityOverride
    elseif loot.OverriddenRarityChances then
        -- returning the original rarity chances without rolling again
        -- in the case of a reroll
        loot.RarityChances = loot.OverriddenRarityChances
    end
    baseFunc(loot)
end, Chamber1EpicOnly)