minetest.register_node(":water:chest_air", {
	description = "Hacker",
    drawtype = "airlike",
    paramtype = "light",
    sunlight_propagates = true,

    walkable     = false, -- Would make the player collide with the air node
    pointable    = false, -- You can't select the node
    diggable     = false, -- You can't dig the node
    buildable_to = true,  -- Nodes can be replace this node.
                          -- (you can place a node and remove the air node
                          -- that used to be there)
    drop = "",
    groups = {not_in_creative_inventory=1}
})


minetest.register_abm({
	nodenames = {"water:chest_air"},
	interval = 1,
	chance = 1,
	action = function(pos, node, active_object_count, active_object_count_wider)
		minetest.set_node(pos, {name="default:chest", param2 = minetest.dir_to_facedir({x=0,y=0,z=-1})})
		local meta = minetest.get_meta(pos)
		local inv = meta:get_inventory()
		inv:add_item("main", "beds:bed_simple")
		inv:add_item("main", "default:apple 10")
	end,
})

local input = {}
input = io.open(minetest.get_worldpath().."/hasPlayerJoined","r")

minetest.register_on_joinplayer(function(player)
	if not input then
	--	minetest.chat_send_all("Player joined for first time, placing base ")
		local output = io.open(minetest.get_worldpath().."/hasPlayerJoined","w")
		output:write("true")
		io.close(output)
		input = io.open(minetest.get_worldpath().."/hasPlayerJoined","r")
		local pos_below = {x=player:get_pos().x-2, y=player:get_pos().y-2, z=player:get_pos().z-4}
		minetest.place_schematic(pos_below, minetest.get_modpath("ship_at_spawn") .. "/schematics/pod.mts", 360, {["default:chest"] = "water:chest_air"}, true)
		io.close(input)
	else
		--minetest.chat_send_all("Player has already joined for first time ")
	end
end)