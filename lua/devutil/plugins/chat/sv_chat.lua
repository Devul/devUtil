function devUtil.addText( client, ... )
  if not IsValid( client ) then return end
  if not ... or not #{ ... } then return end

  net.Start( "devUtil.sendNotification" )
    net.WriteTable( { ... } )
  net.Send( client )
end

function devUtil.setClipboardText( client, text )
  if not IsValid( client ) or not text then return end

  net.Start( "devUtil.setClipboardText" )
    net.WriteString( tostring( text ) )
  net.Send( client )
end

local chatPrefix = devUtil.config.chatPrefix
function devUtil.playerSay( client, text )
  text = string.Explode( " ", text )

  local chatPrefixLen = string.len( chatPrefix )

  if string.sub( text[1], 1, chatPrefixLen ) ~= chatPrefix then return end
  local command = string.sub( text[1], chatPrefixLen + 1 )

  local subCommandPoint = string.find( text[1], ".", chatPrefixLen + 1 )
  if subCommandPoint and devUtil.findCommand( command ) then
    local commandData = devUtil.commands[ devUtil.findCommand( command ) ]
    local subCommand = string.Replace( command, commandData.identifier, "" ) -- Remove the base command from the string
    subCommand = string.Replace( subCommand, ".", "" ) -- Remove the separator ( for the sub command )

    local subCommandData = commandData.subCommands[ subCommand ]
    if subCommandData then
      text[1] = nil
      subCommandData.callback( client, unpack( text ) )

      return ""
    end
  end

  if devUtil.commands[ command ] then
    local commandData =  devUtil.commands[ command ]

    text[1] = nil
    commandData.callback( client, unpack( text ) )

    return ""
  end
end
hook.Add( "PlayerSay", "devUtil.playerSay", devUtil.playerSay )
