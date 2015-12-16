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
        local ent = client:GetEyeTrace().Entity

        client:ChatPrint( tostring( ent:GetPos() ) )
        devUtil.setClipboardText( client, tostring( ent:GetPos() ) )
      end
    },
    ["ang"] = {
      callback = function( client, ... )
        if not IsValid( client ) then return end

        local args = { ... }
        local ent = client:GetEyeTrace().Entity

        client:ChatPrint( tostring( ent:GetAngles() ) )
        devUtil.setClipboardText( client, tostring( ent:GetAngles() ) )
      end
    },
    ["del"] = {
      callback = function( client, ... )
        if not IsValid( client ) then return end

        local args = { ... }
        local ent = client:GetEyeTrace().Entity
        if ent:IsWorld() then client:ChatPrint( "You cannot delete the world." ) return end

        ent:Remove()
        client:ChatPrint( tostring( ent ) .. " removed." )
      end
    },
    ["col"] = {
      callback = function( client, ... )
        if not IsValid( client ) then return end
        local args = { ... }
        local ent = client:GetEyeTrace().Entity
        if ent:IsWorld() then client:ChatPrint( "You cannot delete the world." ) return end

        if devUtil.config.colors[ args[1] ] then
          ent:SetColor( devUtil.config.colors[ args[1] ] )
        elseif tonumber( args[1] ) and tonumber( args[2] ) and tonumber( args[3] ) then
          ent:SetColor( Color( args[1], args[2], args[3], ( args[4] or 255 ) ) )

          if args[4] then
            ent:SetRenderMode( RENDERMODE_TRANSALPHA )
          end
        end
      end
    },
    ["open"] = {
      callback = function( client, ... )
        if not IsValid( client ) then return end

        local args = { ... }
        local ent = client:GetEyeTrace().Entity
        if ent:IsWorld() then client:ChatPrint( "You cannot fire the world." ) return end

        ent:Fire( "unlock" )
        ent:Fire( "open" )
      end
    },
  }
})

devUtil.addChatCommand( "npc", {
  access = function( client ) return client:IsSuperAdmin() end,
  callback = function( client, ... )
      if not IsValid( client ) then return end

      local args = { ... }
      local target = tonumber( args[1] ) and Player( tonumber( args[1] ) ) or client

      target:ChatPrint( tostring( target:GetEyeTrace().Entity:IsNPC() ) )
  end,

  subCommands = {
    ["create"] = {
      callback = function( client, ... )
        if not IsValid( client ) then return end

        local args = { ... }
        local pos = client:GetEyeTrace().HitPos

        local ent = ents.Create( args[1] and tostring( args[1] ) or "npc_zombie" )
        ent:SetPos( pos )
        ent:Spawn()
      end
    },
  }
})
