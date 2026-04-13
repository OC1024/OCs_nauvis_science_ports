if not data.raw["item-subgroup"]["science-pack-alternative"] then
  if mods["science-tab"] then
    data:extend({
      {
        type = "item-subgroup",
        name = "science-pack-alternative",
        group = "science",
        order = "yb",
      }
    })
  else
    data:extend({
      {
        type = "item-subgroup",
        name = "science-pack-alternative",
        group = "intermediate-products",
        order = "yb",
      },
    })
  end
end