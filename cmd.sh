
sh /home/root1/work/eos-resouce/wallet.sh

eosiocpp -o /home/root1/work/eos/contracts/invest/invest.wast  /home/root1/work/eos/contracts/invest/invest.cpp 
eosiocpp -g /home/root1/work/eos/contracts/invest/invest.api  /home/root1/work/eos/contracts/invest/invest.cpp

cleos  --wallet-url http://127.0.0.1:6666 --url http://localhost:8000 set contract  invest /home/root1/work/eos/contracts/invest -p  invest

cleos --wallet-url http://localhost:6666  wallet unlock --password=PW5KY1uq5mBaJRizwHhPAYp1w71yXRgAT322gKR6Yh7Uwx4BymBai

cleos --wallet-url http://localhost:6666  wallet import  --private-key 5KDsFepEAS7hEpnkRVFk7NQiX7gxCTVvUVTTVvi84XSkuNKRaVh

#cleos --wallet-url http://localhost:6666 --url http://localhost:8000 create account eosio eosio.token EOS7nnGJ7Ra911dwR1rQFw2MD2M8RkRPzUBtYb3qBmuYfaxbkUWmd EOS7nnGJ7Ra911dwR1rQFw2MD2M8RkRPzUBtYb3qBmuYfaxbkUWmd

#cleos --wallet-url http://localhost:6666 --url http://localhost:8000 set contract eosio.token /home/root1/work/eos/build/contracts/eosio.token -p eosio.token

#cleos --wallet-url http://localhost:6666 --url http://localhost:8000 push action eosio.token create '["eosio", "1000000.0000 EOS", 0, 0, 0]' -p eosio.token

cleos  --wallet-url http://localhost:6666 --url http://localhost:8000 push action eosio.token issue '[ "eosio", "100000000.0000 EOS", "memo"]' -p eosio


cleos --wallet-url http://127.0.0.1:4444 wallet unlock --password=PW5HzA1Gbp8mCE4grJHnFsSTFWnoynhLLKjnsBHQsRSAdWcuaMmjD

#创建交易所合约账户 etbexchange5
#Private key: 5HrvtqXNEDSJyjqcoxr45Frgxatf2nMWcNtcV2NqW2zD4dctoWM
#Public key: EOS6D1nt1aYtWPbfm5qburgRZc8gHVY6pwAcu812U9CnYigJN1saA
cleos --wallet-url http://127.0.0.1:4444 wallet import  --private-key 5HrvtqXNEDSJyjqcoxr45Frgxatf2nMWcNtcV2NqW2zD4dctoWM

cleos  --wallet-url http://localhost:6666   --url http://localhost:8000 system newaccount --transfer eosio etbexchanger EOS6D1nt1aYtWPbfm5qburgRZc8gHVY6pwAcu812U9CnYigJN1saA --stake-net "1000.0000 EOS" --stake-cpu "1000.0000 EOS" --buy-ram "10000.0000 EOS"


cleos --wallet-url http://127.0.0.1:4444 wallet import  --private-key 5HxS1BExGpZkink9wxK9kfhiLsqqvGPwtuqqyCCGn2mCU9Gux2M
cleos  --wallet-url http://localhost:6666   --url http://localhost:8000 system newaccount --transfer eosio  etbexchange5 EOS7YAQTAALWQ6mRZCNchz3sGivmzzfrdmrY1EDat9jodXBwj6ShN --stake-net "1000.0000 EOS" --stake-cpu "1000.0000 EOS" --buy-ram "100.0000 EOS"





#创建交易所资金账户exchangeacc1,用来存放EOS和ETB代币
#Private key: 5HxS1BExGpZkink9wxK9kfhiLsqqvGPwtuqqyCCGn2mCU9Gux2M
#Public key: EOS7YAQTAALWQ6mRZCNchz3sGivmzzfrdmrY1EDat9jodXBwj6ShN
cleos --wallet-url http://127.0.0.1:4444 wallet import  --private-key 5HxS1BExGpZkink9wxK9kfhiLsqqvGPwtuqqyCCGn2mCU9Gux2M
cleos  --wallet-url http://localhost:6666   --url http://localhost:8000 system newaccount --transfer eosio gameone54321 EOS7YAQTAALWQ6mRZCNchz3sGivmzzfrdmrY1EDat9jodXBwj6ShN --stake-net "1000.0000 EOS" --stake-cpu "1000.0000 EOS" --buy-ram "100.0000 EOS"


