require 'rspec'
require 'pg'
require 'patient'

DB = PG.connect({:dbname => 'test_doctors_office'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM patients *;")
  end
end
describe("Patient") do
  describe("#initialize") do
    it("will create a patient object") do
      doc1 = Patient.new({:name => "Davey Johnson", :id => nil, :doctor_id => 1, :birth_date => '1978-01-19 03:14:07'})
      expect(doc1.name).to(eq("Davey Johnson"))
    end
    it("will create a patient object") do
      doc1 = Patient.new({:name => "Davey Johnson", :id => nil, :doctor_id => 1, :birth_date => '1978-01-19 03:14:07'})
      expect(doc1.doctor_id).to(eq(1))
    end
  end

  describe("#save") do
    it("adds a Patient to the array of saved Patients") do
      test_patient = Patient.new({:name => "Davey Johnson", :id => nil, :doctor_id => 1, :birth_date => '1978-01-19 03:14:07'})
      test_patient.save()
      test_patient2 = Patient.new({:name => "Lucy Jones", :id => nil, :doctor_id => 1, :birth_date => '1990-01-19 03:14:07'})
      test_patient2.save()
      expect(Patient.all()).to(eq([test_patient, test_patient2]))
    end
  end

  describe("#find") do
    it("returns the patient with the given name.") do
      Patient.new({:name => "Lucky", :id => nil, :birth_date => '1990-01-19 03:14:07', :doctor_id => 1}).save
      expect(Patient.find("Lucky").name).to(eq("Lucky"))
    end
  end

  describe("#==") do
    it("is the same patient if it has the same name, doctor and birthdate") do
      task1 = Patient.new({:name => "Patel", :id => nil, :doctor_id => 1, :birth_date => '1990-01-19 03:14:07'})
      task2 = Patient.new({:name => "Patel", :id => nil, :doctor_id => 1, birth_date: '1990-01-19 03:14:07'})
      expect(task1).to(eq(task2))
    end
  end
end
