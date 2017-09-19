class Patient
  attr_reader :name, :id, :birth_date, :doctor_id
  def initialize(attributes)
    @name = attributes.fetch(:name)
    @id = attributes.fetch(:id)
    @birth_date = attributes.fetch(:birth_date)
    @doctor_id = attributes.fetch(:doctor_id)
  end

  def save
    result = DB.exec("INSERT INTO patients (name, birth_date, doctor_id) VALUES ('#{@name}', '#{@birth_date}', '#{@doctor_id}') RETURNING id;")
    @id = result.first().fetch("id").to_i()
  end

  def self.all
    returned_patients = DB.exec("SELECT * FROM patients;")
    patients = []
    returned_patients.each() do |patient|
      name = patient.fetch("name")
      id = patient.fetch("id")
      birth_date = patient.fetch("birth_date")
      doctor_id = patient.fetch("doctor_id")
      patients.push(Patient.new({:name => name, :id => id.to_i, :doctor_id => doctor_id.to_i, :birth_date => birth_date}))
    end
    patients
  end

  def self.find(name)
    found_patient = nil
    self.all.each do |patient|
      if patient.name == name
        found_patient = patient
      end
    end
    found_patient
  end

  def ==(another_patient)
    self.name().==(another_patient.name()).&(self.id().==(another_patient.id())) && self.birth_date == another_patient.birth_date
  end

  def find_doc
    doctor_data = DB.exec("SELECT * FROM doctors WHERE doctors.id =#{self.doctor_id};").first
    name = doctor_data.fetch("name")
    id = doctor_data.fetch("id")
    specialty_id = doctor_data.fetch("specialty_id")
    Doctor.new({:name => name, :id => id.to_i, :specialty_id => specialty_id.to_i})
  end
end
