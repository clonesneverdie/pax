const hre = require('hardhat')

async function main() {
	const Pax = await hre.ethers.getContractFactory('Pax')
	const pax = await Pax.deploy()

	await pax.deployed()

	console.log('Pax deployed to:', pax.address)
}

main()
	.then(() => process.exit(0))
	.catch((error) => {
		console.error(error)
		process.exit(1)
	})
