log("OCs Alt Sciences Techs are used for OCs Nauvis Science Ports")

local recipe_unlocks = {
    ["foundry-automation-science-pack"] = "foundry-science-packs-tech",
    ["foundry-logistic-science-pack"] = "foundry-science-packs-tech",
    ["foundry-military-science-pack"] = "foundry-science-packs-tech",
    ["biochamber-chemical-science-pack"] = "biochamber-science-packs-tech",
    ["biochamber-space-science-pack"] = "biochamber-science-packs-tech",
    ["emplant-production-science-pack"] = "emp-science-packs-tech",
    ["emplant-utility-science-pack"] = "emp-science-packs-tech",
}
oc_tech.add_recipe_unlocks(recipe_unlocks)

-- add nauvis-science-port recipes to the prod bonus techs
local recipe_tech_bonus = {
    ["foundry-automation-science-pack"] = "foundry-science-packs-productivity-tech",
    ["foundry-logistic-science-pack"] = "foundry-science-packs-productivity-tech",
    ["foundry-military-science-pack"] = "foundry-science-packs-productivity-tech",
    ["biochamber-chemical-science-pack"] = "biochamber-science-packs-productivity-tech",
    ["biochamber-space-science-pack"] = "biochamber-science-packs-productivity-tech",
    ["emplant-production-science-pack"] = "emp-science-packs-productivity-tech",
    ["emplant-utility-science-pack"] = "emp-science-packs-productivity-tech",
}
for recipe_name, techname in pairs(recipe_tech_bonus) do
    oc_tech.add_productivity_bonus(techname, recipe_name, 0.05) -- 5% bonus, same as the base science packs
end
