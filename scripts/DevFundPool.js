const hre = require('hardhat')

const PAXEmitter = '0x97C2315DE88107DBACb0E911046F15f3bEC94360'
const pid = '1'
const StakingToken = ''

async function main() {
	const DevFund = await hre.ethers.getContractFactory('ERC20StakingPool')
	const devFund = await DevFund.deploy(PAXEmitter, pid, StakingToken)

	await devFund.deployed()

	console.log('DevFundPool deployed to:', devFund.address)
}

main()
	.then(() => process.exit(0))
	.catch((error) => {
		console.error(error)
		process.exit(1)
	})
