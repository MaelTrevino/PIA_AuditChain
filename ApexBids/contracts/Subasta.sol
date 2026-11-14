// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract Subasta {
    //Estado
    address public owner;
    string public nombreArticulo;
    uint256 public precioMinimo;
    uint256 public finSubasta;
    address public mejorPostor;
    uint256 public mejorOferta;
    bool public finalizada;

    //Reembolsos pendientes para quienes no tenga la oferta lider
    mapping(address => uint256) public ofertas;

    event OfertaRecibida(address indexed postor, uint256 monto);
    event SubastaFinalizada(address indexed ganador, uint256 monto);
    event OfertaRetirada(address indexed postor, uint256 monto);

    modifier soloOwner() {
        require(msg.sender == owner, "Solo el owner puede hacer esto");
        _;
    }

    modifier subastaActiva() {
        require(!finalizada, "La subasta ya finalizo");
        require(block.timestamp < finSubasta, "La subasta ya cerro");
        _;
    }

    modifier nameNotEmpty(string memory _nombre) {
        require(bytes(_nombre).length > 0, "El nombre no puede estar vacio");
        _;
    }

    constructor(
        string memory _nombre,
        uint256 _precioMinimo,
        uint256 _duracionMinutos
    ) nameNotEmpty(_nombre) {
        require(_precioMinimo > 0, "El precio minimo debe ser mayor a 0");
        require(_duracionMinutos > 0, "La duracion debe ser mayor a 0");

        owner = msg.sender;
        nombreArticulo = _nombre;
        precioMinimo = _precioMinimo;
        finSubasta = block.timestamp + (_duracionMinutos * 1 minutes);
    }

    //Funcion para realizar oferta 
    function ofertar() external payable subastaActiva {
        require(msg.sender != owner, "El owner no puede ofertar");
        require(msg.value > mejorOferta, "Tu oferta debe superar la actual");
        require(msg.value >= precioMinimo, "No alcanza el precio minimo");

        //El postor anterior queda con reembolso pendiente
        if (mejorPostor != address(0)) {
            ofertas[mejorPostor] += mejorOferta;
        }

        mejorPostor = msg.sender;
        mejorOferta = msg.value;

        emit OfertaRecibida(msg.sender, msg.value);
    }

    //Funcion para retirar ofertas superadas
    function retirarOferta() external {
        require(msg.sender != mejorPostor, "Eres el lider, no puedes retirar tu oferta");

        uint256 monto = ofertas[msg.sender];
        require(monto > 0, "No tienes nada que retirar");

        ofertas[msg.sender] = 0;
        (bool ok, ) = payable(msg.sender).call{value: monto}("");
        require(ok, "La transferencia fallo");

        emit OfertaRetirada(msg.sender, monto);
    }

    //El owner cobra al finalizar y cerrar la subasta
    function finalizar() external soloOwner {
        require(!finalizada, "Ya esta finalizada");
        require(block.timestamp >= finSubasta, "Aun no termina el tiempo");

        finalizada = true;

        if (mejorPostor != address(0)) {
            (bool ok, ) = payable(owner).call{value: mejorOferta}("");
            require(ok, "El pago al owner fallo");
            emit SubastaFinalizada(mejorPostor, mejorOferta);
        }
    }

    //Funciones para mostrar informacion en el frontend
    function verSubasta()
        external
        view
        returns (
            string memory nombre,
            uint256 precioMin,
            uint256 tiempoRestante,
            address lider,
            uint256 ofertaLider,
            bool terminada
        )
    {
        uint256 restante = block.timestamp >= finSubasta
            ? 0
            : finSubasta - block.timestamp;

        return (
            nombreArticulo,
            precioMinimo,
            restante,
            mejorPostor,
            mejorOferta,
            finalizada
        );
    }

    function miOferta() external view returns (uint256) {
        return ofertas[msg.sender];
    }

    function soyOwner() external view returns (bool) {
        return msg.sender == owner;
    }
}
