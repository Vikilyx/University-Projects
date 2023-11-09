-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Creato il: Gen 11, 2023 alle 16:45
-- Versione del server: 10.4.27-MariaDB
-- Versione PHP: 7.4.33

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `Canile Veneto`
--

-- --------------------------------------------------------

--
-- Struttura della tabella `Adottanti`
--

CREATE TABLE `Adottanti` (
  `Id_Adottante` varchar(255) NOT NULL,
  `nome` varchar(20) DEFAULT NULL,
  `telefono` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `Adottanti`
--

INSERT INTO `Adottanti` (`Id_Adottante`, `nome`, `telefono`) VALUES
('001', 'Alfredo', 347943845),
('002', 'Giuseppe', 347933845),
('003', 'Carmela', 348933845);

-- --------------------------------------------------------

--
-- Struttura della tabella `Adozioni`
--

CREATE TABLE `Adozioni` (
  `Cane` varchar(255) DEFAULT NULL,
  `Adottante` varchar(255) DEFAULT NULL,
  `DT_Adozione` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `Adozioni`
--

INSERT INTO `Adozioni` (`Cane`, `Adottante`, `DT_Adozione`) VALUES
('001/2020', '001', '2021-01-19');

-- --------------------------------------------------------

--
-- Struttura della tabella `Attivita`
--

CREATE TABLE `Attivita` (
  `Id_Attività` varchar(255) NOT NULL,
  `Descrizione` varchar(255) DEFAULT NULL,
  `Frequenza` varchar(1) DEFAULT NULL,
  `DT_Inizio` date DEFAULT NULL,
  `DT_Fine` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `Attivita`
--

INSERT INTO `Attivita` (`Id_Attività`, `Descrizione`, `Frequenza`, `DT_Inizio`, `DT_Fine`) VALUES
('COL/01', 'Colletta alimentare', 'M', '2022-07-21', '2022-09-21'),
('COL/02', 'Colletta alimentare', 'M', '2022-02-27', '2022-05-27'),
('GES/01', 'Gestione dei pasti', 'D', '2023-03-01', '2023-06-01'),
('PUL/01', 'Pulizia Cucce', 'W', '2022-09-21', '2022-12-21'),
('PUL/02', 'Pulizia Cucce', 'W', '2022-10-10', '2022-12-10');

-- --------------------------------------------------------

--
-- Struttura della tabella `Cani`
--

CREATE TABLE `Cani` (
  `Id_Cane` varchar(255) NOT NULL,
  `foto` varchar(255) DEFAULT NULL,
  `nome` varchar(255) DEFAULT NULL,
  `sesso` varchar(255) DEFAULT NULL,
  `comune_ritrovamento` varchar(255) DEFAULT NULL,
  `DT_ritrovamento` date DEFAULT NULL,
  `manto` varchar(255) DEFAULT NULL,
  `taglia` varchar(255) DEFAULT NULL,
  `razza` varchar(255) DEFAULT NULL,
  `anno_nascita` int(11) DEFAULT NULL,
  `Veterinario` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `Cani`
--

INSERT INTO `Cani` (`Id_Cane`, `foto`, `nome`, `sesso`, `comune_ritrovamento`, `DT_ritrovamento`, `manto`, `taglia`, `razza`, `anno_nascita`, `Veterinario`) VALUES
('001/2020', '.jpeg', 'Kikko', 'M', 'Macerata', '2020-11-27', 'Maculato', 'Media', 'Meticcio', 2019, 'INF/01'),
('002/2020', '.jpeg', 'Mery', 'F', 'Bolzano', '2020-02-13', 'Castano', 'Piccola', 'Meticcio', 2020, 'INF/01'),
('003/2020', '.jpeg', 'Adam', 'M', 'Asturia', '2021-05-14', 'Bianco', 'Grande', 'Alano', 2020, 'INF/02');

-- --------------------------------------------------------

--
-- Struttura della tabella `Disponibilità_attivita`
--

CREATE TABLE `Disponibilità_attivita` (
  `Id_Volontario` varchar(255) DEFAULT NULL,
  `Id_Attivita` varchar(255) NOT NULL,
  `Giorni_disponibili` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `Disponibilità_attivita`
--

INSERT INTO `Disponibilità_attivita` (`Id_Volontario`, `Id_Attivita`, `Giorni_disponibili`) VALUES
('VOL/01', 'COL/01', 'Lunedì-Martedì-Mercoledì'),
('VOL/02', 'COL/01', 'Lunedì-Mercoledì'),
('INF/01', 'PUL/01', 'Mercoledì'),
('INF/02', 'PUL/02', 'Venerdì'),
('INF/01', 'PUL/02', 'Sabato'),
('INF/01', 'COL/01', ''),
('INF/01', 'COL/02', 'Domenica');

-- --------------------------------------------------------

--
-- Struttura stand-in per le viste `storico_attività`
-- (Vedi sotto per la vista effettiva)
--
CREATE TABLE `storico_attività` (
`Id_Attività` varchar(255)
,`Descrizione` varchar(255)
,`Frequenza` varchar(1)
,`DT_Inizio` date
,`DT_Fine` date
,`Id_Volontario` varchar(255)
,`nome` varchar(20)
,`cognome` varchar(20)
,`telefono` int(11)
,`CDF` varchar(16)
);

-- --------------------------------------------------------

--
-- Struttura della tabella `Turni_Attivita`
--

CREATE TABLE `Turni_Attivita` (
  `Id_Attività` varchar(255) DEFAULT NULL,
  `Id_Volontario` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `Turni_Attivita`
--

INSERT INTO `Turni_Attivita` (`Id_Attività`, `Id_Volontario`) VALUES
('COL/01', 'VOL/01'),
('COL/01', 'VOL/02'),
('PUL/01', 'INF/01'),
('PUL/02', 'INF/02'),
('COL/02', 'INF/01');

-- --------------------------------------------------------

--
-- Struttura della tabella `Visite`
--

CREATE TABLE `Visite` (
  `Id_Volontario` varchar(255) DEFAULT NULL,
  `Id_Cane` varchar(255) DEFAULT NULL,
  `eseguita` date DEFAULT NULL,
  `esito` varchar(255) DEFAULT NULL,
  `terapia` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `Visite`
--

INSERT INTO `Visite` (`Id_Volontario`, `Id_Cane`, `eseguita`, `esito`, `terapia`) VALUES
('INF/01', '001/2020', '2020-11-30', 'Positivo', 'Nessuna'),
('INF/01', '002/2020', '2020-02-13', 'Positivo', 'Nessuna'),
('INF/02', '003/2020', '2020-05-15', 'Osteoporosi,Infezioni batteriche,Assenza di denti', 'Fosfato di calcio 2mgx60gg,Crema per funghi,Cibo liquido');

-- --------------------------------------------------------

--
-- Struttura della tabella `Volontari`
--

CREATE TABLE `Volontari` (
  `Id_Volontario` varchar(255) NOT NULL,
  `nome` varchar(20) DEFAULT NULL,
  `cognome` varchar(20) DEFAULT NULL,
  `telefono` int(11) NOT NULL,
  `CDF` varchar(16) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dump dei dati per la tabella `Volontari`
--

INSERT INTO `Volontari` (`Id_Volontario`, `nome`, `cognome`, `telefono`, `CDF`) VALUES
('INF/01', 'Amarando', 'Alighieri', 32833728, 'AMAL49C07C23'),
('INF/02', 'Alberta', 'Frescherelli', 32395728, 'ALFR47C07C57'),
('VOL/01', 'Ambrogio', 'Serpini', 328346728, NULL),
('VOL/02', 'Gino', 'Perino', 31247728, NULL);

-- --------------------------------------------------------

--
-- Struttura per vista `storico_attività`
--
DROP TABLE IF EXISTS `storico_attività`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `canile veneto`.`storico_attività`  AS SELECT `canile veneto`.`attivita`.`Id_Attività` AS `Id_Attività`, `canile veneto`.`attivita`.`Descrizione` AS `Descrizione`, `canile veneto`.`attivita`.`Frequenza` AS `Frequenza`, `canile veneto`.`attivita`.`DT_Inizio` AS `DT_Inizio`, `canile veneto`.`attivita`.`DT_Fine` AS `DT_Fine`, `canile veneto`.`volontari`.`Id_Volontario` AS `Id_Volontario`, `canile veneto`.`volontari`.`nome` AS `nome`, `canile veneto`.`volontari`.`cognome` AS `cognome`, `canile veneto`.`volontari`.`telefono` AS `telefono`, `canile veneto`.`volontari`.`CDF` AS `CDF` FROM ((`canile veneto`.`attivita` left join `canile veneto`.`turni_attivita` on(`canile veneto`.`attivita`.`Id_Attività` = `canile veneto`.`turni_attivita`.`Id_Attività`)) left join `canile veneto`.`volontari` on(`canile veneto`.`turni_attivita`.`Id_Volontario` = `canile veneto`.`volontari`.`Id_Volontario`)) WHERE `canile veneto`.`attivita`.`DT_Fine` < curdate()  ;

--
-- Indici per le tabelle scaricate
--

--
-- Indici per le tabelle `Adottanti`
--
ALTER TABLE `Adottanti`
  ADD PRIMARY KEY (`Id_Adottante`);

--
-- Indici per le tabelle `Adozioni`
--
ALTER TABLE `Adozioni`
  ADD KEY `Cane` (`Cane`),
  ADD KEY `Adottante` (`Adottante`);

--
-- Indici per le tabelle `Attivita`
--
ALTER TABLE `Attivita`
  ADD PRIMARY KEY (`Id_Attività`);

--
-- Indici per le tabelle `Cani`
--
ALTER TABLE `Cani`
  ADD PRIMARY KEY (`Id_Cane`),
  ADD KEY `Cani_relation_1` (`Veterinario`);

--
-- Indici per le tabelle `Disponibilità_attivita`
--
ALTER TABLE `Disponibilità_attivita`
  ADD KEY `Disponibilità_attivita_relation_1` (`Id_Volontario`),
  ADD KEY `Disponibilità_attivita_relation_2` (`Id_Attivita`);

--
-- Indici per le tabelle `Turni_Attivita`
--
ALTER TABLE `Turni_Attivita`
  ADD KEY `Partecipazioni_Attivita_relation_1` (`Id_Attività`),
  ADD KEY `Partecipazioni_Attivita_relation_2` (`Id_Volontario`);

--
-- Indici per le tabelle `Visite`
--
ALTER TABLE `Visite`
  ADD KEY `Visite_relation_1` (`Id_Volontario`),
  ADD KEY `Visite_relation_2` (`Id_Cane`);

--
-- Indici per le tabelle `Volontari`
--
ALTER TABLE `Volontari`
  ADD PRIMARY KEY (`Id_Volontario`);

--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `Adozioni`
--
ALTER TABLE `Adozioni`
  ADD CONSTRAINT `adozioni_ibfk_1` FOREIGN KEY (`Cane`) REFERENCES `Cani` (`Id_Cane`) ON DELETE NO ACTION,
  ADD CONSTRAINT `adozioni_ibfk_2` FOREIGN KEY (`Adottante`) REFERENCES `Adottanti` (`Id_Adottante`) ON DELETE NO ACTION;

--
-- Limiti per la tabella `Cani`
--
ALTER TABLE `Cani`
  ADD CONSTRAINT `Cani_relation_1` FOREIGN KEY (`Veterinario`) REFERENCES `Volontari` (`Id_Volontario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limiti per la tabella `Disponibilità_attivita`
--
ALTER TABLE `Disponibilità_attivita`
  ADD CONSTRAINT `Disponibilità_attivita_relation_1` FOREIGN KEY (`Id_Volontario`) REFERENCES `Volontari` (`Id_Volontario`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `Disponibilità_attivita_relation_2` FOREIGN KEY (`Id_Attivita`) REFERENCES `Attivita` (`Id_Attività`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limiti per la tabella `Turni_Attivita`
--
ALTER TABLE `Turni_Attivita`
  ADD CONSTRAINT `Partecipazioni_Attivita_relation_1` FOREIGN KEY (`Id_Attività`) REFERENCES `Attivita` (`Id_Attività`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `Partecipazioni_Attivita_relation_2` FOREIGN KEY (`Id_Volontario`) REFERENCES `Volontari` (`Id_Volontario`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Limiti per la tabella `Visite`
--
ALTER TABLE `Visite`
  ADD CONSTRAINT `Visite_relation_1` FOREIGN KEY (`Id_Volontario`) REFERENCES `Volontari` (`Id_Volontario`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `Visite_relation_2` FOREIGN KEY (`Id_Cane`) REFERENCES `Cani` (`Id_Cane`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
