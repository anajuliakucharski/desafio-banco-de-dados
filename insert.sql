-- Inserindo Clientes (Base)
INSERT INTO Clients (Fname, Minit, Lname, Address, client_type) VALUES 
('Maria', 'M', 'Silva', 'Rua Silva de Prata 29, Carangola - Cidade das Flores', 'PF'),
('Matheus', 'O', 'Pimentel', 'Rua Alemeda 289, Centro - Cidade das Flores', 'PF'),
('Ricardo', 'F', 'Silva', 'Avenida Alameda Vinha 1009, Centro - Cidade das Flores', 'PF'),
('TechSolutions', NULL, NULL, 'Av. Empresarial 500, Porto Digital - Recife', 'PJ');

-- Inserindo Detalhes PF e PJ
INSERT INTO Client_PF (idClient, cpf, birth_date) VALUES 
(1, '12345678901', '1990-05-15'),
(2, '98765432100', '1985-10-20'),
(3, '45678912300', '1978-02-10');

INSERT INTO Client_PJ (idClient, cnpj, social_name, fantasy_name) VALUES 
(4, '12345678000199', 'Tech Solutions LTDA', 'TechSol');

-- Inserindo Produtos
INSERT INTO Product (Pname, classification_kids, category, rating, size) VALUES
('Fone de Ouvido', false, 'Eletrônico', '4', NULL),
('Barbie Elsa', true, 'Brinquedos', '3', NULL),
('Body Carters', true, 'Vestuário', '5', NULL),
('Microfone Vedo', false, 'Eletrônico', '4', NULL),
('Sofá Retrátil', false, 'Móveis', '3', '3x57x80');

-- Inserindo Fornecedores
INSERT INTO Supplier (SocialName, CNPJ, contact) VALUES 
('Almeida e Filhos', '85451964914345', '21985474'),
('Eletrônicos Silva', '93456789393469', '21985484');

-- Inserindo Estoques
INSERT INTO ProductStorage (storageLocation, quantity) VALUES 
('Rio de Janeiro', 1000),
('São Paulo', 500),
('Curitiba', 100);

-- Inserindo Vendedores
INSERT INTO Seller (SocialName, AbsName, CNPJ, CPF, location, contact) VALUES 
('Tech Eletronics', NULL, '12345678945632', NULL, 'Rio de Janeiro', '219946287'),
('Botique Durgas', NULL, NULL, '123456783', 'Rio de Janeiro', '219567895');

-- Inserindo Pedidos
INSERT INTO Orders (idOrderClient, orderStatus, orderDescription, sendValue, paymentCash) VALUES 
(1, 'Em processamento', 'compra via app', NULL, 1),
(2, 'Confirmado', 'compra via web', 50, 0),
(3, 'Confirmado', NULL, NULL, 1),
(4, 'Em processamento', 'compra corporativa', 150, 0);

-- Inserindo Relação de Produtos nos Pedidos
INSERT INTO ProductOrder (idPOproduct, idPOorder, poQuantity, poStatus) VALUES
(1, 1, 2, 'Disponível'),
(2, 1, 1, 'Disponível'),
(3, 2, 1, 'Disponível');

-- Inserindo Entregas (Rastreio)
INSERT INTO Delivery (idOrder, status, tracking_code) VALUES
(2, 'Em trânsito', 'TRK123456789'),
(3, 'Entregue', 'TRK987654321');