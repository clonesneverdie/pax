const hre = require('hardhat')

const PAX = '0x818E6b4bEa1C1FfF712464FE057d4791Efc6D552'
const signer = '0x5307B5E725feB3D6A55605daC1986e3571FB765D'

async function main() {
	const PaxSender = await hre.ethers.getContractFactory('PaxSender')
	const paxSender = await PaxSender.deploy(PAX, signer)

	await paxSender.deployed()

	console.log('PaxSender deployed to:', paxSender.address)
}

main()
	.then(() => process.exit(0))
	.catch((error) => {
		console.error(error)
		process.exit(1)
	})
