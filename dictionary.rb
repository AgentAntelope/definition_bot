class Dictionary

  DICTIONARY_ARRAY = []
  
  def self.array
  return DICTIONARY_ARRAY if DICTIONARY_ARRAY.size > 1000
    dictionary = File.open('dictionary_file')
    dictionary.each_line do |line|
      h = {}
      captures = line.match(/(\w+)( \w+\. .*+)/).captures
      h[captures.first] = captures.last
      DICTIONARY_ARRAY << h
    end
    DICTIONARY_ARRAY
  end
end

