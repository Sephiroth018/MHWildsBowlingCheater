sdk.hook(sdk.find_type_definition("app.FacilityBowling"):get_method("getPinPoint(app.BowlingDef.PinType)"), function(args) end, function(retval) return sdk.to_ptr(sdk.to_int64(retval) * 10) end)
