require_relative 'dictionary'

class Tweet

  attr_accessor :message
  attr_reader :word

  def initialize(word = nil)
    @word = word
    compose
  end

  def compose
  message = " " * 141
    while message.length > 140
      message = word + definition
      self.message = message
    end
  end

  def definition
    Dictionary.array[rand(Dictionary.array.size)].values.first
  end

  def word
    return @word if @word
    Dictionary.array[rand(Dictionary.array.size)].keys.first
  end
end

