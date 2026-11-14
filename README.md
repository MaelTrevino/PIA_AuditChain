# DApp | Aplicación descentralizada para subastas
Aplicación descentralizada para la gestión y participación en subastas digitales a través de tecnología blockchain para garantizar la transparencia, seguridad e integridad de las operaciones digitales.

La aplicación integra tecnologías del ecosistema blockchain, como Solana, para interactuar con redes descentralizadas, MetaMask, como herramienta de gestión de wallets e identidad digital de los usuarios, y Hardhat, como entorno de desarrollo, compilación y pruebas de contratos inteligentes.

El objetivo principal es implementar un sistema de subastas en el que los usuarios puedan conectarse mediante una wallet, participar en subastas y realizar ofertas de manera descentralizada, reduciendo la dependencia de intermediarios y permitiendo que las operaciones se ejecuten mediante lógica basada en blockchain.

Tecnologías utilizadas
- Solana: Blockchain utilizada para la interacción con una red descentralizada.
- MetaMask: Wallet de software para la conexión y gestión de la identidad digital de los usuarios.
- Hardhat: Entorno de desarrollo para la compilación, despliegue y pruebas de contratos inteligentes.
- HTML5 & Tailwind CSS: Interfaz de usuario responsiva con cambio dinámico de tema según el rol detectado (Modo Claro para Postores / Modo Oscuro para Propietario).

Objetivos
- Desarrollar una plataforma de subastas basada en tecnología blockchain.
- Implementar mecanismos de conexión e identificación de usuarios mediante wallets.
- Gestionar la participación de los usuarios y sus ofertas.
- Utilizar contratos inteligentes para automatizar las operaciones de la subasta.
- Aprovechar las características de descentralización, transparencia e inmutabilidad de blockchain.

Características principales
- Conexión de usuarios mediante una wallet.
- Participación en subastas digitales.
- Registro y gestión de ofertas.
- Interacción con contratos inteligentes.
- Ejecución descentralizada de las operaciones.

Propósito
El proyecto busca demostrar la aplicación de tecnologías blockchain en sistemas de comercio digital, explorando el uso de contratos inteligentes y wallets para desarrollar un entorno de subastas transparente, seguro y descentralizado.

Guía de Instalación y Despliegue (Entorno Local)

Para ejecutar el proyecto desde cero en una computadora local, se requieren **Node.js** instalado y la extensión **MetaMask** en el navegador.

1. Clonar e instalar dependencias
```bash
git clone <URL-DEL-REPOSITORIO>
cd ApexBids
npm install
```
2. Levantar el entorno (3 Terminales)
Abre tres ventanas de terminal en la carpeta raíz del proyecto y ejecuta los siguientes comandos en orden:
Terminal 1 - Iniciar la Blockchain Local:
```bash
npx hardhat node
```
(Mantén esta ventana abierta; generará 20 cuentas de prueba con 10,000 ETH simulados)

Terminal 2 - Desplegar el Smart Contract:
```bash
npx hardhat run scripts/deploySubastas.ts --network localhost
```
(Verifica que la dirección del contrato impresa en consola coincida con CONTRACT_ADDRESS en index.html).

Terminal 3 - Servir la Interfaz Web:
```bash
npx serve . -p 5500
```
(Abre tu navegador la dirección http://localhost:5500).

Instrucciones de Uso para el Usuario

Paso 1: Configurar MetaMask en la red local
1. Abre MetaMask, despliega el selector de redes y agrega una red manualmente con los siguientes parámetros:

-Nombre de red: Hardhat Local
-Nueva URL de RPC: http://127.0.0.1:8545
-Identificador de cadena (Chain ID): 31337
-Símbolo de moneda: ETH
2. Importa al menos dos cuentas usando las llaves privadas que aparecen en la Terminal 1 (la Cuenta #0 actúa como el Propietario/Owner que desplegó el contrato; la Cuenta #1 en adelante actúan como Postores).

Paso 2: Exploración en Modo Público (Sin Wallet)
Al ingresar a http://localhost:5500, podrás consultar el artículo en subasta, el precio base, la mejor oferta actual y el cronómetro regresivo. Si intentas ofertar o retirar sin conectar tu wallet, el sistema bloqueará la acción.

Paso 3: Participar como Postor (Interfaz Clara)
1. Haz clic en Conectar Wallet y selecciona una cuenta distinta a la del creador del contrato (ej. Cuenta #1).
2. La interfaz cambiará automáticamente a Modo Postor.
2. Ingresa un monto en ETH superior a la oferta actual en el apartado Enviar Puja y haz clic en Confirmar Puja en Blockchain. Confirma la transacción en MetaMask.
4. Si otro postor supera tu oferta, el monto anterior aparecerá disponible en la tarjeta Reembolsos Pendientes, donde podrás recuperarlo haciendo clic en Retirar Saldo Superado.

Paso 4: Administrar como Propietario (Interfaz Oscura)
1. Desconecta la cuenta actual usando el botón Desconectar Wallet y vuelve a conectar seleccionando la Cuenta #0 (Deployer).
2. La interfaz cambiará al Panel de Propietario en tema oscuro.
3. Una vez que el cronómetro de cierre llegue a 00:00, haz clic en Finalizar Subasta y Cobrar Fondos para dar por terminado el contrato y transferir el monto ganador a la wallet del propietario.
