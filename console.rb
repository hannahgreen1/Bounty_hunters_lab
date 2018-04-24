require("pry")
require_relative("models/creature")

Creature.delete_all()

creature1 = Creature.new({
"name" => "Fred",
"species" => "Unicorn",
"location" => "Forrest",
"homeworld" => "Scotland"
  })

creature1.save()

creature2 = Creature.new({
"name" => "Bill",
"species" => "Dragon",
"location" => "Cave",
"homeworld" => "Wales"
  })

creature2.save()

creature= Creature.all()

binding.pry

nil
