const hre = require('hardhat')

const PAX = '0x818E6b4bEa1C1FfF712464FE057d4791Efc6D552'
const receiver = '0x5e4Cc9175407ccFf2F6fB61b3A5222dFc6aF1021'

async function main() {
	const BuybackFund = await hre.ethers.getContractFactory('BuybackFund')
	const buybackFund = await BuybackFund.deploy(PAX, receiver)

	await buybackFund.deployed()

	console.log('BuybackFund deployed to:', buybackFund.address)
}

main()
	.then(() => process.exit(0))
	.catch((error) => {
		console.error(error)
		process.exit(1)
	})
