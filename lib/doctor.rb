class Doctor
  attr_reader :name, :id, :specialty_id
  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
    @specialty_id = attributes.fetch(:specialty_id)
  end

  def save
    result = DB.exec("INSERT INTO doctors (name) VALUES ('#{@name}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  def self.all
    returned_doctors = DB.exec("SELECT * FROM doctors;")
    doctors = []
    returned_doctors.each() do |doctor|
      name = doctor.fetch("name")
      id = doctor.fetch("id")
      specialty_id = doctor.fetch("specialty_id")
      doctors.push(Doctor.new({:name => name, :id => id.to_i, :specialty_id => specialty_id.to_i}))
    end
    doctors
  end

  def self.find(name)
    param_doctor = Doctor.new({:name => name, :id => nil, :specialty_id =>1})
    found_doctor = nil
    self.all.each do |doctor|
      if doctor.name == param_doctor.name
        found_doctor = doctor
      end
    end
    found_doctor
  end

  def ==(another_doc)
    self.name().==(another_doc.name()).&(self.id().==(another_doc.id()))
  end
end
