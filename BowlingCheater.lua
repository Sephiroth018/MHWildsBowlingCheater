local SettingsManager = require("BowlingCheater.SettingsManager")
local Lazy = require("BowlingCheater.Lazy")

local LazySessionService = Lazy.new(function() return sdk.get_managed_singleton("app.NetworkManager"):get_SessionService() end)

---@param retval any
---@return any
local function modifyPinValue(retval)
  if SettingsManager.getCurrent().enabled and LazySessionService:getValue():getCurrentSession() == 0 then
    return sdk.to_ptr(sdk.to_int64(retval) * SettingsManager.getCurrent().modifier)
  else
    return retval
  end
end

sdk.hook(sdk.find_type_definition("app.FacilityBowling"):get_method("getPinPoint(app.BowlingDef.PinType)"), function(args) end, modifyPinValue)

re.on_draw_ui(function()
  if imgui.tree_node("BowlingCheater") then
    _, SettingsManager.getCurrent().enabled = imgui.checkbox("Enabled", SettingsManager.getCurrent().enabled)

    _, SettingsManager.getCurrent().modifier = imgui.slider_int("Modifier", SettingsManager.getCurrent().modifier, 1, 100)

    imgui.tree_pop()
  end
end)

re.on_config_save(function()
  SettingsManager.save()
end)
