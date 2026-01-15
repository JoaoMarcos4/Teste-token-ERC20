// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
 * Interface ERC20
 * Define o "contrato" que qualquer token ERC20 deve seguir.
 * Aqui só existem assinaturas, nenhuma implementação.
 */
interface IERC20 {

    // ===== GETTERS =====

    // Retorna o supply total do token
    function totalSupply() external view returns (uint256);
    // Retorna o saldo de um endereço
    function balanceOf(address account) external view returns (uint256);
    // Retorna quanto um spender pode gastar do owner
    function allowance(address owner, address spender) external view returns (uint256);

    // ===== FUNÇÕES =====

    // Transfere tokens do remetente para outro endereço
    function transfer(address recipient, uint256 amount) external returns (bool);
    // Autoriza outro endereço a gastar tokens
    function approve(address spender, uint256 amount) external returns (bool);
    // Transfere tokens usando uma autorização prévia
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);

    // ===== EVENTOS =====

    // Emitido em transferências e queimas
    event Transfer(address indexed from, address indexed to, uint256 value);
    // Emitido quando uma autorização é concedida
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

/*
 * Implementação concreta do token FishCat
 */
contract FishCat is IERC20 {

    // ===== METADADOS DO TOKEN =====

    string public constant name = "FishCat";
    string public constant symbol = "FCAT";
    uint8 public constant decimals = 18;

    // ===== ARMAZENAMENTO =====

    // Saldo de cada endereço
    mapping(address => uint256) private balances;

    // Autorizações: owner => (spender => quantidade)
    mapping(address => mapping(address => uint256)) private allowed;

    // Supply total real (variável de estado)
    uint256 private totalSupply_ = 10 ether;

    // Taxa de queima (0,1% = 1 / 1000)
    uint256 private constant BURN_FEE = 1;
    uint256 private constant FEE_DENOMINATOR = 1000;

    /*
     * Construtor
     * Executado uma única vez no deploy
     */
    constructor() {
        // Todo o supply inicial vai para quem fez o deploy
        balances[msg.sender] = totalSupply_;
    }

    // ===== IMPLEMENTAÇÃO DOS GETTERS =====

    function totalSupply() public view override returns (uint256) {
        return totalSupply_;
    }

    function balanceOf(address tokenOwner) public view override returns (uint256) {
        return balances[tokenOwner];
    }

    function allowance(address owner, address delegate) public view override returns (uint256) {
        return allowed[owner][delegate];
    }

    // ===== FUNÇÕES PRINCIPAIS =====

    /*
     * Transferência direta
     * Aplica taxa de queima automaticamente
     */
    function transfer(address receiver, uint256 numTokens) public override returns (bool) {

        // Garante saldo suficiente
        require(numTokens <= balances[msg.sender], "Saldo insuficiente");

        // Impede envio para endereço zero
        require(receiver != address(0), "Endereco invalido");

        // Calcula a taxa de queima
        uint256 fee = (numTokens * BURN_FEE) / FEE_DENOMINATOR;

        // Valor final que o destinatário recebe
        uint256 amount = numTokens - fee;

        // Atualiza saldo do remetente
        balances[msg.sender] -= numTokens;

        // Atualiza saldo do destinatário
        balances[receiver] += amount;

        // Reduz o supply total (queima)
        totalSupply_ -= fee;

        // Evento da transferência real
        emit Transfer(msg.sender, receiver, amount);

        // Evento explícito de queima (padrão ERC20)
        emit Transfer(msg.sender, address(0), fee);

        return true;
    }

    /*
     * Aprovação de gasto por terceiros
     */
    function approve(address delegate, uint256 numTokens) public override returns (bool) {

        // Define quanto o delegate pode gastar
        allowed[msg.sender][delegate] = numTokens;

        // Emite evento padrão
        emit Approval(msg.sender, delegate, numTokens);

        return true;
    }

    /*
     * Transferência usando allowance
     * Também aplica taxa de queima
     */
    function transferFrom(
        address owner,
        address buyer,
        uint256 numTokens
    ) public override returns (bool) {

        // Verifica saldo do dono dos tokens
        require(numTokens <= balances[owner], "Saldo insuficiente");

        // Verifica autorização
        require(numTokens <= allowed[owner][msg.sender], "Allowance insuficiente");

        // Impede envio para endereço zero
        require(buyer != address(0), "Endereco invalido");

        // Calcula taxa
        uint256 fee = (numTokens * BURN_FEE) / FEE_DENOMINATOR;

        // Valor líquido
        uint256 amount = numTokens - fee;

        // Atualiza saldos
        balances[owner] -= numTokens;
        balances[buyer] += amount;

        // Atualiza allowance
        allowed[owner][msg.sender] -= numTokens;

        // Reduz supply
        totalSupply_ -= fee;

        // Eventos
        emit Transfer(owner, buyer, amount);
        emit Transfer(owner, address(0), fee);

        return true;
    }
}
