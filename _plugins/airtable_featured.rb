require 'json'
require 'airtable'
require 'active_support/all'
# require 'active_support/all'

# Pass in api key to client
@client = Airtable::Client.new(ENV['AIRTABLE_API'])

# Pass in the app key and table name

@table = @client.table(ENV['AIRTABLE_TABLE'], "Tweets")
#@records = @table.records()
@records = @table.records(:filterByFormula => "AND(include, featured)", :sort => ["created_at", :desc])

# Change the filename here below but make sure it's in the _data folder.
File.open("_data/twitter/featured.json", "w") do |f|
    data = @records.map { |record| record.attributes }
    f.write(data.to_json)
end
