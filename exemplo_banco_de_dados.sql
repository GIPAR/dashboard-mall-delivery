DROP DATABASE IF EXISTS gipar;
CREATE DATABASE IF NOT EXISTS gipar;
USE gipar;

-- Tabela `usuario`
CREATE TABLE `usuario` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(255) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `nome` varchar(255) NOT NULL,
--  `telefone` varchar(20) NOT NULL,
--  `endereco` varchar(255),
--  `foto` varchar(255),
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabela `loja`
CREATE TABLE `loja` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `categoria` varchar(100) NOT NULL,
  `telefone` varchar(20) NOT NULL,
  `posicao_x` varchar(20) NOT NULL,
  `posicao_y` varchar(20) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabela `produto`
/**
* TODO: Adicionar chave unica para o cadastro de produtos
* No cadastro de produtos, nada impede que produtos repetidos sejam cadastrados
* Adicionar algo como código de barras, ou outra chave parecida
*/

CREATE TABLE `produto` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `descricao` varchar(255),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabela `dispositivo`
CREATE TABLE `dispositivo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(255) NOT NULL,
  `IP` varchar(45) NOT NULL,
  `permissao_acesso` varchar(50) NOT NULL,
  `tipo` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabela `pedido`
CREATE TABLE `pedido` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_usuario` int(11) NOT NULL,
  `id_loja` int(11) NOT NULL,
  `id_dispositivo` int(11) NOT NULL,
  `data_hora` datetime NOT NULL,
  `data_hora_entrega` datetime,
  `status` varchar(50) NOT NULL,
  `endereco_entrega` varchar(255) NOT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`id_usuario`) REFERENCES `usuario`(`id`) ,
  FOREIGN KEY (`id_loja`) REFERENCES `loja`(`id`),
  FOREIGN KEY (`id_dispositivo`) REFERENCES `dispositivo`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Tabela `item_pedido`
CREATE TABLE `item_pedido` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_pedido` int(11) NOT NULL,
  `id_produto` int(11) NOT NULL,
  `quantidade` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  FOREIGN KEY (`id_pedido`) REFERENCES `pedido`(`id`),
  FOREIGN KEY (`id_produto`) REFERENCES `produto`(`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- Tabela para registro do consumo de bateria
CREATE TABLE registro_bateria (
    id INT AUTO_INCREMENT PRIMARY KEY,  -- Identificador único para cada registro
    dispositivo_id INT NOT NULL,        -- ID do dispositivo
    data_hora DATETIME NOT NULL,        -- Data e hora do registro
    porcentagem_bateria DECIMAL(5, 2) NOT NULL, -- Porcentagem da bateria (ex.: 75.50)
    dispositivos_ativos TEXT            -- Lista de dispositivos ativos separados por vírgula
);

-- INSERT INTO `usuario`
INSERT INTO `usuario` (`email`, `senha`, `nome`) VALUES
('heitor@example.com', 'H#h45eiuiu', 'Heitor Rodrigues Lemos Dias'),
('arthur@example.com', 'H#h45eiuiu', 'Arthur da Silva Lemos'),
('pedro@example.com', 'H#h45eiuiu', 'Pedro Vitor Oliveira da Silva'),
('mariana@example.com', 'M#ar123', 'Mariana Souza'),
('joao@example.com', 'J#oa098', 'João Carlos'),
('leticia@example.com', 'L#et654', 'Letícia Ferreira');

-- INSERT INTO `loja`
INSERT INTO `loja` (`nome`, `categoria`, `telefone`, `posicao_x`, `posicao_y`) VALUES
('Riachuelo', 'Moda', '11987654321', '15', '30'),
('C&A', 'Moda', '11991234567', '16', '31'),
('Fast Shop', 'Eletrônicos', '11999887766', '18', '32'),
('Saraiva', 'Livraria', '11998877665', '20', '33'),
('Petz', 'Animais', '11996655443', '21', '34'),
('Apple Store', 'Eletrônicos', '11995544332', '22', '35');

-- INSERT INTO `produto`
INSERT INTO `produto` (`nome`, `descricao`) VALUES
('Mouse Gamer', 'Mouse com sensor óptico de alta precisão'),
('Teclado Mecânico', 'Teclado com switches mecânicos e retroiluminação RGB'),
('Smart TV 4K', 'Smart TV com resolução 4K, 55 polegadas'),
('Fone de Ouvido Bluetooth', 'Fone de ouvido sem fio com cancelamento de ruído'),
('Cafeteira Expresso', 'Cafeteira expresso com sistema de cápsulas'),
('Livro - 1984', 'Clássico de George Orwell em edição de bolso'),
('Tênis Esportivo', 'Tênis leve e confortável para corrida'),
('Bolsa Feminina', 'Bolsa de couro sintético, várias cores'),
('Ventilador de Mesa', 'Ventilador compacto com três velocidades'),
('Tablet Samsung', 'Tablet com tela de 10 polegadas e sistema Android');

-- INSERT INTO `dispositivo`
INSERT INTO `dispositivo` (`nome`, `IP`, `permissao_acesso`, `tipo`) VALUES
('CAMARO', '192.168.0.10', 'Permitido', 'V'),
('NARA', '192.168.0.11', 'Restrito', 'C');

