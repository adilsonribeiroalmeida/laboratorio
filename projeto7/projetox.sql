-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Nov 07, 2026 at 07:43 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `projetox`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `gerar_parcelas` (IN `p_idPedido` INT, IN `p_quantidadeParcelas` INT, IN `p_juros` DECIMAL(5,2))   BEGIN
    DECLARE v_preco DECIMAL(10,2);
    DECLARE v_valorParcela DECIMAL(10,2);
    DECLARE v_valorComJuros DECIMAL(10,2);
    DECLARE v_contador INT DEFAULT 1;

    -- Busca o preço do produto do pedido
    SELECT produtos.preco
    INTO v_preco
    FROM pedidos
    INNER JOIN produtos
        ON produtos.idProduto = pedidos.idProduto
    WHERE pedidos.idPedido = p_idPedido;

    -- Calcula o valor base da parcela
    SET v_valorParcela = v_preco / p_quantidadeParcelas;

    -- Aplica o percentual de juros em cada parcela
    SET v_valorComJuros =
        v_valorParcela + (v_valorParcela * p_juros / 100);

    -- Gera as parcelas
    WHILE v_contador <= p_quantidadeParcelas DO

        INSERT INTO parcelas (
            idPedido,
            numeroParcela,
            valor,
            dataVencimento
        )
        VALUES (
            p_idPedido,
            v_contador,
            v_valorComJuros,
            DATE_ADD(CURDATE(), INTERVAL v_contador MONTH)
        );

        SET v_contador = v_contador + 1;

    END WHILE;

END$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `formatar_rg` (`rg` VARCHAR(50)) RETURNS VARCHAR(20) CHARSET utf8mb4 COLLATE utf8mb4_general_ci DETERMINISTIC BEGIN
    DECLARE rg_limpo VARCHAR(20);

    -- Converte para maiúsculo
    SET rg_limpo = UPPER(rg);

    -- Remove textos e caracteres indesejados
    SET rg_limpo = REPLACE(rg_limpo, 'RG', '');
    SET rg_limpo = REPLACE(rg_limpo, '.', '');
    SET rg_limpo = REPLACE(rg_limpo, '-', '');
    SET rg_limpo = REPLACE(rg_limpo, '/', '');
    SET rg_limpo = REPLACE(rg_limpo, '_', '');
    SET rg_limpo = REPLACE(rg_limpo, ':', '');
    SET rg_limpo = REPLACE(rg_limpo, ' ', '');

    -- Se tiver mais de 9 caracteres,
    -- considera os últimos 9
    IF LENGTH(rg_limpo) > 9 THEN
        SET rg_limpo = RIGHT(rg_limpo, 9);
    END IF;

    -- Formata no padrão XX.XXX.XXX-X
    IF LENGTH(rg_limpo) = 9 THEN
        RETURN CONCAT(
            SUBSTRING(rg_limpo, 1, 2), '.',
            SUBSTRING(rg_limpo, 3, 3), '.',
            SUBSTRING(rg_limpo, 6, 3), '-',
            SUBSTRING(rg_limpo, 9, 1)
        );
    END IF;

    -- Se não tiver 9 caracteres,
    -- retorna apenas o valor limpo
    RETURN rg_limpo;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `artigos`
--

