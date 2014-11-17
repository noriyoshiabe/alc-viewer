require 'uri'
require 'net/http'
require "rexml/document"

unless ARGV.empty?
  result = REXML::Document.new
  result << REXML::XMLDecl.new('1.0', 'UTF-8')
  items = result.add_element("items")

  Net::HTTP.version_1_2
  res = Net::HTTP.start('eow.alc.co.jp', 80) {|http|
    http.get("/eow/sg/?q=#{URI.escape(ARGV[0])}", {'User-Agent' => "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_9_5) AppleWebKit/600.1.17 (KHTML, like Gecko) Version/7.1 Safari/537.85.10"})
  }

  doc = REXML::Document.new(res.body)

  doc.elements.each('suggest/word') do |word|
    item = items.add_element("item")

    item.add_element("title").add_text(URI.unescape(word.text))
    item.add_element("arg").add_text(word.text)
  end

  result.write STDOUT
end
