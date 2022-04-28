local Class = {
  __name="Class",
  _isclass = true
}
Class.mt = {}
setmetatable(Class, Class.mt)

function Class.mt:__call(name, super)
  local t = {
    __name = name,
    super = super or Class,
    _abstract = false,
    __index = Class.mt.__index,
    _isclass = true,
  }
  setmetatable(t, Class.mt)
  return t
end

function Class.mt:__index(k)
  if not rawget(self, "_isclass") then
    return rawget(self, k) or rawget(self, "class")[k]
  end
  local p = self
  while p do
    if rawget(p, k) then return rawget(p, k) end
    if p ~= Class then
      p = p.super
    else
      break
    end
  end
end

function Class.mt:__tostring()
  if self._isclass then
    return self.__name
  end
  return ("%s: %p"):format(self.__name, self)
end

function Class:abstract(...)
  local t = self(...)
  t._abstract = true
  return t
end

function Class:extend(name, abstract)
  local abstract = abstract
  if abstract == nil then abstract = self._abstract end
  return abstract and self:abstract(name, self) or self(name, self)
end

function Class:init(...)

end

function Class:new(...)
  if self._abstract then
    error(tostring(self) .. " is abstract")
  end
  local t = { class=self }
  setmetatable(t, self)
  t:init(...)
  return t
end

return Class
