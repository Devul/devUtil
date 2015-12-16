devUtil.commands = {}

function devUtil.addChatCommand( name, info )
  info.identifier = name

  devUtil.commands[ name ] = info
end

function devUtil.findCommand( cmd )
  for k,v in pairs( devUtil.commands ) do
    if string.find( cmd, k ) then
      return k
    end
  end
end

devUtil.addChatCommand( "trace", {
  args = "number userID (optional)",
  desc = "Returns the entity you are looking at (or the specified entity).",

  access = function( client ) return client:IsSuperAdmin() end,
  callback = function( client, ... )
      if not IsValid( client ) then return end

      local args = { ... }
      local target = tonumber( args[1] ) and Player( tonumber( args[1] ) ) or client

      target:ChatPrint( tostring( target:GetEyeTrace().Entity ) )
      devUtil.setClipboardText( target, tostring( target:GetEyeTrace().Entity ) )
  end,

  subCommands = {
    ["pos"] = {
      callback = function( client, ... )
        if not IsValid( client ) then return end

        local args = { ... }
        local target = tonumber( args[1] ) and Player( tonumber( args[1] ) ) or client

        target:ChatPrint( tostring( target:GetEyeTrace().Entity:GetPos() ) )
        devUtil.setClipboardText( target, tostring( target:GetEyeTrace().Entity:GetPos() ) )
      end,
    }
  }
})
