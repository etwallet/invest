/**
 *  @file
 *  @copyright defined in eos/LICENSE.txt
 */
#pragma once

#include <eosiolib/asset.hpp>
#include <eosiolib/eosio.hpp>
#include <eosiolib/time.hpp>

#include <string>

namespace eosiosystem {
   class system_contract;
}

namespace eosinvest {
    using namespace eosio;
   using std::string;

   class invest : public contract {
      public:
       invest( account_name self ):contract(self){}

       void create(uint64_t start_time, uint64_t days, asset max_quant);

       void deposit(account_name to, asset quantity, string memo);

       void claim(account_name account);

      private:
       struct investinfo {
           uint64_t id;
            time_point_sec start;
            uint64_t expire_days;
            asset max;
            asset total_amount;
            std::map<account_name, asset>account_asset;

            uint64_t primary_key()const { return id; }
       };
       typedef eosio::multi_index<N(investinfos), investinfo> investinfos;

   };

} /// namespace eosio
