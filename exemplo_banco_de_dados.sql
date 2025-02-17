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
('Laboratorio G1', 'Laboratórios', '11987654321', '15', '30'),
('Laboratorio G2', 'Laboratórios', '11991234567', '16', '31'),
('Sala 1', 'Salas', '11999887766', '18', '32'),
('Laboratorio G3', 'Laboratórios', '11998877665', '20', '33'),
('Laboratório G4', 'Labratórios', '11996655443', '21', '34'),
('Sala 2', 'Salas', '11995544332', '22', '35');

-- INSERT INTO `produto`
INSERT INTO `produto` (`nome`, `descricao`) VALUES
('Sensor Ultrassônico', 'Sensor de proximidade para medição de distância em robótica'),
('Microcontrolador ESP32', 'Placa de desenvolvimento com Wi-Fi e Bluetooth integrados'),
('Motor de Passo', 'Motor elétrico de alta precisão para controle de movimento'),
('Câmera Raspberry Pi', 'Módulo de câmera para visão computacional em projetos embarcados'),
('Bateria LiPo 3S', 'Bateria recarregável de polímero de lítio, 11.1V'),
('Impressora 3D', 'Impressora de filamento PLA/ABS para prototipagem rápida'),
('Kit de Chaves de Precisão', 'Conjunto de ferramentas para montagem e manutenção de eletrônicos'),
('Placa Controladora CNC', 'Placa para controle de motores em máquinas CNC'),
('Sensor de Cor TCS3200', 'Sensor para detecção de cores em aplicações robóticas'),
('Módulo GPS', 'Módulo de geolocalização para navegação autônoma');

-- INSERT INTO `dispositivo`
INSERT INTO `dispositivo` (`nome`, `IP`, `permissao_acesso`, `tipo`) VALUES
('CAMARO', '192.168.0.10', 'Permitido', 'V'),
('NARA', '192.168.0.11', 'Restrito', 'C');

