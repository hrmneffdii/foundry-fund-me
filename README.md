## Foundry Found Me Project

explanation

### 1. Features

### 2. Concepts

Here, i'm impelementing about some testing manually in directory `test`, there is many component function such as :

- setUp:
  This function automatically run first in testing. it create initial contract that would be checked after that.

-

### 3. Tips and Tricks

if you are in phase of development, you have to use local chain as much as possible to avoid alchemy node for connected on sepolia eth. is it possible to develop a contract that is need another contract in sepolia eth?, yaa it's imposible. well, to solve this problem, we need a mocks or we called it as fake contract and deploy it on anvil environment.

forge test -vvv --fork-url $RPC_URL , using test within alchemy env
forge coverage --fork-url $RPC_URL, using testing as well as analyzing the entire of code.
forge script script/DeployFundMe.s.sol --rpc-url $RPC_URL_ANVIL --private-key $PRIVATE_KEY --broadcast, using command script to deploy onchain through RPC_URL, if we don't include rpc as well as private key, we actually do at local chain in anvil. don't use the env with account real money
forge snapshot, to find information about gas cost

cast storage address_contact `slot_id`, it can return the 2nd slot of storage

 // What can we do to work with addressses outside the system?
    // 1. Unit - Testing a specific part of our code
    // 2. Integration - Testing how our code works with other parts of our code
    // 3. Forked - Testing our code on a simulated real environment
    // 4. Staging - Testing our code on a real environment that is not production