CREATE TABLE `artigos` (
  `idArtigo` int(11) NOT NULL,
  `titulo` varchar(256) NOT NULL,
  `slug` varchar(265) NOT NULL,
  `resumo` text NOT NULL,
  `conteudo` text NOT NULL,
  `imagem` varchar(256) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `artigos`
--

INSERT INTO `artigos` (`idArtigo`, `titulo`, `slug`, `resumo`, `conteudo`, `imagem`) VALUES
(1, 'Título 1', 'titulo-1', 'Resumo do post', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor ipsum velit, id malesuada turpis vehicula nec. Fusce eu metus rutrum, suscipit turpis non, tincidunt nisl. In quis libero aliquam, maximus neque quis, eleifend arcu. Pellentesque feugiat diam id lectus egestas fringilla. In hac habitasse platea dictumst. Sed eget vehicula turpis. Quisque interdum maximus est id auctor. Phasellus pulvinar urna tellus, at egestas nisl suscipit in. Maecenas ligula dui, convallis quis augue vitae, aliquet tincidunt augue. Duis vel tincidunt orci, vel condimentum odio.\r\n\r\nMauris et euismod urna. Vivamus efficitur, ante id efficitur consectetur, mi libero ultricies leo, consectetur cursus nunc orci ut turpis. Vivamus lacus ligula, laoreet quis pulvinar vitae, tristique venenatis elit. Sed egestas arcu diam, in semper enim sodales eu. Nulla facilisi. Nullam feugiat lobortis mattis. Suspendisse orci turpis, rhoncus in congue nec, congue sed dui. Vestibulum cursus, tellus in mollis feugiat, sapien nisl volutpat tellus, quis tincidunt lacus quam porttitor risus. Vestibulum ornare malesuada facilisis. Maecenas accumsan, tortor ac suscipit pharetra, neque risus tincidunt nibh, non molestie ipsum enim ultrices lectus. Aenean aliquet lectus at dui dapibus convallis vel id velit. Suspendisse nec luctus odio, in dapibus tellus.\r\n\r\nProin tempor nisi vitae finibus dignissim. Nunc ac purus nec mauris posuere hendrerit. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Sed elementum dolor justo, quis pharetra nisl rutrum pharetra. Duis aliquet ullamcorper tortor, quis dapibus nulla dictum non. Vestibulum pretium eros neque, in aliquam quam auctor et. Aliquam tortor est, pellentesque ac consequat at, laoreet et leo. Vestibulum accumsan suscipit nulla quis molestie. Proin nec laoreet sapien, rutrum lobortis felis. Pellentesque eleifend aliquet lectus ut ultricies. In semper varius nisi, vel volutpat diam faucibus et. Nullam malesuada neque eu risus finibus mollis. Proin dignissim, nunc eu scelerisque efficitur, massa velit ullamcorper tortor, non ullamcorper lorem nibh imperdiet augue. Aliquam convallis faucibus turpis.', 'noticia1.webp'),
(2, 'Título 2', 'titulo-2', 'Resumo do Artigo', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor ipsum velit, id malesuada turpis vehicula nec. Fusce eu metus rutrum, suscipit turpis non, tincidunt nisl. In quis libero aliquam, maximus neque quis, eleifend arcu. Pellentesque feugiat diam id lectus egestas fringilla. In hac habitasse platea dictumst. Sed eget vehicula turpis. Quisque interdum maximus est id auctor. Phasellus pulvinar urna tellus, at egestas nisl suscipit in. Maecenas ligula dui, convallis quis augue vitae, aliquet tincidunt augue. Duis vel tincidunt orci, vel condimentum odio.\r\n\r\nMauris et euismod urna. Vivamus efficitur, ante id efficitur consectetur, mi libero ultricies leo, consectetur cursus nunc orci ut turpis. Vivamus lacus ligula, laoreet quis pulvinar vitae, tristique venenatis elit. Sed egestas arcu diam, in semper enim sodales eu. Nulla facilisi. Nullam feugiat lobortis mattis. Suspendisse orci turpis, rhoncus in congue nec, congue sed dui. Vestibulum cursus, tellus in mollis feugiat, sapien nisl volutpat tellus, quis tincidunt lacus quam porttitor risus. Vestibulum ornare malesuada facilisis. Maecenas accumsan, tortor ac suscipit pharetra, neque risus tincidunt nibh, non molestie ipsum enim ultrices lectus. Aenean aliquet lectus at dui dapibus convallis vel id velit. Suspendisse nec luctus odio, in dapibus tellus.\r\n\r\nProin tempor nisi vitae finibus dignissim. Nunc ac purus nec mauris posuere hendrerit. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Sed elementum dolor justo, quis pharetra nisl rutrum pharetra. Duis aliquet ullamcorper tortor, quis dapibus nulla dictum non. Vestibulum pretium eros neque, in aliquam quam auctor et. Aliquam tortor est, pellentesque ac consequat at, laoreet et leo. Vestibulum accumsan suscipit nulla quis molestie. Proin nec laoreet sapien, rutrum lobortis felis. Pellentesque eleifend aliquet lectus ut ultricies. In semper varius nisi, vel volutpat diam faucibus et. Nullam malesuada neque eu risus finibus mollis. Proin dignissim, nunc eu scelerisque efficitur, massa velit ullamcorper tortor, non ullamcorper lorem nibh imperdiet augue. Aliquam convallis faucibus turpis.', 'noticia2.webp'),
(3, 'Título 3', 'titulo-3', 'Resumo do Artigo', 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Vivamus auctor ipsum velit, id malesuada turpis vehicula nec. Fusce eu metus rutrum, suscipit turpis non, tincidunt nisl. In quis libero aliquam, maximus neque quis, eleifend arcu. Pellentesque feugiat diam id lectus egestas fringilla. In hac habitasse platea dictumst. Sed eget vehicula turpis. Quisque interdum maximus est id auctor. Phasellus pulvinar urna tellus, at egestas nisl suscipit in. Maecenas ligula dui, convallis quis augue vitae, aliquet tincidunt augue. Duis vel tincidunt orci, vel condimentum odio.\r\n\r\nMauris et euismod urna. Vivamus efficitur, ante id efficitur consectetur, mi libero ultricies leo, consectetur cursus nunc orci ut turpis. Vivamus lacus ligula, laoreet quis pulvinar vitae, tristique venenatis elit. Sed egestas arcu diam, in semper enim sodales eu. Nulla facilisi. Nullam feugiat lobortis mattis. Suspendisse orci turpis, rhoncus in congue nec, congue sed dui. Vestibulum cursus, tellus in mollis feugiat, sapien nisl volutpat tellus, quis tincidunt lacus quam porttitor risus. Vestibulum ornare malesuada facilisis. Maecenas accumsan, tortor ac suscipit pharetra, neque risus tincidunt nibh, non molestie ipsum enim ultrices lectus. Aenean aliquet lectus at dui dapibus convallis vel id velit. Suspendisse nec luctus odio, in dapibus tellus.\r\n\r\nProin tempor nisi vitae finibus dignissim. Nunc ac purus nec mauris posuere hendrerit. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Sed elementum dolor justo, quis pharetra nisl rutrum pharetra. Duis aliquet ullamcorper tortor, quis dapibus nulla dictum non. Vestibulum pretium eros neque, in aliquam quam auctor et. Aliquam tortor est, pellentesque ac consequat at, laoreet et leo. Vestibulum accumsan suscipit nulla quis molestie. Proin nec laoreet sapien, rutrum lobortis felis. Pellentesque eleifend aliquet lectus ut ultricies. In semper varius nisi, vel volutpat diam faucibus et. Nullam malesuada neque eu risus finibus mollis. Proin dignissim, nunc eu scelerisque efficitur, massa velit ullamcorper tortor, non ullamcorper lorem nibh imperdiet augue. Aliquam convallis faucibus turpis.', 'noticia3.webp');

-- --------------------------------------------------------

--
-- Table structure for table `categorias`
--

CREATE TABLE `categorias` (
  `idCategoria` int(11) NOT NULL,
  `nome` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `categorias`
--

INSERT INTO `categorias` (`idCategoria`, `nome`) VALUES
(1, 'Ferramentas de Jardinagem'),
(2, 'Sementes e Mudas'),
(3, 'Adubos e Fertilizantes'),
(4, 'Vasos e Jardineiras'),
(5, 'Sistemas de Irrigação'),
(6, 'Equipamentos de Poda'),
(7, 'Substratos e Terra Vegetal'),
(8, 'Controle de Pragas'),
(9, 'Gramados e Paisagismo'),
(10, 'Acessórios de Jardinagem');

-- --------------------------------------------------------

--
-- Table structure for table `cidades`
--

CREATE TABLE `cidades` (
  `idCidade` int(11) NOT NULL,
  `idEstado` int(11) NOT NULL,
  `nome` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `cidades`
--

INSERT INTO `cidades` (`idCidade`, `idEstado`, `nome`) VALUES
(1, 1, 'Sales'),
(2, 2, 'Teresópolis');

-- --------------------------------------------------------

--
-- Table structure for table `entradas`
--

CREATE TABLE `entradas` (
  `idEntrada` int(11) NOT NULL,
  `valor` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `entradas`
--

INSERT INTO `entradas` (`idEntrada`, `valor`) VALUES
(1, 2000.00),
(2, 3000.00),
(3, 4500.00),
(4, 5000.00),
(5, 7000.00),
(6, 6000.00);

-- --------------------------------------------------------

--
-- Table structure for table `estados`
--

CREATE TABLE `estados` (
  `idEstado` int(11) NOT NULL,
  `nome` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `estados`
--

INSERT INTO `estados` (`idEstado`, `nome`) VALUES
(1, 'São Paulo'),
(2, 'Rio de Janeiro');

-- --------------------------------------------------------

--
-- Table structure for table `parcelas`
--

CREATE TABLE `parcelas` (
  `idParcela` int(11) NOT NULL,
  `idPedido` int(11) DEFAULT NULL,
  `numeroParcela` int(11) DEFAULT NULL,
  `valor` decimal(10,2) DEFAULT NULL,
  `dataVencimento` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `parcelas`
--

INSERT INTO `parcelas` (`idParcela`, `idPedido`, `numeroParcela`, `valor`, `dataVencimento`) VALUES
(1, 1, 1, 612.00, '2026-09-29'),
(2, 1, 2, 612.00, '2026-10-29'),
(3, 1, 3, 612.00, '2026-11-29'),
(4, 1, 4, 612.00, '2026-12-29'),
(5, 1, 5, 612.00, '2027-01-29'),
(6, 1, 6, 612.00, '2027-02-28'),
(7, 1, 7, 612.00, '2027-03-29'),
(8, 1, 8, 612.00, '2027-04-29'),
(9, 1, 9, 612.00, '2027-05-29'),
(10, 1, 10, 612.00, '2027-06-29');

-- --------------------------------------------------------

--
-- Table structure for table `pedidos`
--

CREATE TABLE `pedidos` (
  `idPedido` int(11) NOT NULL,
  `idUsuario` int(11) NOT NULL,
  `idProduto` int(11) NOT NULL,
  `data` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pedidos`
--

INSERT INTO `pedidos` (`idPedido`, `idUsuario`, `idProduto`, `data`) VALUES
(1, 1, 1, '2026-09-03 19:08:20');

--
-- Triggers `pedidos`
--
DELIMITER $$
CREATE TRIGGER `baixar_estoque_apos_pedido` AFTER INSERT ON `pedidos` FOR EACH ROW BEGIN
    UPDATE produtos
    SET quantidade = quantidade - 1
    WHERE idProduto = NEW.idProduto;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `produtos`
--

CREATE TABLE `produtos` (
  `idProduto` int(11) NOT NULL,
  `idCategoria` int(11) DEFAULT NULL,
  `nome` varchar(128) NOT NULL,
  `preco` decimal(10,2) NOT NULL,
  `quantidade` int(11) DEFAULT 10 COMMENT 'Quantidade do produto no estoque'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `produtos`
--

INSERT INTO `produtos` (`idProduto`, `idCategoria`, `nome`, `preco`, `quantidade`) VALUES
(1, 1, 'Pá de Jardim', 6000.00, 9),
(2, 1, 'Enxada de Jardim', 1500.00, NULL),
(3, 1, 'Ancinho de Aço', 2499.90, 10),
(4, 2, 'Rastelo para Folhas', 4500.00, 10),
(5, 2, 'Pazinha de Plantio', 1500.00, 10),
(6, 2, 'Garfo de Jardinagem', 250.00, 10),
(7, 2, 'Carrinho de Mão', 350.00, 10),
(8, 2, 'Vassoura para Jardim', 499.90, 10),
(9, 2, 'Escardilho Manual', 3899.90, 10),
(10, 1, 'Cavadeira Articulada', 8999.00, 10),
(11, 2, 'Sementes de Grama Esmeralda', 499.98, 10),
(13, 1, 'Sementes de Manjericão', 2999.90, 10),
(14, 1, 'Sementes de Coentro', 399.90, 10),
(15, 1, 'Muda de Roseira', 3299.90, 10),
(16, 5, 'Muda de Lavanda', 49.90, 10),
(17, 5, 'Muda de Hibisco', 89.90, 10),
(18, 5, 'Muda de Primavera', 119.90, 10),
(19, 5, 'Muda de Palmeira Areca', 79.90, 10),
(20, 5, 'Muda de Samambaia', 159.90, 10),
(21, 5, 'Adubo NPK 10-10-10', 129.90, 10),
(22, 5, 'Adubo NPK 04-14-08', 139.90, 10),
(23, 5, 'Fertilizante Orgânico', 69.90, 10),
(24, 5, 'Húmus de Minhoca', 39.90, 10),
(25, 5, 'Esterco Bovino Curtido', 99.90, 10),
(27, 3, 'Torta de Mamona', 2799.00, 10),
(28, 3, 'Fertilizante para Orquídeas', 699.00, 10),
(29, 3, 'Fertilizante para Gramados', 899.00, 10),
(30, 3, 'Composto Orgânico', 249.00, 10),
(31, 3, 'Vaso Plástico Pequeno', 3799.00, 10),
(32, 3, 'Vaso Plástico Grande', 2499.00, 10),
(33, 3, 'Vaso de Cerâmica', 2899.00, 10),
(34, 3, 'Vaso de Barro', 2199.00, 10),
(35, 3, 'Jardineira Retangular', 3499.00, 10),
(36, 3, 'Vaso Autoirrigável', 2199.00, 10),
(37, 3, 'Vaso Suspenso', 1399.00, 10),
(38, 3, 'Cachepô Decorativo', 699.00, 10),
(39, 3, 'Jardineira de Madeira', 499.00, 10),
(40, 3, 'Vaso de Fibra de Vidro', 699.00, 10),
(41, 3, 'Mangueira de Jardim 10 Metros', 249.00, 10),
(42, 3, 'Mangueira de Jardim 20 Metros', 499.00, 10),
(43, 4, 'Esguicho Regulável', 2499.00, 10),
(44, 4, 'Aspersor Giratório', 1899.00, 10),
(45, 4, 'Irrigador Oscilante', 799.00, 10),
(46, 4, 'Gotejador Ajustável', 699.00, 10),
(47, 1, 'Kit de Irrigação por Gotejamento', 1899.00, 10),
(48, 1, 'Temporizador de Irrigação', 399.00, 10),
(49, 1, 'Conector para Mangueira', 2199.00, 10),
(50, 2, 'Regador Plástico 5 Litros', 199.00, 10),
(51, 6, 'Tesoura de Poda Manual', 699.00, 10),
(52, 6, 'Tesoura de Poda Profissional', 399.00, 10),
(53, 6, 'Serrote de Poda', 149.90, 10),
(54, 6, 'Podador de Galhos Altos', 399.00, 10),
(55, 7, 'Aparador de Cerca Viva', 199.00, 10),
(56, 7, 'Roçadeira Elétrica', 149.00, 10),
(57, 7, 'Roçadeira a Gasolina', 1899.00, 10),
(58, 7, 'Cortador de Grama Elétrico', 299.00, 10),
(59, 7, 'Cortador de Grama a Gasolina', 89.90, 10),
(60, 8, 'Tesoura para Cerca Viva', 129.90, 10),
(61, 8, 'Terra Vegetal 5 kg', 119.90, 10),
(62, 8, 'Terra Vegetal 10 kg', 199.90, 10),
(63, 8, 'Substrato para Flores', 99.90, 10),
(64, 8, 'Substrato para Hortaliças', 89.90, 10),
(65, 9, 'Substrato para Orquídeas', 249.90, 10),
(66, 9, 'Substrato para Suculentas', 199.90, 10),
(67, 9, 'Casca de Pinus', 129.90, 10),
(68, 9, 'Fibra de Coco', 179.90, 10),
(69, 9, 'Areia Lavada para Jardinagem', 149.90, 10),
(70, 10, 'Argila Expandida', 399.00, 10),
(71, 10, 'Óleo de Neem para Plantas', 299.00, 10),
(72, 10, 'Sabão Inseticida para Plantas', 189.00, 10),
(73, 10, 'Armadilha Adesiva Amarela', 899.00, 10),
(74, 10, 'Armadilha Adesiva Azul', 499.00, 10),
(75, 6, 'Tela de Proteção para Hortas', 329.90, 10),
(76, 6, 'Barreira Física contra Lesmas', 499.90, 10),
(77, 6, 'Armadilha para Moscas de Frutas', 49.90, 10),
(78, 6, 'Pulverizador Manual 2 Litros', 299.90, 10),
(79, 6, 'Pulverizador Costal 20 Litros', 379.90, 10),
(80, 7, 'Rede de Proteção contra Insetos', 199.90, 10),
(81, 7, 'Placas de Grama Esmeralda', 599.90, 10),
(82, 7, 'Placas de Grama São Carlos', 129.90, 10),
(83, 7, 'Placas de Grama Batatais', 79.90, 10),
(84, 7, 'Pedras Decorativas Brancas', 249.90, 10),
(85, 8, 'Seixos Naturais', 149.90, 10),
(86, 8, 'Pedrisco para Jardim', 89.90, 10),
(87, 8, 'Manta de Drenagem', 119.90, 10),
(88, 8, 'Limitador de Grama', 139.90, 10),
(89, 8, 'Borda Decorativa para Jardim', 129.90, 10),
(90, 9, 'Manta Geotêxtil para Paisagismo', 399.90, 10),
(91, 9, 'Luvas de Jardinagem', 229.90, 10),
(92, 9, 'Avental de Jardinagem', 149.90, 10),
(93, 9, 'Joelheira para Jardinagem', 99.90, 10),
(94, 9, 'Bota de Borracha', 89.90, 10),
(95, 10, 'Chapéu de Proteção Solar', 449.90, 10),
(96, 10, 'Suporte para Vasos', 299.90, 10),
(97, 10, 'Etiquetas para Identificação de Plantas', 79.90, 10),
(98, 10, 'Cordão para Amarração de Plantas', 69.90, 10),
(99, 10, 'Tutor de Bambu para Plantas', 599.90, 10),
(100, 5, 'Camisa Social Masculina', 179.90, 10),
(101, 9, 'Jogo de Damas e Xadrez', 79.90, 10);

-- --------------------------------------------------------

--
-- Table structure for table `saidas`
--

CREATE TABLE `saidas` (
  `idSaida` int(11) NOT NULL,
  `valor` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `saidas`
--

INSERT INTO `saidas` (`idSaida`, `valor`) VALUES
(1, 600.00),
(2, 100.00),
(3, 250.00),
(4, 400.00);

-- --------------------------------------------------------

--
-- Table structure for table `servicos`
--

CREATE TABLE `servicos` (
  `idServico` int(11) NOT NULL,
  `nome` varchar(128) NOT NULL,
  `slug` varchar(128) NOT NULL,
  `descricao` text NOT NULL,
  `tempoExecucao` time NOT NULL,
  `validade` varchar(64) NOT NULL,
  `preco` decimal(10,2) NOT NULL,
  `imagem` varchar(256) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `servicos`
--

INSERT INTO `servicos` (`idServico`, `nome`, `slug`, `descricao`, `tempoExecucao`, `validade`, `preco`, `imagem`) VALUES
(1, 'Corte e Manutenção', 'corte-e-manutencao', 'Descrição do serviço', '04:00:00', '90 dias', 500.00, 'servico-de-corte-e-manutencao.png'),
(2, 'Adubação e Fertilização', 'adubacao-e-fertilizacao', 'Descrição do serviço', '04:00:00', '60 dias', 400.00, 'servico-de-adubacao-e-fertilizacao.webp'),
(3, 'Controle de Pragas', 'controle-de-pragas', 'Descrição do serviço', '04:00:00', '30 dias', 300.00, 'servico-controle-de-pragas.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `usuarios`
--

CREATE TABLE `usuarios` (
  `idUsuario` int(11) NOT NULL,
  `nome` varchar(128) NOT NULL,
  `email` varchar(128) NOT NULL,
  `rg` varchar(128) DEFAULT NULL,
  `idCidade` int(11) DEFAULT NULL,
  `sexo` enum('f','m') NOT NULL,
  `dataNascimento` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `usuarios`
--

INSERT INTO `usuarios` (`idUsuario`, `nome`, `email`, `rg`, `idCidade`, `sexo`, `dataNascimento`) VALUES
(1, 'Adilson Almeida', 'adilsontrassi@gmail.com', '25.503.782-7', 1, 'm', '1977-05-02'),
(2, 'Pedro Almeida', 'pedroalmeida@gmail.com', '23.345.378-8', 2, 'm', '1999-05-15'),
(3, 'João da Silva', 'joao.silva1@email.com', '12.345.678-9', 1, 'm', '1998-01-23'),
(4, 'Maria Oliveira', 'maria.oliveira2@email.com', '23.456.789-0', 2, 'f', '1998-02-09'),
(5, 'Carlos Santos', 'carlos.santos3@email.com', '34.567.890-1', 1, 'm', '1997-05-28'),
(6, 'Ana Souza', 'ana.souza4@email.com', '45.678.901-2', 2, 'f', '1999-08-12'),
(7, 'Pedro Ferreira', 'pedro.ferreira5@email.com', '56.789.012-3', 1, 'm', '1998-04-02'),
(8, 'Juliana Costa', 'juliana.costa6@email.com', '67.890.123-4', 2, 'f', '1996-03-11'),
(9, 'Lucas Rodrigues', 'lucas.rodrigues7@email.com', '78.901.234-5', 1, 'm', '1999-02-14'),
(10, 'Fernanda Almeida', 'fernanda.almeida8@email.com', '89.012.345-6', 2, 'f', '1999-02-15'),
(11, 'Rafael Gomes', 'rafael.gomes9@email.com', '90.123.456-7', 1, 'm', '1999-05-24'),
(12, 'Patricia Ribeiro', 'patricia.ribeiro10@email.com', '01.234.567-X', 2, 'f', '1995-06-23'),
(13, 'Marcos Carvalho', 'marcos.carvalho11@email.com', '12.345.678-9', 1, 'm', '1996-07-19'),
(14, 'Camila Martins', 'camila.martins12@email.com', '12.345.678-0', 2, 'f', '1998-06-22'),
(15, 'Bruno Rocha', 'bruno.rocha13@email.com', '23.456.789-1', 1, 'm', '1998-07-25'),
(16, 'Aline Barbosa', 'aline.barbosa14@email.com', '34.567.890-2', 2, 'f', '1997-10-18'),
(17, 'Daniel Lopes', 'daniel.lopes15@email.com', '45.678.901-3', 1, 'm', '1993-05-22'),
(18, 'Renata Moreira', 'renata.moreira16@email.com', '56.789.012-4', 2, 'f', '1998-08-21'),
(19, 'Felipe Cardoso', 'felipe.cardoso17@email.com', '67.890.123-5', 1, 'm', '1999-01-16'),
(20, 'Vanessa Teixeira', 'vanessa.teixeira18@email.com', '78.901.234-6', 2, 'f', '1996-06-27'),
(21, 'Gustavo Correia', 'gustavo.correia19@email.com', '89.012.345-7', 1, 'm', '1997-02-11'),
(22, 'Leticia Mendes', 'leticia.mendes20@email.com', '90.123.456-X', 2, 'f', '1995-09-14'),
(23, 'Rodrigo Nunes', 'rodrigo.nunes21@email.com', '12.345.678-9', 1, 'm', '1999-01-20'),
(24, 'Priscila Freitas', 'priscila.freitas22@email.com', '12.345.678-0', 2, 'f', '1997-12-25'),
(25, 'Thiago Castro', 'thiago.castro23@email.com', '23.456.789-1', 1, 'm', '1999-02-19'),
(26, 'Amanda Moura', 'amanda.moura24@email.com', '34.567.890-2', 2, 'f', NULL),
(27, 'Diego Pinto', 'diego.pinto25@email.com', '45.678.901-3', 1, 'm', NULL),
(28, 'Larissa Araujo', 'larissa.araujo26@email.com', '56.789.012-4', 2, 'f', NULL),
(29, 'Eduardo Campos', 'eduardo.campos27@email.com', '67.890.123-5', 1, 'm', NULL),
(30, 'Beatriz Dias', 'beatriz.dias28@email.com', '78.901.234-6', 2, 'f', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `usuarios_mulheres`
--

CREATE TABLE `usuarios_mulheres` (
  `idUsuario` int(11) NOT NULL,
  `nome` varchar(128) NOT NULL,
  `email` varchar(128) NOT NULL,
  `rg` varchar(128) DEFAULT NULL,
  `idCidade` int(11) DEFAULT NULL,
  `sexo` enum('f','m') NOT NULL,
  `dataNascimento` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `usuarios_mulheres`
--

INSERT INTO `usuarios_mulheres` (`idUsuario`, `nome`, `email`, `rg`, `idCidade`, `sexo`, `dataNascimento`) VALUES
(4, 'Maria Oliveira', 'maria.oliveira2@email.com', '23.456.789-0', 2, 'f', '1998-02-09'),
(6, 'Ana Souza', 'ana.souza4@email.com', '45.678.901-2', 2, 'f', '1999-08-12'),
(8, 'Juliana Costa', 'juliana.costa6@email.com', '67.890.123-4', 2, 'f', '1996-03-11'),
(10, 'Fernanda Almeida', 'fernanda.almeida8@email.com', '89.012.345-6', 2, 'f', '1999-02-15'),
(12, 'Patricia Ribeiro', 'patricia.ribeiro10@email.com', '01.234.567-X', 2, 'f', '1995-06-23'),
(14, 'Camila Martins', 'camila.martins12@email.com', '12.345.678-0', 2, 'f', '1998-06-22'),
(16, 'Aline Barbosa', 'aline.barbosa14@email.com', '34.567.890-2', 2, 'f', '1997-10-18'),
(18, 'Renata Moreira', 'renata.moreira16@email.com', '56.789.012-4', 2, 'f', '1998-08-21'),
(20, 'Vanessa Teixeira', 'vanessa.teixeira18@email.com', '78.901.234-6', 2, 'f', '1996-06-27'),
(22, 'Leticia Mendes', 'leticia.mendes20@email.com', '90.123.456-X', 2, 'f', '1995-09-14'),
(24, 'Priscila Freitas', 'priscila.freitas22@email.com', '12.345.678-0', 2, 'f', '1997-12-25'),
(26, 'Amanda Moura', 'amanda.moura24@email.com', '34.567.890-2', 2, 'f', NULL),
(28, 'Larissa Araujo', 'larissa.araujo26@email.com', '56.789.012-4', 2, 'f', NULL),
(30, 'Beatriz Dias', 'beatriz.dias28@email.com', '78.901.234-6', 2, 'f', NULL);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_usuarios_estados`
-- (See below for the actual view)
--
CREATE TABLE `v_usuarios_estados` (
`usuario` varchar(128)
,`estado` varchar(128)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `v_usuarios_produtos_parcelas`
-- (See below for the actual view)
--
CREATE TABLE `v_usuarios_produtos_parcelas` (
`idParcela` int(11)
,`usuario` varchar(128)
,`produto` varchar(128)
,`numeroParcela` int(11)
,`valor` decimal(10,2)
,`dataVencimento` date
);

-- --------------------------------------------------------

--
-- Structure for view `v_usuarios_estados`
--
DROP TABLE IF EXISTS `v_usuarios_estados`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_usuarios_estados`  AS SELECT `usuarios`.`nome` AS `usuario`, `estados`.`nome` AS `estado` FROM ((`usuarios` join `cidades` on(`usuarios`.`idCidade` = `cidades`.`idCidade`)) join `estados` on(`cidades`.`idEstado` = `estados`.`idEstado`)) ;

-- --------------------------------------------------------

--
-- Structure for view `v_usuarios_produtos_parcelas`
--
DROP TABLE IF EXISTS `v_usuarios_produtos_parcelas`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `v_usuarios_produtos_parcelas`  AS SELECT `pa`.`idParcela` AS `idParcela`, `u`.`nome` AS `usuario`, `pr`.`nome` AS `produto`, `pa`.`numeroParcela` AS `numeroParcela`, `pa`.`valor` AS `valor`, `pa`.`dataVencimento` AS `dataVencimento` FROM (((`parcelas` `pa` join `pedidos` `pe`) join `usuarios` `u`) join `produtos` `pr`) WHERE `pa`.`idPedido` = `pe`.`idPedido` AND `pe`.`idUsuario` = `u`.`idUsuario` AND `pe`.`idProduto` = `pr`.`idProduto` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `artigos`
--
ALTER TABLE `artigos`
  ADD PRIMARY KEY (`idArtigo`);

--
-- Indexes for table `categorias`
--
ALTER TABLE `categorias`
  ADD PRIMARY KEY (`idCategoria`);

--
-- Indexes for table `cidades`
--
ALTER TABLE `cidades`
  ADD PRIMARY KEY (`idCidade`),
  ADD KEY `idEstado` (`idEstado`);

--
-- Indexes for table `entradas`
--
ALTER TABLE `entradas`
  ADD PRIMARY KEY (`idEntrada`);

--
-- Indexes for table `estados`
--
ALTER TABLE `estados`
  ADD PRIMARY KEY (`idEstado`);

--
-- Indexes for table `parcelas`
--
ALTER TABLE `parcelas`
  ADD PRIMARY KEY (`idParcela`);

--
-- Indexes for table `pedidos`
--
ALTER TABLE `pedidos`
  ADD PRIMARY KEY (`idPedido`),
  ADD KEY `idUsuario` (`idUsuario`),
  ADD KEY `idProduto` (`idProduto`);

--
-- Indexes for table `produtos`
--
ALTER TABLE `produtos`
  ADD PRIMARY KEY (`idProduto`),
  ADD KEY `idCategoria` (`idCategoria`);

--
-- Indexes for table `saidas`
--
ALTER TABLE `saidas`
  ADD PRIMARY KEY (`idSaida`);

--
-- Indexes for table `servicos`
--
ALTER TABLE `servicos`
  ADD PRIMARY KEY (`idServico`);

--
-- Indexes for table `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`idUsuario`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `idCidade` (`idCidade`);

--
-- Indexes for table `usuarios_mulheres`
--
ALTER TABLE `usuarios_mulheres`
  ADD PRIMARY KEY (`idUsuario`),
  ADD UNIQUE KEY `email` (`email`),
  ADD KEY `idCidade` (`idCidade`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `artigos`
--
ALTER TABLE `artigos`
  MODIFY `idArtigo` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `categorias`
--
ALTER TABLE `categorias`
  MODIFY `idCategoria` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `cidades`
--
ALTER TABLE `cidades`
  MODIFY `idCidade` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `entradas`
--
ALTER TABLE `entradas`
  MODIFY `idEntrada` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `estados`
--
ALTER TABLE `estados`
  MODIFY `idEstado` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `parcelas`
--
ALTER TABLE `parcelas`
  MODIFY `idParcela` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `pedidos`
--
ALTER TABLE `pedidos`
  MODIFY `idPedido` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `produtos`
--
ALTER TABLE `produtos`
  MODIFY `idProduto` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=102;

--
-- AUTO_INCREMENT for table `saidas`
--
ALTER TABLE `saidas`
  MODIFY `idSaida` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `servicos`
--
ALTER TABLE `servicos`
  MODIFY `idServico` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `idUsuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=107;

--
-- AUTO_INCREMENT for table `usuarios_mulheres`
--
ALTER TABLE `usuarios_mulheres`
  MODIFY `idUsuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=31;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `cidades`
--
ALTER TABLE `cidades`
  ADD CONSTRAINT `idEstado` FOREIGN KEY (`idEstado`) REFERENCES `estados` (`idEstado`);

--
-- Constraints for table `pedidos`
--
ALTER TABLE `pedidos`
  ADD CONSTRAINT `idProduto` FOREIGN KEY (`idProduto`) REFERENCES `produtos` (`idProduto`),
  ADD CONSTRAINT `idUsuario` FOREIGN KEY (`idUsuario`) REFERENCES `usuarios` (`idUsuario`);

--
-- Constraints for table `produtos`
--
ALTER TABLE `produtos`
  ADD CONSTRAINT `idCategoria` FOREIGN KEY (`idCategoria`) REFERENCES `categorias` (`idCategoria`);

--
-- Constraints for table `usuarios`
--
ALTER TABLE `usuarios`
  ADD CONSTRAINT `idCidade` FOREIGN KEY (`idCidade`) REFERENCES `cidades` (`idCidade`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
