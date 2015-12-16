devUtil = devUtil or {}
devUtil.plugin = devUtil.plugin or { Lists = { } }

local function loadPlugins()
    local fol = "devutil/plugins/"

    local files, folders = file.Find(fol .. "*", "LUA")

    for _, folder in SortedPairs(folders, true) do
        if folder == "." or folder == ".." then continue end

        for _, File in SortedPairs(file.Find(fol .. folder .. "/sh_*.lua", "LUA"), true) do
            if SERVER then
                AddCSLuaFile(fol .. folder .. "/" .. File)
            end

            include(fol .. folder .. "/" .. File)
        end

        if SERVER then
            for _, File in SortedPairs(file.Find(fol .. folder .. "/sv_*.lua", "LUA"), true) do
                include(fol .. folder .. "/" .. File)
            end
        end

        for _, File in SortedPairs(file.Find(fol .. folder .. "/cl_*.lua", "LUA"), true) do
            if SERVER then
                AddCSLuaFile(fol .. folder .. "/" .. File)
            else
                include(fol .. folder .. "/" .. File)
            end
        end
    end
end

loadPlugins()
