const hre = require("hardhat");

const PAX = '0x818E6b4bEa1C1FfF712464FE057d4791Efc6D552'
const emissionPerBlock = '4000000000000000000'

async function main() {
  const PaxEmitter = await hre.ethers.getContractFactory("PaxEmitter");
  const paxEmitter = await PaxEmitter.deploy();

  await paxEmitter.deployed();

  console.log("Pax deployed to:", paxEmitter.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
