const hre = require('hardhat')

const PAXEmitter = '0x97C2315DE88107DBACb0E911046F15f3bEC94360'
const pid = '4'
const StakingToken = '0xf7463107b942a73bb002d42e50e549810479a662'

async function main() {
	const QuickswapPool = await hre.ethers.getContractFactory('ERC20StakingPool')
	const quickswapPool = await QuickswapPool.deploy(PAXEmitter, pid, StakingToken)

	await quickswapPool.deployed()

	console.log('QuickswapPool deployed to:', quickswapPool.address)
}

main()
	.then(() => process.exit(0))
	.catch((error) => {
		console.error(error)
		process.exit(1)
	})
