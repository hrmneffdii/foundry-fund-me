# Foundry Found Me Dummy Project

![images](./images/charity.png)

[source image ](https://www.google.com/url?sa=i&url=https%3A%2F%2Fwww.1stformations.co.uk%2Fblog%2Fhow-does-hmrc-tax-uk-companys-charitable-donations%2F&psig=AOvVaw0eNm8GDo1TvvWHZCaIFKnI&ust=1715591272851000&source=images&cd=vfe&opi=89978449&ved=2ahUKEwj8jLrU4YeGAxU59qACHV8CA8gQr4kDegQIARBn)

## **Background:**

The "Fund Me" dummy project is a decentralized crowdfunding platform developed on the Ethereum blockchain using Solidity smart contracts within the Foundry framework. It aims to modernize the traditional fundraising landscape by providing a transparent, secure, and efficient platform for individuals and organizations to raise funds for their initiatives. By leveraging blockchain technology, Fund Me seeks to overcome the limitations of conventional crowdfunding platforms, offering a decentralized solution that ensures transparency, accessibility, and trust in the fundraising process.

Fund Me operates on Ethereum's blockchain, ensuring decentralization and immutability, eliminating the need for intermediaries. Transactions are transparently recorded, empowering contributors to track fund utilization. Smart contracts govern the process, ensuring security and reducing fraud risks. With an intuitive interface, both fundraisers and contributors can easily participate, making fundraising accessible to all. The integration of Chainlink's Price Feed enables automatic Ether to USD conversion, enhancing stability and predictability in fundraising goals. Overall, Fund Me aims to democratize fundraising, fostering innovation and social impact worldwide.

### 1. Features

Within this smart contract, many functionalities that can be offered, such as :

- This contract can receive ether from someone through functionality itself.
- It also can withdraw from this contract to the owner and ensure that security is guaranteed.
- It is also covered by the script for deloployment in testnet or mainnet, and test for unit testing for the professionality of the project

### 2. Concepts

Here, i'm impelementing about some testing manually in directory `test`, there is many component function such as :

- Unit Testing :

  Unit testing is a process of testing individual components of code to ensure that they function as expected. This testing involves checking the functionality of the code, as well as any support libraries it uses. The purpose of unit testing is to identify and fix any issues with the code components so that they perform at their best.

- Integration Testing :

  Integration testing in Foundry is about ensuring that all the different parts of the platform work seamlessly together. It's like checking that the gears in a complex machine fit together perfectly and turn smoothly

- Mock Agregator :

  The Mock agregator is intended to create a fake contract to replace a real agregator(that runs in testnet or mainnet).it can be running in a local anvil environment.

### 3. Tips and Tricks

If you are in a phase of development, you have to use the local chain as much as possible to avoid the alchemy node connected to Sepolia ETH. Is it possible to develop a contract that needs another contract in Sepolia eth? yaa it's impossible. well, to solve this problem, we need a mock or we call it a fake contract, and deploy it on an anvil environment.

There is many commands which important for this project:

- using test within alchemy env

  `forge test -vvv --fork-url $RPC_URL `

- using testing as well as analyzing the eentire of code.

  `forge coverage --fork-url $RPC_URL`

- , using command script to deploy onchain through RPC_URL, if we don't include rpc as well as private key, we actually do at local chain in anvil. don't use the env with account real money

  `forge script script/DeployFundMe.s.sol --rpc-url $RPC_URL_ANVIL --private-key $PRIVATE_KEY --broadcast`

- to find information about gas cost
  `forge snapshot`

- cast storage address_contact `slot_id` it can return the 2nd slot of storage

#### What can we do to work with addressses outside the system?

1. Unit - Testing a specific part of our code
2. Integration - Testing how our code works with other parts of our code
3. Forked - Testing our code on a simulated real environment
4. Staging - Testing our code on a real environment that is not production
