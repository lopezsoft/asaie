 /**********************         A partir de enero 4 de 2019	       *************************** /
-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.2.10-MariaDB-log - mariadb.org binary distribution
-- SO del servidor:              Win64
-- HeidiSQL Versión:             9.5.0.5433
-- --------------------------------------------------------


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Volcando estructura para tabla matiaspv.countries
DROP TABLE IF EXISTS `countries`;
CREATE TABLE IF NOT EXISTS `countries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `ContinentA2` varchar(2) NOT NULL DEFAULT '',
  `abbreviation_A2` varchar(6) NOT NULL,
  `abbreviation_A3` varchar(6) NOT NULL DEFAULT '',
  `FIPS` varchar(4) NOT NULL DEFAULT '',
  `NUTS` varchar(2) NOT NULL DEFAULT '',
  `HASC` varchar(2) NOT NULL DEFAULT '',
  `country_name` varchar(150) NOT NULL,
  `language` varchar(3) NOT NULL DEFAULT '',
  `LanguagePC` varchar(10) NOT NULL DEFAULT '',
  `phone_code` varchar(6) NOT NULL DEFAULT '',
  `TLD` varchar(6) NOT NULL DEFAULT '',
  `Latitude` int(11) NOT NULL DEFAULT 0,
  `Longitude` int(11) NOT NULL DEFAULT 0,
  `Altitude` int(11) NOT NULL DEFAULT 0,
  `TerritoryOf` varchar(3) NOT NULL DEFAULT '',
  `image` varchar(120) NOT NULL DEFAULT '',
  `active` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `pais` (`phone_code`) USING BTREE,
  UNIQUE KEY `abbreviation_A2` (`abbreviation_A2`)
) ENGINE=InnoDB AUTO_INCREMENT=1255 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC;

-- Volcando datos para la tabla matiaspv.countries: ~250 rows (aproximadamente)
/*!40000 ALTER TABLE `countries` DISABLE KEYS */;
INSERT INTO `countries` (`id`, `ContinentA2`, `abbreviation_A2`, `abbreviation_A3`, `FIPS`, `NUTS`, `HASC`, `country_name`, `language`, `LanguagePC`, `phone_code`, `TLD`, `Latitude`, `Longitude`, `Altitude`, `TerritoryOf`, `image`, `active`) VALUES
	(1, '', 'AIA', '', '', '', '', 'Anguila', '', '', '1 264', '', 0, 0, 0, '0', 'anguila.png', 0),
	(2, '', 'ATG', '', '', '', '', 'Antigua y Barbuda', '', '', '1 268', '', 0, 0, 0, '0', 'antigua y barbuda.png', 0),
	(3, '', 'BHS', '', '', '', '', 'Bahamas', '', '', '1 242', '', 0, 0, 0, '0', 'bahamas.png', 0),
	(4, '', 'BRB', '', '', '', '', 'Barbados', '', '', '1 246', '', 0, 0, 0, '0', 'barbados.png', 0),
	(5, 'AS', 'BD', 'BGD', 'BG00', '', 'BD', 'Bangladesh', 'BN', 'EN', '880', '.bd', 24309, 90058, 85, '', '', 0),
	(6, '', 'DMA', '', '', '', '', 'Dominica', '', '', '1 767', '', 0, 0, 0, '0', 'dominica.png', 0),
	(7, '', 'SVK', '', '', '', '', 'Eslovaquia', '', '', '421', '', 0, 0, 0, '0', 'eslovaquia.png', 0),
	(8, '', 'GRD', '', '', '', '', 'Granada', '', '', '1 473', '', 0, 0, 0, '0', 'granada.png', 0),
	(9, '', 'BMU', '', '', '', '', 'Islas Bermudas', '', '', '1 441', '', 0, 0, 0, '0', 'islas bermudas.png', 0),
	(10, '', 'CYM', '', '', '', '', 'Islas Caimán', '', '', '1 345', '', 0, 0, 0, '0', 'islas caiman.png', 0),
	(11, '', 'MNP', '', '', '', '', 'Islas Marianas del Norte', '', '', '1 670', '', 0, 0, 0, '0', 'islas marianas del norte.png', 0),
	(12, '', 'PCN', '', '', '', '', 'Islas Pitcairn', '', '', '870', '', 0, 0, 0, '0', 'islas pitcairn.png', 0),
	(13, '', 'TCA', '', '', '', '', 'Islas Turcas y Caicos', '', '', '1 649', '', 0, 0, 0, '0', 'islas turcas y caicos.png', 0),
	(14, '', 'VIR', '', '', '', '', 'Islas Vírgenes de los Estados Unidos', '', '', '1 340', '', 0, 0, 0, '0', 'islas virgenes de los estados unidos.png', 0),
	(15, '', 'JAM', '', '', '', '', 'Jamaica', '', '', '1 876', '', 0, 0, 0, '0', 'jamaica.png', 0),
	(16, '', 'KGZ', '', '', '', '', 'Kirgizstán', '', '', '996', '', 0, 0, 0, '0', 'kirgizstan.png', 0),
	(17, '', 'LIE', '', '', '', '', 'Liechtenstein', '', '', '423', '', 0, 0, 0, '0', 'liechtenstein.png', 0),
	(18, '', 'MCO', '', '', '', '', 'Mónaco', '', '', '377', '', 0, 0, 0, '0', 'monaco.png', 0),
	(19, '', 'MNE', '', '', '', '', 'Montenegro', '', '', '382', '', 0, 0, 0, '0', 'montenegro.png', 0),
	(20, '', 'MSR', '', '', '', '', 'Montserrat', '', '', '1 664', '', 0, 0, 0, '0', 'montserrat.png', 0),
	(21, '', 'CZE', '', '', '', '', 'República Checa', '', '', '420', '', 0, 0, 0, '0', 'republica checa.png', 0),
	(22, '', 'DOM', '', '', '', '', 'República Dominicana', '', '', '1 809', '', 0, 0, 0, '0', 'republica dominicana.png', 0),
	(23, '', 'ASM', '', '', '', '', 'Samoa Americana', '', '', '1 684', '', 0, 0, 0, '0', 'samoa americana.png', 0),
	(24, '', 'KNA', '', '', '', '', 'San Cristóbal y Nieves', '', '', '1 869', '', 0, 0, 0, '0', 'san cristobal y nieves.png', 0),
	(25, '', 'MAF', '', '', '', '', 'San Martín (Francia)', '', '', '1 599', '', 0, 0, 0, '0', 'san martin (francia).png', 0),
	(26, '', 'VCT', '', '', '', '', 'San Vicente y las Granadinas', '', '', '1 784', '', 0, 0, 0, '0', 'san vicente y las granadinas.png', 0),
	(27, '', 'LCA', '', '', '', '', 'Santa Lucía', '', '', '1 758', '', 0, 0, 0, '0', 'santa lucia.png', 0),
	(28, '', 'TJK', '', '', '', '', 'Tadjikistán', '', '', '992', '', 0, 0, 0, '0', 'tadjikistan.png', 0),
	(29, '', 'TTO', '', '', '', '', 'Trinidad y Tobago', '', '', '1 868', '', 0, 0, 0, '0', 'trinidad y tobago.png', 0),
	(30, '', 'UZB', '', '', '', '', 'Uzbekistán', '', '', '998', '', 0, 0, 0, '0', 'uzbekistan.png', 0),
	(31, 'AS', 'AF', 'AFG', 'AF00', '', 'AF', 'Afghanistan', 'FA', 'EN', '93', '.af', 33833, 66025, 1884, '', '', 0),
	(32, 'EU', 'AX', 'ALA', '-', '', 'AX', 'Åland Islands', 'SV', 'EN,SV', '+358-1', '.ax', 60202, 19965, 4, 'FI', '', 0),
	(33, 'EU', 'AL', 'ALB', 'AL00', '', 'AL', 'Albania', 'SQ', 'SQ', '355', '.al', 41111, 20027, 708, '', '', 0),
	(34, 'AF', 'DZ', 'DZA', 'AG00', '', 'DZ', 'Algeria', 'AR', 'FR', '213', '.dz', 28214, 2655, 800, '', '', 0),
	(35, 'OC', 'AS', 'ASM', 'AQ00', '', 'AS', 'American Samoa', 'EN', 'EN', '684', '.as', -14330, -170750, 193, 'US', '', 0),
	(36, 'EU', 'AD', 'AND', 'AN00', '', 'AD', 'Andorra', 'CA', 'CA', '376', '.ad', 42551, 1576, 1996, '', '', 0),
	(37, 'AF', 'AO', 'AGO', 'AO00', '', 'AO', 'Angola', 'PT', 'PT', '244', '.ao', -12333, 17539, 1112, '', '', 0),
	(38, 'NA', 'AG', 'ATG', 'AC00', '', 'AG', 'Antigua and Barbuda', 'EN', 'EN', '1268', '.ag', 17146, -61821, 62, '', '', 0),
	(39, 'SA', 'AR', 'ARG', 'AR00', '', 'AR', 'Argentina', 'ES', 'ES', '54', '.ar', -35630, -65159, 595, '', 'argentina.png', 1),
	(40, 'AS', 'AM', 'ARM', 'AM00', '', 'AM', 'Armenia', 'HY', 'EN,HY', '374', '.am', 40292, 44937, 1792, '', '', 0),
	(41, 'NA', 'AW', 'ABW', 'AA00', '', 'AW', 'Aruba', 'NL', 'NL', '297', '.aw', 12498, -69937, 65, 'NL', '', 0),
	(42, 'EU', 'AT', 'AUT', 'AU00', 'AT', 'AT', 'Austria', 'DE', 'DE', '43', '.at', 47589, 14140, 910, '', '', 0),
	(43, 'AS', 'AZ', 'AZE', 'AJ00', '', 'AZ', 'Azerbaijan', 'AZ', 'EN,AZ', '994', '.az', 40356, 47869, 384, '', '', 0),
	(44, 'AS', 'BH', 'BHR', 'BA00', '', 'BH', 'Bahrain', 'AR', 'EN', '973', '.bh', 26094, 50543, 24, '', '', 0),
	(45, 'SA', 'CO', 'COL', 'CO00', '', 'CO', 'Colombia', 'ES', 'ES', '57', '.co', 3998, -73278, 593, '', 'colombia.png', 1),
	(46, 'NA', 'BB', 'BRB', 'BB00', '', 'BB', 'Barbados', 'EN', 'EN', '246', '.bb', 13178, -59549, 67, '', '', 0),
	(47, 'EU', 'BY', 'BLR', 'BO00', '', 'BY', 'Belarus', 'BE', 'EN,RU', '375', '.by', 53543, 28055, 160, '', '', 0),
	(48, 'EU', 'BE', 'BEL', 'BE00', 'BE', 'BE', 'Belgium', 'FR', 'FR,NL', '32', '.be', 50649, 4642, 181, '', '', 0),
	(49, 'SA', 'BZ', 'BLZ', 'BH00', '', 'BZ', 'Belize', 'EN', 'EN', '501', '.bz', 17330, -88630, 173, '', '', 0),
	(50, 'AF', 'BJ', 'BEN', 'BN00', '', 'BJ', 'Benin', 'FR', 'FR', '229', '.bj', 9624, 2338, 273, '', '', 0),
	(51, 'NA', 'BM', 'BMU', 'BD00', '', 'BM', 'Bermuda', 'EN', 'EN', '441', '.bm', 32303, -64752, 15, 'GB', '', 0),
	(52, 'AS', 'BT', 'BTN', 'BT00', '', 'BT', 'Bhutan', 'DZ', 'EN', '975', '.bt', 27417, 90435, 2220, '', '', 0),
	(53, 'SA', 'BO', 'BOL', 'BL00', '', 'BO', 'Bolivia', 'ES', 'ES', '591', '.bo', -16712, -64666, 1192, '', 'bolivia.png', 1),
	(54, 'EU', 'BA', 'BIH', 'BK00', '', 'BA', 'Bosnia and Herzegovina', 'BS', 'BS', '387', '.ba', 44169, 17783, 500, '', '', 0),
	(55, 'AF', 'BW', 'BWA', 'BC00', '', 'BW', 'Botswana', 'EN', 'EN', '267', '.bw', -22189, 23814, 1013, '', '', 0),
	(56, 'SA', 'BR', 'BRA', 'BR00', '', 'BR', 'Brazil', 'PT', 'PT', '55', '.br', -10808, -52975, 320, '', '', 0),
	(57, 'EU', 'IO', 'IOT', 'IO00', '', 'IO', 'British Indian Ocean Territory', 'EN', 'EN', '284', '.io', -6108, 71889, 3, 'GB', '', 0),
	(58, 'NA', 'VG', 'VGB', 'VI00', '', 'VG', 'British Virgin Islands', 'EN', 'EN', '1340', '.vg', 18492, -64551, 104, 'GB', '', 0),
	(59, 'AS', 'BN', 'BRN', 'BX00', '', 'BN', 'Brunei Darussalam', 'MS', 'EN', '673', '.bn', 4570, 114748, 36, '', '', 0),
	(60, 'EU', 'BG', 'BGR', 'BU00', 'BG', 'BG', 'Bulgaria', 'BG', 'EN,BG', '359', '.bg', 42767, 25282, 472, '', '', 0),
	(61, 'AF', 'BF', 'BFA', 'UV00', '', 'BF', 'Burkina Faso', 'FR', 'FR', '226', '.bf', 12285, -1746, 297, '', '', 0),
	(62, 'AF', 'BI', 'BDI', 'BY00', '', 'BI', 'Burundi', 'FR', 'FR', '257', '.bi', -3365, 29887, 1504, '', '', 0),
	(63, 'AS', 'KH', 'KHM', 'CB00', '', 'KH', 'Cambodia', 'KM', 'EN', '855', '.kh', 12570, 104814, 126, '', '', 0),
	(64, 'AF', 'CM', 'CMR', 'CM00', '', 'CM', 'Cameroon', 'FR', 'FR', '237', '.cm', 5685, 12723, 667, '', '', 0),
	(65, 'AF', 'CV', 'CPV', 'CV00', '', 'CV', 'Cape Verde', 'PT', 'PT', '238', '.cv', 16315, -24035, 565, '', '', 0),
	(66, 'NA', 'KY', 'CYM', 'CJ00', '', 'KY', 'Cayman Islands', 'EN', 'EN', '345', '.ky', 19511, -80605, 9, 'GB', '', 0),
	(67, 'AF', 'CF', 'CAF', 'CT00', '', 'CF', 'Central African Republic', 'FR', 'FR', '236', '.cf', 6574, 20487, 635, '', '', 0),
	(68, 'AF', 'TD', 'TCD', 'CD00', '', 'TD', 'Chad', 'FR', 'FR', '235', '.td', 15943, 18943, 543, '', '', 0),
	(69, 'SA', 'CL', 'CHL', 'CI00', '', 'CL', 'Chile', 'ES', 'ES', '56', '.cl', -39117, -72441, 1871, '', 'chile.png', 1),
	(70, 'AS', 'CN', 'CHN', 'CH00', '', 'CN', 'China', 'ZH', 'EN,ZH', '86', '.cn', 36554, 104056, 1840, '', '', 0),
	(71, 'AS', 'CC', 'CCK', 'CK00', '', 'CC', 'Cocos (Keeling) Islands', 'MS', 'EN,MS', '61', '.cc', -12043, 96893, 1, 'AU', '', 0),
	(72, 'AF', 'CG', 'COG', 'CF00', '', 'CG', 'Congo (Brazzaville)', 'FR', 'FR', '242', '.cg', -641, 15638, 320, '', '', 0),
	(73, 'AF', 'CD', 'COD', 'CG00', '', 'CD', 'Congo DR', 'FR', 'FR', '243', '.cd', -2880, 23656, 726, '', '', 0),
	(74, 'OC', 'CK', 'COK', 'CW00', '', 'CK', 'Cook Islands', 'EN', 'EN', '682', '.ck', -21234, -159778, 130, 'NZ', '', 0),
	(75, 'SA', 'CR', 'CRI', 'CS00', '', 'CR', 'Costa Rica', 'ES', 'ES', '506', '.cr', 10000, -83881, 746, '', 'costa rica.png', 1),
	(76, 'AF', 'CI', 'CIV', 'IV00', '', 'CI', 'Côte D\Ivoire', 'FR', 'FR', '225', '.ci', 7599, -5553, 237, '', '', 0),
	(77, 'EU', 'HR', 'HRV', 'HR00', 'HR', 'HR', 'Croatia', 'HR', 'HR', '385', '.hr', 45743, 17099, 331, '', '', 0),
	(78, 'NA', 'CU', 'CUB', 'CU00', '', 'CU', 'Cuba', 'ES', 'ES', '53', '.cu', 22103, -79014, 108, '', 'cuba.png', 1),
	(79, 'NA', 'CW', 'CUW', 'UC00', '', 'CW', 'Curaçao', 'NL', 'NL', '599-9', '.cw', 12145, -68919, 75, 'NL', '', 0),
	(80, 'AS', 'CY', 'CYP', 'CY00', 'CY', 'CY', 'Cyprus', 'EL', 'EN,EL', '357', '.cy', 35051, 33295, 91, '', '', 0),
	(81, 'EU', 'DK', 'DNK', 'DA00', '', 'DK', 'Denmark', 'DA', 'DA', '45', '.dk', 56102, 9556, 34, '', '', 0),
	(82, 'AF', 'DJ', 'DJI', 'DJ00', '', 'DJ', 'Djibouti', 'FR', 'FR', '253', '.dj', 11743, 42632, 430, '', '', 0),
	(83, 'NA', 'DM', 'DMA', 'DO00', '', 'DM', 'Dominica', 'EN', 'EN', '767', '.dm', 15399, -61339, 289, '', '', 0),
	(84, 'SA', 'EC', 'ECU', 'EC00', '', 'EC', 'Ecuador', 'ES', 'ES', '593', '.ec', -1422, -78871, 1117, '', 'ecuador.png', 1),
	(85, 'AF', 'EG', 'EGY', 'EG00', '', 'EG', 'Egypt', 'AR', 'EN', '20', '.eg', 26747, 29869, 321, '', '', 0),
	(86, 'SA', 'SV', 'SLV', 'ES00', '', 'SV', 'El Salvador', 'ES', 'ES', '503', '.sv', 13669, -88866, 442, '', 'el salvador.png', 1),
	(87, 'AF', 'GQ', 'GNQ', 'EK00', '', 'GQ', 'Equatorial Guinea', 'ES', 'ES', '240', '.gq', 1533, 10373, 577, '', 'equatorial guinea.png', 1),
	(88, 'AF', 'ER', 'ERI', 'ER00', '', 'ER', 'Eritrea', 'AA', 'EN', '291', '.er', 15638, 38851, 853, '', '', 0),
	(89, 'EU', 'EE', 'EST', 'EN00', 'EE', 'EE', 'Estonia', 'ET', 'ET', '372', '.ee', 58694, 25253, 61, '', '', 0),
	(90, 'AF', 'ET', 'ETH', 'ET00', '', 'ET', 'Ethiopia', 'AM', 'EN', '251', '.et', 8622, 39635, 1330, '', '', 0),
	(91, 'SA', 'FK', 'FLK', 'FK00', '', 'FK', 'Falkland Islands', 'EN', 'EN', '500', '.fk', -51773, -59728, 141, 'GB', '', 0),
	(92, 'EU', 'FO', 'FRO', 'FO00', '', 'FO', 'Faroe Islands', 'FO', 'FO', '298', '.fo', 61954, -6857, 176, 'DK', '', 0),
	(93, 'OC', 'FJ', 'FJI', 'FJ00', '', 'FJ', 'Fiji', 'EN', 'EN', '679', '.fj', -16514, 179454, 264, '', '', 0),
	(94, 'EU', 'FI', 'FIN', 'FI00', 'FI', 'FI', 'Finland', 'FI', 'FI,SV', '358', '.fi', 64290, 25992, 164, '', '', 0),
	(95, 'EU', 'FR', 'FRA', 'FR00', 'FR', 'FR', 'France', 'FR', 'FR', '33', '.fr', 46642, 2338, 375, '', '', 0),
	(96, 'SA', 'GF', 'GUF', 'FG00', '', 'GF', 'French Guiana', 'FR', 'FR', '594', '.gf', 4118, -53134, 168, 'FR', '', 0),
	(97, 'OC', 'PF', 'PYF', 'FP00', '', 'PF', 'French Polynesia', 'FR', 'FR', '689', '.pf', -18280, -142223, 448, 'FR', '', 0),
	(98, 'AF', 'GA', 'GAB', 'GB00', '', 'GA', 'Gabon', 'FR', 'FR', '241', '.ga', -635, 11739, 377, '', '', 0),
	(99, 'AF', 'GM', 'GMB', 'GA00', '', 'GM', 'Gambia', 'EN', 'EN', '220', '.gm', 13440, -15491, 34, '', '', 0),
	(100, 'EU', 'DE', 'DEU', 'GM00', 'DE', 'DE', 'Germany', 'DE', 'DE', '49', '.de', 51202, 10382, 263, '', '', 0),
	(101, 'AF', 'GH', 'GHA', 'GH00', '', 'GH', 'Ghana', 'EN', 'EN', '233', '.gh', 7921, -1204, 190, '', '', 0),
	(102, 'EU', 'GI', 'GIB', 'GI00', '', 'GI', 'Gibraltar', 'EN', 'EN', '350', '.gi', 36136, -5349, 43, 'GB', '', 0),
	(103, 'EU', 'GR', 'GRC', 'GR00', 'EL', 'GR', 'Greece', 'EL', 'EN,EL', '30', '.gr', 38301, 23741, 498, '', '', 0),
	(104, 'NA', 'GL', 'GRL', 'GL00', '', 'GL', 'Greenland', 'KL', 'DA', '299', '.gl', 74350, -41090, 1792, 'DK', '', 0),
	(105, 'NA', 'GD', 'GRD', 'GJ00', '', 'GD', 'Grenada', 'EN', 'EN', '473', '.gd', 12196, -61640, 132, '', '', 0),
	(106, 'OC', 'GU', 'GUM', 'GQ00', '', 'GU', 'Guam', 'EN', 'EN', '671', '.gu', 13124, 144694, 41, 'US', '', 0),
	(107, 'SA', 'GT', 'GTM', 'GT00', '', 'GT', 'Guatemala', 'ES', 'ES', '502', '.gt', 15478, -90156, 759, '', 'guatemala.png', 1),
	(108, 'EU', 'GG', 'GGY', 'GK00', '', 'GG', 'Guernsey', 'EN', 'EN', '+44-14', '.gg', 49528, -2406, 22, 'GB', '', 0),
	(109, 'AF', 'GN', 'GIN', 'GV00', '', 'GN', 'Guinea', 'FR', 'FR', '224', '.gn', 10967, -10922, 472, '', '', 0),
	(110, 'AF', 'GW', 'GNB', 'PU00', '', 'GW', 'Guinea-Bissau', 'PT', 'PT', '245', '.gw', 11904, -15163, 70, '', '', 0),
	(111, 'SA', 'GY', 'GUY', 'GY00', '', 'GY', 'Guyana', 'EN', 'EN', '592', '.gy', 5097, -59048, 207, '', '', 0),
	(112, 'NA', 'HT', 'HTI', 'HA00', '', 'HT', 'Haiti', 'HT', 'FR', '509', '.ht', 19090, -72438, 470, '', '', 0),
	(113, 'SA', 'HN', 'HND', 'HO00', '', 'HN', 'Honduras', 'ES', 'ES', '504', '.hn', 14974, -86267, 684, '', 'honduras.png', 1),
	(114, 'AS', 'HK', 'HKG', 'HK00', '', 'HK', 'Hong Kong', 'ZH', 'EN', '852', '.hk', 22336, 114187, 191, 'CN', '', 0),
	(115, 'EU', 'HU', 'HUN', 'HU00', 'HU', 'HU', 'Hungary', 'HU', 'HU', '36', '.hu', 47166, 19418, 143, '', '', 0),
	(116, 'EU', 'IS', 'ISL', 'IC00', 'IS', 'IS', 'Iceland', 'IS', 'IS', '354', '.is', 64929, -18962, 557, '', '', 0),
	(117, 'AS', 'IN', 'IND', 'IN00', '', 'IN', 'India', 'TA', 'EN', '91', '.in', 22671, 79144, 160, '', '', 0),
	(118, 'AS', 'ID', 'IDN', 'ID00', '', 'ID', 'Indonesia', 'ID', 'EN', '62', '.id', -2956, 119521, 367, '', '', 0),
	(119, 'AS', 'IR', 'IRN', 'IR00', '', 'IR', 'Iran', 'FA', 'EN', '98', '.ir', 32496, 54295, 1305, '', '', 0),
	(120, 'AS', 'IQ', 'IRQ', 'IZ00', '', 'IQ', 'Iraq', 'AR', 'EN,AR', '964', '.iq', 33045, 43797, 312, '', '', 0),
	(121, 'EU', 'IE', 'IRL', 'EI00', 'IE', 'IE', 'Ireland', 'EN', 'EN', '353', '.ie', 53183, -8199, 118, '', '', 0),
	(122, 'EU', 'IM', 'IMN', 'IM00', '', 'IM', 'Isle of Man', 'EN', 'EN', '+44-16', '.im', 54225, -4562, 89, 'GB', '', 0),
	(123, 'AS', 'IL', 'ISR', 'IS00', '', 'IL', 'Israel', 'HE', 'EN,HE', '972', '.il', 31608, 34818, 508, '', '', 0),
	(124, 'EU', 'IT', 'ITA', 'IT00', 'IT', 'IT', 'Italy', 'IT', 'IT', '39', '.it', 42768, 12492, 538, '', '', 0),
	(125, 'AS', 'JP', 'JPN', 'JA00', '', 'JP', 'Japan', 'JA', 'EN,JA,AI', '81', '.jp', 35156, 136060, 438, '', '', 0),
	(126, 'EU', 'JE', 'JEY', 'JE00', '', 'JE', 'Jersey', 'EN', 'EN', '+44-15', '.je', 49229, -2123, 28, 'GB', '', 0),
	(127, 'AS', 'JO', 'JOR', 'JO00', '', 'JO', 'Jordan', 'AR', 'EN', '962', '.jo', 31212, 36385, 812, '', '', 0),
	(128, 'AF', 'KE', 'KEN', 'KE00', '', 'KE', 'Kenya', 'SW', 'EN', '254', '.ke', 511, 37878, 762, '', '', 0),
	(129, 'OC', 'KI', 'KIR', 'KR00', '', 'KI', 'Kiribati', 'EN', 'EN', '686', '.ki', -539, 174228, 16, '', '', 0),
	(130, 'AS', 'KW', 'KWT', 'KU00', '', 'KW', 'Kuwait', 'AR', 'EN,AR', '965', '.kw', 29427, 47452, 108, '', '', 0),
	(131, 'AS', 'LA', 'LAO', 'LA00', '', 'LA', 'Laos', 'LO', 'EN', '856', '.la', 19074, 103361, 710, '', '', 0),
	(132, 'EU', 'LV', 'LVA', 'LG00', 'LV', 'LV', 'Latvia', 'LV', 'LV', '371', '.lv', 56869, 24841, 87, '', '', 0),
	(133, 'AS', 'LB', 'LBN', 'LE00', '', 'LB', 'Lebanon', 'AR', 'EN,AR', '961', '.lb', 33946, 35809, 1250, '', '', 0),
	(134, 'AF', 'LS', 'LSO', 'LT00', '', 'LS', 'Lesotho', 'EN', 'EN', '266', '.ls', -29580, 28254, 2161, '', '', 0),
	(135, 'AF', 'LR', 'LBR', 'LI00', '', 'LR', 'Liberia', 'EN', 'EN', '231', '.lr', 6412, -9323, 243, '', '', 0),
	(136, 'AF', 'LY', 'LBY', 'LY00', '', 'LY', 'Libya', 'AR', 'EN', '218', '.ly', 27236, 18044, 423, '', '', 0),
	(137, 'EU', 'LT', 'LTU', 'LH00', 'LT', 'LT', 'Lithuania', 'LT', 'LT', '370', '.lt', 55338, 23874, 110, '', '', 0),
	(138, 'EU', 'LU', 'LUX', 'LU00', 'LU', 'LU', 'Luxembourg', 'FR', 'FR', '352', '.lu', 49778, 6095, 325, '', '', 0),
	(139, 'AS', 'MO', 'MAC', 'MC00', '', 'MO', 'Macau', 'ZH', 'EN', '853', '.mo', 22128, 113576, 34, 'CN', '', 0),
	(140, 'EU', 'MK', 'MKD', 'MK00', 'MK', 'MK', 'Macedonia', 'MK', 'EN,MK', '389', '.mk', 41603, 21715, 741, '', '', 0),
	(141, 'AF', 'MG', 'MDG', 'MA00', '', 'MG', 'Madagascar', 'FR', 'FR', '261', '.mg', -19272, 46698, 615, '', '', 0),
	(142, 'AF', 'MW', 'MWI', 'MI00', '', 'MW', 'Malawi', 'NY', 'EN', '265', '.mw', -13350, 33754, 779, '', '', 0),
	(143, 'AS', 'MY', 'MYS', 'MY00', '', 'MY', 'Malaysia', 'MS', 'EN', '60', '.my', 4404, 102235, 419, '', '', 0),
	(144, 'AS', 'MV', 'MDV', 'MV00', '', 'MV', 'Maldives', 'DI', 'EN', '960', '.mv', 3092, 73056, 1, '', '', 0),
	(145, 'AF', 'ML', 'MLI', 'ML00', '', 'ML', 'Mali', 'FR', 'FR', '223', '.ml', 17358, -3526, 343, '', '', 0),
	(146, 'EU', 'MT', 'MLT', 'MT00', 'MT', 'MT', 'Malta', 'MT', 'EN,MT', '356', '.mt', 35933, 14381, 50, '', '', 0),
	(147, 'OC', 'MH', 'MHL', 'RM00', '', 'MH', 'Marshall Islands', 'MH', 'EN,MH', '692', '.mh', 10786, 169134, 2, 'US', '', 0),
	(148, 'NA', 'MQ', 'MTQ', 'MB00', '', 'MQ', 'Martinique', 'FR', 'FR', '596', '.mq', 14643, -60978, 123, 'FR', '', 0),
	(149, 'AF', 'MR', 'MRT', 'MR00', '', 'MR', 'Mauritania', 'AR', 'EN', '222', '.mr', 20259, -10364, 276, '', '', 0),
	(150, 'AF', 'MU', 'MUS', 'MP00', '', 'MU', 'Mauritius', 'EN', 'EN', '230', '.mu', -20220, 57589, 165, '', '', 0),
	(151, 'AF', 'YT', 'MYT', 'MF00', '', 'YT', 'Mayotte', 'FR', 'FR', '269', '.yt', -12796, 45142, 132, 'FR', '', 0),
	(152, 'NA', 'MX', 'MEX', 'MX00', '', 'MX', 'Mexico', 'ES', 'ES', '52', '.mx', 23909, -102634, 1111, '', 'mexico.png', 1),
	(153, 'AS', 'FM', 'FSM', 'FM00', '', 'FM', 'Micronesia', 'EN', 'EN', '691', '.fm', 5865, 151521, 21, 'US', '', 0),
	(154, 'EU', 'MD', 'MDA', 'MD00', '', 'MD', 'Moldova', 'RO', 'RO', '373', '.md', 47203, 28473, 139, '', '', 0),
	(155, 'EU', 'MC', 'MCO', 'MN00', '', 'MC', 'Monaco', 'FR', 'FR', '337', '.mc', 43740, 7427, 32, '', '', 0),
	(156, 'AS', 'MN', 'MNG', 'MG00', '', 'MN', 'Mongolia', 'MN', 'EN,MN', '976', '.mn', 46836, 103067, 1528, '', '', 0),
	(157, 'AF', 'MZ', 'MOZ', 'MZ00', '', 'MZ', 'Mozambique', 'PT', 'PT', '258', '.mz', -17906, 35347, 345, '', '', 0),
	(158, 'AS', 'MM', 'MMR', 'BM00', '', 'MM', 'Myanmar', 'MY', 'EN', '95', '.mm', 21406, 96108, 826, '', '', 0),
	(159, 'AF', 'NA', 'NAM', 'WA00', '', 'NA', 'Namibia', 'EN', 'EN', '264', '.na', -22149, 17180, 1141, '', '', 0),
	(160, 'OC', 'NR', 'NRU', 'NR00', '', 'NR', 'Nauru', 'NA', 'EN', '674', '.nr', -528, 166933, 14, '', '', 0),
	(161, 'AS', 'NP', 'NPL', 'NP00', '', 'NP', 'Nepal', 'NE', 'EN', '977', '.np', 28264, 83931, 2565, '', '', 0),
	(162, 'EU', 'NL', 'NLD', 'NL00', 'NL', 'NL', 'Netherlands', 'NL', 'NL', '31', '.nl', 52342, 5528, 30, '', '', 0),
	(163, 'EU', 'AN', 'ANT', '-', '', 'AN', 'Netherlands Antilles', 'NL', 'NL', '599', '.an', 12331, -68812, 57, 'NL', '', 0),
	(164, 'OC', 'NC', 'NCL', 'NC00', '', 'NC', 'New Caledonia', 'FR', 'FR', '687', '.nc', -20992, 165019, 325, 'FR', '', 0),
	(165, 'OC', 'NZ', 'NZL', 'NZ00', '', 'NZ', 'New Zealand', 'EN', 'EN', '64', '.nz', -41667, 172941, 388, '', '', 0),
	(166, 'SA', 'NI', 'NIC', 'NU00', '', 'NI', 'Nicaragua', 'ES', 'ES', '505', '.ni', 12904, -84922, 298, '', 'nicaragua.png', 1),
	(167, 'AF', 'NE', 'NER', 'NG00', '', 'NE', 'Niger', 'FR', 'FR', '227', '.ne', 17424, 9401, 474, '', '', 0),
	(168, 'AF', 'NG', 'NGA', 'NI00', '', 'NG', 'Nigeria', 'EN', 'EN', '234', '.ng', 9559, 8078, 380, '', '', 0),
	(169, 'OC', 'NU', 'NIU', 'NE00', '', 'NU', 'Niue', 'NI', 'EN', '683', '.nu', -19051, -169860, 13, 'NZ', '', 0),
	(170, 'OC', 'NF', 'NFK', 'NF00', '', 'NF', 'Norfolk Island', 'EN', 'EN', '672', '.nf', -29033, 167951, 63, 'AU', '', 0),
	(171, 'AS', 'KP', 'PRK', 'KN00', '', 'KP', 'North Korea', 'KO', 'EN', '850', '.kp', 40279, 126663, 600, '', '', 0),
	(172, 'OC', 'MP', 'MNP', 'CQ00', '', 'MP', 'Northern Mariana Islands', 'FI', 'EN', '670', '.mp', 18289, 145699, 193, 'US', '', 0),
	(173, 'AS', 'OM', 'OMN', 'MU00', '', 'OM', 'Oman', 'AR', 'EN', '968', '.om', 21010, 56854, 310, '', '', 0),
	(174, 'AS', 'PK', 'PAK', 'PK00', '', 'PK', 'Pakistan', 'UR', 'EN', '92', '.pk', 29316, 68765, 900, '', '', 0),
	(175, 'OC', 'PW', 'PLW', 'PS00', '', 'PW', 'Palau', 'PW', 'EN,PW', '680', '.pw', 7317, 134403, 37, '', '', 0),
	(176, 'AS', 'PS', 'PSE', 'GZ00', '', 'PS', 'Palestinian Territory (Gaza Strip)', 'AR', 'EN', '970', '.ps', 31407, 34393, 206, '', '', 0),
	(177, 'SA', 'PA', 'PAN', 'PM00', '', 'PA', 'Panama', 'ES', 'ES', '507', '.pa', 8599, -80410, 360, '', 'panama.png', 1),
	(178, 'OC', 'PG', 'PNG', 'PP00', '', 'PG', 'Papua New Guinea', 'EN', 'EN', '675', '.pg', -6121, 146858, 667, '', '', 0),
	(179, 'SA', 'PY', 'PRY', 'PA00', '', 'PY', 'Paraguay', 'ES', 'ES', '595', '.py', -23244, -58394, 178, '', 'paraguay.png', 1),
	(180, 'SA', 'PE', 'PER', 'PE00', '', 'PE', 'Peru', 'ES', 'ES', '51', '.pe', -9213, -75112, 1555, '', 'peru.png', 1),
	(181, 'AS', 'PH', 'PHL', 'RP00', '', 'PH', 'Philippines', 'EN', 'EN', '63', '.ph', 12023, 122714, 442, '', '', 0),
	(182, 'OC', 'PN', 'PCN', 'PC00', '', 'PN', 'Pitcairn Islands', 'EN', 'EN', '', '.pn', -24378, -128325, 69, 'GB', '', 0),
	(183, 'EU', 'PL', 'POL', 'PL00', 'PL', 'PL', 'Poland', 'PL', 'PL', '48', '.pl', 52147, 19378, 173, '', '', 0),
	(184, 'EU', 'PT', 'PRT', 'PO00', 'PT', 'PT', 'Portugal', 'PT', 'PT', '351', '.pt', 39642, -8346, 372, '', '', 0),
	(185, 'AS', 'QA', 'QAT', 'QA00', '', 'QA', 'Qatar', 'AR', 'EN', '974', '.qa', 25414, 51260, 28, '', '', 0),
	(186, 'AF', 'RE', 'REU', 'RE00', '', 'RE', 'Réunion', 'FR', 'FR', '262', '.re', -21143, 55532, 327, 'FR', '', 0),
	(187, 'EU', 'RO', 'ROU', 'RO00', 'RO', 'RO', 'Romania', 'RO', 'RO', '40', '.ro', 45839, 25009, 414, '', '', 0),
	(188, 'AF', 'RW', 'RWA', 'RW00', '', 'RW', 'Rwanda', 'RW', 'FR', '250', '.rw', -2003, 29923, 1598, '', '', 0),
	(189, 'AF', 'EH', 'ESH', 'WI00', '', 'EH', 'Sahrawi Arab (Western Sahara)', 'AR', 'EN', '212', '.eh', 24666, -13191, 161, '', '', 0),
	(190, 'AF', 'SH', 'SHN', 'SH00', '', 'SH', 'Saint Helena, Ascension and Tristan Da Cunha', 'EN', 'EN', '290', '.sh', -15831, -5618, 55, 'GB', '', 0),
	(191, 'NA', 'KN', 'KNA', 'SC00', '', 'KN', 'Saint Kitts and Nevis', 'EN', 'EN', '869', '.kn', 17244, -62643, 138, '', '', 0),
	(192, 'NA', 'LC', 'LCA', 'ST00', '', 'LC', 'Saint Lucia', 'EN', 'EN', '758', '.lc', 13889, -60965, 190, '', '', 0),
	(193, 'NA', 'MF', 'MAF', 'RN00', '', 'MF', 'Saint Martin', 'FR', 'FR', '590', '.gp', 18044, -63057, 84, 'FR', '', 0),
	(194, 'NA', 'PM', 'SPM', 'SB00', '', 'PM', 'Saint Pierre and Miquelon', 'FR', 'FR', '508', '.pm', 46906, -56337, 48, 'FR', '', 0),
	(195, 'NA', 'VC', 'VCT', 'VC00', '', 'VC', 'Saint Vincent and the Grenadines', 'EN', 'EN', '809', '.vc', 13185, -61229, 189, '', '', 0),
	(196, 'OC', 'WS', 'WSM', 'WS00', '', 'WS', 'Samoa', 'SM', 'SM', '685', '.ws', -13852, -172031, 127, '', '', 0),
	(197, 'EU', 'SM', 'SMR', 'SM00', '', 'SM', 'San Marino', 'IT', 'IT', '378', '.sm', 43944, 12459, 112, '', '', 0),
	(198, 'AF', 'ST', 'STP', 'TP00', '', 'ST', 'São Tomé and Príncipe', 'PT', 'PT', '239', '.st', 820, 7002, 327, '', '', 0),
	(199, 'AS', 'SA', 'SAU', 'SA00', '', 'SA', 'Saudi Arabia', 'AR', 'EN', '966', '.sa', 23888, 44442, 665, '', '', 0),
	(200, 'AF', 'SN', 'SEN', 'SG00', '', 'SN', 'Senegal', 'FR', 'FR', '221', '.sn', 14900, -14599, 69, '', '', 0),
	(201, 'AS', 'RS', 'SRB', 'RI00', '', 'RS', 'Serbia', 'SR', 'EN,SR', '381', '.yu', 43855, 20590, 442, '', '', 0),
	(202, 'AF', 'SC', 'SYC', 'SE00', '', 'SC', 'Seychelles', 'EN', 'EN', '248', '.sc', -4685, 55482, 132, '', '', 0),
	(203, 'AF', 'SL', 'SLE', 'SL00', '', 'SL', 'Sierra Leone', 'EN', 'EN', '232', '.sl', 8521, -11844, 279, '', '', 0),
	(204, 'AS', 'SG', 'SGP', 'SN00', '', 'SG', 'Singapore', 'ZH', 'EN', '65', '.sg', 1322, 103821, 32, '', '', 0),
	(205, 'NA', 'SX', 'MAF', 'NN00', '', 'SX', 'Sint Maarten', 'NL', 'NL', '721', '.an', 18044, -63082, 48, 'NL', '', 0),
	(206, 'EU', 'SK', 'SVK', 'LO00', 'SK', 'SK', 'Slovakia', 'SK', 'SK', '42', '.sk', 48707, 19487, 458, '', '', 0),
	(207, 'EU', 'SI', 'SVN', 'SI00', 'SI', 'SI', 'Slovenia', 'SL', 'SL', '386', '.si', 46120, 14821, 492, '', '', 0),
	(208, 'OC', 'SB', 'SLB', 'BP00', '', 'SB', 'Solomon Islands', 'EN', 'EN', '677', '.sb', -9149, 160987, 51, '', '', 0),
	(209, 'AF', 'SO', 'SOM', 'SO00', '', 'SO', 'Somalia', 'SO', 'EN', '252', '.so', 9460, 47167, 410, '', '', 0),
	(210, 'AF', 'ZA', 'ZAF', 'SF00', '', 'ZA', 'South Africa', 'EN', 'EN', '27', '.za', -29046, 25063, 1034, '', '', 0),
	(211, 'AN', 'GS', 'SGS', 'SX00', '', 'GS', 'South Georgia and the South Sandwich Islands', 'EN', 'EN', '995', '.gs', -54401, -36586, 7, 'GB', '', 0),
	(212, 'AS', 'KR', 'KOR', 'KS00', '', 'KR', 'South Korea', 'KO', 'EN,KO', '82', '.kr', 36097, 127513, 282, '', '', 0),
	(213, 'AF', 'SS', 'SSD', 'OD00', '', 'SS', 'South Sudan', 'AR', 'EN', '211', '.ss', 7515, 30121, 637, '', '', 0),
	(214, 'EU', 'ES', 'ESP', 'SP00', 'ES', 'ES', 'España', 'ES', 'ES', '34', '.es', 40396, -3551, 660, '', 'spain.png', 1),
	(215, 'AS', 'LK', 'LKA', 'CE00', '', 'LK', 'Sri Lanka', 'SI', 'EN', '94', '.lk', 7789, 80681, 228, '', '', 0),
	(216, 'AF', 'SD', 'SDN', 'SU00', '', 'SD', 'Sudan', 'AR', 'EN', '249', '.sd', 13933, 30152, 568, '', '', 0),
	(217, 'SA', 'SR', 'SUR', 'NS00', '', 'SR', 'Suriname', 'NL', 'NL', '597', '.sr', 4217, -55889, 246, '', '', 0),
	(218, 'EU', 'SJ', 'SJM', 'SV00', '', 'SJ', 'Svalbard and Jan Mayen', 'NO', 'NO', '47', '.sj', 77270, 14380, 189, 'NO', '', 0),
	(219, 'AF', 'SZ', 'SWZ', 'WZ00', '', 'SZ', 'Swaziland', 'EN', 'EN', '268', '.sz', -26565, 31501, 305, '', '', 0),
	(220, 'EU', 'SE', 'SWE', 'SW00', 'SE', 'SE', 'Sweden', 'SV', 'SV', '46', '.se', 62915, 16237, 320, '', '', 0),
	(221, 'EU', 'CH', 'CHE', 'SZ00', '', 'CH', 'Switzerland', 'DE', 'DE,FR,IT', '41', '.ch', 46806, 8226, 1350, '', '', 0),
	(222, 'AS', 'SY', 'SYR', 'SY00', '', 'SY', 'Syria', 'SY', 'EN,AR', '963', '.sy', 35030, 38469, 514, '', '', 0),
	(223, 'AS', 'TW', 'TWN', 'TW00', '', 'TW', 'Taiwan', 'CH', 'EN,ZH', '886', '.tw', 23686, 120897, 1150, '', '', 0),
	(224, 'AF', 'TZ', 'TZA', 'TZ00', '', 'TZ', 'Tanzania', 'SW', 'EN', '255', '.tz', -6307, 34854, 1018, '', '', 0),
	(225, 'AS', 'TH', 'THA', 'TH00', '', 'TH', 'Thailand', 'TH', 'EN,TH', '66', '.th', 15229, 101100, 287, '', '', 0),
	(226, 'AF', 'TG', 'TGO', 'TO00', '', 'TG', 'Togo', 'FR', 'FR', '228', '.tg', 8513, 980, 236, '', '', 0),
	(227, 'OC', 'TK', 'TKL', 'TL00', '', 'TK', 'Tokelau', 'TK', 'EN', '690', '.tk', -9150, -171815, 1, 'NZ', '', 0),
	(228, 'OC', 'TO', 'TON', 'TN00', '', 'TO', 'Tonga', 'TO', 'EN', '676', '.to', -18985, -174586, 206, '', '', 0),
	(229, 'NA', 'TT', 'TTO', 'TD00', '', 'TT', 'Trinidad and Tobago', 'EN', 'EN', '868', '.tt', 10701, -61152, 83, '', '', 0),
	(230, 'AF', 'TN', 'TUN', 'TS00', '', 'TN', 'Tunisia', 'AR', 'FR', '216', '.tn', 34356, 9754, 246, '', '', 0),
	(231, 'EU', 'TR', 'TUR', 'TU00', 'TR', 'TR', 'Turkey', 'TR', 'TR', '90', '.tr', 39051, 34930, 1132, '', '', 0),
	(232, 'AS', 'TM', 'TKM', 'TX00', '', 'TM', 'Turkmenistan', 'TK', 'EN', '993', '.tm', 39201, 59082, 230, '', '', 0),
	(233, 'NA', 'TC', 'TCA', 'TK00', '', 'TC', 'Turks and Caicos', 'EN', 'EN', '649', '.tc', 21505, -71754, 9, 'GB', '', 0),
	(234, 'OC', 'TV', 'TUV', 'TV00', '', 'TV', 'Tuvalu', 'TV', 'EN', '688', '.tv', -8507, 179196, 1, '', '', 0),
	(235, 'AF', 'UG', 'UGA', 'UG00', '', 'UG', 'Uganda', 'EN', 'EN', '256', '.ug', 1282, 32388, 989, '', '', 0),
	(236, 'EU', 'UA', 'UKR', 'UP00', '', 'UA', 'Ukraine', 'UK', 'EN,UK', '380', '.ua', 48927, 31478, 175, '', '', 0),
	(237, 'AS', 'AE', 'ARE', 'AE00', '', 'AE', 'United Arab Emirates', 'AR', 'EN', '971', '.ae', 23685, 54204, 149, '', '', 0),
	(238, 'EU', 'GB', 'GBR', 'UK00', 'UK', 'GB', 'United Kingdom', 'EN', 'EN', '44', '.uk', 54071, -2784, 162, '', '', 0),
	(239, 'NA', 'US', 'USA', 'US00', '', 'US', 'United States', 'EN', 'EN', '1', '.us', 39450, -98908, 760, '', '', 0),
	(240, 'SA', 'UY', 'URY', 'UY00', '', 'UY', 'Uruguay', 'ES', 'ES', '598', '.uy', -32863, -56007, 109, '', 'uruguay.png', 1),
	(241, 'NA', 'VI', 'VIR', 'VQ00', '', 'VI', 'US Virgin Islands', 'EN', 'EN', '340', '.vi', 17753, -64735, 39, 'US', '', 0),
	(242, 'AS', 'UZ', 'UZB', 'UZ00', '', 'UZ', 'Uzbekistan', 'UZ', 'EN,RU', '7', '.uz', 41772, 63146, 928, '', '', 0),
	(243, 'OC', 'VU', 'VUT', 'NH00', '', 'VU', 'Vanuatu', 'BI', 'EN', '678', '.vu', -16651, 168022, 375, '', '', 0),
	(244, 'EU', 'VA', 'VAT', 'VT00', '', 'VA', 'Vatican City', 'LA', 'LA', '379', '.va', 41903, 12453, 15, '', '', 0),
	(245, 'SA', 'VE', 'VEN', 'VE00', '', 'VE', 'Venezuela', 'ES', 'ES', '58', '.ve', 7674, -66150, 450, '', 'venezuela.png', 1),
	(246, 'AS', 'VN', 'VNM', 'VM00', '', 'VN', 'Viet Nam', 'VI', 'VI', '84', '.vn', 16803, 106993, 327, '', '', 0),
	(247, 'OC', 'WF', 'WLF', 'WF00', '', 'WF', 'Wallis and Futuna', 'WL', 'FR', '681', '.wf', -11417, -177703, 73, 'FR', '', 0),
	(248, 'AS', 'YE', 'YEM', 'YM00', '', 'YE', 'Yemen', 'AR', 'EN,AR', '967', '.ye', 15341, 47908, 999, '', '', 0),
	(249, 'AF', 'ZM', 'ZMB', 'ZA00', '', 'ZM', 'Zambia', 'EN', 'EN', '260', '.zm', -14197, 27996, 1138, '', '', 0),
	(260, 'AF', 'ZW', 'ZWE', 'ZI00', '', 'ZW', 'Zimbabwe', 'EN', 'EN', '263', '.zw', -19000, 29869, 961, '', '', 0);
