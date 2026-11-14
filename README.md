# ApexBids | DApp de Subastas Descentralizadas

Aplicación descentralizada (DApp) para la gestión y participación en subastas digitales mediante tecnología blockchain, con el propósito de garantizar la transparencia, seguridad e integridad de las operaciones.

ApexBids integra tecnologías del ecosistema blockchain para permitir que los usuarios interactúen con contratos inteligentes, conecten sus wallets y participen en subastas sin depender de intermediarios tradicionales.

El proyecto busca implementar un sistema en el que las ofertas y operaciones se ejecuten mediante lógica basada en blockchain, aprovechando las características de descentralización, transparencia e inmutabilidad.

---

## Tecnologías utilizadas

| Tecnología | Descripción |
|:---|:---|
| **Solana** | Tecnología blockchain considerada para la interacción con redes descentralizadas. |
| **MetaMask** | Wallet de software para la conexión y gestión de la identidad digital de los usuarios. |
| **Hardhat** | Entorno de desarrollo para la compilación, despliegue y pruebas de contratos inteligentes. |
| **HTML5** | Estructura de la interfaz de usuario. |
| **Tailwind CSS** | Diseño responsivo y gestión dinámica de temas según el rol del usuario. |

## Objetivos

- Desarrollar una plataforma de subastas basada en tecnología blockchain.
- Implementar mecanismos de conexión e identificación mediante wallets.
- Gestionar la participación de los usuarios y sus respectivas ofertas.
- Utilizar contratos inteligentes para automatizar las operaciones de la subasta.
- Aprovechar las características de descentralización, transparencia e inmutabilidad de blockchain.

## Características principales

- **Conexión mediante Wallet:** Identificación de usuarios a través de MetaMask.
- **Subastas digitales:** Participación y registro de ofertas en una subasta.
- **Integración Blockchain:** Interacción directa con contratos inteligentes.
- **Gestión de ofertas:** Registro de pujas y administración de reembolsos pendientes.
- **Roles diferenciados:** Detección automática del propietario y los postores.
- **Interfaz dinámica:** Modo claro para postores y modo oscuro para el propietario.
- **Ejecución descentralizada:** Operaciones gestionadas mediante lógica implementada en blockchain.

## Propósito del proyecto

ApexBids busca demostrar la aplicación de tecnologías blockchain en sistemas de comercio digital, explorando el uso de contratos inteligentes y wallets para desarrollar un entorno de subastas transparente, seguro y descentralizado.

---

# Guía de instalación y despliegue

Esta sección describe el procedimiento para ejecutar el proyecto en un entorno local desde cero.

### Requisitos previos

Antes de comenzar, asegúrate de contar con las siguientes herramientas:

- [Node.js](https://nodejs.org/)
- [MetaMask](https://metamask.io/) (extensión para el navegador).
- Git.

### 1. Clonar el repositorio

Abre una terminal y ejecuta los siguientes comandos:

```bash
git clone <URL-DEL-REPOSITORIO>
cd ApexBids
npm install
```

### 2. Iniciar el entorno local

Para ejecutar el proyecto correctamente, es necesario utilizar **tres terminales independientes**, todas ubicadas en la carpeta raíz del repositorio.

**Terminal 1 — Iniciar la Blockchain Local**

```bash
npx hardhat node
```

> Mantén esta terminal abierta. Se generarán 20 cuentas de prueba con 10,000 ETH simulados cada una.

**Terminal 2 — Desplegar el Smart Contract**

```bash
npx hardhat run scripts/deploySubastas.ts --network localhost
```

> Verifica que la dirección del contrato impresa en consola coincida con el valor de `CONTRACT_ADDRESS` configurado en `index.html`.

**Terminal 3 — Iniciar el servidor web**

```bash
npx serve . -p 5500
```

Una vez iniciado el servidor, abre tu navegador en:

[http://localhost:5500](http://localhost:5500)

---

# Guía de uso

## Paso 1. Configurar MetaMask

Para interactuar con la blockchain local, es necesario configurar manualmente una red en MetaMask.

En el selector de redes, agrega una nueva red utilizando los siguientes parámetros:

| Parámetro | Valor |
|:---|:---|
| Nombre de red | Hardhat Local |
| URL de RPC | `http://127.0.0.1:8545` |
| Chain ID | `31337` |
| Símbolo de moneda | ETH |

**Importar cuentas de prueba**

Importa al menos dos cuentas utilizando las llaves privadas generadas en la Terminal 1.

- **Cuenta #0:** Propietario (Owner) que despliega el contrato.
- **Cuenta #1 en adelante:** Cuentas destinadas a participar como postores.

## Paso 2. Explorar la plataforma (Modo Público)

Ingresa a [http://localhost:5500](http://localhost:5500).

Sin conectar una wallet, podrás consultar:

- El artículo disponible en subasta.
- El precio base.
- La mejor oferta actual.
- El cronómetro regresivo.

> **Nota:** Las operaciones de ofertar y retirar fondos requieren conectar una wallet. El sistema bloqueará estas acciones mientras permanezcas en modo público.

## Paso 3. Participar como postor (Interfaz Clara)

1. Haz clic en **Conectar Wallet** y selecciona una cuenta distinta a la del creador del contrato (por ejemplo, Cuenta #1).
2. La interfaz cambiará automáticamente al modo postor, utilizando el tema claro.
3. Ingresa un monto en ETH superior a la oferta actual en el apartado **Enviar Puja**.
4. Haz clic en **Confirmar Puja en Blockchain** y confirma la transacción desde MetaMask.
5. Si otro postor supera tu oferta, el monto anterior aparecerá en la tarjeta **Reembolsos Pendientes**.
6. Para recuperar tus fondos, haz clic en **Retirar Saldo Superado**.

## Paso 4. Administrar como propietario (Interfaz Oscura)

1. Desconecta la cuenta actual mediante el botón **Desconectar Wallet**.
2. Vuelve a conectar MetaMask seleccionando la **Cuenta #0 (Deployer)**.
3. La interfaz cambiará automáticamente al panel del propietario, utilizando el tema oscuro.
4. Cuando el cronómetro de cierre llegue a `00:00`, haz clic en **Finalizar Subasta y Cobrar Fondos**.
5. Esta acción dará por terminada la subasta y transferirá el monto ganador a la wallet del propietario.
