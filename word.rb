require './dictionary'

class Word < String
  def initialize
    Dictionary.array[rand(Dictionary.array.size)].keys.first
  end
end