/*!40000 ALTER TABLE `countries` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;

-- Volcando estructura para tabla sme.departments
DROP TABLE IF EXISTS `departments`;
CREATE TABLE IF NOT EXISTS `departments` (
  `id` int(30) NOT NULL AUTO_INCREMENT,
  `id_country` int(11) NOT NULL,
  `code` varchar(6) NOT NULL,
  `name_departament` varchar(120) NOT NULL,
  `abbreviation` varchar(12) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_code` (`code`,`id_country`) USING BTREE,
  KEY `id_country` (`id_country`),
  CONSTRAINT `FK_dc_id_country` FOREIGN KEY (`id_country`) REFERENCES `countries` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla sme.departments: ~34 rows (aproximadamente)
/*!40000 ALTER TABLE `departments` DISABLE KEYS */;
INSERT INTO `departments` (`id`, `id_country`, `code`, `name_departament`, `abbreviation`) VALUES
	(1, 45, '04', 'No aplica', 'N/APLI'),
	(2, 45, '05', 'Antioquia', 'ANT.'),
	(3, 45, '08', 'Atlántico', 'ATL.'),
	(4, 45, '11', 'Bogotá D.C.', 'BOG.'),
	(5, 45, '13', 'Bolívar', 'BOL.'),
	(6, 45, '15', 'Boyaca', 'BOY.'),
	(7, 45, '17', 'Caldas', 'CAL.'),
	(8, 45, '18', 'Caquetá', 'CAQ.'),
	(9, 45, '19', 'Cauca', 'CAU.'),
	(10, 45, '20', 'Cesar', 'CES.'),
	(11, 45, '23', 'Córdoba', 'CÓRD.'),
	(12, 45, '25', 'Cundinamarca', 'CUND.'),
	(13, 45, '27', 'Chocó', 'CHO.'),
	(14, 45, '41', 'Huila', 'HUILA'),
	(15, 45, '44', 'Guajira', 'GUAJ.'),
	(16, 45, '47', 'Magdalena', 'MAGD.'),
	(17, 45, '50', 'Meta', 'META'),
	(18, 45, '52', 'Nariño', 'NAR.'),
	(19, 45, '54', 'Norte de Santander', 'N.STDER'),
	(20, 45, '63', 'Quindio', 'QUIN.'),
	(21, 45, '66', 'Risaralda', 'RISAR.'),
	(22, 45, '68', 'Santander', 'STDER'),
	(23, 45, '70', 'Sucre', 'SUC.'),
	(24, 45, '73', 'Tolima', 'TOL.'),
	(25, 45, '76', 'Valle', 'VAL.'),
	(26, 45, '81', 'Arauca', 'ARA.'),
	(27, 45, '85', 'Casanare', 'CAS.'),
	(28, 45, '86', 'Putumayo', 'PUT.'),
	(29, 45, '88', 'San Andrés', 'S.AND.'),
	(30, 45, '91', 'Amazonas', 'AMA.'),
	(31, 45, '94', 'Guainía', 'GUAINIA'),
	(32, 45, '95', 'Guaviare', 'GUAV.'),
	(33, 45, '97', 'Vaupés', 'VAU.'),
	(35, 45, '99', 'Vichada', 'VICH');
/*!40000 ALTER TABLE `departments` ENABLE KEYS */;


