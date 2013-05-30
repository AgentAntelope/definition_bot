require './dictionary'
require './word'
require './definition'

class Tweet

  attr_accessor :message, :word, :definition

  def initialize
    self.word = Word.new
    self.definition = Definition.new
    compose
    puts message
  end
  
  def compose
  message = " " * 141
    while message.length > 140
      message = word + Definition.new
      self.message = message
    end
  end
end

