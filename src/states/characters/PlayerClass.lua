PlayerClass = Class{}

function PlayerClass:init(def, subclass)
    self.class = def.class
    self.hit_dice = def.hit_dice
    self.hitpoints_firstlevel = def.hitpoints_firstlevel
    self.spellMod = def.spellMod

    self.subclass = def.subclasses[subclass]
end

function PlayerClass:CalculateSpellAttack(prof, mod)
    return prof + mod
end

function PlayerClass:CalculateSpellSave(prof, mod)
    return 8 + prof + mod
end