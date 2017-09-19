class Specialty
  attr_reader :specialty_name, :id
  def initialize(attributes)
    @specialty_name = attributes.fetch(:specialty_name)
    @id = attributes.fetch(:id)
  end

  def save
    result = DB.exec("INSERT INTO specialties (specialty_name) VALUES ('#{@specialty_name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  def self.all
    returned_specialties = DB.exec("SELECT * FROM specialties;")
    specialties = []
    returned_specialties.each() do |specialty|
      specialty_name = specialty.fetch("specialty_name")
      id = specialty.fetch("id")
      specialties.push(Specialty.new({:specialty_name => specialty_name, :id => id.to_i}))
    end
    specialties
  end

  def ==(another_specialty)
    self.specialty_name().==(another_specialty.specialty_name()).&(self.id().==(another_specialty.id()))
  end
end
