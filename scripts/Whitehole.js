const hre = require('hardhat')

const PAX = '0x818E6b4bEa1C1FfF712464FE057d4791Efc6D552'

async function main() {
	const Whitehole = await hre.ethers.getContractFactory('Whitehole')
	const whitehole = await Whitehole.deploy(PAX)

	await whitehole.deployed()

	console.log('Whitehole deployed to:', whitehole.address)
}

main()
	.then(() => process.exit(0))
	.catch((error) => {
		console.error(error)
		process.exit(1)
	})
