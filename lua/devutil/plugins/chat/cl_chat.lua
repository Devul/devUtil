net.Receive( "devUtil.sendNotification", function( len )
  local notification = net.ReadTable()

  chat.AddText( unpack( notification ) )
end)

net.Receive( "devUtil.setClipboardText", function( len )
  SetClipboardText( net.ReadString() or "" )
end )
