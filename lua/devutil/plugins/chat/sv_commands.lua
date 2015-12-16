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
        local ent = target:GetEyeTrace().Entity

        target:ChatPrint( tostring( ent:GetPos() ) )
        devUtil.setClipboardText( target, tostring( ent:GetPos() ) )
      end
    },
    ["ang"] = {
      callback = function( client, ... )
        if not IsValid( client ) then return end

        local args = { ... }
        local target = tonumber( args[1] ) and Player( tonumber( args[1] ) ) or client
        local ent = target:GetEyeTrace().Entity

        target:ChatPrint( tostring( ent:GetAngles() ) )
        devUtil.setClipboardText( target, tostring( ent:GetAngles() ) )
      end
    },
    ["del"] = {
      callback = function( client, ... )
        if not IsValid( client ) then return end

        local args = { ... }
        local target = tonumber( args[1] ) and Player( tonumber( args[1] ) ) or client
        local ent = target:GetEyeTrace().Entity
        if ent:IsWorld() then target:ChatPrint( "You cannot delete the world." ) return end

        ent:Remove()
        target:ChatPrint( tostring( ent ) .. " removed." )
      end
    }
  }
})
