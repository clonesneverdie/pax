const hre = require('hardhat')

const PAXEmitter = '0x97C2315DE88107DBACb0E911046F15f3bEC94360'
const pid = '2'
const CNDV2 = '0x6c15030A0055D7350c89EbbD460EB4F145462Fbd'
const MAXSupply = '10000'

async function main() {
	const ClonesV2Pool = await hre.ethers.getContractFactory('ClonesV2Pool')
	const clonesV2Pool = await ClonesV2Pool.deploy(PAXEmitter, pid, CNDV2, MAXSupply)

	await clonesV2Pool.deployed()

	console.log('ClonesV2Pool deployed to:', clonesV2Pool.address)
}

main()
	.then(() => process.exit(0))
	.catch((error) => {
		console.error(error)
		process.exit(1)
	})
