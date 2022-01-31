require "nokogiri"
require "httparty"
require "byebug"

def scrapper
  url = "http://www.weirdshityoucanbuy.com/"
  raw_page = HTTParty.get(url)
  parsed_page = Nokogiri::HTML(raw_page)
  shatty_items = Array.new
  items = parsed_page.css('tbody.wsite-multicol-tbody')  
  page = 1
  last_page = 9
  while page <= last_page
  	new_url = "http://www.weirdshityoucanbuy.com/#{page}.html"
  	paginated_raw_page = HTTParty.get(new_url)
    paginated_parsed_page = Nokogiri::HTML(paginated_raw_page)
    paginated_items = paginated_parsed_page.css('tbody.wsite-multicol-tbody')  
    paginated_items.each do |item|
  	  item = {
  		  name: item.css('h2.wsite-content-title').text
  	  }
  	  shatty_items << item
    end
    page += 1
  end

  shatty_items.each do |item|
  	puts item[:name]
  end
end

scrapper