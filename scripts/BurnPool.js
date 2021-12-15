const hre = require('hardhat')

const PAXEmitter = '0x97C2315DE88107DBACb0E911046F15f3bEC94360'
const pid = '0'

async function main() {
	const BurnPool = await hre.ethers.getContractFactory('BurnPool')
	const burnPool = await BurnPool.deploy(PAXEmitter, pid)

	await burnPool.deployed()

	console.log('BurnPool deployed to:', burnPool.address)
}

main()
	.then(() => process.exit(0))
	.catch((error) => {
		console.error(error)
		process.exit(1)
	})