-- Volcando estructura para tabla sme.cities
DROP TABLE IF EXISTS `cities`;
CREATE TABLE IF NOT EXISTS `cities` (
  `id` int(30) NOT NULL AUTO_INCREMENT,
  `id_dept` int(30) NOT NULL,
  `city_code` varchar(20) NOT NULL,
  `name_city` varchar(120) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_dept_city` (`id_dept`,`name_city`),
  KEY `K_name_city` (`name_city`),
  KEY `K_city_code` (`city_code`),
  CONSTRAINT `FK_cd_id_dept` FOREIGN KEY (`id_dept`) REFERENCES `departments` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1129 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla sme.cities: ~1.127 rows (aproximadamente)
/*!40000 ALTER TABLE `cities` DISABLE KEYS */;
INSERT INTO `cities` (`id`, `id_dept`, `city_code`, `name_city`) VALUES
	(1, 2, '001', 'MEDELLIN'),
	(2, 2, '002', 'ABEJORRAL'),
	(3, 2, '004', 'ABRIAQUI'),
	(4, 2, '021', 'ALEJANDRIA'),
	(5, 2, '030', 'AMAGA'),
	(6, 2, '031', 'AMALFI'),
	(7, 2, '034', 'ANDES'),
	(8, 2, '036', 'ANGELOPOLIS'),
	(9, 2, '038', 'ANGOSTURA'),
	(10, 2, '040', 'ANORI'),
	(11, 2, '042', 'ANTIOQUIA'),
	(12, 2, '044', 'ANZA'),
	(13, 2, '045', 'APARTADO'),
	(14, 2, '051', 'ARBOLETES'),
	(15, 2, '055', 'ARGELIA'),
	(16, 2, '059', 'ARMENIA'),
	(17, 2, '079', 'BARBOSA'),
	(18, 2, '086', 'BELMIRA'),
	(19, 2, '088', 'BELLO'),
	(20, 2, '091', 'BETANIA'),
	(21, 2, '093', 'BETULIA'),
	(22, 2, '101', 'BOLIVAR'),
	(23, 2, '107', 'BRICEÑO'),
	(24, 2, '113', 'BURITICA'),
	(25, 2, '120', 'CACERES'),
	(26, 2, '125', 'CAICEDO'),
	(27, 2, '129', 'CALDAS'),
	(28, 2, '134', 'CAMPAMENTO'),
	(29, 2, '138', 'CAÑASGORDAS'),
	(30, 2, '142', 'CARACOLI'),
	(31, 2, '145', 'CARAMANTA'),
	(32, 2, '147', 'CAREPA'),
	(33, 2, '148', 'CARMEN DE VIBORAL'),
	(34, 2, '150', 'CAROLINA'),
	(35, 2, '154', 'CAUCASIA'),
	(36, 2, '172', 'CHIGORODO'),
	(37, 2, '190', 'CISNEROS'),
	(38, 2, '197', 'COCORNA'),
	(39, 2, '206', 'CONCEPCION'),
	(40, 2, '209', 'CONCORDIA'),
	(41, 2, '212', 'COPACABANA'),
	(42, 2, '234', 'DABEIBA'),
	(43, 2, '237', 'DON MATIAS'),
	(44, 2, '240', 'EBEJICO'),
	(45, 2, '250', 'EL BAGRE'),
	(46, 2, '264', 'ENTRERRIOS'),
	(47, 2, '266', 'ENVIGADO'),
	(48, 2, '282', 'FREDONIA'),
	(49, 2, '284', 'FRONTINO'),
	(50, 2, '306', 'GIRALDO'),
	(51, 2, '308', 'GIRARDOTA'),
	(52, 2, '310', 'GOMEZ PLATA'),
	(53, 2, '313', 'GRANADA'),
	(54, 2, '315', 'GUADALUPE'),
	(55, 2, '318', 'GUARNE'),
	(56, 2, '321', 'GUATAPE'),
	(57, 2, '347', 'HELICONIA'),
	(58, 2, '353', 'HISPANIA'),
	(59, 2, '360', 'ITAGUI'),
	(60, 2, '361', 'ITUANGO'),
	(61, 2, '364', 'JARDIN'),
	(62, 2, '368', 'JERICO'),
	(63, 2, '376', 'LA CEJA'),
	(64, 2, '380', 'LA ESTRELLA'),
	(65, 2, '390', 'LA PINTADA'),
	(66, 2, '400', 'LA UNION'),
	(67, 2, '411', 'LIBORINA'),
	(68, 2, '425', 'MACEO'),
	(69, 2, '440', 'MARINILLA'),
	(70, 2, '467', 'MONTEBELLO'),
	(71, 2, '475', 'MURINDO'),
	(72, 2, '480', 'MUTATA'),
	(73, 2, '483', 'NARIÑO'),
	(74, 2, '490', 'NECOCLI'),
	(75, 2, '495', 'NECHI'),
	(76, 2, '501', 'OLAYA'),
	(77, 2, '541', 'PEÑOL'),
	(78, 2, '543', 'PEQUE'),
	(79, 2, '576', 'PUEBLORRICO'),
	(80, 2, '579', 'PUERTO BERRIO'),
	(81, 2, '585', 'PUERTO NARE (LA MAGDALENA)'),
	(82, 2, '591', 'PUERTO TRIUNFO'),
	(83, 2, '604', 'REMEDIOS'),
	(84, 2, '607', 'RETIRO'),
	(85, 2, '615', 'RIONEGRO'),
	(86, 2, '628', 'SABANALARGA'),
	(87, 2, '631', 'SABANETA'),
	(88, 2, '642', 'SALGAR'),
	(89, 2, '647', 'SAN ANDRES'),
	(90, 2, '649', 'SAN CARLOS'),
	(91, 2, '652', 'SAN FRANCISCO'),
	(92, 2, '656', 'SAN JERONIMO'),
	(93, 2, '658', 'SAN JOSE DE LA MONTAÑA'),
	(94, 2, '659', 'SAN JUAN DE URABA'),
	(95, 2, '660', 'SAN LUIS'),
	(96, 2, '664', 'SAN PEDRO'),
	(97, 2, '665', 'SAN PEDRO DE URABA'),
	(98, 2, '667', 'SAN RAFAEL'),
	(99, 2, '670', 'SAN ROQUE'),
	(100, 2, '674', 'SAN VICENTE'),
	(101, 2, '679', 'SANTA BARBARA'),
	(102, 2, '686', 'SANTA ROSA DE OSOS'),
	(103, 2, '690', 'SANTO DOMINGO'),
	(104, 2, '697', 'SANTUARIO'),
	(105, 2, '736', 'SEGOVIA'),
	(106, 2, '756', 'SONSON'),
	(107, 2, '761', 'SOPETRAN'),
	(108, 2, '789', 'TAMESIS'),
	(109, 2, '790', 'TARAZA'),
	(110, 2, '792', 'TARSO'),
	(111, 2, '809', 'TITIRIBI'),
	(112, 2, '819', 'TOLEDO'),
	(113, 2, '837', 'TURBO'),
	(114, 2, '842', 'URAMITA'),
	(115, 2, '847', 'URRAO'),
	(116, 2, '854', 'VALDIVIA'),
	(117, 2, '856', 'VALPARAISO'),
	(118, 2, '858', 'VEGACHI'),
	(119, 2, '861', 'VENECIA'),
	(120, 2, '873', 'VIGIA DEL FUERTE'),
	(121, 2, '885', 'YALI'),
	(122, 2, '887', 'YARUMAL'),
	(123, 2, '890', 'YOLOMBO'),
	(124, 2, '893', 'YONDO'),
	(125, 2, '895', 'ZARAGOZA'),
	(126, 3, '001', 'BARRANQUILLA DISTRITO ESPECIAL'),
	(127, 3, '078', 'BARANOA'),
	(128, 3, '137', 'CAMPO DE LA CRUZ'),
	(129, 3, '141', 'CANDELARIA'),
	(130, 3, '296', 'GALAPA'),
	(131, 3, '372', 'JUAN DE ACOSTA'),
	(132, 3, '421', 'LURUACO'),
	(133, 3, '433', 'MALAMBO'),
	(134, 3, '436', 'MANATI'),
	(135, 3, '520', 'PALMAR DE VARELA'),
	(136, 3, '549', 'PIOJO'),
	(137, 3, '558', 'POLO NUEVO'),
	(138, 3, '560', 'PONEDERA'),
	(139, 3, '573', 'PUERTO COLOMBIA'),
	(140, 3, '606', 'REPELON'),
	(141, 3, '634', 'SABANAGRANDE'),
	(142, 3, '638', 'SABANALARGA'),
	(143, 3, '675', 'SANTA LUCIA'),
	(144, 3, '685', 'SANTO TOMAS'),
	(145, 3, '758', 'SOLEDAD'),
	(146, 3, '770', 'SUAN'),
	(147, 3, '832', 'TUBARA'),
	(148, 3, '849', 'USIACURI'),
	(149, 4, '000', 'DISTRITO CAPITAL'),
	(150, 4, '001', 'LOCALIDAD 01 - USAQUEN'),
	(151, 4, '002', 'LOCALIDAD 02 - CHAPINERO'),
	(152, 4, '003', 'LOCALIDAD 03 - SANTA FE'),
	(153, 4, '004', 'LOCALIDAD 04 - SAN CRISTOBAL'),
	(154, 4, '005', 'LOCALIDAD 05 - USME'),
	(155, 4, '006', 'LOCALIDAD 06 -TUNJUELITO'),
	(156, 4, '007', 'LOCALIDAD 07 - BOSA'),
	(157, 4, '008', 'LOCALIDAD 08 - KENNEDY'),
	(158, 4, '009', 'LOCALIDAD 09 - FONTIBON'),
	(159, 4, '010', 'LOCALIDAD 10 - ENGATIVA'),
	(160, 4, '011', 'LOCALIDAD 11 - SUBA'),
	(161, 4, '012', 'LOCALIDAD 12 - BARRIOS UNIDOS'),
	(162, 4, '013', 'LOCALIDAD 13 - TEUSAQUILLO'),
	(163, 4, '014', 'LOCALIDAD 14 - MARTIRES'),
	(164, 4, '015', 'LOCALIDAD 15 - ANTONIO NARIÑO'),
	(165, 4, '016', 'LOCALIDAD 16 - PUENTE ARANDA'),
	(166, 4, '017', 'LOCALIDAD 17 - CANDELARIA'),
	(167, 4, '018', 'LOCALIDAD 18 - RAFAEL URIBE'),
	(168, 4, '019', 'LOCALIDAD 19 - CIUDAD BOLIVAR'),
	(169, 4, '020', 'LOCALIDAD 20 - SUMAPAZ'),
	(170, 5, '001', 'CARTAGENA (DISTRITO TURISTICO Y CULTURAL D'),
	(171, 5, '006', 'ACHI'),
	(172, 5, '030', 'ALTOS DEL ROSARIO'),
	(173, 5, '042', 'ARENAL'),
	(174, 5, '052', 'ARJONA'),
	(175, 5, '062', 'ARROYOHONDO'),
	(176, 5, '074', 'BARRANCO DE LOBA'),
	(177, 5, '140', 'CALAMAR'),
	(178, 5, '160', 'CANTAGALLO'),
	(179, 5, '188', 'CICUCO'),
	(180, 5, '212', 'CORDOBA'),
	(181, 5, '222', 'CLEMENCIA'),
	(182, 5, '244', 'EL CARMEN DE BOLIVAR'),
	(183, 5, '248', 'EL GUAMO'),
	(184, 5, '268', 'EL PEÑON'),
	(185, 5, '300', 'HATILLO DE LOBA'),
	(186, 5, '430', 'MAGANGUE'),
	(187, 5, '433', 'MAHATES'),
	(188, 5, '440', 'MARGARITA'),
	(189, 5, '442', 'MARIA LA BAJA'),
	(190, 5, '458', 'MONTECRISTO'),
	(191, 5, '468', 'MOMPOS'),
	(192, 5, '473', 'MORALES'),
	(193, 5, '549', 'PINILLOS'),
	(194, 5, '580', 'REGIDOR'),
	(195, 5, '600', 'RIO VIEJO'),
	(196, 5, '620', 'SAN CRISTOBAL'),
	(197, 5, '647', 'SAN ESTANISLAO'),
	(198, 5, '650', 'SAN FERNANDO'),
	(199, 5, '654', 'SAN JACINTO'),
	(200, 5, '655', 'SAN JACINTO DEL CAUCA'),
	(201, 5, '657', 'SAN JUAN NEPOMUCENO'),
	(202, 5, '667', 'SAN MARTIN DE LOBA'),
	(203, 5, '670', 'SAN PABLO'),
	(204, 5, '673', 'SANTA CATALINA'),
	(205, 5, '683', 'SANTA ROSA'),
	(206, 5, '688', 'SANTA ROSA DEL SUR'),
	(207, 5, '744', 'SIMITI'),
	(208, 5, '760', 'SOPLAVIENTO'),
	(209, 5, '780', 'TALAIGUA NUEVO'),
	(210, 5, '810', 'TIQUISIO (PUERTO RICO)'),
	(211, 5, '836', 'TURBACO'),
	(212, 5, '838', 'TURBANA'),
	(213, 5, '873', 'VILLANUEVA'),
	(214, 5, '894', 'ZAMBRANO'),
	(215, 6, '001', 'TUNJA'),
	(216, 6, '022', 'ALMEIDA'),
	(217, 6, '047', 'AQUITANIA'),
	(218, 6, '051', 'ARCABUCO'),
	(219, 6, '087', 'BELEN'),
	(220, 6, '090', 'BERBEO'),
	(221, 6, '092', 'BETEITIVA'),
	(222, 6, '097', 'BOAVITA'),
	(223, 6, '104', 'BOYACA'),
	(224, 6, '106', 'BRICEÑO'),
	(225, 6, '109', 'BUENAVISTA'),
	(226, 6, '114', 'BUSBANZA'),
	(227, 6, '131', 'CALDAS'),
	(228, 6, '135', 'CAMPOHERMOSO'),
	(229, 6, '162', 'CERINZA'),
	(230, 6, '172', 'CHINAVITA'),
	(231, 6, '176', 'CHIQUINQUIRA'),
	(232, 6, '180', 'CHISCAS'),
	(233, 6, '183', 'CHITA'),
	(234, 6, '185', 'CHITARAQUE'),
	(235, 6, '187', 'CHIVATA'),
	(236, 6, '189', 'CIENEGA'),
	(237, 6, '204', 'COMBITA'),
	(238, 6, '212', 'COPER'),
	(239, 6, '215', 'CORRALES'),
	(240, 6, '218', 'COVARACHIA'),
	(241, 6, '223', 'CUBARA'),
	(242, 6, '224', 'CUCAITA'),
	(243, 6, '226', 'CUITIVA'),
	(244, 6, '232', 'CHIQUIZA'),
	(245, 6, '236', 'CHIVOR'),
	(246, 6, '238', 'DUITAMA'),
	(247, 6, '244', 'EL COCUY'),
	(248, 6, '248', 'EL ESPINO'),
	(249, 6, '272', 'FIRAVITOBA'),
	(250, 6, '276', 'FLORESTA'),
	(251, 6, '293', 'GACHANTIVA'),
	(252, 6, '296', 'GAMEZA'),
	(253, 6, '299', 'GARAGOA'),
	(254, 6, '317', 'GUACAMAYAS'),
	(255, 6, '322', 'GUATEQUE'),
	(256, 6, '325', 'GUAYATA'),
	(257, 6, '332', 'GUICAN'),
	(258, 6, '362', 'IZA'),
	(259, 6, '367', 'JENESANO'),
	(260, 6, '368', 'JERICO'),
	(261, 6, '377', 'LABRANZAGRANDE'),
	(262, 6, '380', 'LA CAPILLA'),
	(263, 6, '401', 'LA VICTORIA'),
	(264, 6, '403', 'LA UVITA'),
	(265, 6, '407', 'VILLA DE LEIVA'),
	(266, 6, '425', 'MACANAL'),
	(267, 6, '442', 'MARIPI'),
	(268, 6, '455', 'MIRAFLORES'),
	(269, 6, '464', 'MONGUA'),
	(270, 6, '466', 'MONGUI'),
	(271, 6, '469', 'MONIQUIRA'),
	(272, 6, '476', 'MOTAVITA'),
	(273, 6, '480', 'MUZO'),
	(274, 6, '491', 'NOBSA'),
	(275, 6, '494', 'NUEVO COLON'),
	(276, 6, '500', 'OICATA'),
	(277, 6, '507', 'OTANCHE'),
	(278, 6, '511', 'PACHAVITA'),
	(279, 6, '514', 'PAEZ'),
	(280, 6, '516', 'PAIPA'),
	(281, 6, '518', 'PAJARITO'),
	(282, 6, '522', 'PANQUEBA'),
	(283, 6, '531', 'PAUNA'),
	(284, 6, '533', 'PAYA'),
	(285, 6, '537', 'PAZ DEL RIO'),
	(286, 6, '542', 'PESCA'),
	(287, 6, '550', 'PISBA'),
	(288, 6, '572', 'PUERTO BOYACA'),
	(289, 6, '580', 'QUIPAMA'),
	(290, 6, '599', 'RAMIRIQUI'),
	(291, 6, '600', 'RAQUIRA'),
	(292, 6, '621', 'RONDON'),
	(293, 6, '632', 'SABOYA'),
	(294, 6, '638', 'SACHICA'),
	(295, 6, '646', 'SAMACA'),
	(296, 6, '660', 'SAN EDUARDO'),
	(297, 6, '664', 'SAN JOSE DE PARE'),
	(298, 6, '667', 'SAN LUIS DE GACENO'),
	(299, 6, '673', 'SAN MATEO'),
	(300, 6, '676', 'SAN MIGUEL DE SEMA'),
	(301, 6, '681', 'SAN PABLO DE BORBUR'),
	(302, 6, '686', 'SANTANA'),
	(303, 6, '690', 'SANTA MARIA'),
	(304, 6, '693', 'SANTA ROSA DE VITERBO'),
	(305, 6, '696', 'SANTA SOFIA'),
	(306, 6, '720', 'SATIVANORTE'),
	(307, 6, '723', 'SATIVASUR'),
	(308, 6, '740', 'SIACHOQUE'),
	(309, 6, '753', 'SOATA'),
	(310, 6, '755', 'SOCOTA'),
	(311, 6, '757', 'SOCHA'),
	(312, 6, '759', 'SOGAMOSO'),
	(313, 6, '761', 'SOMONDOCO'),
	(314, 6, '762', 'SORA'),
	(315, 6, '763', 'SOTAQUIRA'),
	(316, 6, '764', 'SORACA'),
	(317, 6, '774', 'SUSACON'),
	(318, 6, '776', 'SUTAMARCHAN'),
	(319, 6, '778', 'SUTATENZA'),
	(320, 6, '790', 'TASCO'),
	(321, 6, '798', 'TENZA'),
	(322, 6, '804', 'TIBANA'),
	(323, 6, '806', 'TIBASOSA'),
	(324, 6, '808', 'TINJACA'),
	(325, 6, '810', 'TIPACOQUE'),
	(326, 6, '814', 'TOCA'),
	(327, 6, '816', 'TOGUI'),
	(328, 6, '820', 'TOPAGA'),
	(329, 6, '822', 'TOTA'),
	(330, 6, '832', 'TUNUNGUA'),
	(331, 6, '835', 'TURMEQUE'),
	(332, 6, '837', 'TUTA'),
	(333, 6, '839', 'TUTASA'),
	(334, 6, '842', 'UMBITA'),
	(335, 6, '861', 'VENTAQUEMADA'),
	(336, 6, '879', 'VIRACACHA'),
	(337, 6, '897', 'ZETAQUIRA'),
	(338, 7, '001', 'MANIZALES'),
	(339, 7, '013', 'AGUADAS'),
	(340, 7, '042', 'ANSERMA'),
	(341, 7, '050', 'ARANZAZU'),
	(342, 7, '088', 'BELALCAZAR'),
	(343, 7, '174', 'CHINCHINA'),
	(344, 7, '272', 'FILADELFIA'),
	(345, 7, '380', 'LA DORADA'),
	(346, 7, '388', 'LA MERCED'),
	(347, 7, '433', 'MANZANARES'),
	(348, 7, '442', 'MARMATO'),
	(349, 7, '444', 'MARQUETALIA'),
	(350, 7, '446', 'MARULANDA'),
	(351, 7, '486', 'NEIRA'),
	(352, 7, '495', 'NORCASIA'),
	(353, 7, '513', 'PACORA'),
	(354, 7, '524', 'PALESTINA'),
	(355, 7, '541', 'PENSILVANIA'),
	(356, 7, '614', 'RIOSUCIO'),
	(357, 7, '616', 'RISARALDA'),
	(358, 7, '653', 'SALAMINA'),
	(359, 7, '662', 'SAMANA'),
	(360, 7, '665', 'SAN JOSE'),
	(361, 7, '777', 'SUPIA'),
	(362, 7, '867', 'VICTORIA'),
	(363, 7, '873', 'VILLAMARIA'),
	(364, 7, '877', 'VITERBO'),
	(365, 8, '001', 'FLORENCIA'),
	(366, 8, '029', 'ALBANIA'),
	(367, 8, '094', 'BELEN DE LOS ANDAQUIES'),
	(368, 8, '150', 'CARTAGENA DEL CHAIRA'),
	(369, 8, '205', 'CURILLO'),
	(370, 8, '247', 'EL DONCELLO'),
	(371, 8, '256', 'EL PAUJIL'),
	(372, 8, '410', 'LA MONTAÑITA'),
	(373, 8, '460', 'MILAN'),
	(374, 8, '479', 'MORELIA'),
	(375, 8, '592', 'PUERTO RICO'),
	(376, 8, '610', 'SAN JOSE DE FRAGUA'),
	(377, 8, '753', 'SAN  VICENTE DEL CAGUAN'),
	(378, 8, '756', 'SOLANO'),
	(379, 8, '785', 'SOLITA'),
	(380, 8, '860', 'VALPARAISO'),
	(381, 9, '001', 'POPAYAN'),
	(382, 9, '022', 'ALMAGUER'),
	(383, 9, '050', 'ARGELIA'),
	(384, 9, '075', 'BALBOA'),
	(385, 9, '100', 'BOLIVAR'),
	(386, 9, '110', 'BUENOS AIRES'),
	(387, 9, '130', 'CAJIBIO'),
	(388, 9, '137', 'CALDONO'),
	(389, 9, '142', 'CALOTO'),
	(390, 9, '212', 'CORINTO'),
	(391, 9, '256', 'EL TAMBO'),
	(392, 9, '290', 'FLORENCIA'),
	(393, 9, '318', 'GUAPI'),
	(394, 9, '355', 'INZA'),
	(395, 9, '364', 'JAMBALO'),
	(396, 9, '392', 'LA SIERRA'),
	(397, 9, '397', 'LA VEGA'),
	(398, 9, '418', 'LOPEZ (MICAY)'),
	(399, 9, '450', 'MERCADERES'),
	(400, 9, '455', 'MIRANDA'),
	(401, 9, '473', 'MORALES'),
	(402, 9, '513', 'PADILLA'),
	(403, 9, '517', 'PAEZ (BELALCAZAR)'),
	(404, 9, '532', 'PATIA (EL BORDO)'),
	(405, 9, '533', 'PIAMONTE'),
	(406, 9, '548', 'PIENDAMO'),
	(407, 9, '573', 'PUERTO TEJADA'),
	(408, 9, '585', 'PURACE (COCONUCO)'),
	(409, 9, '622', 'ROSAS'),
	(410, 9, '693', 'SAN SEBASTIAN'),
	(411, 9, '698', 'SANTANDER DE QUILICHAO'),
	(412, 9, '701', 'SANTA ROSA'),
	(413, 9, '743', 'SILVIA'),
	(414, 9, '760', 'SOTARA (PAISPAMBA)'),
	(415, 9, '780', 'SUAREZ'),
	(416, 9, '807', 'TIMBIO'),
	(417, 9, '809', 'TIMBIQUI'),
	(418, 9, '821', 'TORIBIO'),
	(419, 9, '824', 'TOTORO'),
	(420, 9, '845', 'VILLARICA'),
	(421, 10, '001', 'VALLEDUPAR'),
	(422, 10, '011', 'AGUACHICA'),
	(423, 10, '013', 'AGUSTIN CODAZZI'),
	(424, 10, '032', 'ASTREA'),
	(425, 10, '045', 'BECERRIL'),
	(426, 10, '060', 'BOSCONIA'),
	(427, 10, '175', 'CHIMICHAGUA'),
	(428, 10, '178', 'CHIRIGUANA'),
	(429, 10, '228', 'CURUMANI'),
	(430, 10, '238', 'EL COPEY'),
	(431, 10, '250', 'EL PASO'),
	(432, 10, '295', 'GAMARRA'),
	(433, 10, '310', 'GONZALEZ'),
	(434, 10, '383', 'LA GLORIA'),
	(435, 10, '400', 'LA JAGUA IBIRICO'),
	(436, 10, '443', 'MANAURE (BALCON DEL CESAR)'),
	(437, 10, '517', 'PAILITAS'),
	(438, 10, '550', 'PELAYA'),
	(439, 10, '570', 'PUEBLO BELLO'),
	(440, 10, '614', 'RIO DE ORO'),
	(441, 10, '621', 'LA PAZ (ROBLES)'),
	(442, 10, '710', 'SAN ALBERTO'),
	(443, 10, '750', 'SAN DIEGO'),
	(444, 10, '770', 'SAN MARTIN'),
	(445, 10, '787', 'TAMALAMEQUE'),
	(446, 11, '001', 'MONTERIA'),
	(447, 11, '068', 'AYAPEL'),
	(448, 11, '079', 'BUENAVISTA'),
	(449, 11, '090', 'CANALETE'),
	(450, 11, '162', 'CERETE'),
	(451, 11, '168', 'CHIMA'),
	(452, 11, '182', 'CHINU'),
	(453, 11, '189', 'CIENAGA DE ORO'),
	(454, 11, '300', 'COTORRA'),
	(455, 11, '350', 'LA APARTADA'),
	(456, 11, '417', 'LORICA'),
	(457, 11, '419', 'LOS CORDOBAS'),
	(458, 11, '464', 'MOMIL'),
	(459, 11, '466', 'MONTELIBANO'),
	(460, 11, '500', 'MOÑITOS'),
	(461, 11, '555', 'PLANETA RICA'),
	(462, 11, '570', 'PUEBLO NUEVO'),
	(463, 11, '574', 'PUERTO ESCONDIDO'),
	(464, 11, '580', 'PUERTO LIBERTADOR'),
	(465, 11, '586', 'PURISIMA'),
	(466, 11, '660', 'SAHAGUN'),
	(467, 11, '670', 'SAN ANDRES SOTAVENTO'),
	(468, 11, '672', 'SAN ANTERO'),
	(469, 11, '675', 'SAN BERNARDO DEL VIENTO'),
	(470, 11, '678', 'SAN CARLOS'),
	(471, 11, '686', 'SAN PELAYO'),
	(472, 11, '807', 'TIERRALTA'),
	(473, 11, '855', 'VALENCIA'),
	(474, 12, '001', 'AGUA DE DIOS'),
	(475, 12, '019', 'ALBAN'),
	(476, 12, '035', 'ANAPOIMA'),
	(477, 12, '040', 'ANOLAIMA'),
	(478, 12, '053', 'ARBELAEZ'),
	(479, 12, '086', 'BELTRAN'),
	(480, 12, '095', 'BITUIMA'),
	(481, 12, '099', 'BOJACA'),
	(482, 12, '120', 'CABRERA'),
	(483, 12, '123', 'CACHIPAY'),
	(484, 12, '126', 'CAJICA'),
	(485, 12, '148', 'CAPARRAPI'),
	(486, 12, '151', 'CAQUEZA'),
	(487, 12, '154', 'CARMEN DE CARUPA'),
	(488, 12, '168', 'CHAGUANI'),
	(489, 12, '175', 'CHIA'),
	(490, 12, '178', 'CHIPAQUE'),
	(491, 12, '181', 'CHOACHI'),
	(492, 12, '183', 'CHOCONTA'),
	(493, 12, '200', 'COGUA'),
	(494, 12, '214', 'COTA'),
	(495, 12, '224', 'CUCUNUBA'),
	(496, 12, '245', 'EL COLEGIO'),
	(497, 12, '258', 'EL PEÑON'),
	(498, 12, '260', 'EL ROSAL'),
	(499, 12, '269', 'FACATATIVA'),
	(500, 12, '279', 'FOMEQUE'),
	(501, 12, '281', 'FOSCA'),
	(502, 12, '286', 'FUNZA'),
	(503, 12, '288', 'FUQUENE'),
	(504, 12, '290', 'FUSAGASUGA'),
	(505, 12, '293', 'GACHALA'),
	(506, 12, '295', 'GACHANCIPA'),
	(507, 12, '297', 'GACHETA'),
	(508, 12, '299', 'GAMA'),
	(509, 12, '307', 'GIRARDOT'),
	(510, 12, '312', 'GRANADA'),
	(511, 12, '317', 'GUACHETA'),
	(512, 12, '320', 'GUADUAS'),
	(513, 12, '322', 'GUASCA'),
	(514, 12, '324', 'GUATAQUI'),
	(515, 12, '326', 'GUATAVITA'),
	(516, 12, '328', 'GUAYABAL DE SIQUIMA'),
	(517, 12, '335', 'GUAYABETAL'),
	(518, 12, '339', 'GUTIERREZ'),
	(519, 12, '368', 'JERUSALEN'),
	(520, 12, '372', 'JUNIN'),
	(521, 12, '377', 'LA CALERA'),
	(522, 12, '386', 'LA MESA'),
	(523, 12, '394', 'LA PALMA'),
	(524, 12, '398', 'LA PEÑA'),
	(525, 12, '402', 'LA VEGA'),
	(526, 12, '407', 'LENGUAZAQUE'),
	(527, 12, '426', 'MACHETA'),
	(528, 12, '430', 'MADRID'),
	(529, 12, '436', 'MANTA'),
	(530, 12, '438', 'MEDINA'),
	(531, 12, '473', 'MOSQUERA'),
	(532, 12, '483', 'NARIÑO'),
	(533, 12, '486', 'NEMOCON'),
	(534, 12, '488', 'NILO'),
	(535, 12, '489', 'NIMAIMA'),
	(536, 12, '491', 'NOCAIMA'),
	(537, 12, '506', 'VENECIA (OSPINA PEREZ)'),
	(538, 12, '513', 'PACHO'),
	(539, 12, '518', 'PAIME'),
	(540, 12, '524', 'PANDI'),
	(541, 12, '530', 'PARATEBUENO'),
	(542, 12, '535', 'PASCA'),
	(543, 12, '572', 'PUERTO SALGAR'),
	(544, 12, '580', 'PULI'),
	(545, 12, '592', 'QUEBRADANEGRA'),
	(546, 12, '594', 'QUETAME'),
	(547, 12, '596', 'QUIPILE'),
	(548, 12, '599', 'APULO (RAFAEL REYES)'),
	(549, 12, '612', 'RICAURTE'),
	(550, 12, '645', 'SAN  ANTONIO DEL  TEQUENDAMA'),
	(551, 12, '649', 'SAN BERNARDO'),
	(552, 12, '653', 'SAN CAYETANO'),
	(553, 12, '658', 'SAN FRANCISCO'),
	(554, 12, '662', 'SAN JUAN DE RIOSECO'),
	(555, 12, '718', 'SASAIMA'),
	(556, 12, '736', 'SESQUILE'),
	(557, 12, '740', 'SIBATE'),
	(558, 12, '743', 'SILVANIA'),
	(559, 12, '745', 'SIMIJACA'),
	(560, 12, '754', 'SOACHA'),
	(561, 12, '758', 'SOPO'),
	(562, 12, '769', 'SUBACHOQUE'),
	(563, 12, '772', 'SUESCA'),
	(564, 12, '777', 'SUPATA'),
	(565, 12, '779', 'SUSA'),
	(566, 12, '781', 'SUTATAUSA'),
	(567, 12, '785', 'TABIO'),
	(568, 12, '793', 'TAUSA'),
	(569, 12, '797', 'TENA'),
	(570, 12, '799', 'TENJO'),
	(571, 12, '805', 'TIBACUY'),
	(572, 12, '807', 'TIBIRITA'),
	(573, 12, '815', 'TOCAIMA'),
	(574, 12, '817', 'TOCANCIPA'),
	(575, 12, '823', 'TOPAIPI'),
	(576, 12, '839', 'UBALA'),
	(577, 12, '841', 'UBAQUE'),
	(578, 12, '843', 'UBATE'),
	(579, 12, '845', 'UNE'),
	(580, 12, '851', 'UTICA'),
	(581, 12, '862', 'VERGARA'),
	(582, 12, '867', 'VIANI'),
	(583, 12, '871', 'VILLAGOMEZ'),
	(584, 12, '873', 'VILLAPINZON'),
	(585, 12, '875', 'VILLETA'),
	(586, 12, '878', 'VIOTA'),
	(587, 12, '885', 'YACOPI'),
	(588, 12, '898', 'ZIPACON'),
	(589, 12, '899', 'ZIPAQUIRA'),
	(590, 13, '001', 'QUIBDO (SAN FRANCISCO DE QUIBDO)'),
	(591, 13, '006', 'ACANDI'),
	(592, 13, '025', 'ALTO BAUDO (PIE DE PATO)'),
	(593, 13, '050', 'ATRATO'),
	(594, 13, '073', 'BAGADO'),
	(595, 13, '075', 'BAHIA SOLANO (MUTIS)'),
	(596, 13, '077', 'BAJO BAUDO (PIZARRO)'),
	(597, 13, '099', 'BOJAYA (BELLAVISTA)'),
	(598, 13, '135', 'CANTON DE SAN PABLO (MANAGRU)'),
	(599, 13, '205', 'CONDOTO'),
	(600, 13, '245', 'EL CARMEN DE ATRATO'),
	(601, 13, '250', 'LITORAL DEL BAJO SAN JUAN (SANTA GENOVEVA'),
	(602, 13, '361', 'ISTMINA'),
	(603, 13, '372', 'JURADO'),
	(604, 13, '413', 'LLORO'),
	(605, 13, '425', 'MEDIO ATRATO'),
	(606, 13, '430', 'MEDIO BAUDO'),
	(607, 13, '491', 'NOVITA'),
	(608, 13, '495', 'NUQUI'),
	(609, 13, '600', 'RIOQUITO'),
	(610, 13, '615', 'RIOSUCIO'),
	(611, 13, '660', 'SAN JOSE DEL PALMAR'),
	(612, 13, '745', 'SIPI'),
	(613, 13, '787', 'TADO'),
	(614, 13, '800', 'UNGUIA'),
	(615, 13, '810', 'UNION PANAMERICANA'),
	(616, 14, '001', 'NEIVA'),
	(617, 14, '006', 'ACEVEDO'),
	(618, 14, '013', 'AGRADO'),
	(619, 14, '016', 'AIPE'),
	(620, 14, '020', 'ALGECIRAS'),
	(621, 14, '026', 'ALTAMIRA'),
	(622, 14, '078', 'BARAYA'),
	(623, 14, '132', 'CAMPOALEGRE'),
	(624, 14, '206', 'COLOMBIA'),
	(625, 14, '244', 'ELIAS'),
	(626, 14, '298', 'GARZON'),
	(627, 14, '306', 'GIGANTE'),
	(628, 14, '319', 'GUADALUPE'),
	(629, 14, '349', 'HOBO'),
	(630, 14, '357', 'IQUIRA'),
	(631, 14, '359', 'ISNOS (SAN JOSE DE ISNOS)'),
	(632, 14, '378', 'LA ARGENTINA'),
	(633, 14, '396', 'LA PLATA'),
	(634, 14, '483', 'NATAGA'),
	(635, 14, '503', 'OPORAPA'),
	(636, 14, '518', 'PAICOL'),
	(637, 14, '524', 'PALERMO'),
	(638, 14, '530', 'PALESTINA'),
	(639, 14, '548', 'PITAL'),
	(640, 14, '551', 'PITALITO'),
	(641, 14, '615', 'RIVERA'),
	(642, 14, '660', 'SALADOBLANCO'),
	(643, 14, '668', 'SAN AGUSTIN'),
	(644, 14, '676', 'SANTA MARIA'),
	(645, 14, '770', 'SUAZA'),
	(646, 14, '791', 'TARQUI'),
	(647, 14, '797', 'TESALIA'),
	(648, 14, '799', 'TELLO'),
	(649, 14, '801', 'TERUEL'),
	(650, 14, '807', 'TIMANA'),
	(651, 14, '872', 'VILLAVIEJA'),
	(652, 14, '885', 'YAGUARA'),
	(653, 15, '001', 'RIOHACHA'),
	(654, 15, '078', 'BARRANCAS'),
	(655, 15, '090', 'DIBULLA'),
	(656, 15, '098', 'DISTRACCION'),
	(657, 15, '110', 'EL MOLINO'),
	(658, 15, '279', 'FONSECA'),
	(659, 15, '378', 'HATONUEVO'),
	(660, 15, '420', 'LA JAGUA DEL PILAR'),
	(661, 15, '430', 'MAICAO'),
	(662, 15, '560', 'MANAURE'),
	(663, 15, '650', 'SAN JUAN DEL CESAR'),
	(664, 15, '847', 'URIBIA'),
	(665, 15, '855', 'URUMITA'),
	(666, 15, '874', 'VILLANUEVA'),
	(667, 16, '001', 'SANTA MARTA (DISTRITO TURISTICO, CULTURAL'),
	(668, 16, '030', 'ALGARROBO'),
	(669, 16, '053', 'ARACATACA'),
	(670, 16, '058', 'ARIGUANI (EL DIFICIL)'),
	(671, 16, '161', 'CERRO SAN ANTONIO'),
	(672, 16, '170', 'CHIVOLO'),
	(673, 16, '189', 'CIENAGA'),
	(674, 16, '205', 'CONCORDIA'),
	(675, 16, '245', 'EL BANCO'),
	(676, 16, '258', 'EL PIÑON'),
	(677, 16, '268', 'EL RETEN'),
	(678, 16, '288', 'FUNDACION'),
	(679, 16, '318', 'GUAMAL'),
	(680, 16, '541', 'PEDRAZA'),
	(681, 16, '545', 'PIJIÑO DEL CARMEN (PIJIÑO)'),
	(682, 16, '551', 'PIVIJAY'),
	(683, 16, '555', 'PLATO'),
	(684, 16, '570', 'PUEBLOVIEJO'),
	(685, 16, '605', 'REMOLINO'),
	(686, 16, '660', 'SABANAS DE SAN ANGEL'),
	(687, 16, '675', 'SALAMINA'),
	(688, 16, '692', 'SAN SEBASTIAN DE BUENAVISTA'),
	(689, 16, '703', 'SAN ZENON'),
	(690, 16, '707', 'SANTA ANA'),
	(691, 16, '745', 'SITIONUEVO'),
	(692, 16, '798', 'TENERIFE'),
	(693, 17, '001', 'VILLAVICENCIO'),
	(694, 17, '006', 'ACACIAS'),
	(695, 17, '110', 'BARRANCA DE UPIA'),
	(696, 17, '124', 'CABUYARO'),
	(697, 17, '150', 'CASTILLA LA NUEVA'),
	(698, 17, '223', 'SAN LUIS DE CUBARRAL'),
	(699, 17, '226', 'CUMARAL'),
	(700, 17, '245', 'EL CALVARIO'),
	(701, 17, '251', 'EL CASTILLO'),
	(702, 17, '270', 'EL DORADO'),
	(703, 17, '287', 'FUENTE DE ORO'),
	(704, 17, '313', 'GRANADA'),
	(705, 17, '318', 'GUAMAL'),
	(706, 17, '325', 'MAPIRIPAN'),
	(707, 17, '330', 'MESETAS'),
	(708, 17, '350', 'LA MACARENA'),
	(709, 17, '370', 'LA URIBE'),
	(710, 17, '400', 'LEJANIAS'),
	(711, 17, '450', 'PUERTO CONCORDIA'),
	(712, 17, '568', 'PUERTO GAITAN'),
	(713, 17, '573', 'PUERTO LOPEZ'),
	(714, 17, '577', 'PUERTO LLERAS'),
	(715, 17, '590', 'PUERTO RICO'),
	(716, 17, '606', 'RESTREPO'),
	(717, 17, '680', 'SAN CARLOS DE GUAROA'),
	(718, 17, '683', 'SAN  JUAN DE ARAMA'),
	(719, 17, '686', 'SAN JUANITO'),
	(720, 17, '689', 'SAN MARTIN'),
	(721, 17, '711', 'VISTAHERMOSA'),
	(722, 18, '001', 'PASTO (SAN JUAN DE PASTO)'),
	(723, 18, '019', 'ALBAN (SAN JOSE)'),
	(724, 18, '022', 'ALDANA'),
	(725, 18, '036', 'ANCUYA'),
	(726, 18, '051', 'ARBOLEDA (BERRUECOS)'),
	(727, 18, '079', 'BARBACOAS'),
	(728, 18, '083', 'BELEN'),
	(729, 18, '110', 'BUESACO'),
	(730, 18, '203', 'COLON (GENOVA)'),
	(731, 18, '207', 'CONSACA'),
	(732, 18, '210', 'CONTADERO'),
	(733, 18, '215', 'CORDOBA'),
	(734, 18, '224', 'CUASPUD (CARLOSAMA)'),
	(735, 18, '227', 'CUMBAL'),
	(736, 18, '233', 'CUMBITARA'),
	(737, 18, '240', 'CHACHAGUI'),
	(738, 18, '250', 'EL CHARCO'),
	(739, 18, '254', 'EL PEÑOL'),
	(740, 18, '256', 'EL ROSARIO'),
	(741, 18, '258', 'EL TABLON'),
	(742, 18, '260', 'EL TAMBO'),
	(743, 18, '287', 'FUNES'),
	(744, 18, '317', 'GUACHUCAL'),
	(745, 18, '320', 'GUAITARILLA'),
	(746, 18, '323', 'GUALMATAN'),
	(747, 18, '352', 'ILES'),
	(748, 18, '354', 'IMUES'),
	(749, 18, '356', 'IPIALES'),
	(750, 18, '378', 'LA CRUZ'),
	(751, 18, '381', 'LA FLORIDA'),
	(752, 18, '385', 'LA LLANADA'),
	(753, 18, '390', 'LA TOLA'),
	(754, 18, '399', 'LA UNION'),
	(755, 18, '405', 'LEIVA'),
	(756, 18, '411', 'LINARES'),
	(757, 18, '418', 'LOS ANDES (SOTOMAYOR)'),
	(758, 18, '427', 'MAGUI (PAYAN)'),
	(759, 18, '435', 'MALLAMA (PIEDRANCHA)'),
	(760, 18, '473', 'MOSQUERA'),
	(761, 18, '490', 'OLAYA HERRERA (BOCAS DE SATINGA)'),
	(762, 18, '506', 'OSPINA'),
	(763, 18, '520', 'FRANCISCO PIZARRO (SALAHONDA)'),
	(764, 18, '540', 'POLICARPA'),
	(765, 18, '560', 'POTOSI'),
	(766, 18, '565', 'PROVIDENCIA'),
	(767, 18, '573', 'PUERRES'),
	(768, 18, '585', 'PUPIALES'),
	(769, 18, '612', 'RICAURTE'),
	(770, 18, '621', 'ROBERTO PAYAN (SAN JOSE)'),
	(771, 18, '678', 'SAMANIEGO'),
	(772, 18, '683', 'SANDONA'),
	(773, 18, '685', 'SAN BERNARDO'),
	(774, 18, '687', 'SAN LORENZO'),
	(775, 18, '693', 'SAN PABLO'),
	(776, 18, '694', 'SAN PEDRO DE CARTAGO'),
	(777, 18, '696', 'SANTA BARBARA (ISCUANDE)'),
	(778, 18, '699', 'SANTA CRUZ (GUACHAVES)'),
	(779, 18, '720', 'SAPUYES'),
	(780, 18, '786', 'TAMINANGO'),
	(781, 18, '788', 'TANGUA'),
	(782, 18, '835', 'TUMACO'),
	(783, 18, '838', 'TUQUERRES'),
	(784, 18, '885', 'YACUANQUER'),
	(785, 19, '001', 'CUCUTA'),
	(786, 19, '003', 'ABREGO'),
	(787, 19, '051', 'ARBOLEDAS'),
	(788, 19, '099', 'BOCHALEMA'),
	(789, 19, '109', 'BUCARASICA'),
	(790, 19, '125', 'CACOTA'),
	(791, 19, '128', 'CACHIRA'),
	(792, 19, '172', 'CHINACOTA'),
	(793, 19, '174', 'CHITAGA'),
	(794, 19, '206', 'CONVENCION'),
	(795, 19, '223', 'CUCUTILLA'),
	(796, 19, '239', 'DURANIA'),
	(797, 19, '245', 'EL CARMEN'),
	(798, 19, '250', 'EL TARRA'),
	(799, 19, '261', 'EL ZULIA'),
	(800, 19, '313', 'GRAMALOTE'),
	(801, 19, '344', 'HACARI'),
	(802, 19, '347', 'HERRAN'),
	(803, 19, '377', 'LABATECA'),
	(804, 19, '385', 'LA ESPERANZA'),
	(805, 19, '398', 'LA PLAYA'),
	(806, 19, '405', 'LOS PATIOS'),
	(807, 19, '418', 'LOURDES'),
	(808, 19, '480', 'MUTISCUA'),
	(809, 19, '498', 'OCAÑA'),
	(810, 19, '518', 'PAMPLONA'),
	(811, 19, '520', 'PAMPLONITA'),
	(812, 19, '553', 'PUERTO SANTANDER'),
	(813, 19, '599', 'RAGONVALIA'),
	(814, 19, '660', 'SALAZAR'),
	(815, 19, '670', 'SAN CALIXTO'),
	(816, 19, '673', 'SAN CAYETANO'),
	(817, 19, '680', 'SANTIAGO'),
	(818, 19, '720', 'SARDINATA'),
	(819, 19, '743', 'SILOS'),
	(820, 19, '800', 'TEORAMA'),
	(821, 19, '810', 'TIBU'),
	(822, 19, '820', 'TOLEDO'),
	(823, 19, '871', 'VILLACARO'),
	(824, 19, '874', 'VILLA DEL ROSARIO'),
	(825, 20, '001', 'ARMENIA'),
	(826, 20, '111', 'BUENAVISTA'),
	(827, 20, '130', 'CALARCA'),
	(828, 20, '190', 'CIRCASIA'),
	(829, 20, '212', 'CORDOBA'),
	(830, 20, '272', 'FILANDIA'),
	(831, 20, '302', 'GENOVA'),
	(832, 20, '401', 'LA TEBAIDA'),
	(833, 20, '470', 'MONTENEGRO'),
	(834, 20, '548', 'PIJAO'),
	(835, 20, '594', 'QUIMBAYA'),
	(836, 20, '690', 'SALENTO'),
	(837, 21, '001', 'PEREIRA'),
	(838, 21, '045', 'APIA'),
	(839, 21, '075', 'BALBOA'),
	(840, 21, '088', 'BELEN DE UMBRIA'),
	(841, 21, '170', 'DOS QUEBRADAS'),
	(842, 21, '318', 'GUATICA'),
	(843, 21, '383', 'LA CELIA'),
	(844, 21, '400', 'LA VIRGINIA'),
	(845, 21, '440', 'MARSELLA'),
	(846, 21, '456', 'MISTRATO'),
	(847, 21, '572', 'PUEBLO RICO'),
	(848, 21, '594', 'QUINCHIA'),
	(849, 21, '682', 'SANTA ROSA DE CABAL'),
	(850, 21, '687', 'SANTUARIO'),
	(851, 22, '001', 'BUCARAMANGA'),
	(852, 22, '013', 'AGUADA'),
	(853, 22, '020', 'ALBANIA'),
	(854, 22, '051', 'ARATOCA'),
	(855, 22, '077', 'BARBOSA'),
	(856, 22, '079', 'BARICHARA'),
	(857, 22, '081', 'BARRANCABERMEJA'),
	(858, 22, '092', 'BETULIA'),
	(859, 22, '101', 'BOLIVAR'),
	(860, 22, '121', 'CABRERA'),
	(861, 22, '132', 'CALIFORNIA'),
	(862, 22, '147', 'CAPITANEJO'),
	(863, 22, '152', 'CARCASI'),
	(864, 22, '160', 'CEPITA'),
	(865, 22, '162', 'CERRITO'),
	(866, 22, '167', 'CHARALA'),
	(867, 22, '169', 'CHARTA'),
	(868, 22, '176', 'CHIMA'),
	(869, 22, '179', 'CHIPATA'),
	(870, 22, '190', 'CIMITARRA'),
	(871, 22, '207', 'CONCEPCION'),
	(872, 22, '209', 'CONFINES'),
	(873, 22, '211', 'CONTRATACION'),
	(874, 22, '217', 'COROMORO'),
	(875, 22, '229', 'CURITI'),
	(876, 22, '235', 'EL CARMEN DE CHUCURY'),
	(877, 22, '245', 'EL GUACAMAYO'),
	(878, 22, '250', 'EL PEÑON'),
	(879, 22, '255', 'EL PLAYON'),
	(880, 22, '264', 'ENCINO'),
	(881, 22, '266', 'ENCISO'),
	(882, 22, '271', 'FLORIAN'),
	(883, 22, '276', 'FLORIDABLANCA'),
	(884, 22, '296', 'GALAN'),
	(885, 22, '298', 'GAMBITA'),
	(886, 22, '307', 'GIRON'),
	(887, 22, '318', 'GUACA'),
	(888, 22, '320', 'GUADALUPE'),
	(889, 22, '322', 'GUAPOTA'),
	(890, 22, '324', 'GUAVATA'),
	(891, 22, '327', 'GUEPSA'),
	(892, 22, '344', 'HATO'),
	(893, 22, '368', 'JESUS MARIA'),
	(894, 22, '370', 'JORDAN'),
	(895, 22, '377', 'LA BELLEZA'),
	(896, 22, '385', 'LANDAZURI'),
	(897, 22, '397', 'LA PAZ'),
	(898, 22, '406', 'LEBRIJA'),
	(899, 22, '418', 'LOS SANTOS'),
	(900, 22, '425', 'MACARAVITA'),
	(901, 22, '432', 'MALAGA'),
	(902, 22, '444', 'MATANZA'),
	(903, 22, '464', 'MOGOTES'),
	(904, 22, '468', 'MOLAGAVITA'),
	(905, 22, '498', 'OCAMONTE'),
	(906, 22, '500', 'OIBA'),
	(907, 22, '502', 'ONZAGA'),
	(908, 22, '522', 'PALMAR'),
	(909, 22, '524', 'PALMAS DEL SOCORRO'),
	(910, 22, '533', 'PARAMO'),
	(911, 22, '547', 'PIEDECUESTA'),
	(912, 22, '549', 'PINCHOTE'),
	(913, 22, '572', 'PUENTE NACIONAL'),
	(914, 22, '573', 'PUERTO PARRA'),
	(915, 22, '575', 'PUERTO WILCHES'),
	(916, 22, '615', 'RIONEGRO'),
	(917, 22, '655', 'SABANA DE TORRES'),
	(918, 22, '669', 'SAN ANDRES'),
	(919, 22, '673', 'SAN BENITO'),
	(920, 22, '679', 'SAN GIL'),
	(921, 22, '682', 'SAN JOAQUIN'),
	(922, 22, '684', 'SAN JOSE DE MIRANDA'),
	(923, 22, '686', 'SAN MIGUEL'),
	(924, 22, '689', 'SAN VICENTE DE CHUCURI'),
	(925, 22, '705', 'SANTA BARBARA'),
	(926, 22, '720', 'SANTA HELENA DEL OPON'),
	(927, 22, '745', 'SIMACOTA'),
	(928, 22, '755', 'SOCORRO'),
	(929, 22, '770', 'SUAITA'),
	(930, 22, '773', 'SUCRE'),
	(931, 22, '780', 'SURATA'),
	(932, 22, '820', 'TONA'),
	(933, 22, '855', 'VALLE SAN JOSE'),
	(934, 22, '861', 'VELEZ'),
	(935, 22, '867', 'VETAS'),
	(936, 22, '872', 'VILLANUEVA'),
	(937, 22, '895', 'ZAPATOCA'),
	(938, 23, '001', 'SINCELEJO'),
	(939, 23, '110', 'BUENAVISTA'),
	(940, 23, '124', 'CAIMITO'),
	(941, 23, '204', 'COLOSO (RICAURTE)'),
	(942, 23, '215', 'COROZAL'),
	(943, 23, '230', 'CHALAN'),
	(944, 23, '235', 'GALERAS (NUEVA GRANADA)'),
	(945, 23, '265', 'GUARANDA'),
	(946, 23, '400', 'LA UNION'),
	(947, 23, '418', 'LOS PALMITOS'),
	(948, 23, '429', 'MAJAGUAL'),
	(949, 23, '473', 'MORROA'),
	(950, 23, '508', 'OVEJAS'),
	(951, 23, '523', 'PALMITO'),
	(952, 23, '670', 'SAMPUES'),
	(953, 23, '678', 'SAN BENITO ABAD'),
	(954, 23, '702', 'SAN JUAN DE BETULIA'),
	(955, 23, '708', 'SAN MARCOS'),
	(956, 23, '713', 'SAN ONOFRE'),
	(957, 23, '717', 'SAN PEDRO'),
	(958, 23, '742', 'SINCE'),
	(959, 23, '771', 'SUCRE'),
	(960, 23, '820', 'TOLU'),
	(961, 23, '823', 'TOLUVIEJO'),
	(962, 24, '001', 'IBAGUE'),
	(963, 24, '024', 'ALPUJARRA'),
	(964, 24, '026', 'ALVARADO'),
	(965, 24, '030', 'AMBALEMA'),
	(966, 24, '043', 'ANZOATEGUI'),
	(967, 24, '055', 'ARMERO (GUAYABAL)'),
	(968, 24, '067', 'ATACO'),
	(969, 24, '124', 'CAJAMARCA'),
	(970, 24, '148', 'CARMEN APICALA'),
	(971, 24, '152', 'CASABIANCA'),
	(972, 24, '168', 'CHAPARRAL'),
	(973, 24, '200', 'COELLO'),
	(974, 24, '217', 'COYAIMA'),
	(975, 24, '226', 'CUNDAY'),
	(976, 24, '236', 'DOLORES'),
	(977, 24, '268', 'ESPINAL'),
	(978, 24, '270', 'FALAN'),
	(979, 24, '275', 'FLANDES'),
	(980, 24, '283', 'FRESNO'),
	(981, 24, '319', 'GUAMO'),
	(982, 24, '347', 'HERVEO'),
	(983, 24, '349', 'HONDA'),
	(984, 24, '352', 'ICONONZO'),
	(985, 24, '408', 'LERIDA'),
	(986, 24, '411', 'LIBANO'),
	(987, 24, '443', 'MARIQUITA'),
	(988, 24, '449', 'MELGAR'),
	(989, 24, '461', 'MURILLO'),
	(990, 24, '483', 'NATAGAIMA'),
	(991, 24, '504', 'ORTEGA'),
	(992, 24, '520', 'PALOCABILDO'),
	(993, 24, '547', 'PIEDRAS'),
	(994, 24, '555', 'PLANADAS'),
	(995, 24, '563', 'PRADO'),
	(996, 24, '585', 'PURIFICACION'),
	(997, 24, '616', 'RIOBLANCO'),
	(998, 24, '622', 'RONCESVALLES'),
	(999, 24, '624', 'ROVIRA'),
	(1000, 24, '671', 'SALDAÑA'),
	(1001, 24, '675', 'SAN ANTONIO'),
	(1002, 24, '678', 'SAN LUIS'),
	(1003, 24, '686', 'SANTA ISABEL'),
	(1004, 24, '770', 'SUAREZ'),
	(1005, 24, '854', 'VALLE DE SAN JUAN'),
	(1006, 24, '861', 'VENADILLO'),
	(1007, 24, '870', 'VILLAHERMOSA'),
	(1008, 24, '873', 'VILLARRICA'),
	(1009, 25, '001', 'CALI (SANTIAGO DE CALI)'),
	(1010, 25, '020', 'ALCALA'),
	(1011, 25, '036', 'ANDALUCIA'),
	(1012, 25, '041', 'ANSERMANUEVO'),
	(1013, 25, '054', 'ARGELIA'),
	(1014, 25, '100', 'BOLIVAR'),
	(1015, 25, '109', 'BUENAVENTURA'),
	(1016, 25, '111', 'BUGA'),
	(1017, 25, '113', 'BUGALAGRANDE'),
	(1018, 25, '122', 'CAICEDONIA'),
	(1019, 25, '126', 'CALIMA (DARIEN)'),
	(1020, 25, '130', 'CANDELARIA'),
	(1021, 25, '147', 'CARTAGO'),
	(1022, 25, '233', 'DAGUA'),
	(1023, 25, '243', 'EL AGUILA'),
	(1024, 25, '246', 'EL CAIRO'),
	(1025, 25, '248', 'EL CERRITO'),
	(1026, 25, '250', 'EL DOVIO'),
	(1027, 25, '275', 'FLORIDA'),
	(1028, 25, '306', 'GINEBRA'),
	(1029, 25, '318', 'GUACARI'),
	(1030, 25, '364', 'JAMUNDI'),
	(1031, 25, '377', 'LA CUMBRE'),
	(1032, 25, '400', 'LA UNION'),
	(1033, 25, '403', 'LA VICTORIA'),
	(1034, 25, '497', 'OBANDO'),
	(1035, 25, '520', 'PALMIRA'),
	(1036, 25, '563', 'PRADERA'),
	(1037, 25, '606', 'RESTREPO'),
	(1038, 25, '616', 'RIOFRIO'),
	(1039, 25, '622', 'ROLDANILLO'),
	(1040, 25, '670', 'SAN PEDRO'),
	(1041, 25, '736', 'SEVILLA'),
	(1042, 25, '823', 'TORO'),
	(1043, 25, '828', 'TRUJILLO'),
	(1044, 25, '834', 'TULUA'),
	(1045, 25, '845', 'ULLOA'),
	(1046, 25, '863', 'VERSALLES'),
	(1047, 25, '869', 'VIJES'),
	(1048, 25, '890', 'YOTOCO'),
	(1049, 25, '892', 'YUMBO'),
	(1050, 25, '895', 'ZARZAL'),
	(1051, 26, '001', 'ARAUCA'),
	(1052, 26, '065', 'ARAUQUITA'),
	(1053, 26, '220', 'CRAVO NORTE'),
	(1054, 26, '300', 'FORTUL'),
	(1055, 26, '591', 'PUERTO RONDON'),
	(1056, 26, '736', 'SARAVENA'),
	(1057, 26, '794', 'TAME'),
	(1058, 27, '001', 'YOPAL'),
	(1059, 27, '010', 'AGUAZUL'),
	(1060, 27, '015', 'CHAMEZA'),
	(1061, 27, '125', 'HATO COROZAL'),
	(1062, 27, '136', 'LA SALINA'),
	(1063, 27, '139', 'MANI'),
	(1064, 27, '162', 'MONTERREY'),
	(1065, 27, '225', 'NUNCHIA'),
	(1066, 27, '230', 'OROCUE'),
	(1067, 27, '250', 'PAZ DE ARIPORO'),
	(1068, 27, '263', 'PORE'),
	(1069, 27, '279', 'RECETOR'),
	(1070, 27, '300', 'SABANALARGA'),
	(1071, 27, '315', 'SACAMA'),
	(1072, 27, '325', 'SAN LUIS DE PALENQUE'),
	(1073, 27, '400', 'TAMARA'),
	(1074, 27, '410', 'TAURAMENA'),
	(1075, 27, '430', 'TRINIDAD'),
	(1076, 27, '440', 'VILLANUEVA'),
	(1077, 28, '001', 'MOCOA'),
	(1078, 28, '219', 'COLON'),
	(1079, 28, '320', 'ORITO'),
	(1080, 28, '568', 'PUERTO ASIS'),
	(1081, 28, '569', 'PUERTO CAICEDO'),
	(1082, 28, '571', 'PUERTO GUZMAN'),
	(1083, 28, '573', 'PUERTO LEGUIZAMO'),
	(1084, 28, '749', 'SIBUNDOY'),
	(1085, 28, '755', 'SAN FRANCISCO'),
	(1086, 28, '757', 'SAN MIGUEL (LA DORADA)'),
	(1087, 28, '760', 'SANTIAGO'),
	(1088, 28, '865', 'LA HORMIGA (VALLE DEL GUAMUEZ)'),
	(1089, 28, '885', 'VILLAGARZON'),
	(1090, 29, '001', 'SAN ANDRES'),
	(1091, 29, '564', 'PROVIDENCIA'),
	(1092, 30, '001', 'LETICIA'),
	(1093, 30, '263', 'EL ENCANTO'),
	(1094, 30, '405', 'LA CHORRERA'),
	(1095, 30, '407', 'LA PEDRERA'),
	(1096, 30, '430', 'LA VICTORIA'),
	(1097, 30, '460', 'MIRITI-PARANA'),
	(1098, 30, '530', 'PUERTO ALEGRIA'),
	(1099, 30, '536', 'PUERTO ARICA'),
	(1100, 30, '540', 'PUERTO NARIÑO'),
	(1101, 30, '669', 'PUERTO SANTANDER'),
	(1102, 30, '798', 'TARAPACA'),
	(1103, 31, '001', 'PUERTO INIRIDA'),
	(1104, 31, '343', 'BARRANCO MINAS'),
	(1105, 31, '883', 'SAN FELIPE'),
	(1106, 31, '884', 'PUERTO COLOMBIA'),
	(1107, 31, '885', 'LA GUADALUPE'),
	(1108, 31, '886', 'CACAHUAL'),
	(1109, 31, '887', 'PANA PANA (CAMPO ALEGRE)'),
	(1110, 31, '888', 'MORICHAL (MORICHAL NUEVO)'),
	(1111, 32, '001', 'SAN JOSE DEL GUAVIARE'),
	(1112, 32, '015', 'CALAMAR'),
	(1113, 32, '025', 'EL RETORNO'),
	(1114, 32, '200', 'MIRAFLORES'),
	(1115, 33, '001', 'MITU'),
	(1116, 33, '161', 'CARURU'),
	(1117, 33, '511', 'PACOA'),
	(1118, 33, '666', 'TARAIRA'),
	(1119, 33, '777', 'PAPUNAUA (MORICHAL)'),
	(1120, 33, '889', 'YAVARATE'),
	(1121, 35, '001', 'PUERTO CARREÑO'),
	(1122, 35, '524', 'LA PRIMAVERA'),
	(1123, 35, '572', 'SANTA RITA'),
	(1124, 35, '666', 'SANTA ROSALIA'),
	(1125, 35, '760', 'SAN JOSE DE OCUNE'),
	(1126, 35, '773', 'CUMARIBO'),
	(1128, 1, '000', 'No aplica');
/*!40000 ALTER TABLE `cities` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;


ALTER TABLE `establecimiento`
	DROP FOREIGN KEY `establecimiento_ibfk_263`,
	DROP FOREIGN KEY `establecimiento_ibfk_261`,
	DROP FOREIGN KEY `establecimiento_ibfk_258`,
	DROP FOREIGN KEY `establecimiento_ibfk_251`,
	DROP FOREIGN KEY `establecimiento_ibfk_239`,
	DROP FOREIGN KEY `establecimiento_ibfk_227`,
	DROP FOREIGN KEY `establecimiento_ibfk_220`,
	DROP FOREIGN KEY `establecimiento_ibfk_219`;

ALTER TABLE `establecimiento`
	DROP COLUMN `RESGUARDO`,
	DROP COLUMN `ETNIA`,
	DROP COLUMN `DISCA`,
	DROP COLUMN `CAPAEXCEP`,
	DROP COLUMN `SUBSIDIO`,
	DROP COLUMN `ID_CARACTER`,
	DROP COLUMN `FECHA_CREACION`,
	DROP COLUMN `DPTO_FUN`,
	DROP COLUMN `ID_CALENDARIO`;
	
ALTER TABLE `establecimiento`
	ADD COLUMN `ID_COUNTRY` INT(20) NOT NULL DEFAULT '45' AFTER `ID`,
	ADD INDEX `K_ID_COUNTRY` (`ID_COUNTRY`),
	ADD CONSTRAINT `FK_establecimiento_countries` FOREIGN KEY (`ID_COUNTRY`) REFERENCES `countries` (`id`) ON UPDATE CASCADE;

ALTER TABLE `establecimiento`
	CHANGE COLUMN `SEDES` `SEDES` INT NOT NULL DEFAULT '1' AFTER `CORREO`;

ALTER TABLE `establecimiento`
	ALTER `NOMBRE_IE` DROP DEFAULT;
ALTER TABLE `establecimiento`
	CHANGE COLUMN `NOMBRE_IE` `NOMBRE_IE` VARCHAR(250) NOT NULL AFTER `LOCALIDAD`;
	
ALTER TABLE `establecimiento`
	COLLATE='utf8_general_ci',
	CONVERT TO CHARSET utf8;

ALTER TABLE `tipo_establecimiento`
	COLLATE='utf8_general_ci',
	CONVERT TO CHARSET utf8;
	
ALTER TABLE `establecimiento`
	CHANGE COLUMN `MUN_FUN` `ID_CITY` INT(30) NOT NULL DEFAULT '1' AFTER `ID_SECTOR`,
	DROP INDEX `mun_FUN`,
	ADD INDEX `K_ID_CITY` (`ID_CITY`),
	ADD CONSTRAINT `FK_establecimiento_cities` FOREIGN KEY (`ID_CITY`) REFERENCES `cities` (`id`) ON UPDATE CASCADE;
	
ALTER TABLE `establecimiento`
	CHANGE COLUMN `TELEFONOS` `TELEFONOS` VARCHAR(250) NOT NULL DEFAULT '0' AFTER `DIRECCION`;
	
	
ALTER TABLE `establecimiento`
	ALTER `COD_DANE` DROP DEFAULT,
	ALTER `ID_ZONA` DROP DEFAULT,
	ALTER `ID_SECTOR` DROP DEFAULT,
	ALTER `LOCALIDAD` DROP DEFAULT,
	ALTER `CORREO` DROP DEFAULT,
	ALTER `NIT` DROP DEFAULT;
ALTER TABLE `establecimiento`
	CHANGE COLUMN `ID_CITY` `ID_CITY` INT(30) NOT NULL DEFAULT '1' AFTER `ID_COUNTRY`,
	CHANGE COLUMN `ID_ZONA` `ID_ZONA` INT(1) NOT NULL AFTER `ID_CITY`,
	CHANGE COLUMN `ID_SECTOR` `ID_SECTOR` VARCHAR(1) NOT NULL AFTER `ID_ZONA`,
	CHANGE COLUMN `COD_DANE` `COD_DANE` VARCHAR(12) NOT NULL AFTER `GENERO`,
	CHANGE COLUMN `NIT` `NIT` VARCHAR(20) NOT NULL AFTER `NOMBRE_IE`,
	CHANGE COLUMN `LOCALIDAD` `LOCALIDAD` VARCHAR(100) NOT NULL AFTER `DIRECCION`,
	CHANGE COLUMN `CORREO` `CORREO` VARCHAR(200) NOT NULL AFTER `WEB`;

ALTER TABLE `sedes`
	ALTER `COD_ZONA` DROP DEFAULT,
	ALTER `FAX` DROP DEFAULT,
	ALTER `COD_SEXO` DROP DEFAULT,
	ALTER `CONS_SEDE` DROP DEFAULT,
	ALTER `NOM_SEDE` DROP DEFAULT,
	ALTER `DIREC_SEDE` DROP DEFAULT,
	ALTER `TEL_SED` DROP DEFAULT,
	ALTER `EMAIL` DROP DEFAULT;
ALTER TABLE `sedes`
	CHANGE COLUMN `mun` `ID_CITY` INT(30) NOT NULL DEFAULT '1' AFTER `ID_INST`,
	CHANGE COLUMN `COD_ZONA` `ID_ZONA` INT(2) NOT NULL AFTER `ID_CITY`,
	CHANGE COLUMN `COD_SEXO` `ID_SEXO` INT(1) NOT NULL AFTER `ID_ZONA`,
	CHANGE COLUMN `CONS_SEDE` `CONS_SEDE` VARCHAR(14) NOT NULL AFTER `ID_SEXO`,
	CHANGE COLUMN `FAX` `FAX` VARCHAR(50) NOT NULL AFTER `DANE_SEDE`,
	CHANGE COLUMN `NOM_SEDE` `NOMBRE_SEDE` VARCHAR(100) NOT NULL AFTER `FAX`,
	CHANGE COLUMN `DIREC_SEDE` `DIRECCION_SEDE` VARCHAR(100) NOT NULL AFTER `NOMBRE_SEDE`,
	CHANGE COLUMN `TEL_SED` `TELEFONOS_SEDE` VARCHAR(200) NOT NULL AFTER `DIRECCION_SEDE`,
	CHANGE COLUMN `EMAIL` `EMAIL` VARCHAR(200) NOT NULL AFTER `BARRIO`,
	DROP COLUMN `COD_JORN`,
	DROP COLUMN `COD_NIV`,
	DROP COLUMN `FECHA`,
	DROP COLUMN `dpto`;
	
	
/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Volcando estructura para tabla sme.niveles_sedes
CREATE TABLE IF NOT EXISTS `niveles_sedes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_sede` int(30) NOT NULL,
  `id_nivel` int(30) NOT NULL,
  `estado` int(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_Nivel_Sede` (`id_nivel`,`id_sede`),
  KEY `K_id_sede` (`id_sede`),
  KEY `K_id_nivel` (`id_nivel`),
  CONSTRAINT `FK_niveles_sedes_niveles_estudio` FOREIGN KEY (`id_nivel`) REFERENCES `niveles_estudio` (`id`) ON UPDATE CASCADE,
  CONSTRAINT `FK_niveles_sedes_sedes` FOREIGN KEY (`id_sede`) REFERENCES `sedes` (`ID`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla sme.niveles_sedes: ~4 rows (aproximadamente)
/*!40000 ALTER TABLE `niveles_sedes` DISABLE KEYS */;
INSERT INTO `niveles_sedes` (`id`, `id_sede`, `id_nivel`, `estado`) VALUES
	(1, 1, 1, 1),
	(2, 1, 2, 1),
	(3, 1, 3, 1),
	(4, 1, 4, 1);
/*!40000 ALTER TABLE `niveles_sedes` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;

-- Volcando estructura para tabla sme.jornadas_sedes
CREATE TABLE IF NOT EXISTS `jornadas_sedes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `id_sede` int(11) NOT NULL,
  `id_jornada` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UK_jornada_sede` (`id_jornada`,`id_sede`),
  KEY `id_sede` (`id_sede`),
  KEY `id_jornada` (`id_jornada`),
  CONSTRAINT `FK_jornadas_sedes_jornadas` FOREIGN KEY (`id_jornada`) REFERENCES `jornadas` (`cod_jorn`) ON UPDATE CASCADE,
  CONSTRAINT `FK_jornadas_sedes_sedes` FOREIGN KEY (`id_sede`) REFERENCES `sedes` (`ID`) ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8;

-- Volcando datos para la tabla sme.jornadas_sedes: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `jornadas_sedes` DISABLE KEYS */;
INSERT INTO `jornadas_sedes` (`id`, `id_sede`, `id_jornada`) VALUES
	(1, 1, 1),
	(2, 1, 2),
	(3, 1, 3);
/*!40000 ALTER TABLE `jornadas_sedes` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;


ALTER TABLE `usuarios`
ALTER `propietario`
DROP DEFAULT,
ALTER `user_u`
DROP DEFAULT,
ALTER `pasword_u`
DROP DEFAULT;
ALTER TABLE `usuarios`
	CHANGE COLUMN `propietario` `nombres` VARCHAR
(60) NOT NULL AFTER `tipo_usuario`,
	CHANGE COLUMN `user_u` `username` VARCHAR
(200) NOT NULL AFTER `nombres`,
	CHANGE COLUMN `pasword_u` `password` VARCHAR
(200) NOT NULL AFTER `username`;

RENAME TABLE `usuarios` TO `users`;

ALTER TABLE `users`
	ALTER `nombres` DROP DEFAULT,
	ALTER `pregunta` DROP DEFAULT,
	ALTER `correo` DROP DEFAULT,
	ALTER `fecha` DROP DEFAULT,
	ALTER `telefonos` DROP DEFAULT;
ALTER TABLE `users`
	CHANGE COLUMN `tipo_usuario` `user_type` INT(20) NOT NULL DEFAULT '3' AFTER `id_inst`,
	CHANGE COLUMN `nombres` `names` VARCHAR(60) NOT NULL AFTER `user_type`,
	CHANGE COLUMN `pregunta` `question` VARCHAR(200) NOT NULL AFTER `password`,
	CHANGE COLUMN `correo` `email` VARCHAR(200) NOT NULL AFTER `respuest`,
	CHANGE COLUMN `estado` `state` INT(1) NOT NULL DEFAULT '1' AFTER `email`,
	CHANGE COLUMN `lectura` `lectur` INT(1) NOT NULL DEFAULT '0' AFTER `state`,
	CHANGE COLUMN `mensaje` `message` MEDIUMTEXT NOT NULL AFTER `lectur`,
	CHANGE COLUMN `fecha` `date` DATE NOT NULL AFTER `message`,
	CHANGE COLUMN `foto` `image` TEXT NOT NULL AFTER `date`,
	CHANGE COLUMN `telefonos` `phone` VARCHAR(200) NOT NULL AFTER `mime`;

ALTER TABLE `users`
	ADD COLUMN `id_sex` INT(20) NOT NULL DEFAULT '1' AFTER `id_inst`,
	ADD COLUMN `last_name` VARCHAR(60) NULL DEFAULT NULL AFTER `names`,
	ADD COLUMN `birth_date` DATE NULL DEFAULT NULL AFTER `last_name`,
	CHANGE COLUMN `question` `question` VARCHAR(200) NULL DEFAULT NULL AFTER `password`,
	CHANGE COLUMN `respuest` `respuest` VARCHAR(200) NULL DEFAULT NULL AFTER `question`;

ALTER TABLE `users`
	ALTER `id_oficina` DROP DEFAULT;
ALTER TABLE `users`
	CHANGE COLUMN `id_oficina` `id_oficina` INT(11) NOT NULL AFTER `user_type`,
	CHANGE COLUMN `state` `state` INT(1) NOT NULL DEFAULT '1' AFTER `phone`;

ALTER TABLE `users`
	ADD INDEX `id_sex` (`id_sex`),
	ADD CONSTRAINT `FK_users_sexo` FOREIGN KEY (`id_sex`) REFERENCES `sexo` (`ID_SEXO`);


ALTER TABLE `docentes`
	DROP COLUMN `dpto_exp`,
	DROP COLUMN `dpto_nac`,
	DROP COLUMN `f_recurso`,
	DROP COLUMN `id_ubicacion`,
	DROP COLUMN `otra`;
ALTER TABLE `docentes`
	ALTER `id_etno_edu` DROP DEFAULT,
	ALTER `id_area_tec` DROP DEFAULT;
ALTER TABLE `docentes`
	CHANGE COLUMN `id_etno_edu` `id_etno_edu` INT(1) NOT NULL AFTER `id_doc`,
	CHANGE COLUMN `id_escalafon` `id_escalafon` INT(2) NOT NULL DEFAULT '1' AFTER `id_etno_edu`,
	CHANGE COLUMN `id_area_tec` `id_area_tec` INT(2) NOT NULL AFTER `id_escalafon`;

ALTER TABLE `docentes`
	CHANGE COLUMN `foto` `foto` TEXT NOT NULL AFTER `tipo_sangr`;

ALTER TABLE `docentes`
	DROP COLUMN `id_etno_edu`,
	DROP COLUMN `id_area_tec`,
	DROP COLUMN `n_cargo`,
	DROP COLUMN `cod_car`,
	DROP COLUMN `fecha_vinc`,
	DROP COLUMN `id_sede`,
	DROP COLUMN `cod_zona`,
	DROP COLUMN `ext`,
	DROP COLUMN `cod_vin`;

ALTER TABLE `docentes`
	ALTER `cod_nivel` DROP DEFAULT,
	ALTER `arean_ens` DROP DEFAULT;
ALTER TABLE `docentes`
	CHANGE COLUMN `cod_nivel` `cod_nivel` INT(1) NOT NULL AFTER `cod_ense`,
	CHANGE COLUMN `arean_ens` `arean_ens` INT(2) NOT NULL AFTER `cod_nivel`;
ALTER TABLE `docentes`
	ADD COLUMN `id_country` INT(20) NOT NULL DEFAULT '45' AFTER `id_inst`,
	ADD INDEX `id_country` (`id_country`),
	ADD CONSTRAINT `FK_docentes_countries` FOREIGN KEY (`id_country`) REFERENCES `countries` (`id`) ON UPDATE CASCADE;

ALTER TABLE `docentes`
	ALTER `pasw` DROP DEFAULT;
ALTER TABLE `docentes`
	CHANGE COLUMN `pasw` `password` VARCHAR(200) NOT NULL AFTER `año`;
ALTER TABLE `docentes`
	CHANGE COLUMN `id_doc` `id_documento` INT(1) NOT NULL DEFAULT '1' AFTER `id_country`;

ALTER TABLE `docentes`
	ALTER `tipo_sangr` DROP DEFAULT,
	ALTER `fec_nac` DROP DEFAULT;
ALTER TABLE `docentes`
	CHANGE COLUMN `tipo_sangr` `tipo_sangre` VARCHAR(5) NOT NULL AFTER `direccion`,
	CHANGE COLUMN `foto` `image` TEXT NOT NULL AFTER `tipo_sangre`,
	CHANGE COLUMN `fec_nac` `fecha_nacimiento` DATE NOT NULL AFTER `documento`,
	CHANGE COLUMN `movil` `movil` VARCHAR(30) NOT NULL DEFAULT '000000000000' AFTER `edad`,
	CHANGE COLUMN `fijo` `fijo` VARCHAR(30) NOT NULL DEFAULT '0000000000' AFTER `movil`,
	CHANGE COLUMN `e_mail` `email` VARCHAR(60) NOT NULL DEFAULT 'correo@correo.com' AFTER `mun_nac`;

ALTER TABLE `docentes`
	ALTER `documento` DROP DEFAULT;
ALTER TABLE `docentes`
	CHANGE COLUMN `documento` `documento` VARCHAR(20) NOT NULL AFTER `mime`;

ALTER TABLE `docentes`
	CHANGE COLUMN `image` `image` TEXT NULL DEFAULT NULL AFTER `tipo_sangre`;

ALTER TABLE `docentes`
	CHANGE COLUMN `tipo_sangre` `tipo_sangre` VARCHAR(5) NULL DEFAULT NULL AFTER `direccion`,
	CHANGE COLUMN `apellido2` `apellido2` VARCHAR(15) NULL DEFAULT NULL AFTER `apellido1`,
	CHANGE COLUMN `nombre2` `nombre2` VARCHAR(15) NULL DEFAULT NULL AFTER `nombre1`,
	CHANGE COLUMN `movil` `movil` VARCHAR(30) NULL DEFAULT NULL AFTER `edad`,
	CHANGE COLUMN `fijo` `fijo` VARCHAR(30) NULL DEFAULT NULL AFTER `movil`;

ALTER TABLE `docentes`
	CHANGE COLUMN `id_docente` `id_docente` INT
(30) NOT NULL AUTO_INCREMENT FIRST;

CREATE TABLE `aux_docentes` (
	`id` INT(30) NOT NULL AUTO_INCREMENT,
	`id_docente` INT(30) NOT NULL,
	`document`	VARCHAR(20) NOT NULL,
	`year` YEAR NOT NULL,
	PRIMARY KEY (`id`),
	INDEX `id_docente` (`id_docente`),
	INDEX `year` (`year`)
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=1;

INSERT INTO aux_docentes (id, id_docente, document, year) 
SELECT t.id_docente, t.id_docente, t.documento, t.`año` FROM docentes t;

CREATE TABLE `docentes_old` (
	`id_docente` INT(20) NOT NULL AUTO_INCREMENT,
	`id_inst` INT(20) NOT NULL DEFAULT '1',
	`id_country` INT(20) NOT NULL DEFAULT '45',
	`id_documento` INT(1) NOT NULL DEFAULT '1',
	`id_escalafon` INT(2) NOT NULL DEFAULT '1',
	`cod_ense` INT(1) NOT NULL,
	`cod_nivel` INT(1) NOT NULL,
	`arean_ens` INT(2) NOT NULL,
	`direccion` VARCHAR(100) NOT NULL,
	`tipo_sangre` VARCHAR(5) NULL DEFAULT NULL,
	`image` TEXT NULL DEFAULT NULL,
	`mime` VARCHAR(100) NOT NULL DEFAULT 'image/jpeg',
	`documento` VARCHAR(20) NOT NULL,
	`fecha_nacimiento` DATE NOT NULL,
	`apellido1` VARCHAR(15) NOT NULL,
	`apellido2` VARCHAR(15) NULL DEFAULT NULL,
	`nombre1` VARCHAR(15) NOT NULL,
	`nombre2` VARCHAR(15) NULL DEFAULT NULL,
	`sexo` VARCHAR(1) NOT NULL,
	`edad` INT(2) NOT NULL DEFAULT '0',
	`movil` VARCHAR(30) NULL DEFAULT NULL,
	`fijo` VARCHAR(30) NULL DEFAULT NULL,
	`mun_exp` INT(11) NOT NULL,
	`mun_nac` INT(11) NOT NULL,
	`email` VARCHAR(60) NOT NULL DEFAULT 'correo@correo.com',
	`año` INT(4) NOT NULL,
	`password` VARCHAR(200) NOT NULL,
	`estado` INT(1) NOT NULL DEFAULT '1',
	`timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY (`id_docente`),
	INDEX `id_doc` (`id_documento`),
	INDEX `cod_nivel` (`cod_nivel`),
	INDEX `cod_ense` (`cod_ense`),
	INDEX `arean_ens` (`arean_ens`),
	INDEX `mun_exp` (`mun_exp`),
	INDEX `mun_nac` (`mun_nac`),
	INDEX `escalafon` (`id_escalafon`),
	INDEX `id_inst` (`id_inst`),
	INDEX `apellido1` (`apellido1`),
	INDEX `apellido2` (`apellido2`),
	INDEX `nombre1` (`nombre1`),
	INDEX `nombre2` (`nombre2`),
	INDEX `documento` (`documento`),
	INDEX `pasw` (`password`),
	INDEX `id_country` (`id_country`)
)
COMMENT='Datos personal docente'
COLLATE='utf8_general_ci'
ENGINE=InnoDB
ROW_FORMAT=COMPACT
AUTO_INCREMENT=1
;

INSERT INTO docentes_old 
SELECT * FROM docentes;

ALTER TABLE `cursos`
	DROP FOREIGN KEY `FK_cursos_docentes`;

ALTER TABLE `dir_grupo`
	DROP FOREIGN KEY `FK_dir_grupo_docentes`;

ALTER TABLE `conv_reg_situaciones_est`
	DROP FOREIGN KEY `conv_reg_situaciones_est_ibfk_5`;

ALTER TABLE `logros_estandares`
	DROP FOREIGN KEY `FK_logros_estandares_docentes`;

ALTER TABLE `parcelador`
	DROP FOREIGN KEY `FK_parcelador_docentes`;

ALTER TABLE `obs_anotaciones_mod_3`
	DROP FOREIGN KEY `obs_anotaciones_mod_3_ibfk_2`;

DELETE FROM docentes;
ALTER TABLE `docentes` AUTO_INCREMENT=0;

INSERT INTO docentes 
SELECT * FROM docentes_old GROUP BY documento;

ALTER TABLE `docentes`
DROP COLUMN `año`;

UPDATE aux_docentes t SET t.id_docente = (SELECT td.id_docente FROM docentes td WHERE td.documento = t.document);

ALTER TABLE `aux_docentes`
	ADD CONSTRAINT `FK_aux_docentes_docentes` FOREIGN KEY (`id_docente`) REFERENCES `docentes` (`id_docente`) ON UPDATE CASCADE;
ALTER TABLE `aux_docentes`
	DROP COLUMN `document`;


ALTER TABLE `administrativos`
	DROP COLUMN `id_cra_adva`,
	DROP COLUMN `id_vinculacion`,
	DROP COLUMN `id_nivel_jerarquico`,
	DROP COLUMN `id_ubicacion`,
	DROP COLUMN `id_tiempo_asignado`,
	DROP COLUMN `id_fuente_recursos`,
	DROP COLUMN `dep_lug_nac`,
	DROP COLUMN `dep_lug_exp`,
	DROP COLUMN `fecha_vinculacion`,
	DROP FOREIGN KEY `FK_administrativos_vinculacion_advos`,
	DROP FOREIGN KEY `FK_administrativos_ubicacion_advos`,
	DROP FOREIGN KEY `FK_administrativos_tiempo_asignado`,
	DROP FOREIGN KEY `FK_administrativos_nivel_jerarquico`,
	DROP FOREIGN KEY `FK_administrativos_fuenterecursos`,
	DROP FOREIGN KEY `FK_administrativos_docdocente`,
	DROP FOREIGN KEY `FK_administrativos_carrera_administrativa`;

ALTER TABLE `administrativos`
	ADD COLUMN `id_country` INT(20) NOT NULL DEFAULT '45' AFTER `id_inst`,
	DROP INDEX `numero_documento`,
	ADD INDEX `id_country` (`id_country`),
	ADD UNIQUE INDEX `numero_documento` (`numero_documento`),
	ADD CONSTRAINT `FK_administrativos_countries` FOREIGN KEY (`id_country`) REFERENCES `countries` (`id`) ON UPDATE CASCADE,
	ADD CONSTRAINT `FK_administrativos_documentos` FOREIGN KEY (`id_documento`) REFERENCES `documentos` (`id`) ON UPDATE CASCADE;

DROP TABLE IF EXISTS `dir_grupo_old`;

ALTER TABLE `dir_grupo`
	DROP FOREIGN KEY `FK_dir_grupo_docentes`;
ALTER TABLE `dir_grupo`
DROP INDEX `id`,
DROP INDEX `FK_dir_grupo_establecimiento`,
DROP INDEX `FK_dir_grupo_grados`,
DROP INDEX `FK_dir_grupo_jornadas`,
DROP FOREIGN KEY `FK_dir_grupo_jornadas`,
DROP FOREIGN KEY `FK_dir_grupo_grados`,
DROP FOREIGN KEY `FK_dir_grupo_establecimiento`;

ALTER TABLE `dir_grupo`
	ALTER `id_docente` DROP DEFAULT,
	ALTER `año` DROP DEFAULT;
ALTER TABLE `dir_grupo`
	CHANGE COLUMN `id_docente` `id_docente` INT(30) NOT NULL AFTER `id_sede`,
	CHANGE COLUMN `año` `year` SMALLINT(4) NOT NULL AFTER `id_jorn`,
	CHANGE COLUMN `estado` `estado` TINYINT(1) NOT NULL DEFAULT 1 AFTER `year`,
	DROP COLUMN `id_inst`,
	ADD INDEX `id_sede` (`id_sede`),
	ADD INDEX `id_docente` (`id_docente`),
	ADD INDEX `grupo` (`grupo`);

ALTER TABLE `dir_grupo`
	ADD UNIQUE INDEX `id_sede_id_docente_id_grado_grupo_id_jorn_year` (`id_sede`, `id_docente`, `id_grado`, `grupo`, `id_jorn`, `year`);

UPDATE dir_grupo AS t SET t.id_docente = (SELECT id_docente FROM aux_docentes t2 WHERE t2.id = t.id_docente);

ALTER TABLE `dir_grupo`
	ADD CONSTRAINT `FK_dir_grupo_sedes` FOREIGN KEY (`id_sede`) REFERENCES `sedes` (`ID`) ON UPDATE CASCADE,
	ADD CONSTRAINT `FK_dir_grupo_docentes` FOREIGN KEY (`id_docente`) REFERENCES `docentes` (`id_docente`) ON UPDATE CASCADE,
	ADD CONSTRAINT `FK_dir_grupo_grados` FOREIGN KEY (`id_grado`) REFERENCES `grados` (`id`) ON UPDATE CASCADE,
	ADD CONSTRAINT `FK_dir_grupo_jornadas` FOREIGN KEY (`id_jorn`) REFERENCES `jornadas` (`cod_jorn`) ON UPDATE CASCADE;

ALTER TABLE
  `inscripciones` CHANGE COLUMN `cod_est` `id` INT(30) NOT NULL AUTO_INCREMENT FIRST;
  ALTER TABLE `inscripciones`
	DROP COLUMN `id_inst`,
	DROP COLUMN `dpto_lug_pobl`,
	DROP COLUMN `dpto_lug_nac`,
	DROP COLUMN `dpto_lug_res`,
	DROP COLUMN `dpto_lug_exp`;

ALTER TABLE `inscripciones`
	CHANGE COLUMN `id_año` `id_year` VARCHAR(20) NOT NULL DEFAULT '0000000-0000' AFTER `e_mail`,
	DROP COLUMN `ben_her_nan`,
	DROP COLUMN `ben_vet_fp`,
	DROP COLUMN `ben_mad_flia`,
	DROP COLUMN `cab_familia`;

ALTER TABLE `inscripciones`
	ALTER `fecha_insc` DROP DEFAULT;
ALTER TABLE `inscripciones`
	CHANGE COLUMN `fecha_insc` `fecha_ingreso` DATE NULL AFTER `tipo_sangre`;

ALTER TABLE `inscripciones`
	ALTER `fecha_nacimiento` DROP DEFAULT;
ALTER TABLE `inscripciones`
	CHANGE COLUMN `fecha_nacimiento` `fecha_nacimiento` DATE NULL AFTER `fecha_ingreso`;

ALTER TABLE `inscripciones`
	ALTER `tipo_sangre` DROP DEFAULT;
ALTER TABLE `inscripciones`
	CHANGE COLUMN `apellido2` `apellido2` VARCHAR(30) NULL DEFAULT '' AFTER `apellido1`,
	CHANGE COLUMN `nombre2` `nombre2` VARCHAR(30) NULL DEFAULT '' AFTER `nombre1`,
	CHANGE COLUMN `tipo_sangre` `tipo_sangre` VARCHAR(3) NULL AFTER `nombre2`;
ALTER TABLE `inscripciones`
	ALTER `apellido2` DROP DEFAULT,
	ALTER `nombre2` DROP DEFAULT;
ALTER TABLE `inscripciones`
	CHANGE COLUMN `apellido2` `apellido2` VARCHAR(30) NULL AFTER `apellido1`,
	CHANGE COLUMN `nombre2` `nombre2` VARCHAR(30) NULL AFTER `nombre1`;

ALTER TABLE `capacidades_excepcionales`
	ADD INDEX `id` (`id`);
ALTER TABLE `tipo_discapacidad`
	ADD INDEX `id` (`id`);
DELETE FROM `capacidades_excepcionales` WHERE  `id`=0 AND `nombre`='Ninguno' LIMIT 1;
ALTER TABLE `capacidades_excepcionales`
	CHANGE COLUMN `id` `id` INT(11) NOT NULL AUTO_INCREMENT FIRST;
ALTER TABLE `capacidades_excepcionales`
	CHANGE COLUMN `id` `id` INT(11) NOT NULL AUTO_INCREMENT FIRST,
	ADD PRIMARY KEY (`id`);
DELETE FROM `tipo_discapacidad` WHERE  `id`=0 AND `nombre`='Ninguna' LIMIT 1;
ALTER TABLE `tipo_discapacidad`
	CHANGE COLUMN `id` `id` INT(11) NOT NULL AUTO_INCREMENT FIRST,
	ADD PRIMARY KEY (`id`);
ALTER TABLE `etnias`
	ALTER `COD_ETNIA` DROP DEFAULT,
	ALTER `NOM_ETNIA` DROP DEFAULT;
ALTER TABLE `etnias`
	ADD COLUMN `id` INT NOT NULL AUTO_INCREMENT FIRST,
	CHANGE COLUMN `COD_ETNIA` `codigo` VARCHAR(3) NOT NULL COLLATE 'latin1_spanish_ci' AFTER `id`,
	CHANGE COLUMN `NOM_ETNIA` `nombre_etnia` VARCHAR(200) NOT NULL COLLATE 'latin1_spanish_ci' AFTER `codigo`,
	DROP PRIMARY KEY,
	ADD INDEX `codigo` (`codigo`),
	ADD PRIMARY KEY (`id`);
ALTER TABLE `etnias`
	COLLATE='utf8_general_ci',
	CONVERT TO CHARSET utf8;
ALTER TABLE `etnias`
	ALTER `codigo` DROP DEFAULT;
ALTER TABLE `etnias`
	CHANGE COLUMN `codigo` `codigo` VARCHAR(6) NOT NULL AFTER `id`;
ALTER TABLE `resguardos`
	ALTER `COD_RESGUA` DROP DEFAULT,
	ALTER `NOMB_RESG` DROP DEFAULT;
ALTER TABLE `resguardos`
	COLLATE='utf8_general_ci',
	CONVERT TO CHARSET utf8,
	ADD COLUMN `id` INT NOT NULL AUTO_INCREMENT FIRST,
	CHANGE COLUMN `COD_RESGUA` `codigo` VARCHAR(6) NOT NULL COLLATE 'utf8_general_ci' AFTER `id`,
	CHANGE COLUMN `NOMB_RESG` `nombre_resguardo` VARCHAR(200) NOT NULL COLLATE 'utf8_general_ci' AFTER `codigo`,
	DROP PRIMARY KEY,
	ADD INDEX `codigo` (`codigo`),
	ADD PRIMARY KEY (`id`);


CREATE TABLE `extra_inscripciones` (
	`id` INT(30) NOT NULL AUTO_INCREMENT,
	`id_inscripcion` INT(30) NOT NULL,
	`id_eps` INT(30) NOT NULL DEFAULT 0,
	`id_etnia` INT(11) NOT NULL DEFAULT 1,
	`id_resgua` INT(11) NOT NULL DEFAULT 1,
	`id_discapacidad` INT(11) NOT NULL DEFAULT 99,
	`id_cap_exc` INT(11) NOT NULL DEFAULT 99,
	`ben_her_nan` INT(1) NOT NULL DEFAULT 0,
	`ben_vet_fp` INT(1) NOT NULL DEFAULT 0,
	`ben_mad_flia` INT(1) NOT NULL DEFAULT 0,
	`cab_familia` INT(1) NOT NULL DEFAULT 0,
	`proviene_otro_mun` VARCHAR(2) NOT NULL DEFAULT 'No',
	`proviene_sector_priv` VARCHAR(2) NOT NULL DEFAULT 'No',
	`sisben` VARCHAR(12) NOT NULL DEFAULT '9 No Aplica',
	`nro_sisben` VARCHAR(20) NOT NULL DEFAULT '0',
	`puntaje_sisben` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`cod_flia_accion` VARCHAR(20) NULL DEFAULT NULL,
	PRIMARY KEY (`id`),
	INDEX `id_inscripcion` (`id_inscripcion`),
	INDEX `id_eps` (`id_eps`),
	INDEX `id_cap_exc` (`id_cap_exc`),
	INDEX `id_discapacidad` (`id_discapacidad`),
	INDEX `id_resgua` (`id_resgua`),
	INDEX `id_etnia` (`id_etnia`),
	CONSTRAINT `FK_extra_inscripciones_capacidades_excepcionales` FOREIGN KEY (`id_cap_exc`) REFERENCES `capacidades_excepcionales` (`id`) ON UPDATE CASCADE,
	CONSTRAINT `FK_extra_inscripciones_eps` FOREIGN KEY (`id_eps`) REFERENCES `eps` (`id`) ON UPDATE CASCADE,
	CONSTRAINT `FK_extra_inscripciones_etnias` FOREIGN KEY (`id_etnia`) REFERENCES `etnias` (`id`) ON UPDATE CASCADE,
	CONSTRAINT `FK_extra_inscripciones_inscripciones` FOREIGN KEY (`id_inscripcion`) REFERENCES `inscripciones` (`id`) ON UPDATE CASCADE,
	CONSTRAINT `FK_extra_inscripciones_resguardos` FOREIGN KEY (`id_resgua`) REFERENCES `resguardos` (`id`) ON UPDATE CASCADE,
	CONSTRAINT `FK_extra_inscripciones_tipo_discapacidad` FOREIGN KEY (`id_discapacidad`) REFERENCES `tipo_discapacidad` (`id`) ON UPDATE CASCADE
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=1
;


UPDATE inscripciones SET cap_exc = 99 WHERE cap_exc = 0;
UPDATE inscripciones SET cap_exc = 99 WHERE cap_exc = 9;
UPDATE inscripciones SET tipo_discapacidad = 99 WHERE tipo_discapacidad = 0;
UPDATE inscripciones SET tipo_discapacidad = 99 WHERE tipo_discapacidad = 9;


CREATE TABLE `inscripciones_copy` (
	`id` INT(30) NOT NULL AUTO_INCREMENT,
	`id_zona` INT(1) NOT NULL,
	`id_eps` INT(20) NOT NULL DEFAULT 1,
	`foto` TEXT NOT NULL,
	`mime` VARCHAR(100) NOT NULL DEFAULT 'image/jpeg',
	`cap_exc` INT(2) NOT NULL DEFAULT 99,
	`proviene_otro_mun` VARCHAR(2) NOT NULL DEFAULT 'No',
	`proviene_sector_priv` VARCHAR(2) NOT NULL DEFAULT 'No',
	`pob_vict_conf` VARCHAR(1) NOT NULL DEFAULT '9',
	`cod_etnia` VARCHAR(3) NOT NULL DEFAULT '000',
	`cod_resgua` VARCHAR(3) NOT NULL DEFAULT '000',
	`cod_doc` INT(2) NOT NULL DEFAULT 5,
	`nro_doc_id` VARCHAR(20) NOT NULL DEFAULT '0000000000',
	`mun_lug_pobl` INT(11) NOT NULL,
	`mun_lug_nac` INT(11) NOT NULL,
	`mun_lug_res` INT(11) NOT NULL,
	`mun_lug_exp` INT(11) NOT NULL,
	`apellido1` VARCHAR(30) NOT NULL,
	`apellido2` VARCHAR(30) NULL DEFAULT NULL,
	`nombre1` VARCHAR(30) NOT NULL,
	`nombre2` VARCHAR(30) NULL DEFAULT NULL,
	`tipo_sangre` VARCHAR(3) NULL DEFAULT NULL,
	`fecha_ingreso` DATE NULL DEFAULT NULL,
	`fecha_nacimiento` DATE NULL DEFAULT NULL,
	`edad` INT(2) NOT NULL DEFAULT 0,
	`sexo` VARCHAR(1) NOT NULL DEFAULT 'x',
	`estrato` VARCHAR(1) NOT NULL DEFAULT '0',
	`sisben` VARCHAR(12) NOT NULL DEFAULT '9 No aplica',
	`nro_sisben` VARCHAR(20) NOT NULL DEFAULT '0',
	`puntaje_sisben` DECIMAL(5,2) NOT NULL DEFAULT 0.00,
	`direccion` VARCHAR(200) NOT NULL DEFAULT 'Desconocida',
	`telefono` VARCHAR(12) NOT NULL DEFAULT '0000000000',
	`IPS` VARCHAR(200) NOT NULL DEFAULT 'Ninguna',
	`tipo_discapacidad` VARCHAR(2) NOT NULL DEFAULT '99',
	`e_mail` VARCHAR(160) NOT NULL DEFAULT 'correo@correo.com',
	`id_year` VARCHAR(20) NOT NULL DEFAULT '0000000-0000',
	`cod_flia_accion` VARCHAR(20) NOT NULL DEFAULT '0',
	PRIMARY KEY (`id`),
	INDEX `cod_etnia` (`cod_etnia`),
	INDEX `cod_resgua` (`cod_resgua`),
	INDEX `mun_lug_exp` (`mun_lug_exp`),
	INDEX `mun_lug_pobl` (`mun_lug_pobl`),
	INDEX `mun_lug_nac` (`mun_lug_nac`),
	INDEX `mun_lug_res` (`mun_lug_res`),
	INDEX `cod_doc` (`cod_doc`),
	INDEX `id_zona` (`id_zona`),
	INDEX `apellido1` (`apellido1`),
	INDEX `apellido2` (`apellido2`),
	INDEX `nombre1` (`nombre1`),
	INDEX `nombre2` (`nombre2`),
	INDEX `nro_doc_id` (`nro_doc_id`),
	INDEX `apellido1_2` (`apellido1`),
	INDEX `apellido2_2` (`apellido2`),
	INDEX `nombre1_2` (`nombre1`),
	INDEX `nombre2_2` (`nombre2`),
	INDEX `nro_doc_id_2` (`nro_doc_id`),
	INDEX `id_eps` (`id_eps`)
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=1
;

INSERT INTO inscripciones_copy SELECT * FROM inscripciones;
SET FOREIGN_KEY_CHECKS =0;
DELETE FROM inscripciones;
ALTER TABLE `inscripciones`
ALTER `nro_doc_id`
DROP DEFAULT;
ALTER TABLE `inscripciones`
	CHANGE COLUMN `nro_doc_id` `nro_doc_id` VARCHAR
(20) NOT NULL AFTER `cod_doc`,
ADD UNIQUE INDEX `uk_nro_doc_id`
(`nro_doc_id`);
SET FOREIGN_KEY_CHECKS =1;

INSERT IGNORE INTO inscripciones SELECT * FROM inscripciones_copy;

INSERT INTO extra_inscripciones  (id_inscripcion, id_eps, id_etnia, id_resgua, id_discapacidad,
id_cap_exc, proviene_otro_mun, proviene_sector_priv, sisben, nro_sisben, puntaje_sisben, cod_flia_accion) 
SELECT ti.id, ti.id_eps, te.id, re.id, ti.tipo_discapacidad,
ti.cap_exc, ti.proviene_otro_mun, ti.proviene_sector_priv, ti.sisben, ti.nro_sisben, 
ti.puntaje_sisben, ti.cod_flia_accion 
FROM inscripciones AS ti 
LEFT JOIN etnias AS te ON ti.cod_etnia = te.codigo 
LEFT JOIN resguardos AS re ON ti.cod_resgua = re.codigo;

ALTER TABLE `poblacion_victima_conflicto`
	CHANGE COLUMN `id` `id` INT(4) NOT NULL AUTO_INCREMENT FIRST,
	ADD PRIMARY KEY (`id`);

ALTER TABLE `extra_inscripciones`
	ADD COLUMN `id_pob_vic_conf` INT(11) NOT NULL DEFAULT 9 AFTER `id_cap_exc`,
	ADD INDEX `id_pob_vic_conf` (`id_pob_vic_conf`),
	ADD CONSTRAINT `FK_extra_inscripciones_poblacion_victima_conflicto` FOREIGN KEY (`id_pob_vic_conf`) REFERENCES `poblacion_victima_conflicto` (`id`) ON UPDATE CASCADE;

UPDATE inscripciones SET pob_vict_conf = 9 WHERE tipo_discapacidad = 0;

UPDATE extra_inscripciones t SET t.id_pob_vic_conf = 
(SELECT t1.pob_vict_conf FROM inscripciones t1 WHERE t1.id = t.id_inscripcion LIMIT 1);

ALTER TABLE `inscripciones`
	DROP COLUMN `id_eps`,
	DROP COLUMN `cap_exc`,
	DROP COLUMN `proviene_otro_mun`,
	DROP COLUMN `proviene_sector_priv`,
	DROP COLUMN `pob_vict_conf`,
	DROP COLUMN `cod_etnia`,
	DROP COLUMN `cod_resgua`,
	DROP COLUMN `sisben`,
	DROP COLUMN `nro_sisben`,
	DROP COLUMN `puntaje_sisben`,
	DROP COLUMN `tipo_discapacidad`,
	DROP COLUMN `cod_flia_accion`,
	DROP INDEX `cod_etnia`,
	DROP INDEX `cod_resgua`,
	DROP INDEX `id_eps`,
	DROP FOREIGN KEY `FK_inscripciones_eps`;

ALTER TABLE `inscripciones`
	ALTER `nro_doc_id` DROP DEFAULT;
ALTER TABLE `inscripciones`
	CHANGE COLUMN `cod_doc` `id_documento` INT(11) NOT NULL DEFAULT 99 AFTER `id_zona`,
	CHANGE COLUMN `sexo` `sexo` VARCHAR(1) NOT NULL DEFAULT 'x' AFTER `id_documento`,
	CHANGE COLUMN `nro_doc_id` `nro_documento` VARCHAR(20) NOT NULL AFTER `mime`,
	CHANGE COLUMN `telefono` `telefono` VARCHAR(30) NULL DEFAULT NULL AFTER `direccion`,
	ADD COLUMN `movil` VARCHAR(30) NULL DEFAULT NULL AFTER `telefono`,
	CHANGE COLUMN `IPS` `ips` VARCHAR(200) NULL DEFAULT NULL AFTER `movil`,
	CHANGE COLUMN `e_mail` `email` VARCHAR(250) NOT NULL DEFAULT 'correo@correo.com' AFTER `ips`;

ALTER TABLE `inscripciones`
	DROP FOREIGN KEY `inscripciones_ibfk_1`,
	DROP FOREIGN KEY `inscripciones_ibfk_2`;
ALTER TABLE `inscripciones`
	ADD CONSTRAINT `FK_inscripciones_documentos` FOREIGN KEY (`id_documento`) REFERENCES `documentos` (`id`) ON UPDATE CASCADE,
	ADD CONSTRAINT `FK_inscripciones_zona` FOREIGN KEY (`id_zona`) REFERENCES `zona` (`id_zona`) ON UPDATE CASCADE;

ALTER TABLE `administrativos`
	ALTER `id_documento` DROP DEFAULT;
ALTER TABLE `administrativos`
	CHANGE COLUMN `id_documento` `id_documento` INT(11) NOT NULL AFTER `id_country`;

ALTER TABLE `administrativos`
	CHANGE COLUMN `id_documento` `id_documento` INT(11) NOT NULL DEFAULT 99 AFTER `id_country`;

ALTER TABLE `docentes`
	CHANGE COLUMN `id_documento` `id_documento` INT(11) NOT NULL DEFAULT 99 AFTER `id_country`;
ALTER TABLE `docentes`
	ADD CONSTRAINT `FK_docentes_documentos` FOREIGN KEY (`id_documento`) REFERENCES `documentos` (`id`);

SET FOREIGN_KEY_CHECKS =0;
UPDATE `documentos` SET `id`='99' WHERE  `id`=0;
SET FOREIGN_KEY_CHECKS =1;

ALTER TABLE `documentos`
	ALTER `id` DROP DEFAULT;
ALTER TABLE `documentos`
	CHANGE COLUMN `id` `id` INT(11) NOT NULL FIRST;

ALTER TABLE `inscripciones`
	CHANGE COLUMN `id_year` `id_year` VARCHAR(50) NULL DEFAULT NULL AFTER `sexo`,
	CHANGE COLUMN `foto` `foto` TEXT NULL AFTER `id_year`;

ALTER TABLE `sexo`
	COLLATE='utf8_general_ci',
	CONVERT TO CHARSET utf8;

ALTER TABLE `sexo`
	ALTER `ID_SEXO` DROP DEFAULT,
	ALTER `TIPO` DROP DEFAULT;

ALTER TABLE `sexo`
	CHANGE COLUMN `ID_SEXO` `id` INT(1) NOT NULL FIRST,
	CHANGE COLUMN `TIPO` `nombre_sexo` VARCHAR(30) NOT NULL AFTER `id`;

ALTER TABLE `sexo`
	ADD COLUMN `abrev_sexo` VARCHAR(2) NULL DEFAULT NULL AFTER `nombre_sexo`;

UPDATE `sexo` SET `abrev_sexo`='M' WHERE  `id`=1;
UPDATE `sexo` SET `abrev_sexo`='F' WHERE  `id`=2;
UPDATE `sexo` SET `abrev_sexo`='MX' WHERE  `id`=3;

INSERT INTO `sexo` (`id`, `nombre_sexo`, `abrev_sexo`) VALUES ('0', 'No asignado', 'NA');

ALTER TABLE `inscripciones`
	ADD COLUMN `id_sexo` INT(1) NOT NULL DEFAULT 0 AFTER `id_documento`,
	ADD INDEX `id_sexo` (`id_sexo`),
	ADD CONSTRAINT `FK_inscripciones_sexo` FOREIGN KEY (`id_sexo`) REFERENCES `sexo` (`id`) ON UPDATE CASCADE;

UPDATE inscripciones t SET t.id_sexo = 1 WHERE t.sexo = 'M';
UPDATE inscripciones t SET t.id_sexo = 2 WHERE t.sexo = 'F';
UPDATE inscripciones t SET t.id_sexo = 0 WHERE t.sexo = 'X';

ALTER TABLE `inscripciones`
	DROP COLUMN `sexo`;
ALTER TABLE `inscripciones`
	CHANGE COLUMN `foto` `foto` TEXT NULL DEFAULT NULL AFTER `tipo_sangre`,
	CHANGE COLUMN `mime` `mime` VARCHAR(100) NOT NULL DEFAULT 'image/jpeg' AFTER `foto`,
	ADD INDEX `id_year` (`id_year`);

ALTER TABLE `inscripciones`
	ALTER `mun_lug_nac` DROP DEFAULT,
	ALTER `mun_lug_res` DROP DEFAULT,
	ALTER `mun_lug_exp` DROP DEFAULT;
ALTER TABLE `inscripciones`
	ADD COLUMN `id_country` INT(30) NOT NULL DEFAULT 45 AFTER `id_sexo`,
	CHANGE COLUMN `mun_lug_nac` `lug_nacimiento` INT(11) NOT NULL AFTER `nro_documento`,
	CHANGE COLUMN `mun_lug_res` `lug_residencia` INT(11) NOT NULL AFTER `lug_nacimiento`,
	CHANGE COLUMN `mun_lug_exp` `lug_expedicion` INT(11) NOT NULL AFTER `lug_residencia`,
	DROP COLUMN `mun_lug_pobl`,
	ADD INDEX `id_country` (`id_country`),
	ADD CONSTRAINT `FK_inscripciones_countries` FOREIGN KEY (`id_country`) REFERENCES `countries` (`id`) ON UPDATE CASCADE;

ALTER TABLE `inscripciones`
	CHANGE COLUMN `edad` `edad` INT(3) NOT NULL DEFAULT 0 AFTER `fecha_nacimiento`,
	CHANGE COLUMN `estrato` `estrato` VARCHAR(1) NULL DEFAULT '0' AFTER `edad`,
	CHANGE COLUMN `direccion` `direccion` VARCHAR(250) NULL DEFAULT NULL AFTER `estrato`,
	ADD COLUMN `timestamp` TIMESTAMP NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp() AFTER `email`;

ALTER TABLE `inscripciones`
	CHANGE COLUMN `email` `email` VARCHAR(250) NULL DEFAULT NULL AFTER `ips`;
ALTER TABLE `inscripciones`
	ADD COLUMN `localidad` VARCHAR(250) NULL DEFAULT NULL AFTER `direccion`;


UPDATE inscripciones SET lug_nacimiento = 1 WHERE lug_nacimiento = 0;
UPDATE inscripciones SET lug_residencia = 1 WHERE lug_residencia = 0;
UPDATE inscripciones SET lug_expedicion = 1 WHERE lug_expedicion = 0;

ALTER TABLE `inscripciones`
	ADD CONSTRAINT `FK_inscripciones_cities` FOREIGN KEY (`lug_nacimiento`) REFERENCES `cities` (`id`) ON UPDATE CASCADE,
	ADD CONSTRAINT `FK_inscripciones_cities_2` FOREIGN KEY (`lug_residencia`) REFERENCES `cities` (`id`) ON UPDATE CASCADE,
	ADD CONSTRAINT `FK_inscripciones_cities_3` FOREIGN KEY (`lug_expedicion`) REFERENCES `cities` (`id`) ON
UPDATE CASCADE;

DELETE FROM usuarios_estu;
DROP TABLE usuarios_estu;

CREATE TABLE `student_users` (
	`id` INT(30) NOT NULL AUTO_INCREMENT,
	`id_student` INT(30) NOT NULL,
	`username` VARCHAR(250) NOT NULL,
	`user_password` VARCHAR(250) NOT NULL,
	`image` TEXT NULL DEFAULT NULL,
	`mime` VARCHAR(60) NOT NULL DEFAULT 'image/jpeg',
	`date` DATE NULL DEFAULT NULL,
	`state` TINYINT(1) NOT NULL DEFAULT 1,
	`timestamp` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
	PRIMARY KEY (`id`),
	UNIQUE INDEX `username` (`username`),
	INDEX `id_student` (`id_student`),
	CONSTRAINT `FK_student_users_inscripciones` FOREIGN KEY (`id_student`) REFERENCES `inscripciones` (`id`) ON UPDATE CASCADE ON DELETE CASCADE
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;

ALTER TABLE `matriculas`
	COLLATE='utf8_general_ci',
	CONVERT TO CHARSET utf8;

ALTER TABLE `matriculas`
DROP COLUMN `id_inst`;

ALTER TABLE `matriculas`
	DROP FOREIGN KEY `FK_matriculas_estado_matricula`,
	DROP FOREIGN KEY `FK_matriculas_grados`,
	DROP FOREIGN KEY `FK_matriculas_inscripciones`,
	DROP FOREIGN KEY `FK_matriculas_jornadas`,
	DROP FOREIGN KEY `FK_matriculas_sedes`;
	
SET FOREIGN_KEY_CHECKS =0;
ALTER TABLE `matriculas`
	ADD CONSTRAINT `FK_matriculas_estado_matricula` FOREIGN KEY (`id_estado`) REFERENCES `estado_matricula` (`id`) ON UPDATE CASCADE,
	ADD CONSTRAINT `FK_matriculas_grados` FOREIGN KEY (`id_grado`) REFERENCES `grados` (`id`) ON UPDATE CASCADE,
	ADD CONSTRAINT `FK_matriculas_inscripciones` FOREIGN KEY (`cod_est`) REFERENCES `inscripciones` (`id`) ON UPDATE CASCADE,
	ADD CONSTRAINT `FK_matriculas_jornadas` FOREIGN KEY (`id_jorn`) REFERENCES `jornadas` (`cod_jorn`) ON UPDATE CASCADE,
	ADD CONSTRAINT `FK_matriculas_sedes` FOREIGN KEY (`id_sede`) REFERENCES `sedes` (`ID`) ON UPDATE CASCADE;

DROP TABLE IF EXISTS `matriculas_old`;

SET FOREIGN_KEY_CHECKS =1;

ALTER TABLE `matriculas`
	ALTER `año` DROP DEFAULT;
ALTER TABLE `matriculas`
	CHANGE COLUMN `obs` `obs` VARCHAR(254) NULL DEFAULT NULL AFTER `ins_proced`,
	CHANGE COLUMN `año` `year` YEAR NOT NULL AFTER `fecha`,
	ADD COLUMN `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP() AFTER `promovido`,
	DROP COLUMN `condicion`,
	DROP COLUMN `situacion`,
	DROP COLUMN `repite`,
	DROP COLUMN `subsidio`;
ALTER TABLE `matriculas`
	ALTER `id_folio` DROP DEFAULT,
	ALTER `nro_matricula` DROP DEFAULT,
	ALTER `libro_mat` DROP DEFAULT;
ALTER TABLE `matriculas`
	CHANGE COLUMN `id_folio` `folio` INT(4) NOT NULL AFTER `nuevo`,
	CHANGE COLUMN `nro_matricula` `nro_matricula` INT(4) NOT NULL AFTER `folio`,
	CHANGE COLUMN `libro_mat` `libro_mat` INT(4) NOT NULL AFTER `nro_matricula`,
	CHANGE COLUMN `fecha` `fecha` DATE NULL DEFAULT NULL AFTER `libro_mat`;

ALTER TABLE `matriculas`
	ALTER `folio` DROP DEFAULT,
	ALTER `nro_matricula` DROP DEFAULT,
	ALTER `libro_mat` DROP DEFAULT;
ALTER TABLE `matriculas`
	CHANGE COLUMN `folio` `folio` INT(4) NOT NULL AFTER `id_estado`,
	CHANGE COLUMN `nro_matricula` `nro_matricula` INT(4) NOT NULL AFTER `folio`,
	CHANGE COLUMN `libro_mat` `libro_mat` INT(4) NOT NULL AFTER `nro_matricula`,
	CHANGE COLUMN `dir_inst` `direccion_inst` VARCHAR(200) NOT NULL DEFAULT 'No aplica' AFTER `grupo`,
	CHANGE COLUMN `ins_proced` `ins_procedencia` VARCHAR(100) NOT NULL DEFAULT 'No aplica' AFTER `direccion_inst`,
	DROP COLUMN `mot_retiro`,
	DROP COLUMN `nuevo`;

ALTER TABLE `matriculas`
	ALTER `libro_mat` DROP DEFAULT;
ALTER TABLE `matriculas`
	CHANGE COLUMN `libro_mat` `libro` INT(4) NOT NULL AFTER `nro_matricula`;

CREATE TABLE `registration_novelties` (
	`id` INT(30) NOT NULL AUTO_INCREMENT,
	`id_register` INT(30) NOT NULL,
	`id_state` INT(30) NOT NULL,
	`motive` TEXT NULL DEFAULT NULL,
	`date` DATE NULL DEFAULT NULL,
	`timestamp` TIMESTAMP NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
	PRIMARY KEY (`id`),
	INDEX `id_register` (`id_register`),
	INDEX `id_state` (`id_state`),
	CONSTRAINT `FK_registration_novelties_estado_matricula` FOREIGN KEY (`id_state`) REFERENCES `estado_matricula` (`id`) ON UPDATE CASCADE,
	CONSTRAINT `FK_registration_novelties_matriculas` FOREIGN KEY (`id_register`) REFERENCES `matriculas` (`id_matric`) ON UPDATE CASCADE ON DELETE CASCADE
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;

ALTER TABLE `matriculas`
	ALTER `grupo` DROP DEFAULT;
ALTER TABLE `matriculas`
	CHANGE COLUMN `grupo` `grupo` VARCHAR(4) NOT NULL AFTER `libro`; 
 
ALTER TABLE `matriculas` RENAME TO `student_enrollment`;
ALTER TABLE `estado_matricula` RENAME TO `registration_status`;

ALTER TABLE `registration_status`
	ALTER `estado_matricula` DROP DEFAULT;
ALTER TABLE `registration_status`
	CHANGE COLUMN `estado_matricula` `name_state` VARCHAR(200) NOT NULL AFTER `id`;

ALTER TABLE `registration_novelties`
	DROP FOREIGN KEY `FK_registration_novelties_estado_matricula`,
	DROP FOREIGN KEY `FK_registration_novelties_matriculas`,
	ADD CONSTRAINT `FK_registration_novelties_student_enrollment` FOREIGN KEY (`id_register`) REFERENCES `student_enrollment` (`id_matric`) ON UPDATE CASCADE ON DELETE CASCADE,
	ADD CONSTRAINT `FK_registration_novelties_registration_status` FOREIGN KEY (`id_state`) REFERENCES `registration_status` (`id`) ON UPDATE CASCADE;
ALTER TABLE `student_enrollment`
	COMMENT='Registro de las matriculas de cada estudiante';

ALTER TABLE `student_enrollment`
	ALTER `id_sede` DROP DEFAULT,
	ALTER `id_jorn` DROP DEFAULT,
	ALTER `cod_est` DROP DEFAULT,
	ALTER `id_grado` DROP DEFAULT;
ALTER TABLE `student_enrollment`
	CHANGE COLUMN `id_matric` `id` INT(30) NOT NULL AUTO_INCREMENT FIRST,
	CHANGE COLUMN `id_sede` `id_headquarters` INT(20) NOT NULL AFTER `id`,
	CHANGE COLUMN `id_jorn` `id_study_day` INT(1) NOT NULL AFTER `id_headquarters`,
	CHANGE COLUMN `cod_est` `id_student` INT(30) NOT NULL AFTER `id_study_day`,
	CHANGE COLUMN `id_grado` `id_grade` INT(11) NOT NULL AFTER `id_student`,
	CHANGE COLUMN `id_estado` `id_state` INT(11) NOT NULL DEFAULT 2 AFTER `id_grade`;

ALTER TABLE `student_enrollment`
	ALTER `nro_matricula` DROP DEFAULT,
	ALTER `libro` DROP DEFAULT,
	ALTER `grupo` DROP DEFAULT;
ALTER TABLE `student_enrollment`
	CHANGE COLUMN `nro_matricula` `registration_number` INT(4) NOT NULL AFTER `folio`,
	CHANGE COLUMN `libro` `book` INT(4) NOT NULL AFTER `registration_number`,
	CHANGE COLUMN `grupo` `group` VARCHAR(4) NOT NULL AFTER `book`,
	CHANGE COLUMN `direccion_inst` `inst_address` VARCHAR(200) NOT NULL DEFAULT 'No aplica' AFTER `group`,
	CHANGE COLUMN `ins_procedencia` `ins_origin` VARCHAR(100) NOT NULL DEFAULT 'No aplica' AFTER `inst_address`,
	CHANGE COLUMN `fecha` `date` DATE NULL DEFAULT NULL AFTER `obs`,
	CHANGE COLUMN `promovido` `promoted` INT(1) NOT NULL DEFAULT 0 AFTER `year`;

ALTER TABLE `student_enrollment`
	DROP FOREIGN KEY `FK_matriculas_estado_matricula`,
	ADD CONSTRAINT `FK_student_enrollment_registration_status` FOREIGN KEY (`id_state`) REFERENCES `registration_status` (`id`) ON UPDATE CASCADE;
ALTER TABLE `student_enrollment`
	CHANGE COLUMN `ins_origin` `inst_origin` VARCHAR(100) NOT NULL DEFAULT 'No aplica' AFTER `inst_address`;
ALTER TABLE `student_enrollment`
	CHANGE COLUMN `inst_origin` `inst_origin` VARCHAR(200) NOT NULL DEFAULT 'No aplica' AFTER `inst_address`;

DROP TRIGGER IF EXISTS `matriculas_before_insert`;
DROP TRIGGER IF EXISTS `matriculas_before_update`;

CREATE TABLE `student_enrollment_copy` (
	`id` INT(30) NOT NULL AUTO_INCREMENT,
	`id_headquarters` INT(20) NOT NULL,
	`id_study_day` INT(1) NOT NULL,
	`id_student` INT(30) NOT NULL,
	`id_grade` INT(11) NOT NULL,
	`id_state` INT(11) NOT NULL DEFAULT 2,
	`folio` INT(4) NOT NULL,
	`registration_number` INT(4) NOT NULL,
	`book` INT(4) NOT NULL,
	`group` VARCHAR(4) NOT NULL,
	`inst_address` VARCHAR(200) NOT NULL DEFAULT 'No aplica',
	`inst_origin` VARCHAR(200) NOT NULL DEFAULT 'No aplica',
	`obs` VARCHAR(254) NULL DEFAULT NULL,
	`date` DATE NULL DEFAULT NULL,
	`year` YEAR NOT NULL,
	`promoted` INT(1) NOT NULL DEFAULT 0,
	`timestamp` TIMESTAMP NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
	PRIMARY KEY (`id`),
	INDEX `id_sede` (`id_headquarters`),
	INDEX `nro_matricula` (`registration_number`),
	INDEX `id_grado` (`id_grade`),
	INDEX `id_jorn` (`id_study_day`),
	INDEX `cod_est` (`id_student`),
	INDEX `id_estado` (`id_state`),
	INDEX `folio` (`folio`),
	INDEX `libro` (`book`)
)
COMMENT='Registro de las matriculas de cada estudiante'
COLLATE='utf8_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=1;

INSERT INTO student_enrollment_copy 
SELECT tm.* FROM student_enrollment AS tm
LEFT JOIN inscripciones AS ti ON tm.id_student = ti.id
WHERE tm.id_student = ti.id;

SET FOREIGN_KEY_CHECKS=0;
DELETE FROM student_enrollment;
ALTER TABLE `student_enrollment`
	AUTO_INCREMENT=1;
SET FOREIGN_KEY_CHECKS=1;

ALTER TABLE `student_enrollment`
	ADD UNIQUE INDEX `enrollment` (`year`, `id_grade`, `id_student`);

-- SET FOREIGN_KEY_CHECKS=0;
INSERT IGNORE INTO student_enrollment 
SELECT tm.* FROM student_enrollment_copy AS tm
LEFT JOIN inscripciones AS ti ON tm.id_student = ti.id
WHERE tm.id_student = ti.id;
-- SET FOREIGN_KEY_CHECKS=1;

-- DELETE FROM student_enrollment_copy 
-- WHERE id = (SELECT id FROM student_enrollment  WHERE id = student_enrollment_copy.id LIMIT 1 );


ALTER TABLE `student_enrollment`
	ALTER `group` DROP DEFAULT;
ALTER TABLE `student_enrollment`
	CHANGE COLUMN `group` `id_group` VARCHAR(4) NOT NULL AFTER `book`,
	ADD INDEX `id_group` (`id_group`);

DROP TABLE IF EXISTS `familiares_old`;

ALTER TABLE `familiares`
	ALTER `mun_lug_exp` DROP DEFAULT,
	ALTER `mun_lug_resid` DROP DEFAULT;
ALTER TABLE `familiares`
	COLLATE='utf8_general_ci',
	CONVERT TO CHARSET utf8,
	CHANGE COLUMN `mun_lug_exp` `lug_expedicion` INT(11) NOT NULL AFTER `nro_documento`,
	CHANGE COLUMN `mun_lug_resid` `lug_residencia` INT(11) NOT NULL AFTER `lug_expedicion`,
	DROP COLUMN `id_inst`,
	DROP COLUMN `dpto_Lug_exp`,
	DROP COLUMN `dpto_Lug_resid`;
ALTER TABLE `familiares`
	DROP FOREIGN KEY `FK_familiares_documentos`;
ALTER TABLE `familiares`
	ALTER `id_documento` DROP DEFAULT;
ALTER TABLE `familiares`
	CHANGE COLUMN `id` `id` INT(30) NOT NULL AUTO_INCREMENT FIRST,
	ADD COLUMN `id_country` INT(11) NOT NULL DEFAULT 45 AFTER `id`,
	CHANGE COLUMN `id_documento` `id_documento` INT(2) NOT NULL AFTER `id_country`,
	ADD INDEX `id_country` (`id_country`),
	ADD CONSTRAINT `FK_familiares_documentos` FOREIGN KEY (`id_documento`) REFERENCES `documentos` (`id`) ON UPDATE CASCADE,
	ADD CONSTRAINT `FK_familiares_countries` FOREIGN KEY (`id_country`) REFERENCES `countries` (`id`) ON UPDATE CASCADE;

ALTER TABLE `familiares`
	ADD COLUMN `id_sexo` INT(1) NOT NULL DEFAULT 0 AFTER `id_documento`,
	ADD COLUMN `tipo_sangre` VARCHAR(4) NOT NULL DEFAULT '' AFTER `nombre2`,
	CHANGE COLUMN `celular` `celular` VARCHAR(30) NOT NULL DEFAULT '0000000000' AFTER `direccion`,
	ADD COLUMN `fijo` VARCHAR(30) NOT NULL DEFAULT '' AFTER `celular`,
	CHANGE COLUMN `foto` `foto` VARCHAR(100) NOT NULL DEFAULT '' AFTER `email`,
	ADD COLUMN `mime` VARCHAR(50) NOT NULL DEFAULT 'image/jpeg' AFTER `foto`,
	ADD COLUMN `activo` TINYINT(1) NOT NULL DEFAULT 1 AFTER `mime`,
	ADD INDEX `id_sexo` (`id_sexo`),
	ADD CONSTRAINT `FK_familiares_sexo` FOREIGN KEY (`id_sexo`) REFERENCES `sexo` (`id`) ON UPDATE CASCADE;

ALTER TABLE `aux_familiares_estudiantes`
	DROP FOREIGN KEY `FK_aux_familiares_estudiantes_familiares`,
	DROP FOREIGN KEY `FK_aux_familiares_estudiantes_inscripciones`;
ALTER TABLE `aux_familiares_estudiantes`
	ALTER `cod_est` DROP DEFAULT;

SET FOREIGN_KEY_CHECKS = 0;
ALTER TABLE `aux_familiares_estudiantes`
	CHANGE COLUMN `cod_est` `id_student` INT(30) NOT NULL AFTER `id`,
	ADD CONSTRAINT `FK_aux_familiares_estudiantes_familiares` FOREIGN KEY (`id_familiar`) REFERENCES `familiares` (`id`) ON UPDATE CASCADE,
	ADD CONSTRAINT `FK_aux_familiares_estudiantes_inscripciones` FOREIGN KEY (`id_student`) REFERENCES `inscripciones` (`id`) ON UPDATE CASCADE;
SET FOREIGN_KEY_CHECKS = 1;

ALTER TABLE `familiares` RENAME TO `families`;
ALTER TABLE `aux_familiares_estudiantes` RENAME TO `aux_families_students`;

ALTER TABLE `families`
	ALTER `id_documento` DROP DEFAULT,
	ALTER `nro_documento` DROP DEFAULT,
	ALTER `lug_expedicion` DROP DEFAULT,
	ALTER `lug_residencia` DROP DEFAULT,
	ALTER `apellido1` DROP DEFAULT,
	ALTER `nombre1` DROP DEFAULT;
ALTER TABLE `families`
	CHANGE COLUMN `id_documento` `id_document` INT(2) NOT NULL AFTER `id_country`,
	CHANGE COLUMN `id_sexo` `id_sex` INT(1) NOT NULL DEFAULT 0 AFTER `id_document`,
	CHANGE COLUMN `nro_documento` `document` VARCHAR(30) NOT NULL AFTER `id_sex`,
	CHANGE COLUMN `lug_expedicion` `expedition_plane` INT(11) NOT NULL AFTER `document`,
	CHANGE COLUMN `lug_residencia` `birth_place` INT(11) NOT NULL AFTER `expedition_plane`,
	CHANGE COLUMN `apellido1` `lastname1` VARCHAR(30) NOT NULL AFTER `birth_place`,
	CHANGE COLUMN `apellido2` `lastname2` VARCHAR(30) NOT NULL DEFAULT '' AFTER `lastname1`,
	CHANGE COLUMN `nombre1` `name1` VARCHAR(30) NOT NULL AFTER `lastname2`,
	CHANGE COLUMN `nombre2` `name2` VARCHAR(30) NOT NULL DEFAULT '' AFTER `name1`,
	CHANGE COLUMN `tipo_sangre` `blood_type` VARCHAR(4) NOT NULL DEFAULT '' AFTER `name2`,
	CHANGE COLUMN `direccion` `address` VARCHAR(250) NOT NULL DEFAULT 'Desconocida' AFTER `blood_type`,
	CHANGE COLUMN `celular` `mobile` VARCHAR(45) NOT NULL DEFAULT '0000000000' AFTER `address`,
	CHANGE COLUMN `ocupacion` `occupation` VARCHAR(120) NOT NULL DEFAULT 'Desconocida' AFTER `mobile`,
	CHANGE COLUMN `direccion_lab` `work_address` VARCHAR(120) NOT NULL DEFAULT 'Desconocida' AFTER `occupation`,
	CHANGE COLUMN `empresa` `company` VARCHAR(120) NOT NULL DEFAULT 'Desconocida' AFTER `work_address`,
	CHANGE COLUMN `foto` `image` VARCHAR(100) NOT NULL DEFAULT '' AFTER `email`,
	CHANGE COLUMN `activo` `active` TINYINT(1) NOT NULL DEFAULT 1 AFTER `mime`,
	DROP COLUMN `fijo`;
ALTER TABLE `aux_families_students`
	ALTER `id_familiar` DROP DEFAULT;
ALTER TABLE `aux_families_students`
	CHANGE COLUMN `id_familiar` `id_family` INT(30) NOT NULL AFTER `id_student`,
	ADD COLUMN `id_tipo` INT(30) NOT NULL DEFAULT 1 AFTER `id_family`,
	ADD INDEX `id_tipo` (`id_tipo`);

CREATE TABLE `family_type` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`family_type_name` VARCHAR(60) NOT NULL DEFAULT '',
	PRIMARY KEY (`id`)
)
ENGINE=InnoDB
;
INSERT INTO `family_type` (`family_type_name`) VALUES ('Acudiente');
INSERT INTO `family_type` (`family_type_name`) VALUES ('Madre');
INSERT INTO `family_type` (`family_type_name`) VALUES ('Padre');

CREATE TABLE `family_relationships` (
	`id` INT(11) NOT NULL AUTO_INCREMENT,
	`name_kinship` VARCHAR(120) NOT NULL,
	PRIMARY KEY (`id`)
)
ENGINE=InnoDB
;
-- Insert rows into table 'family_relationships'
INSERT INTO family_relationships
(id, name_kinship)
VALUES
(1,'Padre'),
(2,'Madre'),
(3,'Abuelo'),
(4,'Abuela'),
(5,'Tío'),
(6,'Tía'),
(9,'Otro');

UPDATE aux_families_students t SET t.id_tipo = 2 WHERE t.tipo_famil = 'Madre';
UPDATE aux_families_students t SET t.id_tipo = 3 WHERE t.tipo_famil = 'Padre';

ALTER TABLE `aux_families_students`
	ADD CONSTRAINT `FK_aux_families_students_family_type` FOREIGN KEY (`id_tipo`) REFERENCES `family_type` (`id`) ON UPDATE CASCADE;

ALTER TABLE `aux_families_students`
	CHANGE COLUMN `parentesco` `id_relationship` INT NOT NULL DEFAULT 2 AFTER `id_tipo`,
	DROP COLUMN `tipo_famil`,
	DROP INDEX `id`,
	ADD UNIQUE INDEX `id` (`id_student`, `id_family`, `id_tipo`),
	ADD INDEX `id_relationship` (`id_relationship`),
	ADD CONSTRAINT `FK_aux_families_students_family_relationships` FOREIGN KEY (`id_relationship`) REFERENCES `family_relationships` (`id`) ON UPDATE CASCADE;

ALTER TABLE `aux_families_students`
	CHANGE COLUMN `id_tipo` `id_type` INT(30) NOT NULL DEFAULT 1 AFTER `id_family`;

ALTER TABLE `student_enrollment`
	CHANGE COLUMN `year` `year` INT NOT NULL DEFAULT 0 AFTER `date`;
ALTER TABLE `aux_families_students`
	CHANGE COLUMN `id_type` `id_type` INT(11) NOT NULL DEFAULT 1 AFTER `id_family`;

SET FOREIGN_KEY_CHECKS=0;
ALTER TABLE `areas`
	CHANGE COLUMN `pierde_año_lectivo` `pierde_año_lectivo` INT(1) NOT NULL DEFAULT '0' AFTER `abrev`,
	DROP COLUMN `id_inst`,
	DROP COLUMN `cod_area`,
	DROP INDEX `cod_area`,
	DROP INDEX `FK_areas_establecimiento`,
	DROP FOREIGN KEY `FK_areas_establecimiento`;


DROP TABLE IF EXISTS `areas_old`;
DROP TABLE IF EXISTS `asignaturas_old`;

CREATE TABLE `aux_asignaturas` (
	`id` INT(30) NOT NULL AUTO_INCREMENT,
	`id_asign` INT(30) NOT NULL,
	`id_area` INT(30) NOT NULL,
	`year` INT(4) NOT NULL,
	`activa` INT(1) NOT NULL DEFAULT 1,
	`timestamp` TIMESTAMP NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
	PRIMARY KEY (`id`),
	INDEX `id_asign` (`id_asign`),
	INDEX `id_area` (`id_area`),
	CONSTRAINT `FK_aux_asignaturas_areas` FOREIGN KEY (`id_area`) REFERENCES `areas` (`id`) ON UPDATE CASCADE,
	CONSTRAINT `FK_aux_asignaturas_asignaturas` FOREIGN KEY (`id_asign`) REFERENCES `asignaturas` (`id_pk`) ON UPDATE CASCADE
)
ENGINE=InnoDB
;

/* TODO  Tener cuidado ingresar años adicionales */

INSERT INTO aux_asignaturas (id_asign, id_area, YEAR) 
SELECT id_pk, id_area, 2012 FROM asignaturas 
WHERE estado = 1;
INSERT INTO aux_asignaturas (id_asign, id_area, YEAR) 
SELECT id_pk, id_area, 2013 FROM asignaturas 
WHERE estado = 1;
INSERT INTO aux_asignaturas (id_asign, id_area, YEAR) 
SELECT id_pk, id_area, 2014 FROM asignaturas 
WHERE estado = 1;
INSERT INTO aux_asignaturas (id_asign, id_area, YEAR) 
SELECT id_pk, id_area, 2015 FROM asignaturas 
WHERE estado = 1;
INSERT INTO aux_asignaturas (id_asign, id_area, YEAR) 
SELECT id_pk, id_area, 2016 FROM asignaturas 
WHERE estado = 1;
INSERT INTO aux_asignaturas (id_asign, id_area, YEAR) 
SELECT id_pk, id_area, 2017 FROM asignaturas 
WHERE estado = 1;
INSERT INTO aux_asignaturas (id_asign, id_area, YEAR) 
SELECT id_pk, id_area, 2018 FROM asignaturas 
WHERE estado = 1;
INSERT INTO aux_asignaturas (id_asign, id_area, YEAR) 
SELECT id_pk, id_area, 2019 FROM asignaturas 
WHERE estado = 1;
INSERT INTO aux_asignaturas (id_asign, id_area, YEAR) 
SELECT id_pk, id_area, 2020 FROM asignaturas 
WHERE estado = 1;

ALTER TABLE `asignaturas`
	DROP COLUMN `id_inst`,
	DROP COLUMN `id_area`,
	DROP FOREIGN KEY `FK_asignaturas_establecimiento`,
	DROP FOREIGN KEY `FK_asignaturas_areas`;

ALTER TABLE `aux_asignaturas`
	ALTER `id_asign` DROP DEFAULT,
	ALTER `id_area` DROP DEFAULT;
ALTER TABLE `aux_asignaturas`
	CHANGE COLUMN `id_asign` `id_asign` INT NOT NULL AFTER `id`,
	CHANGE COLUMN `id_area` `id_area` INT NOT NULL AFTER `id_asign`,
	CHANGE COLUMN `year` `year` SMALLINT(4) NOT NULL DEFAULT 0 AFTER `id_area`,
	CHANGE COLUMN `activa` `activa` TINYINT(1) NOT NULL DEFAULT 1 AFTER `year`;

DROP TABLE IF EXISTS `matcurso_old`;
SET FOREIGN_KEY_CHECKS = 1;

ALTER TABLE `matcurso`
	CHANGE COLUMN `año` `year` SMALLINT(4) NOT NULL DEFAULT 2002 AFTER `ih`,
	CHANGE COLUMN `estado` `estado` TINYINT(1) NOT NULL DEFAULT 1 AFTER `proc4`,
	DROP COLUMN `id_inst`,
	DROP INDEX `id_inst`,
	DROP INDEX `id_asig`,
	ADD UNIQUE INDEX `id_grado_id_asig_year` (`id_grado`, `id_asig`, `year`),
	DROP FOREIGN KEY `FK_matcurso_grados`,
	DROP FOREIGN KEY `FK_matcurso_asignaturas`;
ALTER TABLE `matcurso`
	CHANGE COLUMN `ih` `ih` DECIMAL(4,1) NOT NULL DEFAULT '1' AFTER `id_asig`,
	ADD CONSTRAINT `FK_matcurso_grados` FOREIGN KEY (`id_grado`) REFERENCES `grados` (`id`) ON UPDATE CASCADE,
	ADD CONSTRAINT `FK_matcurso_asignaturas` FOREIGN KEY (`id_asig`) REFERENCES `asignaturas` (`id_pk`) ON UPDATE CASCADE;

SET FOREIGN_KEY_CHECKS = 0;
DROP TABLE IF EXISTS `cursos_old`;

ALTER TABLE `cursos`
	ALTER `id_docente` DROP DEFAULT,
	ALTER `cod_jorn` DROP DEFAULT,
	ALTER `grupo` DROP DEFAULT,
	ALTER `año` DROP DEFAULT;


ALTER TABLE `cursos`
	DROP FOREIGN KEY `FK_cursos_sedes`,
	DROP FOREIGN KEY `FK_cursos_jornadas`,
	DROP FOREIGN KEY `FK_cursos_grados`,
	DROP FOREIGN KEY `FK_cursos_docentes`,
	DROP FOREIGN KEY `FK_cursos_asignaturas`;

ALTER TABLE `cursos`
	CHANGE COLUMN `id_sede` `id_sede` INT(11) NOT NULL DEFAULT 1 AFTER `id`,
	CHANGE COLUMN `id_docente` `id_docente` INT(11) NOT NULL AFTER `id_asig`,
	CHANGE COLUMN `cod_jorn` `id_jorn` INT(4) NOT NULL AFTER `id_docente`,
	CHANGE COLUMN `grupo` `grupo` VARCHAR(4) NOT NULL AFTER `id_jorn`,
	CHANGE COLUMN `año` `year` SMALLINT(4) NOT NULL AFTER `grupo`,
	CHANGE COLUMN `estado` `estado` TINYINT(1) NOT NULL DEFAULT 1 AFTER `year`,
	DROP COLUMN `id_inst`,
	DROP COLUMN `cod_asig`,
	DROP INDEX `cod_grado`,
	DROP INDEX `id_asig`,
	DROP INDEX `id_docente`,
	DROP INDEX `grupo`,
	DROP INDEX `cod_jorn`,
	DROP INDEX `id_inst`,
	DROP INDEX `id_sede`,
	DROP INDEX `id`;

CREATE TABLE `cursos_copy` (
	`id` INT(30) NOT NULL AUTO_INCREMENT,
	`id_sede` INT(11) NOT NULL DEFAULT 1,
	`id_grado` INT(11) NOT NULL,
	`id_asig` INT(11) NOT NULL,
	`id_docente` INT(11) NOT NULL,
	`id_jorn` INT(4) NOT NULL,
	`grupo` VARCHAR(4) NOT NULL,
	`year` SMALLINT(4) NOT NULL,
	`estado` TINYINT(1) NOT NULL DEFAULT 1,
	`timestamp` TIMESTAMP NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
	PRIMARY KEY (`id`)
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=1
;

INSERT INTO cursos_copy SELECT * FROM cursos;

DELETE FROM cursos;
ALTER TABLE `cursos` 	AUTO_INCREMENT=0;

ALTER TABLE `cursos`
	AUTO_INCREMENT=0,
	ADD UNIQUE INDEX `id_sede_id_grado_id_asig_id_docente_id_jorn_grupo_year` (`id_sede`, `id_grado`, `id_asig`, `id_docente`, `id_jorn`, `grupo`, `year`),
	ADD INDEX `id_sede` (`id_sede`),
	ADD INDEX `id_grado` (`id_grado`),
	ADD INDEX `id_asig` (`id_asig`),
	ADD INDEX `id_docente` (`id_docente`),
	ADD INDEX `id_jorn` (`id_jorn`),
	ADD INDEX `grupo` (`grupo`),
	ADD INDEX `year` (`year`),
	ADD CONSTRAINT `FK_cursos_sedes` FOREIGN KEY (`id_sede`) REFERENCES `sedes` (`ID`) ON UPDATE CASCADE,
	ADD CONSTRAINT `FK_cursos_grados` FOREIGN KEY (`id_grado`) REFERENCES `grados` (`id`) ON UPDATE CASCADE,
	ADD CONSTRAINT `FK_cursos_asignaturas` FOREIGN KEY (`id_asig`) REFERENCES `asignaturas` (`id_pk`) ON UPDATE CASCADE,
	ADD CONSTRAINT `FK_cursos_docentes` FOREIGN KEY (`id_docente`) REFERENCES `docentes` (`id_docente`) ON UPDATE CASCADE,
	ADD CONSTRAINT `FK_cursos_jornadas` FOREIGN KEY (`id_jorn`) REFERENCES `jornadas` (`cod_jorn`) ON UPDATE CASCADE;

SET FOREIGN_KEY_CHECKS=1;

UPDATE cursos_copy t SET t.id_docente = 
(SELECT id_docente FROM aux_docentes AS td WHERE td.id = t.id_docente AND td.year = t.year);

INSERT IGNORE INTO cursos SELECT * FROM cursos_copy WHERE estado = 1;

-- DELETE FROM cursos_copy WHERE id IN (SELECT id FROM cursos WHERE estado = 1);

ALTER TABLE `periodos_academicos`
	CHANGE COLUMN `fecha_inical` `fecha_inical` DATE NULL DEFAULT NULL AFTER `descripcion_periodo`,
	CHANGE COLUMN `fecha_cierre` `fecha_cierre` DATE NULL DEFAULT NULL AFTER `fecha_inical`,
	CHANGE COLUMN `fecha_inical_nivelacion` `fecha_inical_nivelacion` DATE NULL DEFAULT NULL AFTER `fecha_cierre`,
	CHANGE COLUMN `fecha_cierre_nivelacion` `fecha_cierre_nivelacion` DATE NULL DEFAULT NULL AFTER `fecha_inical_nivelacion`,
	CHANGE COLUMN `año` `year` SMALLINT
(4) NOT NULL DEFAULT 2002 AFTER `porciento`,
DROP COLUMN `id_inst`,
DROP INDEX `id_inst`,
DROP FOREIGN KEY `FK_periodos_academicos_establecimiento`;


SET FOREIGN_KEY_CHECKS =0;
DROP TABLE IF EXISTS `nscp00_old`;
ALTER TABLE `nscp00`
	DROP FOREIGN KEY `FK_nscp00_cursos`,
	DROP FOREIGN KEY `FK_nscp00_escala_nacional`,
	DROP FOREIGN KEY `FK_nscp00_establecimiento`,
	DROP FOREIGN KEY `FK_nscp00_matriculas`;

ALTER TABLE `nscp00`
	CHANGE COLUMN `año` `year` SMALLINT(4) NOT NULL DEFAULT 2002 AFTER `periodo`,
	CHANGE COLUMN `injustificadas` `injustificadas` TINYINT NOT NULL DEFAULT 0 AFTER `faltas`,
	CHANGE COLUMN `retraso` `retraso` TINYINT NOT NULL DEFAULT 0 AFTER `injustificadas`,
	CHANGE COLUMN `fecha` `fecha` DATE NULL DEFAULT NULL AFTER `nivelacion`,
	DROP COLUMN `id_inst`,
	DROP INDEX `año`,
	ADD UNIQUE INDEX `uk_id` (`year`, `id_curso`, `id_matric`, `periodo`) USING BTREE;



DROP TABLE IF EXISTS `nsp001_old`;
ALTER TABLE `nscp001`
	DROP FOREIGN KEY `FK_nscp001_cursos`,
	DROP FOREIGN KEY `FK_nscp001_escala_nacional`,
	DROP FOREIGN KEY `FK_nscp001_establecimiento`,
	DROP FOREIGN KEY `FK_nscp001_matriculas`;

ALTER TABLE `nscp001`
	CHANGE COLUMN `año` `year` SMALLINT(4) NOT NULL DEFAULT 2002 AFTER `periodo`,
	CHANGE COLUMN `injustificadas` `injustificadas` TINYINT NOT NULL DEFAULT 0 AFTER `faltas`,
	CHANGE COLUMN `retraso` `retraso` TINYINT NOT NULL DEFAULT 0 AFTER `injustificadas`,
	CHANGE COLUMN `fecha` `fecha` DATE NULL DEFAULT NULL AFTER `nivelacion`,
	DROP COLUMN `id_inst`,
	DROP INDEX `año`,
	ADD UNIQUE INDEX `uk_id` (`year`, `id_curso`, `id_matric`, `periodo`) USING BTREE;

DROP TABLE IF EXISTS `nscp002_old`;
ALTER TABLE `nscp002`
	DROP FOREIGN KEY `FK_nscp002_cursos`,
	DROP FOREIGN KEY `FK_nscp002_escala_nacional`,
	DROP FOREIGN KEY `FK_nscp002_establecimiento`,
	DROP FOREIGN KEY `FK_nscp002_matriculas`;

ALTER TABLE `nscp002`
	CHANGE COLUMN `año` `year` SMALLINT(4) NOT NULL DEFAULT 2002 AFTER `periodo`,
	CHANGE COLUMN `injustificadas` `injustificadas` TINYINT NOT NULL DEFAULT 0 AFTER `faltas`,
	CHANGE COLUMN `retraso` `retraso` TINYINT NOT NULL DEFAULT 0 AFTER `injustificadas`,
	CHANGE COLUMN `fecha` `fecha` DATE NULL DEFAULT NULL AFTER `nivelacion`,
	DROP COLUMN `id_inst`,
	DROP INDEX `año`,
	ADD UNIQUE INDEX `uk_id` (`year`, `id_curso`, `id_matric`, `periodo`) USING BTREE;

DROP TABLE IF EXISTS `nscp003_old`;
ALTER TABLE `nscp003`
	DROP FOREIGN KEY `FK_nscp003_cursos`,
	DROP FOREIGN KEY `FK_nscp003_escala_nacional`,
	DROP FOREIGN KEY `FK_nscp003_establecimiento`,
	DROP FOREIGN KEY `FK_nscp003_matriculas`;

ALTER TABLE `nscp003`
	CHANGE COLUMN `año` `year` SMALLINT(4) NOT NULL DEFAULT 2002 AFTER `periodo`,
	CHANGE COLUMN `injustificadas` `injustificadas` TINYINT NOT NULL DEFAULT 0 AFTER `faltas`,
	CHANGE COLUMN `retraso` `retraso` TINYINT NOT NULL DEFAULT 0 AFTER `injustificadas`,
	CHANGE COLUMN `fecha` `fecha` DATE NULL DEFAULT NULL AFTER `nivelacion`,
	DROP COLUMN `id_inst`,
	DROP INDEX `año`,
	ADD UNIQUE INDEX `uk_id` (`year`, `id_curso`, `id_matric`, `periodo`) USING BTREE;

ALTER TABLE `nscp00`
	ALTER `id_matric` DROP DEFAULT;
ALTER TABLE `nscp00`
	CHANGE COLUMN `id_matric` `id_matric` INT(30) NOT NULL AFTER `id_curso`;

ALTER TABLE `nscp001`
	ALTER `id_matric` DROP DEFAULT;
ALTER TABLE `nscp001`
	CHANGE COLUMN `id_matric` `id_matric` INT(30) NOT NULL AFTER `id_curso`;

ALTER TABLE `nscp002`
	ALTER `id_matric` DROP DEFAULT;
ALTER TABLE `nscp002`
	CHANGE COLUMN `id_matric` `id_matric` INT(30) NOT NULL AFTER `id_curso`;


ALTER TABLE `nscp003`
	ALTER `id_matric` DROP DEFAULT;
ALTER TABLE `nscp003`
	CHANGE COLUMN `id_matric` `id_matric` INT(30) NOT NULL AFTER `id_curso`;

CREATE TABLE `nscp00_copy` (
	`id` INT(30) NOT NULL AUTO_INCREMENT,
	`id_curso` INT(30) NOT NULL DEFAULT 0,
	`id_matric` INT(30) NOT NULL,
	`id_escala` INT(11) NOT NULL DEFAULT 0,
	`periodo` VARCHAR(2) NOT NULL,
	`year` SMALLINT(4) NOT NULL DEFAULT 2002,
	`n1` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n2` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n3` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n4` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n5` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n6` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n7` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n8` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n9` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n10` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n11` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n12` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n13` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n14` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n15` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n16` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n17` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n18` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n19` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n20` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n21` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n22` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n23` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n24` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n25` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n26` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n27` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n28` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n29` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n30` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`final` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`faltas` DECIMAL(3,0) NOT NULL DEFAULT 0,
	`injustificadas` TINYINT(4) NOT NULL DEFAULT 0,
	`retraso` TINYINT(4) NOT NULL DEFAULT 0,
	`nota_perdida` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`nota_habilitacion` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`nivelacion` TINYINT(1) NOT NULL DEFAULT 0,
	`fecha` DATE NULL DEFAULT NULL,
	`timestamp` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
	PRIMARY KEY (`id`),
	INDEX `id_curso` (`id_curso`),
	INDEX `id_matric` (`id_matric`),
	INDEX `id_escala` (`id_escala`)
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=1
;

INSERT INTO nscp00_copy SELECT * FROM nscp00;
DELETE FROM nscp00;
ALTER TABLE `nscp00` AUTO_INCREMENT=0;

INSERT IGNORE INTO nscp00 SELECT tn.* FROM nscp00_copy AS tn
LEFT JOIN cursos AS tc ON (tn.id_curso = tc.id AND tn.year = tc.year)
LEFT JOIN student_enrollment AS tm ON (tn.id_matric = tm.id AND tn.year = tm.year)
WHERE tn.id_curso = tc.id AND tn.id_matric = tm.id;

ALTER TABLE `nscp00`
	ADD CONSTRAINT `FK_nscp00_cursos` FOREIGN KEY (`id_curso`) REFERENCES `cursos` (`id`) ON UPDATE CASCADE,
	ADD CONSTRAINT `FK_nscp00_student_enrollment` FOREIGN KEY (`id_matric`) REFERENCES `student_enrollment` (`id`) ON UPDATE CASCADE,
	ADD CONSTRAINT `FK_nscp00_escala_nacional` FOREIGN KEY (`id_escala`) REFERENCES `escala_nacional` (`id`) ON UPDATE CASCADE;

CREATE TABLE `nscp001_copy` (
	`id` INT(30) NOT NULL AUTO_INCREMENT,
	`id_curso` INT(30) NOT NULL DEFAULT 0,
	`id_matric` INT(30) NOT NULL,
	`id_escala` INT(11) NOT NULL DEFAULT 0,
	`periodo` VARCHAR(2) NOT NULL,
	`year` SMALLINT(4) NOT NULL DEFAULT 2002,
	`n1` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n2` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n3` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n4` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n5` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n6` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n7` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n8` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n9` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n10` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n11` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n12` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n13` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n14` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n15` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n16` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n17` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n18` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n19` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n20` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n21` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n22` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n23` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n24` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n25` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n26` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n27` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n28` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n29` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n30` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`final` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`faltas` DECIMAL(3,0) NOT NULL DEFAULT 0,
	`injustificadas` TINYINT(4) NOT NULL DEFAULT 0,
	`retraso` TINYINT(4) NOT NULL DEFAULT 0,
	`nota_perdida` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`nota_habilitacion` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`nivelacion` TINYINT(1) NOT NULL DEFAULT 0,
	`fecha` DATE NULL DEFAULT NULL,
	`timestamp` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
	PRIMARY KEY (`id`),
	INDEX `id_curso` (`id_curso`),
	INDEX `id_matric` (`id_matric`),
	INDEX `id_escala` (`id_escala`)
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=1
;

INSERT INTO nscp001_copy SELECT * FROM nscp001;
DELETE FROM nscp001;
ALTER TABLE `nscp001` AUTO_INCREMENT=0;

INSERT IGNORE INTO nscp001 SELECT tn.* FROM nscp001_copy AS tn
LEFT JOIN cursos AS tc ON (tn.id_curso = tc.id AND tn.year = tc.year)
LEFT JOIN student_enrollment AS tm ON (tn.id_matric = tm.id AND tn.year = tm.year)
WHERE tn.id_curso = tc.id AND tn.id_matric = tm.id;

ALTER TABLE `nscp001`
	ADD CONSTRAINT `FK_nscp001_cursos` FOREIGN KEY (`id_curso`) REFERENCES `cursos` (`id`) ON UPDATE CASCADE,
	ADD CONSTRAINT `FK_nscp001_student_enrollment` FOREIGN KEY (`id_matric`) REFERENCES `student_enrollment` (`id`) ON UPDATE CASCADE,
	ADD CONSTRAINT `FK_nscp001_escala_nacional` FOREIGN KEY (`id_escala`) REFERENCES `escala_nacional` (`id`) ON UPDATE CASCADE;

CREATE TABLE `nscp002_copy` (
	`id` INT(30) NOT NULL AUTO_INCREMENT,
	`id_curso` INT(30) NOT NULL DEFAULT 0,
	`id_matric` INT(30) NOT NULL,
	`id_escala` INT(11) NOT NULL DEFAULT 0,
	`periodo` VARCHAR(2) NOT NULL,
	`year` SMALLINT(4) NOT NULL DEFAULT 2002,
	`n1` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n2` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n3` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n4` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n5` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n6` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n7` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n8` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n9` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n10` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n11` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n12` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n13` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n14` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n15` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n16` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n17` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n18` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n19` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n20` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n21` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n22` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n23` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n24` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n25` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n26` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n27` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n28` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n29` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n30` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`final` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`faltas` DECIMAL(3,0) NOT NULL DEFAULT 0,
	`injustificadas` TINYINT(4) NOT NULL DEFAULT 0,
	`retraso` TINYINT(4) NOT NULL DEFAULT 0,
	`nota_perdida` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`nota_habilitacion` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`nivelacion` TINYINT(1) NOT NULL DEFAULT 0,
	`fecha` DATE NULL DEFAULT NULL,
	`timestamp` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
	PRIMARY KEY (`id`),
	INDEX `id_curso` (`id_curso`),
	INDEX `id_matric` (`id_matric`),
	INDEX `id_escala` (`id_escala`)
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=1
;

INSERT INTO nscp002_copy SELECT * FROM nscp002;
DELETE FROM nscp002;
ALTER TABLE `nscp002` AUTO_INCREMENT=0;

INSERT IGNORE INTO nscp002 SELECT tn.* FROM nscp002_copy AS tn
LEFT JOIN cursos AS tc ON (tn.id_curso = tc.id AND tn.year = tc.year)
LEFT JOIN student_enrollment AS tm ON (tn.id_matric = tm.id AND tn.year = tm.year)
WHERE tn.id_curso = tc.id AND tn.id_matric = tm.id;

ALTER TABLE `nscp002`
	ADD CONSTRAINT `FK_nscp002_cursos` FOREIGN KEY (`id_curso`) REFERENCES `cursos` (`id`) ON UPDATE CASCADE,
	ADD CONSTRAINT `FK_nscp002_student_enrollment` FOREIGN KEY (`id_matric`) REFERENCES `student_enrollment` (`id`) ON UPDATE CASCADE,
	ADD CONSTRAINT `FK_nscp002_escala_nacional` FOREIGN KEY (`id_escala`) REFERENCES `escala_nacional` (`id`) ON UPDATE CASCADE;

CREATE TABLE `nscp003_copy` (
	`id` INT(30) NOT NULL AUTO_INCREMENT,
	`id_curso` INT(30) NOT NULL DEFAULT 0,
	`id_matric` INT(30) NOT NULL,
	`id_escala` INT(11) NOT NULL DEFAULT 0,
	`periodo` VARCHAR(2) NOT NULL,
	`year` SMALLINT(4) NOT NULL DEFAULT 2002,
	`n1` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n2` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n3` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n4` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n5` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n6` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n7` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n8` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n9` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n10` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n11` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n12` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n13` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n14` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n15` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n16` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n17` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n18` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n19` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n20` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n21` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n22` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n23` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n24` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n25` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n26` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n27` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n28` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n29` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n30` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`final` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`faltas` DECIMAL(3,0) NOT NULL DEFAULT 0,
	`injustificadas` TINYINT(4) NOT NULL DEFAULT 0,
	`retraso` TINYINT(4) NOT NULL DEFAULT 0,
	`nota_perdida` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`nota_habilitacion` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`nivelacion` TINYINT(1) NOT NULL DEFAULT 0,
	`fecha` DATE NULL DEFAULT NULL,
	`timestamp` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
	PRIMARY KEY (`id`),
	INDEX `id_curso` (`id_curso`),
	INDEX `id_matric` (`id_matric`),
	INDEX `id_escala` (`id_escala`)
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=1
;

INSERT INTO nscp003_copy SELECT * FROM nscp003;
DELETE FROM nscp003;
ALTER TABLE `nscp003` AUTO_INCREMENT=0;

INSERT IGNORE INTO nscp003 SELECT tn.* FROM nscp003_copy AS tn
LEFT JOIN cursos AS tc ON (tn.id_curso = tc.id AND tn.year = tc.year)
LEFT JOIN student_enrollment AS tm ON (tn.id_matric = tm.id AND tn.year = tm.year)
WHERE tn.id_curso = tc.id AND tn.id_matric = tm.id;

ALTER TABLE `nscp003`
	ADD CONSTRAINT `FK_nscp003_cursos` FOREIGN KEY (`id_curso`) REFERENCES `cursos` (`id`) ON UPDATE CASCADE,
	ADD CONSTRAINT `FK_nscp003_student_enrollment` FOREIGN KEY (`id_matric`) REFERENCES `student_enrollment` (`id`) ON UPDATE CASCADE,
	ADD CONSTRAINT `FK_nscp003_escala_nacional` FOREIGN KEY (`id_escala`) REFERENCES `escala_nacional` (`id`) ON UPDATE CASCADE;

ALTER TABLE `desempeños`
	ALTER `id` DROP DEFAULT;
ALTER TABLE `desempeños`
	CHANGE COLUMN `id` `id` TINYINT(1) NOT NULL AFTER `id_pk`,
	CHANGE COLUMN `año` `year` SMALLINT(4) NOT NULL DEFAULT 2002 AFTER `hasta`,
	CHANGE COLUMN `reprueba` `reprueba` TINYINT(1) NOT NULL DEFAULT 0 AFTER `year`,
	CHANGE COLUMN `calificable` `calificable` TINYINT(1) NOT NULL DEFAULT 1 AFTER `reprueba`,
	DROP COLUMN `id_inst`,
	DROP INDEX `id`,
	ADD UNIQUE INDEX `id` (`id`, `year`, `id_grado_agrupado`, `id_escala`) USING BTREE,
	DROP FOREIGN KEY `desempeños_ibfk_2`,
	DROP FOREIGN KEY `desempeños_ibfk_1`,
	DROP FOREIGN KEY `FK_desempeños_escala_nacional`;
ALTER TABLE `desempeños`
ADD CONSTRAINT `FK_desempeños_grados_agrupados` FOREIGN KEY
(`id_grado_agrupado`) REFERENCES `grados_agrupados`
(`id`) ON
UPDATE CASCADE,
ADD CONSTRAINT `FK_desempeños_escala_nacional` FOREIGN KEY
(`id_escala`) REFERENCES `escala_nacional`
(`id`) ON
UPDATE CASCADE;

ALTER TABLE `competencias`
	DROP INDEX `id_inst`,
	DROP INDEX `id`,
	ADD UNIQUE INDEX `id` (`id`, `año`, `id_grado_agrupado`) USING BTREE,
	DROP FOREIGN KEY `competencias_ibfk_2`,
	DROP FOREIGN KEY `competencias_ibfk_1`;

ALTER TABLE `competencias`
	ALTER `año` DROP DEFAULT;
ALTER TABLE `competencias`
	CHANGE COLUMN `año` `year` SMALLINT(4) NOT NULL AFTER `porcentaje`,
	CHANGE COLUMN `calificable` `calificable` TINYINT(1) NOT NULL DEFAULT 1 AFTER `year`,
	DROP COLUMN `id_inst`;

ALTER TABLE `competencias`
ADD CONSTRAINT `FK_competencias_grados_agrupados` FOREIGN KEY
(`id_grado_agrupado`) REFERENCES `grados_agrupados` (`id`) ON UPDATE CASCADE;

ALTER TABLE `config001`
	CHANGE COLUMN `año` `year` SMALLINT(4) NOT NULL DEFAULT 2011 AFTER `id_grupo_grados`,
	DROP COLUMN `id_inst`,
	DROP FOREIGN KEY `config001_ibfk_1`,
	ADD CONSTRAINT `FK_config001_grados_agrupados` FOREIGN KEY (`id_grupo_grados`) REFERENCES `grados_agrupados` (`id`) ON UPDATE CASCADE;

DROP TABLE IF EXISTS `log_nscp00_old`;

DROP TABLE IF EXISTS `log_nscp001_old`;

DROP TABLE IF EXISTS `log_nscp002_old`;

DROP TABLE IF EXISTS `log_nscp003_old`;

CREATE TABLE `nscp00_promedio_notas` (
	`id` INT(30) NOT NULL AUTO_INCREMENT,
	`id_curso` INT(30) NOT NULL,
	`id_matric` INT(30) NOT NULL,
	`prom` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	PRIMARY KEY (`id`),
	UNIQUE INDEX `id` (`id_matric`, `id_curso`),
	INDEX `curso` (`id_curso`),
	INDEX `id_matric` (`id_matric`),
	CONSTRAINT `FK_promedio_notas_cursos` FOREIGN KEY (`id_curso`) REFERENCES `cursos` (`id`) ON DELETE CASCADE,
	CONSTRAINT `FK_promedio_notas_matriculas` FOREIGN KEY (`id_matric`) REFERENCES `student_enrollment` (`id`) ON DELETE CASCADE
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=0
;

SET FOREIGN_KEY_CHECKS =1;

CREATE TABLE `config_const_cert` (
	`id` TINYINT(4) NOT NULL AUTO_INCREMENT,
	`header1` TEXT NOT NULL DEFAULT '',
	`header2` TEXT NOT NULL DEFAULT '',
	`body` TEXT NOT NULL DEFAULT '',
	`expedition` TEXT NOT NULL DEFAULT '',
	`message` TEXT NOT NULL DEFAULT '',
	`resolution` TEXT NOT NULL DEFAULT '',
	`rector_firm` TINYINT(1) NOT NULL DEFAULT 0,
	`signature_secretary` TINYINT(1) NOT NULL DEFAULT 0,
	`type` TINYINT(1) NOT NULL DEFAULT 0,
	PRIMARY KEY (`id`)
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
AUTO_INCREMENT=0
;


CREATE TABLE `certificate_numbers` (
	`id` TINYINT(4) NOT NULL AUTO_INCREMENT,
	`id_parent` TINYINT(4) NOT NULL,
	`year` SMALLINT(4) NOT NULL,
	`total` MEDIUMINT(9) NOT NULL,
	`type` TINYINT(2) NOT NULL,
	PRIMARY KEY (`id`),
	UNIQUE INDEX `id_parent_year_type` (`id_parent`, `year`, `type`),
	INDEX `id_parent` (`id_parent`),
	INDEX `year` (`year`)
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;

CREATE TABLE `config_const_cert_end` (
	`id` TINYINT(4) NOT NULL AUTO_INCREMENT,
	`header1` TEXT NOT NULL DEFAULT '',
	`header2` TEXT NOT NULL DEFAULT '',
	`body` TEXT NOT NULL DEFAULT '',
	`expedition` TEXT NOT NULL DEFAULT '',
	`message` TEXT NOT NULL DEFAULT '',
	`resolution` TEXT NOT NULL DEFAULT '',
	`rector_firm` TINYINT(1) NOT NULL DEFAULT 0,
	`signature_secretary` TINYINT(1) NOT NULL DEFAULT 0,
	`year_from` SMALLINT(4) NOT NULL,
	`year_until` SMALLINT(4) NOT NULL,
	`type` TINYINT(1) NOT NULL DEFAULT 0,
	PRIMARY KEY (`id`)
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;

-- Insert rows into table 'config_const_cert'
INSERT INTO config_const_cert
( header1, header2, body, expedition, message, rector_firm, signature_secretary, type)
SELECT t.encabezado, t.encabezado2, t.cuerpo, t.expedicion, t.constar,
t.firma_rec, t.firma_sec, 1
FROM configconstancias AS t ORDER BY id DESC LIMIT 1;

INSERT INTO config_const_cert
( header1, header2, body, expedition, message, rector_firm, signature_secretary, type)
SELECT t.encabezado, t.encabezado2, t.cuerpo, t.expedicion, t.constar,
t.firma_rec, t.firma_sec, 2
FROM configcertifcadosper AS t ORDER BY id DESC LIMIT 1;

INSERT INTO config_const_cert
( header1, header2, body, expedition, message, rector_firm, signature_secretary, type)
SELECT t.encabezado, t.encabezado2, t.cuerpo, t.expedicion, t.constar,
t.firma_rec, t.firma_sec, 3
FROM configconstanciasciclos AS t ORDER BY id DESC LIMIT 1;

INSERT INTO config_const_cert_end
( header1, header2, body, expedition, message, resolution, rector_firm, signature_secretary, type, year_from, year_until)
SELECT t.encabezado, t.encabezado2, t.cuerpo, t.expedicion, t.CERTIFICA,
t.resolucion,t.firma_rec, t.firma_sec, 4, 2000, 2030
FROM configcerfinal AS t ORDER BY id DESC LIMIT 1;

INSERT INTO config_const_cert_end
( header1, header2, body, expedition, message, resolution, rector_firm, signature_secretary, type, year_from, year_until)
SELECT t.encabezado, t.encabezado2, t.cuerpo, t.expedicion, t.CERTIFICA,
t.resolucion,t.firma_rec, t.firma_sec, 5, 2000, 2030
FROM configcerfinalciclos AS t ORDER BY id DESC LIMIT 1;

DROP TABLE IF EXISTS `configconstancias`;
DROP TABLE IF EXISTS `configcertifcadosper`;
DROP TABLE IF EXISTS `config`;
DROP TABLE IF EXISTS `configcerfinalcilcos`;
DROP TABLE IF EXISTS `configboletin_old`;
DROP TABLE IF EXISTS `configconstanciasciclos`;
DROP TABLE IF EXISTS `configcertificado`;
DROP TABLE IF EXISTS `configcerfinal`;
DROP TABLE IF EXISTS `configcerfinalciclos`;

SET FOREIGN_KEY_CHECKS =0;
DROP TABLE IF EXISTS `config_columns_docentes`;
DROP TABLE IF EXISTS `configuraciones_column`;
SET FOREIGN_KEY_CHECKS =1;

ALTER TABLE `config_const_cert`
	ADD COLUMN `show_number` TINYINT(1) NOT NULL DEFAULT 0 AFTER `signature_secretary`;

ALTER TABLE `config_const_cert_end`
	ADD COLUMN `show_number` TINYINT(1) NOT NULL DEFAULT 0 AFTER `signature_secretary`;

ALTER TABLE `config_const_cert`
	CHANGE COLUMN `type` `type` SMALLINT(1) NOT NULL DEFAULT 0 AFTER `show_number`;

ALTER TABLE `config_const_cert_end`
	CHANGE COLUMN `type` `type` SMALLINT(1) NOT NULL DEFAULT 0 AFTER `year_until`;

ALTER TABLE `firmas`
	CHANGE COLUMN `firmarector` `firmarector` TINYINT(1) NOT NULL DEFAULT 1 AFTER `firma4`,
	CHANGE COLUMN `firmasecre` `firmasecre` TINYINT(1) NOT NULL DEFAULT 1 AFTER `firmarector`,
	CHANGE COLUMN `firmacoor` `firmacoor` TINYINT(1) NOT NULL DEFAULT 1 AFTER `firmasecre`,
	CHANGE COLUMN `firmadirgrupo` `firmadirgrupo` TINYINT(1) NOT NULL DEFAULT 1 AFTER `firmacoor`,
	CHANGE COLUMN `usar_firma_escan` `usar_firma_escan` TINYINT(1) NOT NULL DEFAULT 1 AFTER `firma_escaneada`,
	DROP COLUMN `id_inst`,
	DROP FOREIGN KEY `FK_firmas_establecimiento`;


DROP PROCEDURE IF EXISTS `sp_select_notas_academicas_estudiante`;
DROP PROCEDURE IF EXISTS `sp_select_notas_periodo`;

ALTER TABLE `certificate_numbers`
	CHANGE COLUMN `id` `id` INT NOT NULL AUTO_INCREMENT FIRST;

CREATE TABLE `backup_notes` (
	`id` INT(30) NOT NULL,
	`id_curso` INT(30) NOT NULL DEFAULT 0,
	`id_matric` INT(30) NOT NULL,
	`id_escala` INT(11) NOT NULL DEFAULT 0,
	`periodo` VARCHAR(2) NOT NULL,
	`year` SMALLINT(4) NOT NULL DEFAULT 2002,
	`n1` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n2` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n3` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n4` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n5` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n6` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n7` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n8` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n9` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n10` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n11` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n12` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n13` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n14` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n15` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n16` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n17` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n18` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n19` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n20` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n21` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n22` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n23` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n24` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n25` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n26` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n27` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n28` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n29` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`n30` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`final` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`faltas` DECIMAL(3,0) NOT NULL DEFAULT 0,
	`injustificadas` TINYINT(4) NOT NULL DEFAULT 0,
	`retraso` TINYINT(4) NOT NULL DEFAULT 0,
	`nota_perdida` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`nota_habilitacion` DECIMAL(6,2) NOT NULL DEFAULT 0.00,
	`nivelacion` TINYINT(1) NOT NULL DEFAULT 0,
	`fecha` DATE NULL DEFAULT NULL,
	`table_name` VARCHAR(60) NOT NULL,
	`timestamp` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
	PRIMARY KEY (`id`)
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;

ALTER TABLE `consolidado_totales`
	ALTER `año` DROP DEFAULT;
ALTER TABLE `consolidado_totales`
	CHANGE COLUMN `año` `year` SMALLINT(4) NOT NULL AFTER `grupo`,
	DROP COLUMN `id_inst`,
	DROP PRIMARY KEY,
	ADD PRIMARY KEY (`id_sede`, `id_jorn`, `id_grado`, `grupo`, `year`, `periodo`);

ALTER TABLE `consolidado_areas_totales`
	ALTER `año` DROP DEFAULT;
ALTER TABLE `consolidado_areas_totales`
	CHANGE COLUMN `año` `year` SMALLINT(4) NOT NULL AFTER `grupo`,
	DROP COLUMN `id_inst`,
	DROP PRIMARY KEY,
	ADD PRIMARY KEY (`id_sede`, `id_jorn`, `id_grado`, `grupo`, `year`, `periodo`);

CREATE TABLE `encabezado_reportes_copy` (
	`id` INT(20) NOT NULL AUTO_INCREMENT,
	`id_inst` INT(20) NOT NULL DEFAULT 1,
	`encabezado` TEXT NOT NULL COLLATE 'utf8_general_ci',
	`dane` VARCHAR(200) NOT NULL,
	`nit` VARCHAR(200) NOT NULL,
	`resolucion` TEXT NOT NULL COLLATE 'utf8_general_ci',
	`logo` BLOB NOT NULL,
	`mime` VARCHAR(6) NOT NULL,
	`pie` VARCHAR(250) NOT NULL,
	`año` YEAR NOT NULL,
	PRIMARY KEY (`id`)
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;

INSERT INTO encabezado_reportes_copy SELECT * FROM encabezado_reportes;
DELETE FROM encabezado_reportes;

DROP TABLE IF EXISTS `encabezado_reportes`;

CREATE TABLE `encabezado_reportes` (
	`id` INT(20) NOT NULL AUTO_INCREMENT,
	`encabezado` TEXT NOT NULL,
	`dane` VARCHAR(200) NOT NULL DEFAULT '',
	`dni` VARCHAR(200) NOT NULL DEFAULT '',
	`resolucion` TEXT NOT NULL,
	`logo` VARCHAR(50) NOT NULL DEFAULT '',
	`mime` VARCHAR(120) NOT NULL DEFAULT 'image/jpeg',
	`pie` TEXT NOT NULL DEFAULT '',
	PRIMARY KEY (`id`)
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;

INSERT INTO encabezado_reportes(encabezado,dane,dni,resolucion,pie) 
SELECT encabezado,dane,nit,resolucion,pie FROM encabezado_reportes_copy 
ORDER BY id DESC LIMIT 1;

DROP TABLE IF EXISTS `encabezado_reportes_copy`;

SET FOREIGN_KEY_CHECKS =0;
DROP TABLE IF EXISTS `logros_estandares_old`;
ALTER TABLE `logros_estandares`
	CHANGE COLUMN `año` `year` SMALLINT(4) NOT NULL DEFAULT 2000 AFTER `descripcion`,
	DROP COLUMN `id_inst`;

ALTER TABLE `sugerencias`
	COLLATE='utf8_general_ci',
	CONVERT TO CHARSET utf8,
	CHANGE COLUMN `año` `year` SMALLINT(4) NOT NULL DEFAULT 2010 AFTER `id_docente`,
	DROP COLUMN `id_inst`,
	DROP COLUMN `consecutivo`,
	DROP COLUMN `cod_dane`,
	DROP INDEX `id`;
UPDATE sugerencias SET sugerencia = TRIM(sugerencia);
SET FOREIGN_KEY_CHECKS =1;

UPDATE sugerencias t SET t.id_docente = 
(SELECT id_docente FROM aux_docentes AS td WHERE td.id = t.id_docente AND td.year = t.year);
UPDATE logros_estandares t SET t.id_docente = 
(SELECT id_docente FROM aux_docentes AS td WHERE td.id = t.id_docente AND td.year = t.year);

ALTER TABLE `estadistica_grupo`
	CHANGE COLUMN `año` `year` SMALLINT
(4) NOT NULL DEFAULT 0 AFTER `periodo`,
DROP COLUMN `id_inst`,
DROP INDEX `id_inst`,
ADD INDEX `id_inst`
(`id_sede`, `id_desempeño`, `total`, `grupo`, `cod_grado`, `year`);

ALTER TABLE `estadistica_edades`
	CHANGE COLUMN `año` `year` SMALLINT(4) NOT NULL DEFAULT 0 AFTER `id_jorn`,
	DROP COLUMN `id_inst`;
ALTER TABLE `estadistica_edades`
	ADD COLUMN `id_sexo` SMALLINT(4) NOT NULL DEFAULT 0 AFTER `id_jorn`,
	DROP COLUMN `sexo`;
ALTER TABLE `estadistica_edades`
	ALTER `cod_grado` DROP DEFAULT;
ALTER TABLE `estadistica_edades`
	CHANGE COLUMN `cod_grado` `id_grado` INT(11) NOT NULL AFTER `id_sede`;
	
SET FOREIGN_KEY_CHECKS =1;


SET FOREIGN_KEY_CHECKS =0;
DROP TABLE IF EXISTS `student_users`;
DROP TRIGGER IF EXISTS `student_users_before_insert`;
SET FOREIGN_KEY_CHECKS = 1;

SET FOREIGN_KEY_CHECKS = 0;
ALTER TABLE `users`
	DROP FOREIGN KEY `users_ibfk_1`,
	DROP FOREIGN KEY `FK_users_sexo`;

ALTER TABLE `users`
	DROP INDEX `id_inst`,
	DROP INDEX `tipo_usuario`,
	DROP INDEX `id_oficina`,
	DROP INDEX `id_sex`;

ALTER TABLE `users`
	CHANGE COLUMN `state` `state` TINYINT(1) NOT NULL DEFAULT 1 AFTER `mime`,
	DROP COLUMN `id_inst`,
	DROP COLUMN `id_sex`,
	DROP COLUMN `id_oficina`,
	DROP COLUMN `birth_date`,
	DROP COLUMN `phone`;
SET FOREIGN_KEY_CHECKS 	= 1;

ALTER TABLE `users`
	COLLATE='utf8_general_ci',
	CONVERT TO CHARSET utf8;
ALTER TABLE `users`
	ALTER `date` DROP DEFAULT;
ALTER TABLE `users`
	CHANGE COLUMN `date` `date` DATE NULL AFTER `message`,
	CHANGE COLUMN `image` `image` MEDIUMTEXT NULL AFTER `date`;

ALTER TABLE `users`
	ALTER `email` DROP DEFAULT;
ALTER TABLE `users`
	CHANGE COLUMN `email` `email` VARCHAR(200) NULL AFTER `respuest`,
	CHANGE COLUMN `lectur` `lectur` TINYINT(1) NOT NULL DEFAULT 0 AFTER `email`,
	DROP COLUMN `names`,
	DROP COLUMN `last_name`,
	ADD INDEX `user_type` (`user_type`),
	ADD UNIQUE INDEX `username` (`username`),
	ADD INDEX `password` (`password`);

ALTER TABLE `users`
	CHANGE COLUMN `image` `image` VARCHAR(50) NULL DEFAULT NULL AFTER `date`;
ALTER TABLE `users`
	CHANGE COLUMN `state` `active` TINYINT(1) NOT NULL DEFAULT 1 AFTER `mime`;

ALTER TABLE `tipos_usuarios` RENAME TO `user_types`;
ALTER TABLE `user_types`
	ALTER `nombre` DROP DEFAULT,
	ALTER `descripcion` DROP DEFAULT;
ALTER TABLE `user_types`
	CHANGE COLUMN `nombre` `name` VARCHAR(60) NOT NULL COLLATE 'utf8_spanish_ci' AFTER `id`,
	CHANGE COLUMN `descripcion` `description` VARCHAR(255) NULL COLLATE 'utf8_spanish_ci' AFTER `name`,
	CHANGE COLUMN `estado` `active` TINYINT(1) NOT NULL DEFAULT 1 AFTER `description`;

DROP TABLE IF EXISTS `roles`;
ALTER TABLE `users`
	ADD CONSTRAINT `FK_users_user_types` FOREIGN KEY (`user_type`) REFERENCES `user_types` (`id`) ON UPDATE CASCADE;
ALTER TABLE `users`
	ADD COLUMN `user_id` BIGINT NULL DEFAULT NULL AFTER `id`,
	ADD INDEX `user_id` (`user_id`);

ALTER TABLE `administrativos`
	DROP COLUMN `id_inst`,
	DROP COLUMN `año`,
	DROP COLUMN `cod_dane`,
	DROP INDEX `cod_dane`;

ALTER TABLE `administrativos`
	CHANGE COLUMN `foto` `foto` VARCHAR(50) NOT NULL DEFAULT '' AFTER `mun_lug_exp`;

INSERT INTO users (user_id, user_type, username, password, active)
SELECT id, 3, numero_documento, SHA1(numero_documento),1 FROM administrativos;

ALTER TABLE `docentes`
	DROP COLUMN `id_inst`,
	DROP COLUMN `password`;

DROP TABLE IF EXISTS `login_docentes`;

INSERT INTO users (user_id, user_type, username, password, active, names, last_name)
(SELECT id_docente, 4, documento, SHA1(documento),1,
CONCAT(TRIM(nombre1),' ',TRIM(nombre2)), CONCAT(TRIM(apellido1),' ',TRIM(apellido2)) 
FROM docentes) ON DUPLICATE KEY UPDATE names = CONCAT(TRIM(nombre1),' ',TRIM(nombre2)),
last_name=CONCAT(TRIM(apellido1),' ',TRIM(apellido2));

SET FOREIGN_KEY_CHECKS = 0;

CREATE TABLE `dir_grupo_copy` (
	`id` INT(20) NOT NULL AUTO_INCREMENT,
	`id_sede` INT(20) NOT NULL DEFAULT 1,
	`id_docente` INT(30) NOT NULL,
	`id_grado` INT(11) NOT NULL,
	`grupo` VARCHAR(2) NOT NULL,
	`id_jorn` INT(1) NOT NULL,
	`year` SMALLINT(4) NOT NULL,
	`estado` TINYINT(1) NOT NULL DEFAULT 1,
	`timestamp` TIMESTAMP NOT NULL DEFAULT current_timestamp(),
	PRIMARY KEY (`id`),
	INDEX `id_sede` (`id_sede`),
	INDEX `id_docente` (`id_docente`),
	INDEX `grupo` (`grupo`),
	INDEX `FK_dir_grupo_grados` (`id_grado`),
	INDEX `FK_dir_grupo_jornadas` (`id_jorn`)
)
COMMENT='Tabla para el control de directores de gurpo'
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;

ALTER TABLE `dir_grupo`
	DROP INDEX `id_sede_id_docente_id_grado_grupo_id_jorn_year`;

INSERT INTO dir_grupo_copy (id, id_sede, id_docente, id_grado, grupo, id_jorn, year, estado) 
SELECT id, id_sede, id_docente, id_grado, grupo, id_jorn, year, estado FROM dir_grupo;

TRUNCATE `dir_grupo`;

ALTER TABLE `dir_grupo`
	ADD UNIQUE INDEX `id_sede_id_grado_grupo_id_jorn_year` (`id_sede`, `id_grado`, `grupo`, `id_jorn`, `year`);

INSERT IGNORE INTO dir_grupo (id, id_sede, id_docente, id_grado, grupo, id_jorn, year, estado) 
SELECT id, id_sede, id_docente, id_grado, grupo, id_jorn, year, estado FROM dir_grupo_copy ;

SET FOREIGN_KEY_CHECKS = 1;

ALTER TABLE `config001`
	ADD COLUMN `fecha_prom` DATE NULL DEFAULT NULL AFTER `prom_area_puesto`;

CREATE TABLE `promotion_areas` (
	`id` BIGINT NOT NULL AUTO_INCREMENT,
	`area_id` INT NOT NULL,
	`config_id` INT NOT NULL,
	PRIMARY KEY (`id`),
	INDEX `config_id` (`config_id`),
	INDEX `area_id` (`area_id`),
	CONSTRAINT `FK__areas` FOREIGN KEY (`area_id`) REFERENCES `areas` (`id`) ON UPDATE CASCADE,
	CONSTRAINT `FK__config001` FOREIGN KEY (`config_id`) REFERENCES `config001` (`id`) ON UPDATE CASCADE
)
COMMENT='Areas que interfieren en la promocion del estudiante.'
COLLATE='utf8_general_ci'
;

ALTER TABLE `obs_items_modelos`
	CHANGE COLUMN `año` `year` YEAR NOT NULL AFTER `descripcion`,
	DROP COLUMN `id_inst`;


ALTER TABLE `encabezado_reportes`
	CHANGE COLUMN `logo` `logo` VARCHAR(120) NOT NULL DEFAULT '' COLLATE 'utf8_general_ci' AFTER `resolucion`;

ALTER TABLE `encabezado_reportes`
	ADD COLUMN `escudo` VARCHAR(120) NOT NULL DEFAULT '' AFTER `logo`,
	ADD COLUMN `mime_esc` VARCHAR(120) NOT NULL DEFAULT 'image/jpeg' AFTER `mime`;

ALTER TABLE `respeciales`
	CHANGE COLUMN `fecha` `fecha` DATE NULL AFTER `notarecuperada`,
	ADD COLUMN `notas` VARCHAR(250) NULL DEFAULT NULL AFTER `fecha`;

ALTER TABLE `promovidos_anticipados`
	DROP INDEX `cons_sede`,
	DROP INDEX `id_inst`,
	DROP INDEX `FK_promovidos_anticipados_inscripciones`,
	DROP INDEX `FK_promovidos_anticipados_asignaturas`,
	DROP INDEX `FK_promovidos_anticipados_jornadas`,
	DROP FOREIGN KEY `FK_promovidos_anticipados_inscripciones`,
	DROP FOREIGN KEY `FK_promovidos_anticipados_sedes`,
	DROP FOREIGN KEY `FK_promovidos_anticipados_jornadas`,
	DROP FOREIGN KEY `FK_promovidos_anticipados_grados`,
	DROP FOREIGN KEY `FK_promovidos_anticipados_asignaturas`;

ALTER TABLE `promovidos_anticipados`
	CHANGE COLUMN `cod_est` `student_id` INT(30) NOT NULL AFTER `id`,
	CHANGE COLUMN `año` `year` YEAR NOT NULL AFTER `grupo`,
	CHANGE COLUMN `estado` `estado` TINYINT(1) NOT NULL DEFAULT 1 AFTER `faltas`,
	DROP COLUMN `id_inst`;

ALTER TABLE `promovidos_anticipados`
	ADD INDEX `student_id` (`student_id`),
	ADD INDEX `id_grado` (`id_grado`),
	ADD INDEX `id_asig` (`id_asig`),
	ADD INDEX `cod_jorn` (`cod_jorn`),
	ADD CONSTRAINT `FK_promovidos_anticipados_inscripciones` FOREIGN KEY (`student_id`) REFERENCES `inscripciones` (`id`) ON UPDATE CASCADE,
	ADD CONSTRAINT `FK_promovidos_anticipados_sedes` FOREIGN KEY (`id_sede`) REFERENCES `sedes` (`ID`) ON UPDATE CASCADE,
	ADD CONSTRAINT `FK_promovidos_anticipados_grados` FOREIGN KEY (`id_grado`) REFERENCES `grados` (`id`) ON UPDATE CASCADE,
	ADD CONSTRAINT `FK_promovidos_anticipados_asignaturas` FOREIGN KEY (`id_asig`) REFERENCES `asignaturas` (`id_pk`) ON UPDATE CASCADE,
	ADD CONSTRAINT `FK_promovidos_anticipados_jornadas` FOREIGN KEY (`cod_jorn`) REFERENCES `jornadas` (`cod_jorn`) ON UPDATE CASCADE;

CREATE TABLE `promoted_header` (
	`id` BIGINT(20) NOT NULL AUTO_INCREMENT,
	`student_id` INT(30) NOT NULL,
	`headq_id` INT(30) NOT NULL DEFAULT '1',
	`grade_id` INT(11) NOT NULL,
	`subject_id` INT(11) NOT NULL,
	`studyday_id` INT(2) NOT NULL,
	`group` VARCHAR(2) NOT NULL COLLATE 'utf8_general_ci',
	`year` YEAR NOT NULL,
	`state` TINYINT(1) NOT NULL DEFAULT '1',
	`tiemestamp` TIMESTAMP NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
	PRIMARY KEY (`id`) USING BTREE,
	INDEX `student_id` (`student_id`) USING BTREE,
	INDEX `headq_id` (`headq_id`) USING BTREE,
	INDEX `grade_id` (`grade_id`) USING BTREE,
	INDEX `subject_id` (`subject_id`) USING BTREE,
	INDEX `studyday_id` (`studyday_id`) USING BTREE,
	CONSTRAINT `FK_promoted_header_asignaturas` FOREIGN KEY (`subject_id`) REFERENCES `asignaturas` (`id_pk`) ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT `FK_promoted_header_grados` FOREIGN KEY (`grade_id`) REFERENCES `grados` (`id`) ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT `FK_promoted_header_inscripciones` FOREIGN KEY (`student_id`) REFERENCES `inscripciones` (`id`) ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT `FK_promoted_header_jornadas` FOREIGN KEY (`studyday_id`) REFERENCES `jornadas` (`cod_jorn`) ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT `FK_promoted_header_sedes` FOREIGN KEY (`headq_id`) REFERENCES `sedes` (`ID`) ON UPDATE CASCADE ON DELETE RESTRICT
)
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;

ALTER TABLE `promoted_header`
	DROP COLUMN `subject_id`,
	DROP INDEX `subject_id`,
	DROP FOREIGN KEY `FK_promoted_header_asignaturas`;

INSERT INTO promoted_header 
(student_id, headq_id, grade_id, studyday_id, `group`, `year`, state, tiemestamp)
SELECT student_id, id_sede, id_grado, cod_jorn, grupo, `year`, estado, tiemestamp
FROM promovidos_anticipados 
GROUP BY student_id, id_sede, id_grado, cod_jorn, grupo, `year`;

ALTER TABLE `promovidos_anticipados` RENAME TO `detail_promoted`;

ALTER TABLE `detail_promoted`
	ADD COLUMN `promoted_id` BIGINT NOT NULL DEFAULT 0 AFTER `id`,
	ADD INDEX `promoted_id` (`promoted_id`);

UPDATE detail_promoted a SET a.promoted_id = 
(SELECT id FROM promoted_header b 
WHERE a.student_id = b.student_id AND a.id_sede = b.headq_id  AND 
a.id_grado = b.grade_id AND a.grupo = b.`group` AND a.year = b.year) ;

ALTER TABLE `detail_promoted`
	DROP COLUMN `student_id`,
	DROP COLUMN `id_sede`,
	DROP COLUMN `id_grado`,
	DROP COLUMN `cod_jorn`,
	DROP COLUMN `grupo`,
	DROP COLUMN `year`,
	DROP COLUMN `estado`,
	DROP INDEX `id_sede`,
	DROP INDEX `student_id`,
	DROP INDEX `id_grado`,
	DROP INDEX `cod_jorn`,
	DROP FOREIGN KEY `FK_promovidos_anticipados_grados`,
	DROP FOREIGN KEY `FK_promovidos_anticipados_inscripciones`,
	DROP FOREIGN KEY `FK_promovidos_anticipados_jornadas`,
	DROP FOREIGN KEY `FK_promovidos_anticipados_sedes`;

ALTER TABLE `detail_promoted`
	DROP INDEX `id_asig`,
	DROP FOREIGN KEY `FK_promovidos_anticipados_asignaturas`;

ALTER TABLE `detail_promoted`
	CHANGE COLUMN `id_asig` `subject_id` INT(11) NOT NULL AFTER `promoted_id`,
	CHANGE COLUMN `faltas` `faults` SMALLINT(3) NOT NULL DEFAULT 0 AFTER `final`,
	ADD INDEX `subject_id` (`subject_id`),
	ADD CONSTRAINT `FK_detail_promoted_promoted_header` FOREIGN KEY (`promoted_id`) REFERENCES `promoted_header` (`id`) ON UPDATE CASCADE,
	ADD CONSTRAINT `FK_detail_promoted_asignaturas` FOREIGN KEY (`subject_id`) REFERENCES `asignaturas` (`id_pk`) ON UPDATE CASCADE;

ALTER TABLE `promovidos_detalle` RENAME TO `promoted_observation`;

ALTER TABLE `promoted_observation`
	ADD COLUMN `promoted_id` BIGINT NOT NULL DEFAULT 0 AFTER `id`,
	DROP COLUMN `id_inst`,
	DROP INDEX `id_promovido`,
	DROP INDEX `FK_promovidos_detalle_grados`,
	ADD INDEX `promoted_id` (`promoted_id`),
	DROP FOREIGN KEY `FK_promovidos_detalle_inscripciones`,
	DROP FOREIGN KEY `FK_promovidos_detalle_grados`;

UPDATE promoted_observation a SET a.promoted_id = 
(SELECT id FROM promoted_header b 
WHERE a.cod_est = b.student_id AND a.id_grado = b.grade_id  AND 
 a.`año` = b.year);


ALTER TABLE `promoted_observation`
	CHANGE COLUMN `promoted_id` `promoted_id` BIGINT(20) NOT NULL AFTER `id`,
	DROP COLUMN `cod_est`,
	DROP COLUMN `id_grado`,
	DROP COLUMN `año`,
	ADD CONSTRAINT `FK_promoted_observation_promoted_header` FOREIGN KEY (`promoted_id`) REFERENCES `promoted_header` (`id`) ON UPDATE CASCADE;

ALTER TABLE `obs_observador_mod_3`
	CHANGE COLUMN `id_matric` `id_matric` INT(30) NOT NULL AFTER `id`,
	CHANGE COLUMN `año` `year` YEAR NOT NULL AFTER `id_matric`,
	CHANGE COLUMN `fecha` `fecha` DATE NULL AFTER `discalculia`,
	CHANGE COLUMN `estado` `estado` TINYINT(1) NOT NULL DEFAULT 1 AFTER `fecha`,
	DROP FOREIGN KEY `obs_observador_mod_3_ibfk_1`,
	ADD CONSTRAINT `FK_obs_observador_mod_3_student_enrollment` FOREIGN KEY (`id_matric`) REFERENCES `student_enrollment` (`id`) ON UPDATE CASCADE;

ALTER TABLE `obs_anotaciones_mod_3`
	DROP FOREIGN KEY `obs_anotaciones_mod_3_ibfk_1`;
ALTER TABLE `obs_anotaciones_mod_3`
	CHANGE COLUMN `id` `id` BIGINT NOT NULL AUTO_INCREMENT FIRST,
	CHANGE COLUMN `fecha` `fecha` DATE NULL DEFAULT NULL AFTER `periodo`,
	CHANGE COLUMN `estado` `estado` TINYINT(1) NOT NULL DEFAULT 1 AFTER `timestamp`,
	ADD CONSTRAINT `obs_anotaciones_mod_3_ibfk_1` FOREIGN KEY (`id_observador`) REFERENCES `obs_observador_mod_3` (`id`) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE `obs_items_modelo_3`
	DROP FOREIGN KEY `obs_items_modelo_3_ibfk_1`,
	DROP FOREIGN KEY `obs_items_modelo_3_ibfk_3`;
ALTER TABLE `obs_items_modelo_3`
	CHANGE COLUMN `id` `id` BIGINT NOT NULL AUTO_INCREMENT FIRST,
	CHANGE COLUMN `n1` `n1` SMALLINT(1) NOT NULL DEFAULT 0 AFTER `id_item_criterio`,
	CHANGE COLUMN `n2` `n2` SMALLINT(1) NOT NULL DEFAULT 0 AFTER `n1`,
	CHANGE COLUMN `n3` `n3` SMALLINT(1) NOT NULL DEFAULT 0 AFTER `n2`,
	CHANGE COLUMN `n4` `n4` SMALLINT(1) NOT NULL DEFAULT 0 AFTER `n3`,
	CHANGE COLUMN `av1` `av1` SMALLINT(1) NOT NULL DEFAULT 0 AFTER `n4`,
	CHANGE COLUMN `av2` `av2` SMALLINT(1) NOT NULL DEFAULT 0 AFTER `av1`,
	CHANGE COLUMN `av3` `av3` SMALLINT(1) NOT NULL DEFAULT 0 AFTER `av2`,
	CHANGE COLUMN `av4` `av4` SMALLINT(1) NOT NULL DEFAULT 0 AFTER `av3`,
	CHANGE COLUMN `cs1` `cs1` SMALLINT(1) NOT NULL DEFAULT 0 AFTER `av4`,
	CHANGE COLUMN `cs2` `cs2` SMALLINT(1) NOT NULL DEFAULT 0 AFTER `cs1`,
	CHANGE COLUMN `cs3` `cs3` SMALLINT(1) NOT NULL DEFAULT 0 AFTER `cs2`,
	CHANGE COLUMN `cs4` `cs4` SMALLINT(1) NOT NULL DEFAULT 0 AFTER `cs3`,
	CHANGE COLUMN `s1` `s1` SMALLINT(1) NOT NULL DEFAULT 0 AFTER `cs4`,
	CHANGE COLUMN `s2` `s2` SMALLINT(1) NOT NULL DEFAULT 0 AFTER `s1`,
	CHANGE COLUMN `s3` `s3` SMALLINT(1) NOT NULL DEFAULT 0 AFTER `s2`,
	CHANGE COLUMN `s4` `s4` SMALLINT(1) NOT NULL DEFAULT 0 AFTER `s3`,
	CHANGE COLUMN `estado` `estado` TINYINT(1) NOT NULL DEFAULT 1 AFTER `s4`,
	CHANGE COLUMN `fecha` `fecha` DATE NULL DEFAULT NULL AFTER `estado`,
	ADD CONSTRAINT `obs_items_modelo_3_ibfk_1` FOREIGN KEY (`id_observador`) REFERENCES `obs_observador_mod_3` (`id`) ON UPDATE CASCADE ON DELETE RESTRICT,
	ADD CONSTRAINT `obs_items_modelo_3_ibfk_3` FOREIGN KEY (`id_item_criterio`) REFERENCES `obs_criterios` (`id`) ON UPDATE CASCADE ON DELETE RESTRICT;



/***                          CAMBIOS 2020                ********/


ALTER TABLE `users`
	CHANGE COLUMN `message` `message` LONGTEXT NULL COLLATE 'utf8_general_ci' AFTER `lectur`;

INSERT IGNORE INTO `user_types` (`id`, `name`, `description`, `active`, `timestamp`) VALUES (5, 'Estudiantes', NULL, 1, '2019-11-30 07:31:36');
INSERT IGNORE INTO `user_types` (`id`, `name`, `description`, `active`, `timestamp`) VALUES (7, 'Familiares', NULL, 1, '2019-11-30 07:31:56');


ALTER TABLE `te_shared_evaluation`
	CHANGE COLUMN `read` `eread` TINYINT(1) NOT NULL DEFAULT '0' AFTER `enrollment_id`;

ALTER TABLE `ta_online_activities_history`
	CHANGE COLUMN `id_material` `shared_activity_id` BIGINT(20) NOT NULL AFTER `id`,
	DROP COLUMN `id_matric`,
	DROP INDEX `id_matric`,
	DROP INDEX `id_material`,
	ADD INDEX `shared_activity_id` (`shared_activity_id`);
ALTER TABLE `ta_online_activities_history`
	ADD CONSTRAINT `FK_ta_online_activities_history_ta_shared_online_activities` FOREIGN KEY (`shared_activity_id`) REFERENCES `ta_shared_online_activities` (`id`) ON UPDATE CASCADE;

CREATE TABLE `ta_comments_activities` (
	`id` BIGINT(20) NOT NULL AUTO_INCREMENT,
	`shared_activity_id` BIGINT(20) NOT NULL,
	`comment_activity` MEDIUMTEXT NULL DEFAULT NULL COLLATE 'utf8_general_ci',
	`comment_title` VARCHAR(120) NULL DEFAULT NULL COLLATE 'utf8_general_ci',
	`url_attached` VARCHAR(200) NOT NULL DEFAULT '' COLLATE 'utf8_general_ci',
	`mime` VARCHAR(200) NOT NULL DEFAULT '' COLLATE 'utf8_general_ci',
	`hour_comment` TIMESTAMP NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
	`type_comment` TINYINT(1) NOT NULL DEFAULT '0',
	`state` TINYINT(1) NOT NULL DEFAULT '1',
	PRIMARY KEY (`id`) USING BTREE,
	INDEX `shared_activity_id` (`shared_activity_id`) USING BTREE
)
COMMENT='Comentarios de las actividades'
COLLATE='utf8_general_ci'
ENGINE=InnoDB
;

ALTER TABLE `ta_comments_activities`
ADD CONSTRAINT `FK_ta_comments_activities_ta_shared_online_activities` FOREIGN KEY (`shared_activity_id`) REFERENCES `ta_shared_online_activities` (`id`) ON UPDATE CASCADE ON DELETE RESTRICT;

ALTER TABLE `users`
	DROP INDEX `username`,
	ADD UNIQUE INDEX `user_type_username` (`user_type`, `username`);


/******************** mayo 07 *****************************/

ALTER TABLE `promoted_header`
	CHANGE COLUMN `group` `group_id` VARCHAR(2) NOT NULL COLLATE 'utf8_general_ci' AFTER `studyday_id`;


/******************** mAYO 14 ****************************/
ALTER TABLE `users`
	CHANGE COLUMN `image` `image` VARCHAR(250) NULL DEFAULT NULL COLLATE 'utf8_general_ci' AFTER `date`;



/**************************** MAYO 21 **************************/
ALTER TABLE `te_evaluation_courses`
	ADD UNIQUE INDEX `evaluation_id_course_id` (`evaluation_id`, `course_id`);


/**************************** MAYO 23 **************************/
ALTER TABLE `cursos`
	DROP INDEX `id_sede_id_grado_id_asig_id_docente_id_jorn_grupo_year`,
	ADD UNIQUE INDEX `id_sede_id_grado_id_asig_id_docente_id_jorn_grupo_year` (`id_sede`, `id_grado`, `id_asig`, `id_jorn`, `grupo`, `year`) USING BTREE;



/************************** JUNIO 25 *******************************************/

CREATE TABLE `student_access` (
	`id` BIGINT(20) NOT NULL AUTO_INCREMENT,
	`enrollment_id` INT(30) NOT NULL,
	`notes` TINYINT(1) NOT NULL DEFAULT '1' COMMENT 'Notas',
	`newsletters` TINYINT(1) NOT NULL DEFAULT '1' COMMENT 'Boletines',
	`certificates` TINYINT(1) NOT NULL DEFAULT '1',
	`evaluations` TINYINT(1) NOT NULL DEFAULT '1',
	`activities` TINYINT(1) NOT NULL DEFAULT '1',
	`live_classes` TINYINT(1) NOT NULL DEFAULT '1',
	`leveling` TINYINT(1) NOT NULL DEFAULT '1',
	PRIMARY KEY (`id`) USING BTREE,
	INDEX `enrollment_id` (`enrollment_id`) USING BTREE
)
COMMENT='Control de acceso a los informes para los estudiantes.'
COLLATE='utf8_general_ci'
ENGINE=InnoDB;


/********************************* 10 agosto 2020 ******************************/

ALTER TABLE `configboletin`
	ADD COLUMN `bol_desem` TINYINT(1) NOT NULL DEFAULT 0 AFTER `activeindica`;

/*********************************** AJUSTES **********************************/

INSERT INTO users (user_id, user_type, username, password, active)
	SELECT id_docente, 4, documento, SHA1(documento),1 FROM docentes a
	WHERE NOT EXISTS (		
		SELECT * FROM users b WHERE b.user_type = 4 AND b.user_id = a.id_docente
	);


INSERT IGNORE INTO student_enrollment  (id_student, id, id_headquarters, id_study_day, id_grade, id_group, year, inst_origin, inst_address) 
SELECT c.id id_current, d.id_matric, d.id_sede, d.id_jorn, d.id_grado, d.grupo, d.`año`, d.ins_proced, d.dir_inst
FROM inscripciones_copy a
LEFT JOIN inscripciones AS c ON c.nro_documento = a.nro_doc_id
LEFT JOIN matriculas AS d ON d.cod_est = a.id
WHERE c.nro_documento = a.nro_doc_id AND d.cod_est = a.id AND NOT EXISTS(
	SELECT * FROM inscripciones b WHERE b.id = a.id
) ORDER BY c.id, d.`año`;

INSERT INTO matcurso
(id_grado, id_asig, ih, `year`, porciento, proc1, proc2, proc3, proc4, estado)
SELECT id_grado, id_asig, ih, 2020, porciento, proc1, proc2, proc3, proc4, 1 
FROM matcurso a WHERE a.year = 2019 AND a.estado = 1;

INSERT INTO aux_docentes
(id_docente, `year`)
SELECT a.id_docente, 2020 FROM docentes a
WHERE NOT EXISTS(
	SELECT * FROM aux_docentes b WHERE b.year = 2020 AND b.id_docente = a.id_docente
);


INSERT INTO obs_observador_mod_3_copy
SELECT * FROM obs_observador_mod_3;

/*!40101 SET SQL_MODE=IFNULL(@OLD_LOCAL_SQL_MODE, '') */;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
TRUNCATE obs_observador_mod_3;

ALTER TABLE `obs_observador_mod_3`
	ADD CONSTRAINT `FK_obs_observador_mod_3_student_enrollment` FOREIGN KEY (`id_matric`) REFERENCES `student_enrollment` (`id`) ON UPDATE CASCADE;

INSERT INTO obs_observador_mod_3
SELECT a.* FROM obs_observador_mod_3_copy a 
WHERE EXISTS(
	SELECT * FROM student_enrollment b WHERE b.id = a.id_matric
);

SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=1;


/*!40101 SET SQL_MODE=IFNULL(@OLD_LOCAL_SQL_MODE, '') */;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;

ALTER TABLE `users`
	DROP COLUMN `id`;

ALTER TABLE `users`
	ADD COLUMN `id` BIGINT(20) NOT NULL AUTO_INCREMENT FIRST,
	ADD PRIMARY KEY (`id`);

	
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=1;	


INSERT IGNORE INTO `inscripciones` (`id`, `id_zona`, `id_documento`, `id_sexo`, `nro_documento`, `lug_nacimiento`, `lug_residencia`, 
 `lug_expedicion`, `apellido1`, `apellido2`, `nombre1`, `nombre2`, 
 `tipo_sangre`, `fecha_ingreso`, `fecha_nacimiento`, `edad`, `estrato`, `direccion`,
`telefono`, `ips`, `email`)  
SELECT `id`, `id_zona`, `cod_doc`, 2, 
  `nro_doc_id`, `mun_lug_nac`, `mun_lug_res`, `mun_lug_exp`, `apellido1`, `apellido2`, `nombre1`, 
  `nombre2`, `tipo_sangre`, `fecha_ingreso`, `fecha_nacimiento`, `edad`, `estrato`, `direccion`, 
  `telefono`, `IPS`,  `e_mail` FROM  `inscripciones_copy`;
  

INSERT IGNORE INTO student_enrollment  (id_student, id, id_headquarters, id_study_day, id_grade, id_group, year, inst_origin, inst_address) 
SELECT a.id, d.id_matric, d.id_sede, d.id_jorn, d.id_grado, d.grupo, d.`año`, d.ins_proced, d.dir_inst
FROM inscripciones a
LEFT JOIN matriculas AS d ON d.cod_est = a.id
WHERE d.cod_est = a.id AND NOT EXISTS(
	SELECT * FROM student_enrollment b WHERE b.id = d.id_matric
) ORDER BY a.id, d.`año`;


	
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;	

DELETE FROM inscripciones WHERE id = 221;
DELETE FROM student_enrollment WHERE id_student = 221 ;
	
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=1;	

/*Quitar etiquetas html de un campo*/
UPDATE obs_anotaciones_mod_3 a SET 
a.anotacion = (SELECT strip_tags(a.anotacion));
UPDATE obs_anotaciones_mod_3 a SET 
a.compromiso_est = (SELECT strip_tags(a.compromiso_est));
UPDATE obs_anotaciones_mod_3 a SET 
a.compromiso_acu = (SELECT strip_tags(a.compromiso_acu))
UPDATE obs_anotaciones_mod_3 a SET 
a.compromiso_inst = (SELECT strip_tags(a.compromiso_inst));


	
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;	

INSERT INTO nscp00 SELECT tn.* FROM nscp00_copy AS tn
LEFT JOIN cursos AS tc ON (tn.id_curso = tc.id AND tn.year = tc.year)
LEFT JOIN student_enrollment AS tm ON (tn.id_matric = tm.id AND tn.year = tm.year)
WHERE tn.id_curso = tc.id AND tn.id_matric = tm.id AND NOT EXISTS (
	SELECT * FROM nscp00 AS tr WHERE tr.id_curso = tn.id_curso AND tr.id_matric = tn.id_matric
	AND tr.year = tn.year AND tr.periodo = tn.periodo
);

SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=1;	


UPDATE inscripciones b SET b.nro_doc_id = RAND() 
WHERE EXISTS(
	SELECT COUNT(a.nro_doc_id) AS total, a.nro_doc_id FROM inscripciones a 
	WHERE a.nro_doc_id = b.nro_doc_id 
	GROUP BY a.nro_doc_id 
	HAVING total > 1);



UPDATE obs_anotaciones_mod_3 a 
SET a.anotacion = (SELECT strip_tags(a.anotacion)),
a.compromiso_est = (SELECT strip_tags(a.compromiso_est)),
a.compromiso_acu = (SELECT strip_tags(a.compromiso_acu)),
a.compromiso_inst = (SELECT strip_tags(a.compromiso_inst))
;