-- INSERT INTO `pedido`
INSERT INTO `pedido` (`id_usuario`, `id_loja`, `id_dispositivo`, `data_hora`, `status`, `endereco_entrega`, `data_hora_entrega`) VALUES
(1, 1, 1, '2024-11-05 10:00:00', 'Pendente', 'Riachuelo', NULL),
(2, 1, 2, '2024-11-05 10:05:00', 'Concluído', 'Riachuelo', '2024-11-05 10:30:00'),
(3, 1, 1, '2024-11-05 11:15:00', 'Cancelado', 'C&A', NULL),
(1, 1, 2, '2024-11-05 11:45:00', 'Em Andamento', 'C&A', NULL),
(2, 3, 1, '2024-11-05 12:00:00', 'Pendente', 'Fast Shop', NULL),
(3, 3, 2, '2024-11-05 12:30:00', 'Concluído', 'Fast Shop', '2024-11-05 13:00:00'),
(1, 4, 1, '2024-11-05 13:15:00', 'Pendente', 'Saraiva', NULL),
(2, 4, 2, '2024-11-05 13:45:00', 'Concluído', 'Saraiva', '2024-11-05 14:20:00'),
(3, 5, 1, '2024-11-05 14:30:00', 'Cancelado', 'Petz', NULL),
(1, 5, 2, '2024-11-05 15:00:00', 'Pendente', 'Petz', NULL),
(2, 6, 1, '2024-11-05 15:30:00', 'Concluído', 'Apple Store', '2024-11-05 16:00:00'),
(3, 6, 2, '2024-11-05 16:10:00', 'Pendente', 'Apple Store', NULL),
(1, 1, 1, '2024-11-06 09:00:00', 'Pendente', 'Riachuelo', NULL),
(2, 1, 2, '2024-11-06 09:30:00', 'Concluído', 'Riachuelo', '2024-11-06 10:00:00'),
(3, 2, 1, '2024-11-06 10:45:00', 'Cancelado', 'C&A', NULL),
(1, 2, 2, '2024-11-06 11:15:00', 'Em Andamento', 'C&A', NULL),
(2, 3, 1, '2024-11-06 11:30:00', 'Pendente', 'Fast Shop', NULL),
(3, 3, 2, '2024-11-06 12:00:00', 'Concluído', 'Fast Shop', '2024-11-06 12:30:00'),
(1, 4, 1, '2024-11-06 12:45:00', 'Pendente', 'Saraiva', NULL),
(2, 4, 2, '2024-11-06 13:15:00', 'Concluído', 'Saraiva', '2024-11-06 13:50:00'),
(3, 5, 1, '2024-11-06 14:00:00', 'Cancelado', 'Petz', NULL),
(1, 5, 2, '2024-11-06 14:30:00', 'Pendente', 'Petz', NULL),
(2, 6, 1, '2024-11-06 15:00:00', 'Concluído', 'Apple Store', '2024-11-06 15:30:00'),
(3, 6, 2, '2024-11-06 15:40:00', 'Pendente', 'Apple Store', NULL),
(1, 1, 1, '2024-11-07 08:45:00', 'Pendente', 'Riachuelo', NULL),
(2, 1, 2, '2024-11-07 09:15:00', 'Concluído', 'Riachuelo', '2024-11-07 09:45:00'),
(3, 3, 1, '2024-11-07 10:00:00', 'Cancelado', 'C&A', NULL),
(1, 3, 2, '2024-11-07 10:30:00', 'Em Andamento', 'C&A', NULL),
(2, 3, 1, '2024-11-07 10:45:00', 'Pendente', 'Fast Shop', NULL),
(3, 3, 2, '2024-11-07 11:15:00', 'Concluído', 'Fast Shop', '2024-11-07 11:45:00'),
(1, 4, 1, '2024-11-07 12:00:00', 'Pendente', 'Saraiva', NULL),
(2, 4, 2, '2024-11-07 12:30:00', 'Concluído', 'Saraiva', '2024-11-07 13:05:00'),
(3, 5, 1, '2024-11-07 13:20:00', 'Cancelado', 'Petz', NULL),
(1, 3, 2, '2024-11-07 13:50:00', 'Pendente', 'Petz', NULL),
(2, 6, 1, '2024-11-07 14:15:00', 'Concluído', 'Apple Store', '2024-11-07 14:45:00'),
(3, 6, 2, '2024-11-07 15:00:00', 'Pendente', 'Apple Store', NULL),
(1, 1, 1, '2024-11-08 08:00:00', 'Pendente', 'Riachuelo', NULL),
(2, 1, 2, '2024-11-08 08:30:00', 'Concluído', 'Riachuelo', '2024-11-08 09:00:00'),
(3, 2, 1, '2024-11-08 09:15:00', 'Cancelado', 'C&A', NULL),
(1, 2, 2, '2024-11-08 09:45:00', 'Em Andamento', 'C&A', NULL),
(2, 3, 1, '2024-11-08 10:00:00', 'Pendente', 'Fast Shop', NULL),
(3, 3, 2, '2024-11-08 10:30:00', 'Concluído', 'Fast Shop', '2024-11-08 11:00:00'),
(1, 3, 1, '2024-11-08 11:15:00', 'Pendente', 'Saraiva', NULL),
(2, 4, 2, '2024-11-08 11:45:00', 'Concluído', 'Saraiva', '2024-11-08 12:15:00');

