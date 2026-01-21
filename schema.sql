
-- Criação do Banco de Dados para o Cenário de E-commerce
CREATE DATABASE IF NOT EXISTS ecommerce_dio;
USE ecommerce_dio;

-- 1. Tabela Clientes (Superclasse)
CREATE TABLE Clients (
    idClient INT AUTO_INCREMENT PRIMARY KEY,
    Fname VARCHAR(15),
    Minit VARCHAR(3),
    Lname VARCHAR(20),
    Address VARCHAR(255),
    client_type ENUM('PF', 'PJ') NOT NULL COMMENT 'Define se o cliente é Pessoa Física ou Jurídica'
);

-- 2. Tabela Cliente PF (Subclasse)
CREATE TABLE Client_PF (
    idClient INT PRIMARY KEY,
    cpf CHAR(11) NOT NULL UNIQUE,
    birth_date DATE,
    CONSTRAINT fk_client_pf FOREIGN KEY (idClient) REFERENCES Clients(idClient)
);

-- 3. Tabela Cliente PJ (Subclasse)
CREATE TABLE Client_PJ (
    idClient INT PRIMARY KEY,
    cnpj CHAR(14) NOT NULL UNIQUE,
    social_name VARCHAR(100) NOT NULL,
    fantasy_name VARCHAR(100),
    CONSTRAINT fk_client_pj FOREIGN KEY (idClient) REFERENCES Clients(idClient)
);

-- 4. Tabela Produtos
CREATE TABLE Product (
    idProduct INT AUTO_INCREMENT PRIMARY KEY,
    Pname VARCHAR(50) NOT NULL,
    classification_kids BOOL DEFAULT FALSE,
    category ENUM('Eletrônico','Vestuário','Brinquedos','Alimentos','Móveis') NOT NULL,
    rating FLOAT DEFAULT 0,
    size VARCHAR(10)
);

-- 5. Tabela Pedidos
CREATE TABLE Orders (
    idOrder INT AUTO_INCREMENT PRIMARY KEY,
    idOrderClient INT,
    orderStatus ENUM('Cancelado', 'Confirmado', 'Em processamento') DEFAULT 'Em processamento',
    orderDescription VARCHAR(255),
    sendValue FLOAT DEFAULT 10,
    paymentCash BOOL DEFAULT FALSE, 
    CONSTRAINT fk_orders_client FOREIGN KEY (idOrderClient) REFERENCES Clients(idClient)
);

-- 6. Tabela Pagamentos (Permite múltiplas formas de pagamento por pedido/cliente)
CREATE TABLE Payments (
    idPayment INT AUTO_INCREMENT PRIMARY KEY,
    idOrder INT,
    typePayment ENUM('Boleto', 'Cartão', 'Dois cartões'),
    limitAvailable FLOAT,
    CONSTRAINT fk_payments_order FOREIGN KEY (idOrder) REFERENCES Orders(idOrder)
);

-- 7. Tabela Entrega (Refinamento solicitado: Status e Rastreio)
CREATE TABLE Delivery (
    idDelivery INT AUTO_INCREMENT PRIMARY KEY,
    idOrder INT,
    status ENUM('Em trânsito', 'Entregue', 'Pendente') DEFAULT 'Pendente',
    tracking_code VARCHAR(20) UNIQUE,
    CONSTRAINT fk_delivery_order FOREIGN KEY (idOrder) REFERENCES Orders(idOrder)
);

-- 8. Tabela Estoque
CREATE TABLE ProductStorage (
    idProdStorage INT AUTO_INCREMENT PRIMARY KEY,
    storageLocation VARCHAR(255),
    quantity INT DEFAULT 0
);

-- 9. Tabela Fornecedor
CREATE TABLE Supplier (
    idSupplier INT AUTO_INCREMENT PRIMARY KEY,
    SocialName VARCHAR(255) NOT NULL,
    CNPJ CHAR(14) NOT NULL UNIQUE,
    contact CHAR(11) NOT NULL
);

-- 10. Tabela Vendedor Terceiro
CREATE TABLE Seller (
    idSeller INT AUTO_INCREMENT PRIMARY KEY,
    SocialName VARCHAR(255) NOT NULL,
    AbsName VARCHAR(255),
    CNPJ CHAR(14),
    CPF CHAR(11),
    location VARCHAR(255),
    contact CHAR(11) NOT NULL,
    CONSTRAINT unique_cnpj_seller UNIQUE (CNPJ),
    CONSTRAINT unique_cpf_seller UNIQUE (CPF)
);

-- 11. Relacionamento Produto/Vendedor
CREATE TABLE ProductSeller (
    idPseller INT,
    idPproduct INT,
    prodQuantity INT DEFAULT 1,
    PRIMARY KEY (idPseller, idPproduct),
    CONSTRAINT fk_product_seller FOREIGN KEY (idPseller) REFERENCES Seller(idSeller),
    CONSTRAINT fk_product_product FOREIGN KEY (idPproduct) REFERENCES Product(idProduct)
);

-- 12. Relacionamento Produto/Pedido
CREATE TABLE ProductOrder (
    idPOproduct INT,
    idPOorder INT,
    poQuantity INT DEFAULT 1,
    poStatus ENUM('Disponível', 'Sem estoque') DEFAULT 'Disponível',
    PRIMARY KEY (idPOproduct, idPOorder),
    CONSTRAINT fk_productorder_product FOREIGN KEY (idPOproduct) REFERENCES Product(idProduct),
    CONSTRAINT fk_productorder_order FOREIGN KEY (idPOorder) REFERENCES Orders(idOrder)
);

-- 13. Relacionamento Produto/Estoque
CREATE TABLE StorageLocation (
    idLproduct INT,
    idLstorage INT,
    location VARCHAR(255) NOT NULL,
    PRIMARY KEY (idLproduct, idLstorage),
    CONSTRAINT fk_storage_product FOREIGN KEY (idLproduct) REFERENCES Product(idProduct),
    CONSTRAINT fk_storage_storage FOREIGN KEY (idLstorage) REFERENCES ProductStorage(idProdStorage)
);

-- 14. Relacionamento Produto/Fornecedor
CREATE TABLE ProductSupplier (
    idPsSupplier INT,
    idPsProduct INT,
    quantity INT NOT NULL,
    PRIMARY KEY (idPsSupplier, idPsProduct),
    CONSTRAINT fk_product_supplier_supplier FOREIGN KEY (idPsSupplier) REFERENCES Supplier(idSupplier),
    CONSTRAINT fk_product_supplier_product FOREIGN KEY (idPsProduct) REFERENCES Product(idProduct)
);