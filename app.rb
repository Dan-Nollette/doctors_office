#!/usr/bin/ruby
require 'pg'
require('sinatra')
require('sinatra/reloader')
also_reload('lib/**/*.rb')
require('./lib/patient')
require('./lib/doctor')
require('./lib/specialty')
require 'pg'

DB = PG.connect({:dbname => 'doctors_office'})

get('/') do
  erb(:index)
end

get('/doctor') do
  @patients = Patient.all
  @doctors = Doctor.all
  @Specialties = Specialty.all
  erb(:doctor)
end
get('/patient') do
  @patients = Patient.all
  @doctors = Doctor.all
  @Specialties = Specialty.all
  erb(:patient)
end
get('/admin') do
  @patients = Patient.all
  @doctors = Doctor.all
  @Specialties = Specialty.all
  erb(:admin)
end

post('/patient/') do
  @name = params["patient_name"]
  @patient = Patient.find(@name)
  @doctor = @patient.find_doc
  erb(:patient_specifics)
end