#Private key: 5Jt1McNGg4YhATfRtuz6N6VVePY8srJTdP15vWNezqjofmDiku3
#Public key: EOS6HLK29n42rxDdrzFicu5gp2Xfgubwbe29Ue57Uux7APp8bsCtE
cleos --wallet-url http://127.0.0.1:4444 wallet import  --private-key 5Jt1McNGg4YhATfRtuz6N6VVePY8srJTdP15vWNezqjofmDiku3
cleos  --wallet-url http://localhost:6666   --url http://localhost:8000 system newaccount --transfer eosio  etbexchange5 EOS6HLK29n42rxDdrzFicu5gp2Xfgubwbe29Ue57Uux7APp8bsCtE --stake-net "1000.0000 EOS" --stake-cpu "1000.0000 EOS" --buy-ram "100.0000 EOS"



#移除etbissue1111权限
#cleos  --wallet-url http://127.0.0.1:4444 --url http://localhost:8000  set account permission etbissue1111 owner '{"threshold": 1,"keys": [],"accounts": [{"permission":{"actor":"etbico111111","permission":"eosio.code"},"weight":1}]}'  -p etbissue1111@owner

#cleos  --wallet-url http://127.0.0.1:4444  --url http://localhost:8000 set account permission etbissue1111 active '{"threshold": 1,"keys": [],"accounts": [{"permission":{"actor":"etbico111111","permission":"eosio.code"},"weight":1}]}' owner -p etbissue1111

#创建用户账户
cleos --wallet-url http://localhost:6666 --url http://localhost:8000  system newaccount --transfer eosio user11111111 EOS7nnGJ7Ra911dwR1rQFw2MD2M8RkRPzUBtYb3qBmuYfaxbkUWmd --stake-net "1000.0000 EOS" --stake-cpu "1000.0000 EOS" --buy-ram "100.0000 EOS"

#Private key: 5Jo6Ceomf55SomY3ywwUHVBXK5GzLZF3UCbAgXKP4fvVotLYP1E
#Public key: EOS7TbrWEfDYug9DTu3rERagB5f2kYVZrB9bS8VU9kwjT9DWH9s8B
cleos --wallet-url http://localhost:6666  wallet import  --private-key 5Jo6Ceomf55SomY3ywwUHVBXK5GzLZF3UCbAgXKP4fvVotLYP1E
cleos --wallet-url http://localhost:6666 --url http://localhost:8000  system newaccount --transfer eosio user22222222 EOS7TbrWEfDYug9DTu3rERagB5f2kYVZrB9bS8VU9kwjT9DWH9s8B --stake-net "1000.0000 EOS" --stake-cpu "1000.0000 EOS" --buy-ram "100.0000 EOS"


cleos --wallet-url http://localhost:6666 --url http://localhost:8000  system newaccount --transfer eosio invest EOS7TbrWEfDYug9DTu3rERagB5f2kYVZrB9bS8VU9kwjT9DWH9s8B --stake-net "1000.0000 EOS" --stake-cpu "1000.0000 EOS" --buy-ram "100.0000 EOS"



cleos  --wallet-url http://localhost:6666 --url http://localhost:8000 push action eosio.token issue '["user11111111", "100000000.0000 EOS", "memo"]' -p eosio
cleos  --wallet-url http://localhost:6666 --url http://localhost:8000 push action eosio.token issue '["user22222222", "100000000.0000 EOS", "memo"]' -p eosio


cleos  --wallet-url http://127.0.0.1:6666 --url http://localhost:8000 set contract  invest /home/root1/work/eos/contracts/invest -p  invest

cleos  --wallet-url http://localhost:6666 --url http://localhost:8000  set account permission  invest active '{"threshold": 1,"keys": [{"key": "EOS7TbrWEfDYug9DTu3rERagB5f2kYVZrB9bS8VU9kwjT9DWH9s8B","weight": 1}],"accounts": [{"permission":{"actor":"invest","permission":"eosio.code"},"weight":1}]}' owner -p  invest


cleos  --wallet-url http://127.0.0.1:6666  --url http://localhost:8000 push action  invest create '[1537498400, 1, "20000.0000 EOS"]' -p  invest

cleos  --wallet-url http://127.0.0.1:6666 --url http://localhost:8000 push action eosio.token transfer '["user11111111", "invest","10.0000 EOS","deposit:"]' -p user11111111

cleos  --wallet-url http://127.0.0.1:6666 --url http://localhost:8000 push action eosio.token transfer '["user22222222", "invest","10.0000 EOS","deposit:"]' -p user22222222

cleos  --wallet-url http://127.0.0.1:6666 --url http://localhost:8000 push action invest claim '["user11111111"]' -p user11111111


cleos --wallet-url http://127.0.0.1:4444 --url http://localhost:8000  get table invest invest investinfos

exit

cleos  --wallet-url http://127.0.0.1:6666 --url http://localhost:8000 push action eosio.token transfer '["invest", "user11111111","1.0000 EOS",""]' -p invest











