--This mod is licensed under CC BY-SA

instabuild = {}

--Item Registering

local instabuild_list = {
    { "Small Hut Kit", "small_hut"},
    { "Large Hut Kit", "large_hut"},
    { "Small House Kit", "small_house"},
    { "Large House Kit", "large_house"},
    { "Small Warehouse Kit", "small_warehouse"},
    { "Large Warehouse Kit", "large_warehouse"},
    { "Small Farm Kit", "small_farm"},
    { "Large Farm Kit", "large_farm"},
    { "Short Tower Kit", "short_tower"},
    { "Tall Tower Kit", "tall_tower"},
	{ "Factory Kit", "factory"},
	{ "Modern House Kit", "modern_house"},
	{ "Mansion Kit", "mansion"},
	
}

for i in ipairs(instabuild_list) do
    local builddesc = instabuild_list[i][1]
    local build = instabuild_list[i][2]

    minetest.register_craftitem("instabuild:"..build, {
        description = builddesc,
        inventory_image = build..".png",
        on_place = function(itemstack, placer, pointed_thing)
            if pointed_thing.above then
                local file = io.open(minetest.get_modpath("instabuild").."/models/"..build..".we")
                local value = file:read("*a")
                file:close()
                local p = pointed_thing.above
                p.x = p.x - 5
                p.z = p.z - 2
                local count = worldedit.deserialize(pointed_thing.above, value)
                itemstack:take_item()
            end
            return itemstack
        end,
    })
end

minetest.register_node("instabuild:glass_panel",{
	drawtype="nodebox",
	description= "Glass Panel",
	paramtype = "light",
	paramtype2 = "facedir",
	walkable = false,
	sunlight_propagates = true,
	tiles = { 'default_glass.png' },
	node_box = {
		type = "fixed",
		fixed = {
			{-0.500000,-0.500000,0.000000,0.500000,0.500000,0.500000},
		},
	},
	groups={oddly_breakable_by_hand=3},
})

minetest.register_node("instabuild:glass_roof",{
	drawtype="nodebox",
	description= "Glass Roof",
	paramtype = "light",
	paramtype2 = "facedir",
	sunlight_propagates = true,
	tiles = { "default_glass.png" },
	node_box = {
		type = "fixed",
		fixed = {
			{-0.500000,-0.500000,-0.500000,-0.125000,-0.125000,0.500000}, 
			{0.125000,0.125000,-0.500000,0.500000,0.500000,0.500000},
			{-0.187500,-0.187500,-0.500000,0.187500,0.187500,0.500000},
		},
	},
	groups={oddly_breakable_by_hand=3},
})

minetest.register_node("instabuild:light",{
	drawtype="nodebox",
	description= "Strip Light",
	light_source = 14,
	tiles = { 'default_wood.png',
	          'default_cloud.png',
			  'default_wood.png',
			  'default_wood.png',
			  'default_wood.png',
			  'default_wood.png' },
	paramtype2 = "facedir",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.500000,0.250000,-0.250000,0.500000,0.407216,0.250000},
			{-0.500000,0.312500,-0.062500,0.500000,0.500000,0.062500}, 
		},
	},
	groups={oddly_breakable_by_hand=3},
})

minetest.register_node("instabuild:catwalk",{
	drawtype="nodebox",
	description= "Catwalk",
	paramtype = "light",
	paramtype2 = "facedir",
	tiles = { 'catwalk.png',
	          'catwalk.png',
			  'default_steel_block.png',
			  'default_steel_block.png',
			  'default_steel_block.png',
			  'default_steel_block.png', },
	node_box = {
		type = "fixed",
		fixed = {
			{-0.500000,-0.500000,-0.500000,0.500000,-0.375000,0.500000}, --NodeBox 1
			{-0.500000,-0.500000,-0.062500,-0.437500,0.500000,0.062500}, --NodeBox 2
			{0.443299,-0.500000,-0.062500,0.500000,0.500000,0.062500}, --NodeBox 3
			{0.443299,0.448454,-0.500000,0.500000,0.500000,0.500000}, --NodeBox 4
			{-0.500000,0.448454,-0.500000,-0.437500,0.500000,0.500000}, --NodeBox 5
		},
	},
	groups={oddly_breakable_by_hand=3},
})

minetest.register_node("instabuild:corner",{
	drawtype="nodebox",
	description= "House Corner",
	paramtype = "light",
	sunlight_propagates = true,
	tiles = { 'house_corner.png' },
	groups={oddly_breakable_by_hand=1},
})

