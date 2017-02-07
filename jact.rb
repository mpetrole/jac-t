require 'coinbase/wallet'

client = Coinbase::Wallet::Client.new(api_key:"", api_secret:"")

loop do
  print "Updating...   \r"
pricehash = client.spot_price({currency_pair: 'BTC-USD'})
price = Hash.new
price = pricehash

print "#{price.amount.to_f}    \r"
sleep 60
end