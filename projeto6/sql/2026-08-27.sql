-- MySQL dump 10.13  Distrib 8.0.46, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: projetox
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.32-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `categorias`
--

DROP TABLE IF EXISTS `categorias`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categorias` (
  `idCategoria` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(128) NOT NULL,
  PRIMARY KEY (`idCategoria`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorias`
--

LOCK TABLES `categorias` WRITE;
/*!40000 ALTER TABLE `categorias` DISABLE KEYS */;
INSERT INTO `categorias` VALUES (1,'Eletrônicos'),(2,'Informática'),(3,'Eletrodomésticos'),(4,'Móveis'),(5,'Roupas'),(6,'Calçados'),(7,'Esportes'),(8,'Livros'),(9,'Brinquedos'),(10,'Ferramentas');
/*!40000 ALTER TABLE `categorias` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cidades`
--

DROP TABLE IF EXISTS `cidades`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cidades` (
  `idCidade` int(11) NOT NULL AUTO_INCREMENT,
  `idEstado` int(11) NOT NULL,
  `nome` varchar(128) NOT NULL,
  PRIMARY KEY (`idCidade`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cidades`
--

LOCK TABLES `cidades` WRITE;
/*!40000 ALTER TABLE `cidades` DISABLE KEYS */;
INSERT INTO `cidades` VALUES (1,1,'Sales'),(2,2,'Teresópolis');
/*!40000 ALTER TABLE `cidades` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `entradas`
--

DROP TABLE IF EXISTS `entradas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `entradas` (
  `idEntrada` int(11) NOT NULL AUTO_INCREMENT,
  `valor` decimal(10,2) NOT NULL,
  PRIMARY KEY (`idEntrada`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `entradas`
--

LOCK TABLES `entradas` WRITE;
/*!40000 ALTER TABLE `entradas` DISABLE KEYS */;
INSERT INTO `entradas` VALUES (1,2000.00),(2,3000.00),(3,4500.00),(4,5000.00),(5,7000.00),(6,6000.00);
/*!40000 ALTER TABLE `entradas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `estados`
--

DROP TABLE IF EXISTS `estados`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `estados` (
  `idEstado` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(128) NOT NULL,
  PRIMARY KEY (`idEstado`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `estados`
--

LOCK TABLES `estados` WRITE;
/*!40000 ALTER TABLE `estados` DISABLE KEYS */;
INSERT INTO `estados` VALUES (1,'São Paulo'),(2,'Rio de Janeiro');
/*!40000 ALTER TABLE `estados` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `pedidos`
--

DROP TABLE IF EXISTS `pedidos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `pedidos` (
  `idPedido` int(11) NOT NULL AUTO_INCREMENT,
  `idUsuario` int(11) NOT NULL,
  `idProduto` int(11) NOT NULL,
  PRIMARY KEY (`idPedido`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `pedidos`
--

LOCK TABLES `pedidos` WRITE;
/*!40000 ALTER TABLE `pedidos` DISABLE KEYS */;
INSERT INTO `pedidos` VALUES (1,1,2),(2,2,1),(3,1,1);
/*!40000 ALTER TABLE `pedidos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `produtos`
--

DROP TABLE IF EXISTS `produtos`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `produtos` (
  `idProduto` int(11) NOT NULL AUTO_INCREMENT,
  `idCategoria` int(11) DEFAULT NULL,
  `nome` varchar(128) NOT NULL,
  `preco` decimal(10,2) NOT NULL,
  PRIMARY KEY (`idProduto`)
) ENGINE=InnoDB AUTO_INCREMENT=102 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `produtos`
--

LOCK TABLES `produtos` WRITE;
/*!40000 ALTER TABLE `produtos` DISABLE KEYS */;
INSERT INTO `produtos` VALUES (1,1,'PlayStation 5',5500.00),(2,1,'Xbox 360',1500.00),(3,1,'Nintendo Switch Oled',2499.90),(4,2,'Notebook Dell',4500.00),(5,2,'Monitor LG 27',1500.00),(6,2,'Mouse Gamer',250.00),(7,2,'Teclado Mecânico',350.00),(8,2,'Headset HyperX',499.90),(9,2,'Notebook Lenovo IdeaPad',3899.90),(10,1,'iPhone 16',8999.00),(11,2,'SSD Kingston 1TB',499.98),(13,1,'Motorola Edge 60',2999.90),(14,1,'Alexa Echo Dot',399.90),(15,1,'Smart TV LG 55',3299.90),(16,5,'Camiseta Básica',49.90),(17,5,'Camisa Social',89.90),(18,5,'Calça Jeans',119.90),(19,5,'Bermuda Jeans',79.90),(20,5,'Jaqueta',159.90),(21,5,'Moletom',129.90),(22,5,'Vestido',139.90),(23,5,'Saia',69.90),(24,5,'Regata',39.90),(25,5,'Blusa de Frio',99.90),(26,3,'Geladeira Brastemp Frost Free',4299.00),(27,3,'Máquina de Lavar Eletrolux 12kg',2799.00),(28,3,'Micro-ondas Panasonic 34L',699.00),(29,3,'Air Fryer Philips Walita',899.00),(30,3,'Liquidificador Arno Power Max',249.00),(31,3,'Geladeira Eletrolux Frost Free 400L',3799.00),(32,3,'Freezer Horizontal Consul 309L',2499.00),(33,3,'Máquina de Lavar Brastemp 13kg',2899.00),(34,3,'Secadora de Roupas Eletrolux',2199.00),(35,3,'lava-Louças Brastemp 10 Serviços',3499.00),(36,3,'Fogão 5 Bocas Brastemp',2199.00),(37,3,'Cooktop 5 Bocas Eletrolux',1399.00),(38,3,'Forno Elétrico Fischer 44L',699.00),(39,3,'Batedeira planetária Arno',499.00),(40,3,'Cafeteira Dolce Gusto Genio S',699.00),(41,3,'Panela Elétrica de Arroz Eletrolux',249.00),(42,3,'Aspirador de Pó Eletrolux',499.00),(43,4,'Sofá Retrátil 3 Lugares',2499.00),(44,4,'Guarda-Roupa 6 Portas',1899.00),(45,4,'Mesa de Escritório',799.00),(46,4,'Cadeira de Escritório',699.00),(47,1,'Soudbar JBL Cinema',1899.00),(48,1,'Fone Bluetooth JBL Tune',399.00),(49,1,'Smartphone Samsung Galaxy A55',2199.00),(50,2,'Mouse Logitech G203',199.00),(51,6,'Tenis Nike Air Max',699.00),(52,6,'Tenis Adidas Runfalcon',399.00),(53,6,'Sandália Feminina',149.90),(54,6,'Bota Masculina de Couro',399.00),(55,7,'Bola de Futebol Adidas',199.00),(56,7,'Luva de Goleiro',149.00),(57,7,'Bicicleta Aro 29',1899.00),(58,7,'Kit Halteres 10kg',299.00),(59,7,'Colchonete para Exercícios',89.90),(60,8,'Clean Code',129.90),(61,8,'O Programador Pragmático',119.90),(62,8,'JavaScript O Guia Definitivo',199.90),(63,8,'Banco de Dados SQL',99.90),(64,8,'HTML e CSS',89.90),(65,9,'LEGO Classic',249.90),(66,9,'Hot Wheels Pista Radical',199.90),(67,9,'Boneca Barbie',129.90),(68,9,'Carrinho de Controle Remoto',179.90),(69,9,'Banco Imobiliário',149.90),(70,10,'Furadeira Bosch 500W',399.00),(71,10,'Parafusadeira Vonder',299.00),(72,10,'Jogo de Chaves Tramontina',189.00),(73,10,'Serra Circular Makita',899.00),(74,10,'Maleta de Ferramentas 129 Peças',499.00),(75,6,'Tênis Puma Flyer Runner',329.90),(76,6,'Tênis Mizuno Wave',499.90),(77,6,'Chinelo Havaianas Top',49.90),(78,6,'Sapato Social Democrata',299.90),(79,6,'Tênis Fila Racer',379.90),(80,7,'Bola de Basquete Spalding',199.90),(81,7,'Raquete de Tênis Wilson',599.90),(82,7,'Kit de Faixas Elásticas',129.90),(83,7,'Corda de Pular Profissional',79.90),(84,7,'Mochila Esportiva Adidas',249.90),(85,8,'Estruturas de Dados e Algoritmos',149.90),(86,8,'Lógica de Programação',89.90),(87,8,'Node.js Guia Prático',119.90),(88,8,'Banco de Dados para Desenvolvedores',139.90),(89,8,'React do Básico ao Avançado',129.90),(90,9,'LEGO Technic Carro de Corrida',399.90),(91,9,'Hot Wheels Pista de Corrida',229.90),(92,9,'Jogo de Xadrez Profissional',149.90),(93,9,'Quebra-Cabeça 1000 Peças',99.90),(94,9,'Kit de Massinha Play-Doh',89.90),(95,10,'Furadeira de Impacto Vonder',449.90),(96,10,'Jogo de Soquetes 40 Peças',299.90),(97,10,'Alicate Universal Tramontina',79.90),(98,10,'Trena Stanley 5 Metros',69.90),(99,10,'Esmerilhadeira Bosch 850W',599.90),(100,5,'Camisa Social Masculina',179.90),(101,9,'Jogo de Damas e Xadrez',79.90);
/*!40000 ALTER TABLE `produtos` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `saidas`
--

DROP TABLE IF EXISTS `saidas`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `saidas` (
  `idSaida` int(11) NOT NULL AUTO_INCREMENT,
  `valor` decimal(10,2) NOT NULL,
  PRIMARY KEY (`idSaida`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `saidas`
--

LOCK TABLES `saidas` WRITE;
/*!40000 ALTER TABLE `saidas` DISABLE KEYS */;
INSERT INTO `saidas` VALUES (1,600.00),(2,100.00),(3,250.00),(4,400.00);
/*!40000 ALTER TABLE `saidas` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuarios`
--

DROP TABLE IF EXISTS `usuarios`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuarios` (
  `idUsuario` int(11) NOT NULL AUTO_INCREMENT,
  `nome` varchar(128) NOT NULL,
  `email` varchar(128) NOT NULL,
  `rg` varchar(128) DEFAULT NULL,
  `idCidade` int(11) DEFAULT NULL,
  PRIMARY KEY (`idUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuarios`
--

LOCK TABLES `usuarios` WRITE;
/*!40000 ALTER TABLE `usuarios` DISABLE KEYS */;
INSERT INTO `usuarios` VALUES (1,'Adilson Almeida','adilsontrassi@gmail.com','2550378-27',1),(2,'Pedro Almeida','pedroalmeida@gmail.com',NULL,2);
/*!40000 ALTER TABLE `usuarios` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Temporary view structure for view `v_usuarios_estados`
--

DROP TABLE IF EXISTS `v_usuarios_estados`;
/*!50001 DROP VIEW IF EXISTS `v_usuarios_estados`*/;
SET @saved_cs_client     = @@character_set_client;
/*!50503 SET character_set_client = utf8mb4 */;
/*!50001 CREATE VIEW `v_usuarios_estados` AS SELECT 
 1 AS `usuario`,
 1 AS `estado`*/;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `v_usuarios_estados`
--

/*!50001 DROP VIEW IF EXISTS `v_usuarios_estados`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = cp850 */;
/*!50001 SET character_set_results     = cp850 */;
/*!50001 SET collation_connection      = cp850_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50013 DEFINER=`root`@`localhost` SQL SECURITY DEFINER */
/*!50001 VIEW `v_usuarios_estados` AS select `usuarios`.`nome` AS `usuario`,`estados`.`nome` AS `estado` from ((`usuarios` join `cidades` on(`usuarios`.`idCidade` = `cidades`.`idCidade`)) join `estados` on(`cidades`.`idEstado` = `estados`.`idEstado`)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-08-27 19:16:37
