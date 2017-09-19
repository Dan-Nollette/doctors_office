class Specialty

  def initialize(attributes)
    @specialty = attributes.fetch(:specialty)
    @id = attributes.fetch(:id)
  end

end
