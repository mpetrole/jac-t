require 'rubygems'
require 'bundler/setup'
require 'coinbase/wallet'


bitprice = Hash.new  #the api pulls in hashes, so I need to make hashes
ethhash = Hash.new
bithist = Array.new
ethhist = Array.new
hist = 1
client = Coinbase::Wallet::Client.new(api_key:"", api_secret:"")  #sets up a fake wallet to get values from the api
loop do
puts "\e[H\e[2J"
puts "JAC-T, Just Another Coinbase Ticker \r"
  print "Updating...            \r"
bithash = client.spot_price({currency_pair: 'BTC-USD'})  #this gets the bitcoin price converted to USD
bitprice = bithash.amount.to_f
ethhash = client.exchange_rates({currency: 'ETH'})   #for some reason, the api doesn't support eth-usd, so I had to get janky. Basically, I pull in an array of hashes for eth prices and then get the currency that I want (USD)
ethprice = ethhash.rates.USD.to_f
bithist[hist] = bitprice
ethhist[hist] = ethprice
bithist.delete(nil)
ethhist.delete(nil)
bitavg = bithist.inject(0.0) { |sum,el| sum + el } / bithist.size
ethavg = ethhist.inject(0.0) { |sum,el| sum + el } / ethhist.size
bitchng = bitprice - bitavg
ethchng = ethprice - ethavg
if hist > 4
  hist = 1
else
  hist += 1
end
print "Bitcoin: #{bitprice}(#{sprintf('%.2f', bitchng)}) Ethereum: #{ethprice}(#{sprintf('%.2f', ethchng)})      \r"
sleep 60
end