-- INSERT INTO `pedido`
INSERT INTO `pedido` (`id_usuario`, `id_loja`, `id_dispositivo`, `data_hora`, `status`, `endereco_entrega`, `data_hora_entrega`) VALUES
(1, 1, 1, '2024-11-05 10:00:00', 'Pendente', 'Laboratorio G1', NULL),
(2, 1, 2, '2024-11-05 10:05:00', 'Concluído', 'Laboratorio G1', '2024-11-05 10:30:00'),
(3, 1, 1, '2024-11-05 11:15:00', 'Cancelado', 'Laboratorio G2', NULL),
(1, 1, 2, '2024-11-05 11:45:00', 'Em Andamento', 'Laboratorio G2', NULL),
(2, 3, 1, '2024-11-05 12:00:00', 'Pendente', 'Sala 1', NULL),
(3, 3, 2, '2024-11-05 12:30:00', 'Concluído', 'Sala 1', '2024-11-05 13:00:00'),
(1, 4, 1, '2024-11-05 13:15:00', 'Pendente', 'Laboratorio G3', NULL),
(2, 4, 2, '2024-11-05 13:45:00', 'Concluído', 'Laboratorio G3', '2024-11-05 14:20:00'),
(3, 5, 1, '2024-11-05 14:30:00', 'Cancelado', 'Laboratorio G4', NULL),
(1, 5, 2, '2024-11-05 15:00:00', 'Pendente', 'Laboratorio G4', NULL),
(2, 6, 1, '2024-11-05 15:30:00', 'Concluído', 'Sala 2', '2024-11-05 16:00:00'),
(3, 6, 2, '2024-11-05 16:10:00', 'Pendente', 'Sala 2', NULL),
(1, 1, 1, '2024-11-06 09:00:00', 'Pendente', 'Laboratorio G1', NULL),
(2, 1, 2, '2024-11-06 09:30:00', 'Concluído', 'Laboratorio G1', '2024-11-06 10:00:00'),
(3, 2, 1, '2024-11-06 10:45:00', 'Cancelado', 'Laboratorio G2', NULL),
(1, 2, 2, '2024-11-06 11:15:00', 'Em Andamento', 'Laboratorio G2', NULL),
(2, 3, 1, '2024-11-06 11:30:00', 'Pendente', 'Sala 1', NULL),
(3, 3, 2, '2024-11-06 12:00:00', 'Concluído', 'Sala 1', '2024-11-06 12:30:00'),
(1, 4, 1, '2024-11-06 12:45:00', 'Pendente', 'Laboratorio G3', NULL),
(2, 4, 2, '2024-11-06 13:15:00', 'Concluído', 'Laboratorio G3', '2024-11-06 13:50:00'),
(3, 5, 1, '2024-11-06 14:00:00', 'Cancelado', 'Laboratorio G4', NULL),
(1, 5, 2, '2024-11-06 14:30:00', 'Pendente', 'Laboratorio G4', NULL),
(2, 6, 1, '2024-11-06 15:00:00', 'Concluído', 'Sala 2', '2024-11-06 15:30:00'),
(3, 6, 2, '2024-11-06 15:40:00', 'Pendente', 'Sala 2', NULL),
(1, 1, 1, '2024-11-07 08:45:00', 'Pendente', 'Laboratorio G1', NULL),
(2, 1, 2, '2024-11-07 09:15:00', 'Concluído', 'Laboratorio G1', '2024-11-07 09:45:00'),
(3, 3, 1, '2024-11-07 10:00:00', 'Cancelado', 'Laboratorio G2', NULL),
(1, 3, 2, '2024-11-07 10:30:00', 'Em Andamento', 'Laboratorio G2', NULL),
(2, 3, 1, '2024-11-07 10:45:00', 'Pendente', 'Sala 1', NULL),
(3, 3, 2, '2024-11-07 11:15:00', 'Concluído', 'Sala 1', '2024-11-07 11:45:00'),
(1, 4, 1, '2024-11-07 12:00:00', 'Pendente', 'Laboratorio G3', NULL),
(2, 4, 2, '2024-11-07 12:30:00', 'Concluído', 'Laboratorio G3', '2024-11-07 13:05:00'),
(3, 5, 1, '2024-11-07 13:20:00', 'Cancelado', 'Laboratorio G4', NULL),
(1, 3, 2, '2024-11-07 13:50:00', 'Pendente', 'Laboratorio G4', NULL),
(2, 6, 1, '2024-11-07 14:15:00', 'Concluído', 'Sala 2', '2024-11-07 14:45:00'),
(3, 6, 2, '2024-11-07 15:00:00', 'Pendente', 'Sala 2', NULL),
(1, 1, 1, '2024-11-08 08:00:00', 'Pendente', 'Laboratorio G1', NULL),
(2, 1, 2, '2024-11-08 08:30:00', 'Concluído', 'Laboratorio G1', '2024-11-08 09:00:00'),
(3, 2, 1, '2024-11-08 09:15:00', 'Cancelado', 'Laboratorio G2', NULL),
(1, 2, 2, '2024-11-08 09:45:00', 'Em Andamento', 'Laboratorio G2', NULL),
(2, 3, 1, '2024-11-08 10:00:00', 'Pendente', 'Sala 1', NULL),
(3, 3, 2, '2024-11-08 10:30:00', 'Concluído', 'Sala 1', '2024-11-08 11:00:00'),
(1, 3, 1, '2024-11-08 11:15:00', 'Pendente', 'Laboratorio G3', NULL),
(2, 4, 2, '2024-11-08 11:45:00', 'Concluído', 'Laboratorio G3', '2024-11-08 12:15:00');

-- INSERT INTO `item_pedido`
-- Tabela item_pedido com os últimos 10 produtos e associada aos pedidos recentes
INSERT INTO `item_pedido` (`id_pedido`, `id_produto`, `quantidade`) VALUES
(1, 1, 2),  
(2, 2, 1), 
(3, 3, 1),
(4, 4, 3), 
(5, 5, 1), 
(6, 6, 4),  
(7, 7, 1),  
(8, 8, 2), 
(9, 9, 1),   
(10, 10, 2), 
(11, 1, 1),  
(12, 2, 2), 
(13, 3, 1),
(14, 4, 1), 
(15, 5, 3),
(16, 6, 2), 
(17, 7, 1), 
(18, 8, 1), 
(19, 9, 2), 
(20, 10, 1),
(21, 1, 1),
(22, 2, 1),
(23, 3, 1),
(24, 4, 2),
(25, 5, 1),
(26, 6, 1),
(27, 7, 1),
(28, 8, 1),
(29, 9, 1),
(30, 10, 2),
(31, 1, 2),
(32, 2, 1),
(33, 3, 1),
(34, 4, 3),
(35, 5, 1),
(36, 6, 4),
(37, 7, 1),
(38, 8, 2),
(39, 9, 1),
(40, 10, 1),
(41, 1, 1),
(42, 2, 2), 
(43, 3, 1),
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
