--[[explanation


It looks like "frigo" is meant to make a spell go off. I decided to use TFS' attack system for the implementation.
I had to find the correct animation, which looks like eternal_winter in a smaller diamond shape.

This required some file setup in both tfs and otclient. I rewrote the spell combat from the script with
a new set of areas, which I wrote custom!

For a while I was confused as to why attack areas weren't working. As it turns out, my version just doesn't spawn multiple areas
for some reason. I'm not super happy but there's no reason why this wouldn't work, so I'm still submitting it :)
]]--
local areas = {
    {
        {0,0,0,1,0,0,0},
        {0,0,0,0,1,0,0},
        {0,0,0,0,0,1,0},
        {1,0,0,2,0,0,1},
        {0,0,0,0,0,1,0}
        
    },
    {
        {0,0,0,1,0,0,0},
        {0,0,0,0,1,0,0},
        {0,1,0,1,0,1,0},
        {1,0,0,2,0,0,1},
        {0,1,0,0,0,1,0},
        {0,0,1,0,1,0,0},
    },
    {
        {0,0,0,1,0,0,0},
        {0,0,1,0,1,0,0},
        {0,1,0,1,0,1,0},
        {1,0,1,2,1,0,1},
        {0,1,0,0,0,1,0},
        {0,0,1,0,1,0,0}
    },
    {
        
        {0,0,1,0,1,0,0},
        {0,1,0,1,0,0,0},
        {1,0,1,2,1,0,1},
        {0,1,0,0,0,0,0},
        {0,0,1,0,1,0,0}
        
    },
    {
        {0,0,1,0,1,0,0},
        {0,1,0,1,0,0,0},
        {1,0,1,2,1,0,1},
        {0,1,0,1,0,0,0},
        {0,0,1,0,1,0,0},
        {0,0,0,1,0,0,0}
    },
    {
        {0,0,1,0,1,0,0},
        {0,0,0,0,0,0,0},
        {1,0,1,2,1,0,1},
        {0,1,0,1,0,0,0},
        {0,0,1,0,1,0,0},
        {0,0,0,1,0,0,0}
    },
    {
        {0,0,0,1,0,0,0},
        {0,0,1,0,1,0,0},
        {0,0,0,0,0,1,0},
        {1,0,1,2,1,0,1},
        {0,0,0,1,0,1,0},
        {0,0,1,0,1,0,0},
        {0,0,0,1,0,0,0}
    },
    {
        {0,0,0,1,0,0,0},
        {0,0,1,0,1,0,0},
        {0,1,0,1,0,1,0},
        {1,0,1,2,1,0,1},
        {0,1,0,1,0,1,0},
        {0,0,1,0,1,0,0},
        {0,0,0,1,0,0,0}
    },
    {
        {0,0,0,1,0,0,0},
        {0,0,1,0,1,0,0},
        {0,1,0,1,0,1,0},
        {1,0,1,2,1,0,1},
        {0,1,0,1,0,1,0},
        {0,0,1,0,1,0,0}
    },
    {
        
        {0,0,1,0,1,0,0},
        {0,1,0,1,0,0,0},
        {1,0,1,2,1,0,1},
        {0,1,0,1,0,0,0},
        {0,0,1,0,1,0,0},
        {0,0,0,1,0,0,0}
    },
    {
        {0,0,1,0,1,0,0},
        {0,0,0,0,0,0,0},
        {1,0,1,2,1,0,1},
        {0,0,0,1,0,0,0},
        {0,0,1,0,1,0,0},
        {0,0,0,1,0,0,0}
    },
    {
        {0,0,0,1,0,0,0},
        {0,0,1,0,1,0,0},
        {0,0,0,0,0,1,0},
        {1,0,1,2,1,0,1},
        {0,0,0,1,0,1,0},
        {0,0,1,0,1,0,0},
        {0,0,0,1,0,0,0}
    },
    {
        {0,0,0,1,0,0,0},
        {0,0,1,0,1,0,0},
        {0,1,0,1,0,1,0},
        {1,0,1,2,1,0,1},
        {0,1,0,1,0,1,0},
        {0,0,1,0,1,0,0},
        {0,0,0,1,0,0,0}
    },
    {
        {0,0,0,1,0,0,0},
        {0,0,1,0,1,0,0},
        {0,1,0,1,0,1,0},
        {1,0,1,2,1,0,1},
        {0,1,0,0,0,1,0},
        {0,0,1,0,1,0,0}
        
    },
    {
       
        {0,0,1,0,1,0,0},
        {0,1,0,1,0,0,0},
        {1,0,1,2,1,0,1},
        {0,1,0,0,0,0,0},
        {0,0,1,0,1,0,0}
       
    },
    {{0,0,1,0,1,0,0},
        {0,1,0,1,0,0,0},
        {1,0,1,2,1,0,1},
        {0,1,0,1,0,0,0},
        {0,0,1,0,1,0,0},
        {0,0,0,1,0,0,0}},

    {   {0,0,1,0,1,0,0},
        {0,0,0,0,0,0,0},
        {1,0,1,2,1,0,1},
        {0,0,0,1,0,0,0},
        {0,0,1,0,1,0,0},
        {0,0,0,1,0,0,0}},

    {{0,0,1,0,1,0,0},
    {0,0,0,0,0,0,0},
    {0,0,1,2,1,0,0},
    {0,0,0,1,0,0,0},
    {0,0,1,0,1,0,0},
    {0,0,0,1,0,0,0}}
}


local combats = {}

for i = 1, #areas do
combats[i] = Combat()
combats[i]:setParameter(COMBAT_PARAM_EFFECT, CONST_ME_ICETORNADO)
combats[i]:setArea(createCombatArea(AREA_CIRCLE3X3))
--area[i] goes there instead of AREA_CIRCLE3X3

function onGetFormulaValues(player, level, magicLevel)
	local min = (level / 5) + (magicLevel * 5.5) + 25
	local max = (level / 5) + (magicLevel * 11) + 50
	return -min, -max
end

combats[i]:setCallback(CALLBACK_PARAM_LEVELMAGICVALUE, "onGetFormulaValues")
end


local function castSpell(creatureId, variant, i)
    print(i)
    combats[i]:execute(Creature(creatureId), variant)
    
end
 
function onCastSpell(creature, variant)
    for i = 2, #areas do
        addEvent(castSpell, 300 * i, creature:getId(), variant, i)
    end
    return combats[1]:execute(creature, variant)
end
