require "nokogiri"
require "open-uri"


doc = Nokogiri::HTML(open("http://w2mem.com/words/en/1/"))
doc.xpath('//div[starts-with(@id, "row")]').first(50).
  each{ |row| Card.create(  original_text: row.at("input[type='search']")["value"], 
                            translated_text:row.at("input[type='text']")["value"] ) }
