require("pg")

class Creature

  attr_accessor :name, :species, :location, :homeworld

  def initialize(options)
    @id = options["id"].to_i if options["id"]
    @name = options["name"]
    @species = options["species"]
    @location = options["location"]
    @homeworld = options["homeworld"]
  end

  def save()
    db = PG.connect({
      dbname: "bounty_hunter",
      host: "localhost"
    })
    sql = "INSERT INTO bounty_hunters
      (name,
      species,
      location,
      homeworld)
     VALUES
      ($1, $2, $3, $4) RETURNING id"
      values = [@name, @species, @location, @homeworld]
    db.prepare("save", sql)
    @id = db.exec_prepared("save", values)[0]["id"].to_i #always use this line
    db.close()
  end

  def update()
    db = PG.connect({
      dbname: "bounty_hunter",
      host: "localhost"
    })
    sql = "UPDATE bounty_hunters
    SET (name, species, location, homeworld) = ($1, $2, $3, $4) WHERE id = $5"
    values =[@name, @species, @location, @homeworld, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close()
  end

  def Creature.all
    db = PG.connect ({
      dbname: "bounty_hunter",
      host: "localhost"})
    sql = "SELECT * FROM bounty_hunters"
    db.prepare("all", sql)
    creature_hashes = db.exec_prepared("all")
    db.close()
    creature = creature_hashes.map { |creature_hash| Creature.new(creature_hash) }
    return creature
  end

  def Creature.delete_all()
    db = PG.connect ({
      dbname: "bounty_hunter",
      host: "localhost"})
    sql = "DELETE FROM bounty_hunters"
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all")
    db.close()
  end

  def delete()
    db = PG.connect({
      dbname: "bounty_hunter",
      host: "localhost"
    })
    sql = "DELETE FROM bounty_hunters WHERE id = $1"
    db.prepare("delete", sql)
    db.exec_prepared("delete", [@id])
    db.close()
  end

def Creature.find_by_name(name)
  db = PG.connect({
    dbname: "bounty_hunter",
    host: "localhost"
  })
  sql = "SELECT name FROM bounty_hunters   WHERE name = $1"
  db.prepare("find_by_name", sql)
  db.exec_prepared("find_by_name", [name])
  db.close()
  creature = name
  return creature
end

def Creature.find_by_id(id)
  db = PG.connect({
    dbname: "bounty_hunter",
    host: "localhost"
  })
  sql = "SELECT name FROM bounty_hunters  WHERE id = $5"
  db.prepare("find_by_id", sql)
  db.exec_prepared("find_by_id", [id])
  db.close()
  creature = id
  return creature
end
end
