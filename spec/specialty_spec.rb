require 'rspec'
require 'pg'
require 'doctor'
require 'specialty'

DB = PG.connect({:dbname => 'test_doctors_office'})

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM specialties *;")
    DB.exec("INSERT INTO specialties (specialty_name) VALUES ('Internist') RETURNING id;")
    DB.exec("INSERT INTO specialties (specialty_name) VALUES ('Gastroenterologist') RETURNING id;")
    DB.exec("INSERT INTO specialties (specialty_name) VALUES ('General Practitioner') RETURNING id;")
  end
end

describe("Specialty") do
  describe("#initialize") do
    it("will create a specialty object") do
      specialty1 = Specialty.new({:specialty_name => "Love Doctor", :id => nil, })
      expect(specialty1.specialty_name).to(eq("Love Doctor"))
    end
  end
  describe("#save") do
    it("adds a specialty to the array of saved Specialtys") do
      DB.exec("DELETE FROM specialties *;")
      test_doctor = Specialty.new({ :id => nil, :specialty_name => "DR. Pepper"})
      test_doctor.save()
      test_doctor2 = Specialty.new({:id => nil, :specialty_name => "DR. Pepper"})
      test_doctor2.save()
      expect(Specialty.all()).to(eq([test_doctor, test_doctor2]))
    end
  end

  describe("#==") do
    it("is the same specialty if it has the same name") do
      task1 = Specialty.new({:id => nil, :specialty_name => "DR. Pepper"})
      task2 = Specialty.new({:id => nil, :specialty_name => "DR. Pepper"})
      expect(task1).to(eq(task2))
    end
  end

  # describe("#find") do
  #   it("returns the specialty with the given name.") do
  #     Specialty.new({:id => nil, :specialty_name => "DR. Pepper"}).save
  #     expect(Specialty.find("DR. Pepper").name).to(eq("DR. Pepper"))
  #   end
  # end

end
