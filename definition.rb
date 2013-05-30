require './dictionary'

class Definition < String
  def initialize
    Dictionary.array[rand(Dictionary.array.size)].values.first
  end
end
