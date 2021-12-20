const hre = require('hardhat')

const PAXEmitter = '0x97C2315DE88107DBACb0E911046F15f3bEC94360'
const pid = '3'
const to = '0x77Ef0B244d6c018718bA8902b3d2B0c4144ceAd9'

async function main() {
	const KlayswapPool = await hre.ethers.getContractFactory('ForwardingPool')
	const klayswapPool = await KlayswapPool.deploy(PAXEmitter, pid, to)

	await klayswapPool.deployed()

	console.log('KlayswapPool deployed to:', klayswapPool.address)
}

main()
	.then(() => process.exit(0))
	.catch((error) => {
		console.error(error)
		process.exit(1)
	})
