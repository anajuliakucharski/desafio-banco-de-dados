--quantos pedidos foram feitos por cada cliente
SELECT 
    c.idClient,
    CONCAT(c.Fname, ' ', c.Lname) AS ClientName, 
    COUNT(o.idOrder) AS NumOrders
FROM Clients c
INNER JOIN Orders o ON c.idClient = o.idOrderClient
GROUP BY c.idClient;

-- relação fornecedores e produtos 
SELECT 
    s.SocialName AS Supplier, 
    p.Pname AS Product, 
    ps.quantity AS Qty_Provided
FROM Supplier s
INNER JOIN ProductSupplier ps ON s.idSupplier = ps.idPsSupplier
INNER JOIN Product p ON ps.idPsProduct = p.idProduct
ORDER BY s.SocialName;

-- Recuperando pedidos com status 'Confirmado' e ordenando por quem comprou mais itens
SELECT 
    c.Fname, 
    o.idOrder, 
    SUM(po.poQuantity) AS TotalItems
FROM Clients c
INNER JOIN Orders o ON c.idClient = o.idOrderClient
INNER JOIN ProductOrder po ON o.idOrder = po.idPOorder
WHERE o.orderStatus = 'Confirmado'
GROUP BY o.idOrder
ORDER BY TotalItems DESC;

--filtros em grupos
SELECT 
    p.Pname, 
    SUM(ps.quantity) AS TotalStorage
FROM Product p
INNER JOIN ProductStorage ps ON p.idProduct = ps.idProdStorage -- Assumindo relação direta para exemplo ou via tabela StorageLocation
GROUP BY p.Pname
HAVING TotalStorage > 500;