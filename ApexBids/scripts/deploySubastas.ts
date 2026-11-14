import { network } from "hardhat";

async function main() {
  console.log("Conectando a la red y desplegando Subasta...");

  // En Hardhat 3, ethers se obtiene desde network.connect()
  const { ethers } = await network.connect();

  const nombreArticulo = "Laptop Dell";
  const precioMinimo = ethers.parseEther("1.0");
  const duracionMinutos = 5;

  const subasta = await ethers.deployContract("Subasta", [
    nombreArticulo,
    precioMinimo,
    duracionMinutos,
  ]);

  await subasta.waitForDeployment();

  const direccionContrato = await subasta.getAddress();
  console.log("¡Subasta desplegada con éxito!");
  console.log("Dirección del contrato:", direccionContrato);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});