-- INSERT INTO `item_pedido`
-- Tabela item_pedido com os últimos 10 produtos e associada aos pedidos recentes
INSERT INTO `item_pedido` (`id_pedido`, `id_produto`, `quantidade`) VALUES
(1, 1, 2),   -- Mouse Gamer
(2, 2, 1),   -- Teclado Mecânico
(3, 3, 1),  -- Smart TV 4K
(4, 4, 3),   -- Fone de Ouvido Bluetooth
(5, 5, 1),   -- Cafeteira Expresso
(6, 6, 4),    -- Livro - 1984
(7, 7, 1),   -- Tênis Esportivo
(8, 8, 2),    -- Bolsa Feminina
(9, 9, 1),   -- Ventilador de Mesa
(10, 10, 2), -- Tablet Samsung
(11, 1, 1),  -- Mouse Gamer
(12, 2, 2),  -- Teclado Mecânico
(13, 3, 1), -- Smart TV 4K
(14, 4, 1),  -- Fone de Ouvido Bluetooth
(15, 5, 3),  -- Cafeteira Expresso
(16, 6, 2),   -- Livro - 1984
(17, 7, 1),  -- Tênis Esportivo
(18, 8, 1),   -- Bolsa Feminina
(19, 9, 2),  -- Ventilador de Mesa
(20, 10, 1), -- Tablet Samsung
(21, 1, 1),  -- Mouse Gamer
(22, 2, 1),  -- Teclado Mecânico
(23, 3, 1), -- Smart TV 4K
(24, 4, 2),  -- Fone de Ouvido Bluetooth
(25, 5, 1),  -- Cafeteira Expresso
(26, 6, 1),   -- Livro - 1984
(27, 7, 1),  -- Tênis Esportivo
(28, 8, 1),   -- Bolsa Feminina
(29, 9, 1),  -- Ventilador de Mesa
(30, 10, 2), -- Tablet Samsung
(31, 1, 2),  -- Mouse Gamer
(32, 2, 1),  -- Teclado Mecânico
(33, 3, 1), -- Smart TV 4K
(34, 4, 3),  -- Fone de Ouvido Bluetooth
(35, 5, 1),  -- Cafeteira Expresso
(36, 6, 4),   -- Livro - 1984
(37, 7, 1),  -- Tênis Esportivo
(38, 8, 2),   -- Bolsa Feminina
(39, 9, 1),  -- Ventilador de Mesa
(40, 10, 1), -- Tablet Samsung
(41, 1, 1),  -- Mouse Gamer
(42, 2, 2),  -- Teclado Mecânico
(43, 3, 1), -- Smart TV 4K
(44, 4, 1);

INSERT INTO registro_bateria (dispositivo_id, data_hora, porcentagem_bateria, dispositivos_ativos) VALUES
(2, '2024-11-05 08:00:00', 88.40, 'Sensor 2, Câmera'),
(1, '2024-11-05 10:00:00', 35.80, 'Sensor 1, LIDAR'),
(2, '2024-11-05 12:00:00', 15.00, 'LIDAR'),
(1, '2024-11-05 14:00:00', 20.75, 'Sensor 1'),
(2, '2024-11-05 16:00:00', 60.40, 'Sensor 2, Câmera'),
(1, '2024-11-06 08:00:00', 85.00, 'Sensor 1, Sensor 2, LIDAR, Câmera'),
(2, '2024-11-06 10:00:00', 45.30, 'Sensor 2'),
(1, '2024-11-06 12:00:00', 22.40, 'Sensor 1, Câmera'),
(2, '2024-11-06 14:00:00', 80.00, 'Sensor 1, LIDAR, Câmera'),
(1, '2024-11-06 16:00:00', 100.00, 'Sensor 1, Sensor 2'),
(2, '2024-11-07 08:00:00', 70.50, 'LIDAR, Câmera'),
(1, '2024-11-07 10:00:00', 35.25, 'Sensor 2'),
(2, '2024-11-07 12:00:00', 10.00, 'Sensor 1'),
(1, '2024-11-07 14:00:00', 85.20, 'Sensor 1, Sensor 2, LIDAR, Câmera'),
(2, '2024-11-07 16:00:00', 60.00, 'Sensor 2, LIDAR'),
(1, '2024-11-08 08:00:00', 75.50, 'Sensor 1, Sensor 2, LIDAR, Câmera'),
(2, '2024-11-08 10:00:00', 50.25, 'Sensor 1, Sensor 2, LIDAR'),
(1, '2024-11-08 12:00:00', 30.75, 'Sensor 1, Sensor 2'),
(2, '2024-11-08 14:00:00', 90.00, 'Sensor 1'),
(1, '2024-11-08 16:00:00', 100.00, 'Sensor 1, Sensor 2, LIDAR, Câmera');
