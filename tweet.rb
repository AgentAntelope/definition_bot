require_relative 'dictionary'

class Tweet

  attr_reader :message

  def initialize(word = "")
    @word = word.downcase unless (word.nil? || word.empty?)
    compose
  end

  def compose
  @message = " " * 141
    while @message.length > 140
      @message = word + definition
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
