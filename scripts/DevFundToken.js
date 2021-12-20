const hre = require('hardhat')

async function main() {
	const DevFundToken = await hre.ethers.getContractFactory('DevFundToken')
	const devFundToken = await DevFundToken.deploy()

	await devFundToken.deployed()

	console.log('DevFundToken deployed to:', devFundToken.address)
}

main()
	.then(() => process.exit(0))
	.catch((error) => {
		console.error(error)
		process.exit(1)
	})
