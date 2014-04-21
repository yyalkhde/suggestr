require 'twitter'
require 'json'
require_relative 'credentials'

testArray = []

commonWords = [ "the", "be","to", "of", "and", "a", "in", "that", "have",
                "I", "it", "for", "not", "on", "with", "he", "as", "you",
                "do", "at", "this", "but", "his", "by", "from", "they",
                "we", "say", "her", "she", "or", "an", "will", "my",
                "one", "all", "would", "there", "their", "what", "so",
                "up", "out", "if", "about", "who", "get", "which", "go",
                "me", "when", "make", "can", "like", "time", "no", "just",
                "him", "know", "take", "people", "into", "year", "your",
                "good", "some", "could", "them", "see", "other", "than",
                "then", "now", "look", "only", "come", "its", "over",
                "think", "also", "back", "after", "use", "two", "how",
                "our", "work", "first", "well", "way", "even", "new",
                "want", "because", "any", "these", "give", "day", "most",
                "us"
              ];

client = Twitter::REST::Client.new(@config)
10.times do
  searchTerm = commonWords.sample
  9.times do
    searchTerm += " OR " + commonWords.sample
  end
  puts searchTerm
  searchResult = client.search(commonWords.sample,
                               {:lang  =>  'en'})
  searchResult.each do |tweet|
    testArray << tweet.attrs
  end
end

# might not be the best way to load JSON from file and add new results to exisiting results
previousArray = []
previousArray = JSON.parse(File.read("test.json"))

finalArray = testArray + previousArray

puts testArray.count
puts previousArray.count
puts finalArray.count

# overwrites last file
File.open("test.json", "w").write(JSON.pretty_generate(finalArray))
