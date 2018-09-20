/**
 *  @file
 *  @copyright defined in eos/LICENSE.txt
 */

#include <eosio.token/eosio.token.hpp>
#include "invest.hpp"

namespace eosinvest {
//    const uint64_t day_time = 24 * 3600;     //每天的时间
    const uint64_t day_time = 60;     //每天的时间

    void invest::create(uint64_t start_time, uint64_t days, asset max_quant){
        require_auth(_self);

        investinfos _investinfos(_self, _self);

        eosio_assert(now() <= start_time, "start_time must be after now");
        eosio_assert(days >= 1, "days must be more than 1 day");
        eosio_assert(max_quant.symbol == S(4,EOS), "symbol must be EOS");
        eosio_assert(max_quant.amount > 0, "max_quant must be positive");

        auto itr = _investinfos.begin();
        if(itr != _investinfos.end()){
            _investinfos.erase(itr);
        }
        _investinfos.emplace( _self, [&]( auto& s ) {
            s.id = start_time;
            s.start = time_point_sec(start_time);
            s.expire_days = days;
            s.max = max_quant;
            s.total_amount = asset{0, S(4,EOS)};
        });
    }

    void invest::deposit(account_name to, asset quantity, string memo){

        eosio_assert(quantity.amount >= 100000, "quantity must be >= 10.0000 EOS");
        eosio_assert(quantity.amount % 10000 == 0, "quantity must be integer");
        eosio_assert(quantity.symbol == S(4, EOS), "symbol must be EOS");

        investinfos _investinfos(_self, _self);
        auto itr = _investinfos.begin();
        eosio_assert(itr != _investinfos.end(), "there is no invest");

        investinfo investinfo1 = *itr;
        eosio_assert(investinfo1.total_amount.amount + quantity.amount <= 200000000 , "quantity exceed 20000.0000 EOS ");
        eosio_assert(now() <= investinfo1.start.utc_seconds, "time has expired");
        investinfo1.total_amount += quantity;
        investinfo1.account_asset[to] += quantity;

        _investinfos.modify( itr, 0, [&]( auto& m ) {
            m = investinfo1;
        });
    }

    void invest::claim(account_name account){
        require_auth(account);

        investinfos _investinfos(_self, _self);
        auto itr = _investinfos.begin();
        eosio_assert(itr != _investinfos.end(), "there is no invest");

        investinfo investinfo1 = *itr;
        eosio_assert(now() >= investinfo1.start.utc_seconds + investinfo1.expire_days*day_time, "please come to claim afetr expire_days");

        if(investinfo1.account_asset[account].amount > 0){
            asset quant = investinfo1.account_asset[account];
            quant.amount *= 1.0125;
            action(
                    permission_level{ _self, N(active) },
                    N(eosio.token), N(transfer),
                    std::make_tuple(_self, account, quant, std::string("send EOS to account"))
            ).send();

            investinfo1.account_asset.erase(account);
            _investinfos.modify( itr, 0, [&]( auto& m ) {
                m = investinfo1;
            });
        }else{
            eosio_assert(false, "account not exists");
        }
    }

} /// namespace eosio

using namespace eosinvest;
#include <eosiolib/action.h>

extern "C" {

void apply( uint64_t receiver, uint64_t code, uint64_t action ) {
    print( "\ninvestapply,", name{receiver},"\n" );

    auto self = receiver;
    eosinvest::invest thiscontract( receiver );
    if( code == N(eosio.token) &&  action == N(transfer) ) {
        eosio::token::transfer_args tmp = unpack_action_data<eosio::token::transfer_args>();

        if(tmp.to != self){
            return;
        }

        string memo = tmp.memo;

        memo.erase(memo.begin(), find_if(memo.begin(), memo.end(), [](int ch) {
            return !isspace(ch);
        }));
        memo.erase(find_if(memo.rbegin(), memo.rend(), [](int ch) {
            return !isspace(ch);
        }).base(), memo.end());

        auto separator_pos = memo.find(' ');
        if (separator_pos == string::npos) {
            separator_pos = memo.find(':');
        }

        eosio_assert(separator_pos != string::npos, "Function name and other command must be separated with space or colon");

        string func_name_str = memo.substr(0, separator_pos);
        if(0 == func_name_str.compare("deposit")){
            thiscontract.deposit(tmp.from, tmp.quantity,tmp.memo);
        }else{
            eosio_assert(false,"memo must starts with deposit:");
        }

    }
    else if (code == self  || action == N(onerror) ){
        switch (action)
        {
            EOSIO_API( eosinvest::invest, (create)(claim))
        }
    }
}
}

//EOSIO_ABI( eosinvest::invest, (create)(issue)(transfer) )
