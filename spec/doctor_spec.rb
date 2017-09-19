require 'rspec'
require 'pg'
require 'doctor'

DB = PG.connect({:dbname => 'test_doctors_office'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM doctors *;")
  end
end

describe("Doctor") do
  describe("#initialize") do
    it("will create a doctor object") do
      doc1 = Doctor.new({:name => "Patel", :id => nil, :specialty_id => 1})
      expect(doc1.name).to(eq("Patel"))
    end
  end
  describe("#save") do
    it("adds a Doctor to the array of saved Doctors") do
      test_doctor = Doctor.new({:name => "Patel", :id => nil, :specialty_id => 1})
      test_doctor.save()
      test_doctor2 = Doctor.new({:name => "Lucky", :id => nil, :specialty_id => 1})
      test_doctor2.save()
      expect(Doctor.all()).to(eq([test_doctor, test_doctor2]))
    end
  end

  describe("#==") do
    it("is the same doc if it has the same name") do
      task1 = Doctor.new({:name => "Patel", :id => nil, :specialty_id => 1})
      task2 = Doctor.new({:name => "Patel", :id => nil, :specialty_id => 1})
      expect(task1).to(eq(task2))
    end
  end

  describe("#find") do
    it("returns the doctor with the given name.") do
      Doctor.new({:name => "Lucky", :id => nil, :specialty_id => 1}).save
      expect(Doctor.find("Lucky").name).to(eq("Lucky"))
    end
  end

end
