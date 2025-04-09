---@class Lazy
---@field private value? any
---@field private lazyFunction fun(): any
local Lazy = {}

---@param lazyFunction fun(): any
---@return Lazy
function Lazy.new(lazyFunction)
  ---@type Lazy
  local self = setmetatable({}, Lazy)
  self.lazyFunction = lazyFunction

  return self
end

---@return any
function Lazy:getValue()
  if not self.value then
    self.value = self.lazyFunction()
  end

  return self.value
end

return Lazy
