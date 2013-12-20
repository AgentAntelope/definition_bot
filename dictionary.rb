class Dictionary

  DICTIONARY_ARRAY = []

  def self.array
  return DICTIONARY_ARRAY if DICTIONARY_ARRAY.size > 1000
    dictionary = File.open('dictionary_file')
    dictionary.each_line do |line|
      h = {}
      match = line.match(/(?<word>[\w\- ]+)(?<definition> \w+\..*)/)
      h[match[:word]] = match[:definition]
      DICTIONARY_ARRAY << h
    end
    DICTIONARY_ARRAY
  end
end

