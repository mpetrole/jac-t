require 'coinbase/wallet'

puts "\e[H\e[2J"
puts "JAC-T, Just Another Coinbase Ticker \r"
bitprice = Hash.new  #the api pulls in hashes, so I need to make hashes
ethhash = Hash.new
client = Coinbase::Wallet::Client.new(api_key:"", api_secret:"")  #sets up a fake wallet to get values from the api
loop do
  print "Updating...    \r"
bithash = client.spot_price({currency_pair: 'BTC-USD'})  #this gets the bitcoin price converted to USD
bitprice = bithash
ethhash = client.exchange_rates({currency: 'ETH'})   #for some reason, the api doesn't support eth-usd, so I had to get janky. Basically, I pull in an array of hashes for eth prices and then get the currency that I want (USD)
ethprice = ethhash.rates
print "Bitcoin: #{bitprice.amount.to_f} Etherium: #{ethprice.USD.to_f}   \r"
sleep 60
end