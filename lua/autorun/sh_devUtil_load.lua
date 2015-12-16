devUtil = devUtil or {}

MsgC( Color(0,200,0), "\n" .. ( SERVER and "[Server] " or "[Client] " ) .. "[devUtil] Initialized\n" )
MsgC( Color(255,135,0), "\n" .. ( SERVER and "[Server] " or "[Client] " ) .. "[devUtil] Loading Files\n" )

function devUtil.Include( dir, typ )
	if ( !dir ) then return end
	dir = dir:lower( )
	if ( SERVER and ( typ == "SERVER" or dir:find( "sv_" ) ) ) then
		include( dir )

		typ = "SERVER"
	elseif ( typ == "CLIENT" or dir:find( "cl_" ) ) then
		if ( SERVER ) then
			AddCSLuaFile( dir )
		else
			include( dir )
		end

		typ = "CLIENT"
	elseif ( typ == "SHARED" or dir:find( "sh_" ) ) then
		AddCSLuaFile( dir )
		include( dir )
		typ = "SHARED"
	end
end

devUtil.Include( "devutil/sh_devUtil_config.lua" )

hook.Call( "devUtilInitialized" )

MsgC( Color(0, 200, 0), "\n" .. ( SERVER and "[Server] " or "[Client] " ) .. "[devUtil] Successfully Loaded\n" )