minetest.register_node("instabuild:flame", {
	description = "Fake Fire",
	drawtype = "plantlike",
	tiles = {{
		name="fire_basic_flame_animated.png",
		animation={type="vertical_frames", aspect_w=16, aspect_h=16, length=1},
	}},
	inventory_image = "fire_basic_flame.png",
	light_source = 14,
	groups = {dig_immediate=3},
	drop = '',
	walkable = false,
	buildable_to = true,
})

--Item Crafting

minetest.register_craft({
	output = 'instabuild:small_hut 1',
	recipe = {
		{'default:tree', 'default:mese_crystal_fragment','default:tree'},
		{'default:tree', 'doors:door_wood','default:tree'},
		{'default:tree', 'default:wood','default:tree'},

	}
})

minetest.register_craft({
	output = 'instabuild:large_hut 1',
	recipe = {
		{'default:tree', 'default:mese_crystal_fragment','default:tree'},
		{'default:tree', 'instabuild:small_hut','default:tree'},
		{'default:tree', 'default:wood','default:tree'},

	}
})

minetest.register_craft({
	output = 'instabuild:small_house 1',
	recipe = {
		{'default:brick', 'default:mese_crystal_fragment','default:brick'},
		{'default:brick', 'instabuild:large_hut','default:brick'},
		{'default:brick', 'default:brick','default:brick'},

	}
})

minetest.register_craft({
	output = 'instabuild:large_house 1',
	recipe = {
		{'default:brick', 'default:mese_crystal','default:brick'},
		{'default:brick', 'instabuild:small_house','default:brick'},
		{'default:brick', 'default:brick','default:brick'},

	}
})

minetest.register_craft({
	output = 'instabuild:small_warehouse 1',
	recipe = {
		{'default:wood', 'default:mese_crystal_fragment','default:wood'},
		{'default:wood', 'default:chest','default:wood'},
		{'default:wood', 'default:wood','default:wood'},

	}
})

minetest.register_craft({
	output = 'instabuild:large_warehouse 1',
	recipe = {
		{'default:wood', 'default:mese_crystal','default:wood'},
		{'default:wood', 'instabuild:small_warehouse','default:wood'},
		{'default:wood', 'default:wood','default:wood'},

	}
})

minetest.register_craft({
	output = 'instabuild:small_farm 1',
	recipe = {
		{'default:papyrus', 'default:mese_crystal_fragment','default:papyrus'},
		{'default:sapling', 'default:dirt','default:sapling'},
		{'default:papyrus', 'default:cactus','default:papyrus'},

	}
})

minetest.register_craft({
	output = 'instabuild:large_farm 1',
	recipe = {
		{'default:papyrus', 'default:mese_crystal_fragment','default:papyrus'},
		{'default:sapling', 'instabuild:small_farm','default:sapling'},
		{'default:papyrus', 'default:cactus','default:papyrus'},

	}
})

minetest.register_craft({
	output = 'instabuild:short_tower 1',
	recipe = {
		{'default:cobble', 'default:mese_crystal_fragment','default:cobble'},
		{'default:cobble', 'default:cobble','default:cobble'},
		{'default:cobble', 'doors:door_wood','default:cobble'},

	}
})

minetest.register_craft({
	output = 'instabuild:tall_tower 1',
	recipe = {
		{'default:cobble', 'default:mese_crystal','default:cobble'},
		{'default:cobble', 'instabuild:short_tower','default:cobble'},
		{'default:cobble', 'default:cobble','default:cobble'},

	}
})

minetest.register_craft({
	output = 'instabuild:factory 1',
	recipe = {
		{'default:glass', 'default:mese_crystal','default:glass'},
		{'default:steel_ingot', 'default:torch','default:steel_ingot'},
		{'default:brick', 'doors:door_wood','default:brick'},

	}
})

minetest.register_craft({
	output = 'instabuild:modern_house 1',
	recipe = {
		{'default:stonebrick', 'default:stonebrick','default:stonebrick'},
		{'default:stonebrick', 'default:mese_crystal','default:stonebrick'},
		{'doors:door_wood', 'default:stonebrick','default:stonebrick'},

	}
})

minetest.register_craft({
	output = 'instabuild:mansion 1',
	recipe = {
		{'stairs:stair_wood', 'default:wood','stairs:stair_wood'},
		{'default:sand', 'default:mese','default:sand'},
		{'default:wood', 'doors:door_wood','default:wood'},

	}
})