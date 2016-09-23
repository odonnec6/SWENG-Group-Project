-- phpMyAdmin SQL Dump
-- version 3.5.1
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Mar 24, 2013 at 04:43 PM
-- Server version: 5.5.25
-- PHP Version: 5.4.4

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `bookingdata`
--

-- --------------------------------------------------------

--
-- Table structure for table `areas`
--

CREATE TABLE `areas` (
  `ID` int(11) NOT NULL,
  `no_rooms` int(11) NOT NULL,
  `details` varchar(128) NOT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `areas`
--

INSERT INTO `areas` (`ID`, `no_rooms`, `details`) VALUES
(0, 9, 'Test Area');

-- --------------------------------------------------------

--
-- Table structure for table `bookings`
--

CREATE TABLE `bookings` (
  `time` datetime NOT NULL,
  `user` varchar(64) NOT NULL,
  `area` int(11) NOT NULL,
  `room` int(11) NOT NULL,
  `group` int(11) NOT NULL,
  `purpose` varchar(130) NOT NULL,
  `confirmed` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'confirmed boolean',
  `group_booking` tinyint(1) unsigned NOT NULL DEFAULT '0' COMMENT 'Is it a group booking?',
  PRIMARY KEY (`user`,`time`),
  UNIQUE KEY `time` (`time`,`room`),
  KEY `area` (`area`),
  KEY `room` (`room`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `bookings`
--

INSERT INTO `bookings` (`time`, `user`, `area`, `room`, `group`, `purpose`, `confirmed`, `group_booking`) VALUES
('0000-00-00 00:00:00', 'BannerBob9', 0, 1, 0, '', 0, 0),
('2013-03-07 00:00:00', 'BannerBob9', 0, 1, 0, 'Blah', 0, 0),
('2013-03-07 01:00:00', 'BannerBob9', 0, 1, 0, 'Blah', 0, 0),
('2013-03-15 00:00:00', 'BannerBob9', 0, 9, 0, 'test pick room', 0, 0),
('2013-03-15 20:00:00', 'BannerBob9', 0, 4, 0, 'Test Confirm Booking', 0, 0),
('2013-03-16 07:00:00', 'BannerBob9', 0, 8, 0, 'Test Confirm Booking', 0, 0),
('2013-03-18 14:00:00', 'BannerBob9', 0, 3, 0, 'blah test blah', 0, 0),
('2013-03-18 15:00:00', 'BannerBob9', 0, 1, 0, 'Blah test blahh', 1, 0),
('2013-03-19 00:00:00', 'BannerBob9', 0, 3, 0, 'testing blah', 0, 0),
('2013-03-19 14:00:00', 'BannerBob9', 0, 1, 0, 'Testing confirmation', 0, 0),
('2013-03-19 15:00:00', 'BannerBob9', 0, 6, 0, 'Testing blah', 1, 0),
('2013-03-22 12:00:00', 'BannerBob9', 0, 4, 0, 'Test', 0, 0),
('2013-03-22 23:00:00', 'BannerBob9', 0, 4, 0, 'Testing Cal for bugs', 1, 0),
('2013-03-23 00:00:00', 'BannerBob9', 0, 5, 0, 'Testing cal', 0, 0),
('2013-03-23 18:00:00', 'BannerBob9', 0, 1, 0, '', 0, 0),
('2013-03-23 19:00:00', 'BannerBob9', 0, 2, 0, '', 0, 0),
('2013-03-23 20:00:00', 'BannerBob9', 0, 1, 0, '', 0, 0),
('2013-03-24 01:00:00', 'BannerBob9', 0, 1, 0, '', 0, 0),
('2013-03-23 19:00:00', 'BannerKate131', 0, 3, 0, 'testing duration', 0, 0),
('2013-03-23 20:00:00', 'BannerKate131', 0, 3, 0, 'testing duration', 1, 0),
('2013-03-24 01:00:00', 'BannerKate131', 0, 2, 0, '', 1, 0),
('2013-03-24 15:00:00', 'BannerKate131', 0, 2, 0, '', 0, 0),
('2013-03-24 16:00:00', 'BannerKate131', 0, 1, 0, '', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `groups`
--

CREATE TABLE `groups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`),
  UNIQUE KEY `id` (`id`),
  UNIQUE KEY `id_2` (`id`),
  UNIQUE KEY `id_3` (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `groups`
--

INSERT INTO `groups` (`id`, `name`) VALUES
(4, 'AnotherTest'),
(3, 'TestGroup');

-- --------------------------------------------------------

--
-- Table structure for table `profile`
--

CREATE TABLE `profile` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `Name` varchar(64) NOT NULL,
  `Description` varchar(140) DEFAULT NULL COMMENT 'Brief description of profile',
  `Booking_limit` int(10) unsigned NOT NULL COMMENT 'Max number of days in advance that a booking can be made',
  `Max_number_bookings` int(10) unsigned DEFAULT NULL COMMENT 'Max number of bookings that this user can make. Infinite if null',
  PRIMARY KEY (`id`),
  UNIQUE KEY `Name` (`Name`),
  KEY `id` (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `profile`
--

INSERT INTO `profile` (`id`, `Name`, `Description`, `Booking_limit`, `Max_number_bookings`) VALUES
(1, 'Test Profile 1', 'Profile for testing', 7, 2);

-- --------------------------------------------------------

--
-- Table structure for table `rooms`
--

CREATE TABLE `rooms` (
  `number` int(11) NOT NULL,
  `area_number` int(11) NOT NULL,
  `capacity` int(11) NOT NULL,
  `monitor` tinyint(1) NOT NULL,
  `other` varchar(256) NOT NULL,
  PRIMARY KEY (`number`,`area_number`),
  KEY `area_number` (`area_number`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `rooms`
--

INSERT INTO `rooms` (`number`, `area_number`, `capacity`, `monitor`, `other`) VALUES
(1, 0, 6, 1, 'test'),
(2, 0, 6, 1, 'test'),
(3, 0, 6, 1, 'test'),
(4, 0, 3, 0, 'test'),
(5, 0, 6, 1, 'test'),
(6, 0, 6, 1, 'test'),
(7, 0, 6, 1, 'test'),
(8, 0, 6, 1, 'test'),
(9, 0, 6, 1, 'test');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `username` varchar(64) NOT NULL,
  `name` varchar(70) NOT NULL,
  `profile` int(11) NOT NULL,
  `password` char(64) NOT NULL COMMENT 'SHA256 password',
  `courseCode` varchar(10) NOT NULL,
  `salt` char(32) NOT NULL,
  PRIMARY KEY (`username`),
  UNIQUE KEY `username` (`username`),
  KEY `username_2` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`username`, `name`, `profile`, `password`, `courseCode`, `salt`) VALUES
('AdminAccount', 'Admin Account', 1, '638674309a29f1d9a36702ad9f9729030b3e5dd596ea3ff59459e819811a6b02', 'BA.Test', 'Ã{J ¶Ú_À?ŒpW4á³®Ü\0{`ÐAŒxæŒÃ'),
('BannerBob9', 'Bob Banner', 1, '01ec63141b550f964aa8ac0c1f9548d8ef3b4b2da219c436e2cb1892f32502c7', 'BA.Test', 'fahµ–ulO ‘@GyÔ%°AZ41b~>©Ø±îQ'),
('BannerKate131', 'Kate Banner', 1, 'ba4a619b7c0bc7c592607347bd3e7456e337edf7c9e2f61120d3467715a5a54a', 'BA.Test', ' EÝºË°ÒÅ€òû{Ñv{ª>aF²¿€·ïÚk€~L'),
('BannerKate148', 'Kate Banner', 1, 'febe2155514670b80c540fcb9c1890bf39055e85d7f7ed07c1d1f7de2596af9e', 'BA.Test', '0ÐÐ‚”Ôf\n\\qÀqOÖƒ3îëhŒ¸G…+GnÛ'),
('BannerKate67', 'Kate Banner', 1, '06625eb3cdd3e75f3d49a9a1caae8d39f100297eb3beefa5e999d235402a0570', 'BA.Test', 'r¼PG·)ÞžÛ¢l­''åLoª±/\0€ýÛÌd¾óï'),
('BannerMary32', 'Mary Banner', 1, '655cdb57e4f1d1f7ac3ffb55692ed157ed94e892d058760468bbdea6c0838a0d', 'BA.Test', '''ð¼jÞœêÏ3˜(ãx98e"†;ÈêÖÕÊ^ŸÊžk­'),
('BannerMary75', 'Mary Banner', 1, 'd247d8c76dca980aa2467968bd7810ce6828bb83fcd19d1cb60c7cba665821b4', 'BA.Test', '“Î¢‡PÓ”„)?bVo 7ÚI^áîÐ¨EÚëäe'),
('BannerSam199', 'Sam Banner', 1, 'b3b6afc46444f26e481d76ee5cb392d528db63cb0addda0dc288cef7cfbbb9a1', 'BA.Test', 'DSeý»§ÀxË ùÈÖJ›AÚŽª´ŸÊ&àš”­'),
('BannerSandra179', 'Sandra Banner', 1, '6c6ff011a73ecb3c87770e21966b94aa7b96ab49507f33bcb3a36db1e1b5665c', 'BA.Test', '«_Éƒbækw°Ö´!ôÆXD\nq\\2ž¨tO<Ów9,'),
('BannerSandra61', 'Sandra Banner', 1, 'c62653e692b304bab814f18d890fff331f5e15ed8132dea25357feaf226b6094', 'BA.Test', 'âl·`LzçÏ"Ñ1GDhŒö  €•B\\€b'),
('BannerTom97', 'Tom Banner', 1, '05fb6c601a2e645bd037bc1193eb51f8a4d62cf1b7ef86d4100e695c8c9f1c95', 'BA.Test', '”äû!E^—)6¢ÎÉ“a[N+Á8~< Úõûe»ü\\'),
('BlackJudas41', 'Judas Black', 1, 'a743ddf1e957e93b41091e627e3b91e611cf0d9ebc27450a26ebb282b7d17b3b', 'BA.Test', 'Bÿal \0Uñ5~–\\´jI*¡RX''9öÑkJØ¡5ŒWø'),
('BlackKate64', 'Kate Black', 1, '13933a1bf7dbb403804645a806f133ef9e2e8ed79cbbb6f3e8556546178d245e', 'BA.Test', 'µ·rR‚çŽŸÿGpm$\\£W~ÅƒL ~Í'),
('BlackKate81', 'Kate Black', 1, '5b163135a02c549a7272c71a4475b58dc373abe955b7d4eb356f9998fab3ef1c', 'BA.Test', '‘bÑÂ''J/03ÍÉàŽü¤)æÔ2Ôˆåq_›'),
('BlackMary116', 'Mary Black', 1, '56092baf60247efc9c68efe84f4140e6c93525b57359a21dacca5b48aa069f48', 'BA.Test', '–©1ÕrA“kF×é0ý¢ƒèy¾OªVkƒI7ã'),
('BlackMary26', 'Mary Black', 1, 'a0b9b830f63db23dd01ec7139c1cbca6e17b0a32f7c0219bc4510aef20ae6af0', 'BA.Test', '%^ìxn(¼¼q©3}`=jÁY†0B c3Ü€;Â'),
('BlackMiranda192', 'Miranda Black', 1, '48d09910e058b6d962ad8a81cd324439d97e1b7074461dab5cd8ad26a25fc1b3', 'BA.Test', '²=ê{³u¶Í›2×Jšã˜èloMrç¡:–„ÃZ\0"'),
('BlackPaul153', 'Paul Black', 1, '97d1d83e7204d347a9edc02c8ca610300067b3b629da11cd6e32c2cef525c53c', 'BA.Test', '¼­®U3´«]«GÊ<ƒReV\naT)í¯:„–'),
('BlackPaul34', 'Paul Black', 1, 'd277573f1e5322c5c594ce441f9980d2607f564be901105c30431bc6a4b43859', 'BA.Test', 'Q.£“OŠCÔ[^ñÚ/…;ÙZœá9ùgt6\Z'),
('BlackSam124', 'Sam Black', 1, 'e6a0588bc4c5ec29ca099a264cb51510ab83db8a06292392dc5eb0e9d76e9d2a', 'BA.Test', 'z &…|ÇDý2¨±aÞSß/Mg¡Š¨FÔ·êPÌÏ?'),
('BlackSam167', 'Sam Black', 1, '6aeffd72fc19769481c84a547289ad5f3a8bdbca01810dc95cdeb72117ade94e', 'BA.Test', 'Ò½`>AÁIl{c  ýßìñ{\\zíÍ`('),
('ChurchillAmy37', 'Amy Churchill', 1, 'e1d7f56de4b0a1f3e0fdfb3ee11a300380c15ee24ab472af1c5ca4c7eeb4ff85', 'BA.Test', '^‹\ZögÜa?´ðn<WEbÉ×ÀõbUœ\ZIŒ@0õZa'),
('ChurchillCormac89', 'Cormac Churchill', 1, 'e0e5f0cf53856cb56c4151aa9c3b13bbbd65e01823397d76454f3ffcb1fe81f2', 'BA.Test', 'Í~­¾¹Á†›{aö6w<¡‘q5ñ……óÅ*çeå×'),
('ChurchillFiona95', 'Fiona Churchill', 1, '090f2668525bb612646404a7579150df43a8564d7250fe49185f7416a2161d1c', 'BA.Test', '\ZäDú”ï¸7M×ý½Å”îª–Üd®ú)ÓQ¿áØ'),
('ChurchillSam31', 'Sam Churchill', 1, '4b9b29a4f9fa7c2e19aa04a5e40c0f2dcdfaaf579d50831aa6bb2a1c3495e9cb', 'BA.Test', '\0On}RŒmSZÿÓãÀ1!ýx“ÄPrëEGŸh'),
('ChurchillSandra194', 'Sandra Churchill', 1, 'edf0cd6a4e3e3cff3b7c6e135c316d59ba4f877534b766611bdd3468651e9e71', 'BA.Test', '×Òú¯µê’Ó¥æ„ù¼n]Ž\Zål‘YôªW”Jnïä#'),
('ChurchillSandra71', 'Sandra Churchill', 1, '6dc27c6156ad268bb9cdf889b4d0c54cb251766209f124955aa85e2386ce2c0c', 'BA.Test', '‹ÚÉ÷Wûd Nø„0kÑÉqÚa³÷ŠyVŸ|P°ƒ½'),
('ChurchillZeus146', 'Zeus Churchill', 1, 'b6c2bc39c8873f917850e1b5558faaac3970f01edb96dbd0813bc9f907a3231c', 'BA.Test', '¡ ×Ž''\\¡tdüä“_ßÝ5\Zíû[¢§gDÃbþ'),
('CosgraveBob177', 'Bob Cosgrave', 1, '479bac395c3db53dac29460e05fa3f617eedd8b4ee041553c94e05ee19a3c9e6', 'BA.Test', 'é–*VhØ`PWYh";Ñ¡o™“Ì¡ì¹¢ÄOYûåv'),
('CosgraveCormac174', 'Cormac Cosgrave', 1, 'e7f56caebae9b5e0865e12c413dfd3316b81e69f86102598f91b69d7fc4059d8', 'BA.Test', 'Ä¦¼CSíT ‚l‹2lð.Ñ­ù±^rØEí±úvªæ'),
('CosgraveJack108', 'Jack Cosgrave', 1, 'a18ed4139ddb966845cc6b4e42559058f113dd2722ecbbcae579c7b83dbd79a0', 'BA.Test', '~ƒcˆTò’ø0÷„âF›¢±àñËäš''Aº''R?)'),
('CosgraveJack168', 'Jack Cosgrave', 1, '08e5415f6bca88ac26ff8f1a1e316d0645b6509707d3f57922f1762346b88304', 'BA.Test', '”ÔtÓ×ÒGîáž¹OòÒ ¥qåI!\në¬NJþ±‚0Ja'),
('CosgraveJudas96', 'Judas Cosgrave', 1, '6b7d4723159f570cb35eee9d8ef8ab3d8786654a3b08c839748e1ce750174f31', 'BA.Test', ' vr(½„\ZfŸ\nÑ(ûŸÊ\n¯¨JùæM§³M'),
('CosgraveKate51', 'Kate Cosgrave', 1, '9da62b1a927e4adabf3fd07ce1777b117034d822116131a10e6ce3cb214a70f8', 'BA.Test', 'à§-ñÒþÇNÛd®Ú¢««¢ZGà¨þð“³ù"ÓÎu¸'),
('CosgraveMary150', 'Mary Cosgrave', 1, '4cb854403dddcb810d54f206c8c1d8286f8c09888513ec15a2ae9dd27507dc55', 'BA.Test', 'nÎŸš{ÔÑ;Ñ:4AJI\\8¹¶'' ¡ýàÀGµðPDà'),
('CosgraveMary39', 'Mary Cosgrave', 1, 'd66d5f4dfe45a91542c57d3314c6411d919166c29aef40f3348a1d740f2dc1cf', 'BA.Test', '<>~²¿eZàæÞ¶ª×W&Û\nºÈÎ¨yåµ;¾¯õš'),
('CosgraveMiranda175', 'Miranda Cosgrave', 1, '993b6a6bf8ea96c3eee733bf15e56e92ccd13d496ebfa43dfe4bf87edbcaa070', 'BA.Test', '­ònLÁ…¾zÉ.‡vîöÜNß«/~t®N¤Á»]f”'),
('CosgraveMiranda72', 'Miranda Cosgrave', 1, '6332e4cd8027cdb9ea03e0dad550c6c4e3319f531e8f5e0e05f732ad2c19616f', 'BA.Test', 'dñW\0ÃŽ%-fU&’hþÞŠÉs÷‰Aÿz€âÜU®'),
('CosgraveRichard163', 'Richard Cosgrave', 1, '31c29fb2c9b4734690c3a8798c577b42b63d46d9cf84d13d6c142818dc5463d6', 'BA.Test', '%ÓëÛpÇ®\Zæ 3{¦\0u7Ò‚°¯%`¤GsçŽ'),
('CosgraveTim127', 'Tim Cosgrave', 1, 'b41b8d61aaff5c90324489e1effac6fed6e748112a95a6ab2fb2de87283424bd', 'BA.Test', 'XÆaØ—ô¿B“i''ÎÐÿœÓ‚¾Y$ÄÄËÙ''H4J'),
('CosgraveTim128', 'Tim Cosgrave', 1, 'c6588a612ea6a86aa3a0d26737a55cecd44f6f9eebe8a079794c82a3b42b7182', 'BA.Test', 'pI¦GÞ³î¡Èl:J•ñÙõªïÈæ¸SU0Ÿ.'),
('CosgraveTim42', 'Tim Cosgrave', 1, '29ececd87077e1f01a1e73b769519796723f5c63f71838dffc026893f2529ddb', 'BA.Test', '„×''à„Ûÿ´ª¨UCþ)üÈ\rHé«Á®×écqµ\\)ª‹'),
('CosgraveTim73', 'Tim Cosgrave', 1, '2fbd53d2fe6c4a4555f05b5b8c0d2bd52aba5ddef936f950366550c1ae3fca87', 'BA.Test', '‚B²³%ç·†ð]êP\\R{±S¡Ó›÷Y[#¹ê–'),
('CosgraveTom112', 'Tom Cosgrave', 1, '4aa2eaf93c3ccc8897c7d29fdd627d03c2a46096f7c1e8bf5cb6a40702362740', 'BA.Test', 'æZ«$Ò‰Ämêˆ´©ã¾!¾‚`ÆÅ#€g¾o3¿n'),
('CosgraveTom197', 'Tom Cosgrave', 1, '4b8f01fb0a1572ed12ee37e35f7b2fcd2a4e27cbbc3f9ffde12f57f38f0bbbca', 'BA.Test', '"Må¼Z¬°‡~ð{±›²pÙä¦YnbÜˆ"€Á–Ñ,y'),
('CosgraveZeus70', 'Zeus Cosgrave', 1, '65be071cb17da9af0a31df7e302e70f210367e6a4e616f3a6997d3d52d8a9b10', 'BA.Test', '\\ÍR]XXõ|Óç¾¿6ÑBy\Ze—%äC´šCØÁ'),
('FrenchAmy92', 'Amy French', 1, '3ad8bdfd6c2df83eab70752d83d7cea41357f9e2181e43c557f2e234e2f333ad', 'BA.Test', '¼K»''×A£Òzží}TÅ“Ù7\\s*3£í0½Äå©n'),
('FrenchEmma114', 'Emma French', 1, '0f68c286216bffdb83c37d85676bf52f56e7ac5f60d02df6509991c2b67a15bc', 'BA.Test', 'ŠMÖUî^YL*Ü³–£;›Ïë¡ÇJVïÚ~îñ'),
('FrenchEmma54', 'Emma French', 1, 'c86c8c1a4f3d4b1baebddbc88c1a6e37c25860412caa40e5c9c432abc73f053f', 'BA.Test', 'æ€RVä~iÁáËýÀ›Ÿž½kÈÚç¦òìs]Šp!Ø'),
('FrenchEmma8', 'Emma French', 1, '15caf22048159c9bca62f2e50fa9c25f1f43b997e9b2587efa16a5b89d2f7662', 'BA.Test', '.1ÈÔ”˜„ålQ×IŸä‰ìšSad%©!“j$'),
('FrenchFiona16', 'Fiona French', 1, 'dfaf480b7a42d316bff30684efcf235bc6575009eabd686afd0ef5782facc23b', 'BA.Test', '&™Þp²\0z©Úë!¨éÝù÷Ís7GT‘\n¨•Ìè251Ó'),
('FrenchFiona166', 'Fiona French', 1, '1226fe7f441d767242451e3cb031f9e8a02c2e485dc131c1d009fce39f1fa0f6', 'BA.Test', '¿s.®\Z¶QùŠÒkàc~°“2 ~è{]r)nCù|hµ'),
('FrenchFiona52', 'Fiona French', 1, '1a4e77cfc93b97fae7020f8452c586b9453750e304a227652022466da8f2a1b8', 'BA.Test', '¸"íí)thÃö ­Ö_üMçi0E¢Eæi3P—í,'),
('FrenchGlenn104', 'Glenn French', 1, 'b1577a2620a96ef0aae4c54f8f68fada8fdbeccc8a56c4f3611371e724cc9e87', 'BA.Test', '»ïy7âÃûÿ4ìÒ´i‘Ö\Z‰ê×¶,©ÝÂÁHý_'),
('FrenchGlenn15', 'Glenn French', 1, '2f0e3b7c148239ebad853f577da81693ac77c650800eafd84d826c06a38d3948', 'BA.Test', 'ÍHÖ½1@%Õ°Ø¥S%Ìt;I(ºÏuaÂ8û'),
('FrenchGlenn152', 'Glenn French', 1, '899ff534b6102c8e47c03cb79192f28a87f27f776350612d753253ae685e737a', 'BA.Test', '[Öò2x¬k<ß¿û›gÔÛÕ¼9ŠýÅs÷É˜'),
('FrenchKate3', 'Kate French', 1, '665594784603c7d379f74bfab7df1e956f7cc0cbc7d1b14043931a6d2faa3729', 'BA.Test', 'os»“ê]QÜlY69®è†aòLÎ4ž$SwW0D'),
('FrenchMary109', 'Mary French', 1, 'e7a5e7b6a9832fbbd1a344cd3d6cdbd0874ba5b8133c6f66fbabd7567fe0706a', 'BA.Test', 'ó×{m6ýƒT[ð¾˜¡Á@™ÿå§ðÑEË®eˆ+µ`\\'),
('FrenchMary178', 'Mary French', 1, 'f7cdcf4115469d197144e44ceaa2844c4ad64c00cfdc40c7669b54d7d29ad11d', 'BA.Test', 'ŒY·ù0/wRZå¾j¢£sØÖ-Ê×Ì!ò]dø'),
('FrenchMiranda136', 'Miranda French', 1, '4dd4903ee32a77611eee416090445ce25de61dbce6eec797510cefd8610948ec', 'BA.Test', '8ËX¤¸¨ªÿ7‡¥Ùå´Ç­3Ý@‡€…$}àèÒ'),
('FrenchPaul115', 'Paul French', 1, 'e9e1369aea372f5ab63ea52f4db97b5185e544355b771af829f33b619ac84b96', 'BA.Test', '‚øi¼ªãEAÚºogªæ00ô9d"2Ôûqs‰Ü€™¢'),
('FrenchPaul29', 'Paul French', 1, '83fda9f433bb0a21e298f1f749690eb23b2899071a3ffeca33c2811fc9b65240', 'BA.Test', '­ÅÎøÌ–¦¹¦‹‚Âÿbb kÑÞž:æÞÞ^„’i'),
('FrenchSam11', 'Sam French', 1, '5e3e915cce3e28ca6e1b3ba5249d6e4eac66747dce4b7c7cc271bb7e1b251ae8', 'BA.Test', '3`5Ef§Üªc•©“¦?Æ\Z³n>@®Pfþÿµ'),
('FrenchSam161', 'Sam French', 1, '5be5ec232e206bb82722d2f3b19a6717682f41ba94840477b6d2b012ef224b15', 'BA.Test', 'ï„Î—mjƒ Ýšrºc¿üçJKåÎš…¥‹ÊX'),
('FrenchSam185', 'Sam French', 1, '5a26bb2803ead29f19ca73374ee236b71c0362a81cd14e5eee3b07de8d39cf12', 'BA.Test', '-76îú`ï©\r\0\0„<ew»eÓg\ZÒâô™\0~ŽÈQ'),
('FrenchSam196', 'Sam French', 1, '8e8fbf3860dab25ff156309c1df4491347f009cba20426a5230ca6118a58289b', 'BA.Test', '^ú¯ÜËX‚ÒùÌcZ=!sâý‰;gY\ZÚ§ªð*L±ó'),
('FrenchTom151', 'Tom French', 1, 'f4b14890f2d295b436ef900af98f6aa33dea51596f3a28f61de55e3a78cd2cd9', 'BA.Test', 'w?æßHiÚ  ¤ˆ”3*=ˆJ*3ÏHìzž¼8úüŸÐ¸'),
('FrenchTom160', 'Tom French', 1, '580cb2554121f7717da8ac0fccc3a417ac3f290d8be818e80d05edcd33a8f972', 'BA.Test', '\0ÎœÙ“šNrBÿE%A÷ßûÂ§]DæÉdÇ¯íÔ)'),
('FrenchZeus23', 'Zeus French', 1, '95737df23f2657494551dba5458722db1c01685f3e4c078e3e47996d0c265462', 'BA.Test', 'óÓODëÑ®z\nðÑ;FÑtgXî~h/Â±‚¢:'),
('GleesonFiona123', 'Fiona Gleeson', 1, '91a7155102ee6b0298347557cc29cce83bf0cb093f41e1323cd7b7e6c91fd960', 'BA.Test', 'æ‡L3ÍäAòÚ¬›Ç\Z¶šs:§ÓðPÞ`Ôefnþ'),
('GleesonFiona13', 'Fiona Gleeson', 1, 'd06a675e513e8bd1a1462ae745f2a163086b0bde92b14e3a9cfe8dc085a08a69', 'BA.Test', 'qñWíÇiÊŒ«ç”Òv~¯â<Æ®tú}vótþÓIe'),
('GleesonJack141', 'Jack Gleeson', 1, '438c427a17b43b68b30b316559de7b82c24bad85dceee484ea99bb8293b945e1', 'BA.Test', '}J…Ùß«áõSÊ bÚË0ìËx<÷Œß>S)Ô'),
('GleesonMary162', 'Mary Gleeson', 1, '341a49729e458f7741d07786f0924b10b756b900959ab05fbd8d532750645cff', 'BA.Test', '‹©¼¡/ª»Þ«{\0ÿT­[Ý•‚tÞg%‘”]~±ôâS'),
('GleesonPaul40', 'Paul Gleeson', 1, '0e6dc9b0cc15ac7d6187149cf10a6ec8e053e97c86c7aa9e574efebba9846f10', 'BA.Test', 'À¨Ùž¤\0º°íÿ@÷ËÇ8Ò¹MWå!tˆû?w'),
('GleesonRichard30', 'Richard Gleeson', 1, '1353baf66b8d117759f7af78bc74e1b32a10f8ab0bfcbe648780d523ca96150a', 'BA.Test', '¢"û9Æ}c­ q‘¨Ç&Ð¡¿:H=­Ê‹Éþ·£'),
('GleesonTom63', 'Tom Gleeson', 1, 'beb4340bf52285afb5b2d62f4e8bb9ea9b3b42add6f7a33231d06c1a79823f73', 'BA.Test', 'â>ùnGÚµ˜â¨œûÆ¬•7¶ª¼<®Rh6Å2'),
('GreenCormac121', 'Cormac Green', 1, 'e58c9391ebf1cb920398d1461c2524420b02a85fc8f5cae5d2855a7a9523ff9a', 'BA.Test', '|fcå%d%Æ¸—lj…NN+º¤.¥kTî\r…ê'),
('GreenFiona122', 'Fiona Green', 1, 'e797e61fe1dbfdd87a28da49f5b37b91ab622485c9fa22d217f61d680b949a08', 'BA.Test', '73[?¿ *Ý=g®)ŽeÀQØ)d\nct4Yž‰Û”'),
('GreenGlenn101', 'Glenn Green', 1, 'd8088e1c65cdcab0ecd11e60fc96a37f9348bc78a4b1a39f6164cd2afba1c110', 'BA.Test', '“ÅsœF2@î‘X{YòÝ­w£¨I;§ÁœP*þ{b'),
('GreenJudas36', 'Judas Green', 1, '5269fc7546e49ca4f9ec28f923e25722ca2d94ae71e949affae226ef1547c1b5', 'BA.Test', '‹1d\0¸¥ü"ÊóŽ¦Ø¯gˆ°±þI‘Zž^'),
('GreenMary120', 'Mary Green', 1, '8dc4647b1d14dc0aa2d97c8e7ff01abf13b7ba796e806e2a3c2aab2d10749e86', 'BA.Test', 'mÑY\rÚß×€=…„7©4Q×?a2)Ë‘£ƒox['),
('GreenMiranda176', 'Miranda Green', 1, '8a30e5261c7e7267a55dda6abcb89db90876dc61caba8f142dc7647dd5fc5ae8', 'BA.Test', ' è"¶7þûÉDA‰P\r  \r­-äwqnñ5Ët<5‘©ú'),
('GreenPaul171', 'Paul Green', 1, '5f477fe07e6e80d7dccc3b3929b1295ad4582d8e9f1ca3330706516512966980', 'BA.Test', '+þ¬<r\\n~ûaÚZ¬êt8·ß’TäW9VYB''e'),
('GreenRichard100', 'Richard Green', 1, 'aaccba0e639b3d3bc1c5a0a942bab28748d9f2ca4596e1fc097f933015730ec6', 'BA.Test', 'Šé;1''hØ£ŽGàcÁåÐÄÖþç¼–Ä¬áºAHÇc'),
('GreenRichard5', 'Richard Green', 1, 'f5fb43f5c1cbd963d8e2ede33352e3c67576ccd650c6a3c7922cbde8528fd0af', 'BA.Test', '™é9Èaqè˜Z¨£¦„‹<÷HðXÙ´såAzØ-ÅÔ¹á'),
('GreenSam149', 'Sam Green', 1, '21a23786336eaae60cc4c537e6622560bd4637fd370c83b86ace1d6f740502a3', 'BA.Test', 'ÍÈd€¯k-Á.^Ñ\r4<ž\nøítL‰&¯ÜFù'),
('GreenSam80', 'Sam Green', 1, '6b4cc2978ce1c0aa6e88744fee8faac35c4ea32bbb1f8cbccc55e687cac88ddc', 'BA.Test', 'ye=þ£V£~yÊÌˆ‚`¶N‡¹á=Ã%\rö''Q±&U'),
('GreenTom165', 'Tom Green', 1, '1b1425a23684fcf10f4d491a8f96ba33e96e4e6a5bc3f9e84369d022d459e83b', 'BA.Test', 'X<VŸ''÷X{Š¯“u\0?Bè–“† €Ìç¹ƒ8‚ˆ'),
('HughesAmy154', 'Amy Hughes', 1, 'bffba1b7ef51cf48546097a46de963dc5a149c32c0592f1c07b51469db368b2d', 'BA.Test', '}“Ýƒ‘Cùƒ[\\”ÒÜq"´½Q¯œ09NŸ¸é¦õ¹º'),
('HughesAmy84', 'Amy Hughes', 1, '2ec7b62c785c9c790edef50147eb09d77965b2a148fc6b47c18b29f0964aadfe', 'BA.Test', 'lj7÷,¶¸ÁHs''Â–wÅqõ~U\0ã?÷Hë'),
('HughesCormac198', 'Cormac Hughes', 1, 'bcf6453b5d310fedc2716b2cf3511c9adcf44c3ed021d7e841dffe815877bd77', 'BA.Test', 'I}0/8§ÂY7Ò™$MƒËØk™Š…œ)†i''ÐCŠ~ƒ'),
('HughesFiona25', 'Fiona Hughes', 1, '8190d21c10f59583d657ba92d6a21d5e114a4a30aab5aa8b9a191e2039581e18', 'BA.Test', '_ÕcL  ‚ÅF*ôˆ°¿<©Á|·\nl2ÇMP³y©f'),
('HughesJack46', 'Jack Hughes', 1, '6047babe60d0bd94da83670bc192fdfd21e057c79e32c404a619ce00ab2a763f', 'BA.Test', '`Ï\r}ä‚ÇùJ®ûþÊQÁÆwè¬\rßùON;É'),
('HughesJudas129', 'Judas Hughes', 1, 'caa1f9aa878d10bc076ba795f1daa5b2f071c1c53c9751d5650e222f86c087fb', 'BA.Test', 'ÉOKärÂÐ½!.QAh´ñ—¸ë®W‰Þõ¦è^k'),
('HughesJudas172', 'Judas Hughes', 1, 'c007e465d9f68f21bb1cf7e5d08aa33b05f938d97ae0e543c25a19cc3e95d7c5', 'BA.Test', 'Á_õg3é–[!Å=PO‘4½0‚¶í4ÚûÄ_,»jÁ'),
('HughesJudas91', 'Judas Hughes', 1, '700387984c639db33c2ec7f26099be48bc4fe2c3ad97c663bb12d2cee1e7c83c', 'BA.Test', 'ïÝ7fçpGƒó{®/Htu]q''ø4¬XÕŽtÑX½rïB'),
('HughesMary110', 'Mary Hughes', 1, 'cfdef0266fc5f4ecad9168f25b800b11a0bdf14840f54f2e27eb5c53b52ecf98', 'BA.Test', 'Ï>i>š¯§éÛÁü3i-‘žøLñƒ|à­Ï¿º•\0'),
('HughesPaul45', 'Paul Hughes', 1, '80cceaa91253336504ac219ab2619504374b6b8f8494ebe0bbb04a9d8e4b4691', 'BA.Test', 'P™ãCÏiPb%†P‡Ç}2Ÿ§³Î–Ö¯Ömv'),
('HughesRichard117', 'Richard Hughes', 1, '15ae3f85093917a29d3c416ecc1b0634cb944e362ad36ea93a2bbb46b7127f31', 'BA.Test', '½0Á,Û&¥X°ä´‘ÑKså-‰l¡­ÊÞ:3bñtf'),
('HughesRichard158', 'Richard Hughes', 1, 'b56fbf762a1ad10b541cdf694a928c72a91e26dc91e05bccd11c3cce80a36fd7', 'BA.Test', ':31>DŠúf3‡•ÍfÒoÛ)wzLM,ŒôŠÞ´µß'),
('HughesRichard33', 'Richard Hughes', 1, 'db9300b354b521a925e2ff829896369a29ed84f19b78ea1c57de9d7de7581d5a', 'BA.Test', '€÷É˜—ï6ý·ÏRÊ¬V*†Åïcœþs±8ôýŠø'),
('HughesTim193', 'Tim Hughes', 1, 'b6a2c8694ecf51e3d11294aa4a1709513d6e83fae1d80dfc190b0b9198184ab8', 'BA.Test', 'Dð~×ïfÙ£E³ˆ·¢£ûâœ³%VTš­mR{Lÿ£'),
('HughesTom189', 'Tom Hughes', 1, 'e80cfd2962adc578e53d7aaf5059a67d209fee9d6f95334cd97f9119705b17c2', 'BA.Test', '¹dc˜%R¡š-ú.87\0øQK­ácãwôZ~dT1ÿ'),
('JonesAmy126', 'Amy Jones', 1, 'b0bc1950d44a904fc9ad5ed8483f8d3e63d4f533498fe013b4b37e55bad59409', 'BA.Test', '«^Ý€ÐÌ!xY% e†Z(¡ìÕÄÏ«F-~TÄr„3'),
('JonesBob48', 'Bob Jones', 1, 'e18c726e9c387e9b1f2c1a64163909cad567bfedfa44cd53515b502a01eb2692', 'BA.Test', 'Ì8C<­›kÜ ”K£|MãŠòrwÄ`l¡+h•Ûês'),
('JonesCormac57', 'Cormac Jones', 1, '512b400a73bf977438efb1e659abb25370b1ae54d476a0cb3f34c703ef2cc930', 'BA.Test', 'I˜ÔnHœ#&çü¤-L¤a4ÙL?ú³oÚ?‡'),
('JonesCormac77', 'Cormac Jones', 1, '43454db2d58b0bf95099a02e95f640aa80b8a5705cac700d9a899dcf47a6b92b', 'BA.Test', 'ü!ìŸÉ“Ó§''Zc›\rqOÔ›Õ¸½ªC›œöãHÒ'),
('JonesEmma94', 'Emma Jones', 1, '0110b0673ef31ad7bd4fdedbb798b01aa7878b736e139d99d4271028878b0390', 'BA.Test', 'á­,\r?üñ¸ï*´±Fî"-ÞnOîè2Šƒ—~û+K'),
('JonesJudas118', 'Judas Jones', 1, '78b1f42262b36ccf4b5faaac46452b91bd13444089eeb6cb7ff35e7a618855a0', 'BA.Test', 'é…ç«Ãí%a‹ZGÔ»³(°¶(U4ó,~ö ËHSù'),
('JonesMiranda12', 'Miranda Jones', 1, 'f578f00b287f906196364054b903b8df16a65b14c6a311e5c1cef2046b06f067', 'BA.Test', 'Ð]UÛqéÃ¥oazÉgøÿ`k|LV[Çf«ñ¬ó'),
('JonesRichard186', 'Richard Jones', 1, 'ea7d606d844b505c8a5b1d390a94071ce1f526a199e2672e25e2cd7b99b1d100', 'BA.Test', '77g”§÷Äµ7s¾wq>ªWæ!ÀˆO—É_QýH|'),
('JonesSam140', 'Sam Jones', 1, '130e8a1a8a0d164bbb89b442191a2aad0d7ca8d973ba0802a4e94a4d281ad4fe', 'BA.Test', '¢Isü>b`U)®ý‡hõœyFHÙ«É­ûmªÛµ‘Z­'),
('JonesTim53', 'Tim Jones', 1, '49e0c85ea6abb46b9e94a6da1db1284eb165eadf34d3dbb0137ad154bc3bfd14', 'BA.Test', '9\nq<î&j)  ª7½é÷U"9ªh@~bw>Î'),
('JonesTim87', 'Tim Jones', 1, 'c040d393006be341d9c0378abbfd680e0432414673486d5c24d6e8f8870f9bd2', 'BA.Test', 'Ä"ˆGúÎåh*‘žÆGnûè:®¦š1å"»'),
('JonesTom142', 'Tom Jones', 1, '0df017a185cbecb4e9eb8f295eb66d203b670539df3759d511ee63bee07c2fa7', 'BA.Test', 'þ¼î.·ï?†ÍeËÜ3b–z»ªœ¼B¿ÝµõÜpy3'),
('JonesZeus156', 'Zeus Jones', 1, '625b9d4145b91aaacb7a3a06ee21aa5d518e49b3ae99120ed996dab0d02748ee', 'BA.Test', 'ÝÔ!`€=!÷–òº\Z ?¹K»a‹JP7\rÒzð'),
('LeninAmy56', 'Amy Lenin', 1, '1b8165529937da771627223891616611a1441c6e290df6b4aa4cb6ce58d847cf', 'BA.Test', 'ïƒ—Ô÷u©Ç)•÷  L1Êï¾hkà¯[‰È“z^'),
('LeninEmma130', 'Emma Lenin', 1, '3d152cc0ae0fcee47a0e866456588518326b1ae3ffe9aa483343119156a0ef9f', 'BA.Test', ':4HÉz?¨±¢]u>c\ZFX”l\Z‘Ow~VC¦ë5Í'),
('LeninEmma170', 'Emma Lenin', 1, '4c4a21dcb4c3c4bc6ef5013624d0df3e6a2885ff69251539511b512ffb0f54a8', 'BA.Test', 'ï¤›¨¢þ#ª.\Zw»:J3ã#šC>“uÒFG-"¡ô"'),
('LeninEmma7', 'Emma Lenin', 1, 'bffc805b6380dcd061b90c489ee93eced1dbfe1802dcb2b8984c8bb79b3bd078', 'BA.Test', 'ÁÄÏA#IµƒÕnCF B“Í9Ì`ðéÚ™\nÈõ\Z'),
('LeninJack164', 'Jack Lenin', 1, 'bcc130b4c746ca1cd7e222c4018ae8580aa0f0c2a9df41b36e8e28ec4726f602', 'BA.Test', 'Ý]£Ý;-à‰W–ª‚ÓA›²ý™Å‰ñŽ8“}Ð½o'),
('LeninJudas125', 'Judas Lenin', 1, 'f98caff3bcdcdfa3abb02755f9248f8c5d4828a528371748108a08be671c1e6a', 'BA.Test', 'ÍÎ7œ^aazå{w]â©W€¸óhowù*¿'),
('LeninJudas169', 'Judas Lenin', 1, '883b7b83c973e12040046034c5b054c7f2bc103207c714c992031390297800ff', 'BA.Test', 'gt¹°8¶Ñ<…19#v@-„GîRÜ’Ú8FTAßT å'),
('LeninJudas68', 'Judas Lenin', 1, 'a0d405d08622bb045d56a8a4d75b1d98dde3805f1fb1941a4606760d67a2858d', 'BA.Test', 'µ|Œ©µåƒ.;8£&Ó[¿Æ nÝœ±XêV”“ð'),
('LeninMary0', 'Mary Lenin', 1, '37d80852e49e4ee148cc781c5d38d4bfef7e2efd919369d14e58812768d4f655', 'BA.Test', '$ˆ°ûÓâ°}³kŽ\n†Cc–§Û™Q¶$eó~òF6‚m'),
('LeninMary173', 'Mary Lenin', 1, 'e881a771de75cc8874407e808c493a1b6937b5f2d09cfb3c0eb241222dbb6019', 'BA.Test', '_9ÆÀS2®•v÷RÂÃÏÜ”f¾&vÕ9ÁL¤*ªÜ2x'),
('LeninMiranda88', 'Miranda Lenin', 1, '50b6efc2f11f1ab2173b60e5bc44c5fe66ac1d0e26dcfc07908d1b01bb65fa82', 'BA.Test', '·S¢P–w0m8µµÃu\rv‘v{—z™¹Çh$ÉLJÙß'),
('LeninPaul113', 'Paul Lenin', 1, '9bcb562eab6c5910bbae9733c8ba13c9f048db44f3fb9161aa380ffa02a1d6aa', 'BA.Test', '=ß…ð-Ë—ŽNƒËf£Ü3iœ¥q—\0".-®"Æý'),
('LeninSam107', 'Sam Lenin', 1, '4f6b4eefb481d55dd9e3bed3612f8ef38a8ed338bdb756e6c0af7ae1f3676a8d', 'BA.Test', 'çBžvÞ«’‚b4¼B\0XþÝ4Ø‹5K¥wQÊÃqm±j'),
('LeninTim147', 'Tim Lenin', 1, 'da44990eb1cdf4f777fb97f8ab4be21d2d0070ff443298a9d0903beb80c414f7', 'BA.Test', '—–ÜàÞž‰üÿ¨Â(ü”`¬ –å,G%®AN'),
('LeninTim19', 'Tim Lenin', 1, '586d45139ce375e42f17856be859ce53711b2138cdb223d7350584af45bc125e', 'BA.Test', 'Ó5bì_Ü·\ZBA¡µ¿ÓpÇ]?Ñª$y–TVÇ`¸Ú'),
('LeninTim21', 'Tim Lenin', 1, '628d711fea55346357e19158fc9a0945783d7dddd8e940f542f65c82a06f4be7', 'BA.Test', 'ÖTú-â×OC~¨çÚ8»†ŒÕk®¹as;t'),
('LeninTim76', 'Tim Lenin', 1, '529b29204211f7fbf4b7d78efaaec686772af04d58f3dd35d7e7c8a4a54f3c49', 'BA.Test', '-Ûg&Ú?6ºüó5}­hÜÏ\0¢btOM¸GÀ¡˜~Ö'),
('LeninTom105', 'Tom Lenin', 1, '9981ce2fc63609d3003332c3de4bd73a1f944f8e913ec9ecc8c58ceb7c99756f', 'BA.Test', 'X‹½¹ëší¦R#Ô4§kç>$WÙ±ü+CÂyLÂoÐß'),
('LeninTom6', 'Tom Lenin', 1, '07f895bcf0cb1a0cd842f3f861781ab72b1dcc0c9033516dcdf0404aafb0320d', 'BA.Test', '˜Ã¢äÙ©>ÞœË½ë«‘õžf…Ú•þ(/öåG v'),
('MonkAmy28', 'Amy Monk', 1, 'e9a8e2dbb0776dc132e86d872a763acbe93301291583049add22bade14072c62', 'BA.Test', '\nðÎ¦''[uå(«Õ¦…Å5vf£È³l-0áI_»¥†í•'),
('MonkCormac181', 'Cormac Monk', 1, 'c8689353b2f7bd649af292f749379d21638fd7377eb57c994977af5be4b4df80', 'BA.Test', '&^BM4§™ù†óœÿ¶ŽVö˜Ê³ëÇ–ñEd'),
('MonkCormac20', 'Cormac Monk', 1, 'b80095ce4b3abca998be169253597e33106223ee4777caa7f5225fb6cec6a2d4', 'BA.Test', '…‚²q!ºöt€''Š>ö,ï¬Š¡ûRÒù\r•Ò&¼¾'),
('MonkEmma191', 'Emma Monk', 1, 'a7f63e3eaf711795a4dfe471e86a7a081dace3ef2b830fa7f4943c6a7ae627f1', 'BA.Test', 'z›ƒRò[ügué–K†9\rJìª|Ã*I–»‘ˆ&“Í'),
('MonkFiona50', 'Fiona Monk', 1, 'ad9b3d1f91e363feefc7dcc81e1f7ea994346ffeb164ed4fe30adbbf677f2538', 'BA.Test', 'Ýóýöfž‘¾¤ýŠ¼­›Û&§S7¶:¶$“d×ùóÎÚÅ'),
('MonkFiona59', 'Fiona Monk', 1, '556b7cce1be15412080fd3dcfd5cab1fb59a5e6bffc4fc976faa60fdcb5fb0bf', 'BA.Test', '¯`åá“˜ôùÌ$a“ÙYôIýª¼.§@:¸%„t5Ñ'),
('MonkGlenn102', 'Glenn Monk', 1, '97dc61079b8c9942ee39460c0719e487e26939badad1395f5d2e861855a88212', 'BA.Test', '’£¢ÎÓY¬ƒÕ1ÇE$\\úâ(S''''rÂ%•—>ÃROmc“'),
('MonkKate69', 'Kate Monk', 1, 'cadb8df6773394d7d9b4d2f1223b22fd5d4e3474bb967d9bb0214d7f3100a601', 'BA.Test', '¶ë-”ÞË<Û+sÏ-ÂŒËÅ°ó`\0ãeIÜOác‰”'),
('MonkMiranda188', 'Miranda Monk', 1, '5b01e92f240a66d4896232577dee888dfadbd42f1eafc5f82341f7027fa98cbe', 'BA.Test', 'P¦\\[ËÏò\ZwO ãês Gsß~gµ¾°—\0äø'),
('MonkPaul182', 'Paul Monk', 1, '3dd9e45295ca483d75806228cf68cd500818135dd5bb151e183e7a1bdcf4a4dc', 'BA.Test', 'RV2l™Ì¶\Z¢ú ''žL ôÌuµÛJ2?GKg«ÆÃW+'),
('MonkSam78', 'Sam Monk', 1, '1514d6b985b070c054c8a40319651d2aae7749ff011ca4d10e59ef52be293561', 'BA.Test', 'Î\\òý! ±ë¥T©°1Sþl äÙãWîè'),
('MonkTim98', 'Tim Monk', 1, '9e667338675adeaf81e7edeb7ecdfa7bd543fed026dc25300adb20a8e48502d4', 'BA.Test', 'ú•9/ïÒhù2€JÌõn°•¾a\\XóJ64Òþ'),
('MonkZeus184', 'Zeus Monk', 1, '8aa30f259e9ebcf95077ccfc2ea36451e435fd6ac376a0ed116a1effdcca96de', 'BA.Test', 'H“•Såm0›T(Zwÿ¼ZØ”14"+\\\Z»Öý'),
('MurphyAmy200', 'Amy Murphy', 1, 'fa5cc68b2bf6a7549e141382801969569ed99546517b0ba28699a1f7f6c7ece9', 'BA.Test', '®ßºVtZ•Bj4£ ž?¨ïGÎœ{1‘BH*1«%ÙH'),
('MurphyBob79', 'Bob Murphy', 1, '3b377dbb432cb50e8f45e8814a0a86ddf89c03dbde67bc7e62fd6e6066df4e50', 'BA.Test', '‹H="á"Fkß7uÐ9LEëÔ€œ›°`—L\\²'),
('MurphyEmma159', 'Emma Murphy', 1, 'be5cf5dd8917bc5ef9fc0761c4799f38d83e35a8f7c0fe224a8fab538e609401', 'BA.Test', 'èœu\r°‹1(÷4ŠÅD¨‹õþûÖ‚Â\\¹Œ`'),
('MurphyGlenn138', 'Glenn Murphy', 1, 'fb9454c92f3b071ce22cd1cde0366915da357e105e15c748085d718c1f5f7b2a', 'BA.Test', '¦qƒ×0ùš‚‡³A™zfúcSb!¤ð%LçyjþuG\Z\r'),
('MurphyGlenn38', 'Glenn Murphy', 1, '9608ec66450e2dd77a28312d426c585a866eda0711c7382b7d8256dae39b3924', 'BA.Test', '¤,h¿ø&:A7ÏEÕ†K¾»—|W%n=~zIy‹d.…'),
('MurphyMiranda43', 'Miranda Murphy', 1, '4493584fec89a6c66e1fe062fa29f27099bfb3bbe808bfeac99c4dcb8d02acfc', 'BA.Test', 'MðEŒ4éåœ<ð F+èq"-6à—n¥¬2C§¡}'),
('MurphyRichard4', 'Richard Murphy', 1, 'bb8fe4a98ade359e44efc53601a37031f7bf3421e8ff55a768f170ff86850793', 'BA.Test', 'ÑHi\ZG)ÔbË3éx§r™§Gqû‹Ç»3¤Ç|Á6D'),
('MurphySam183', 'Sam Murphy', 1, '1a49081f748b23f5a3b5782b09c7642f43be6bf6e90a7458d45f2e085d275109', 'BA.Test', 'Hœ³Œ Îú•¾ÉL=¼›Ilƒ¡@Rå„=G6žOYÖ'),
('MurphySam190', 'Sam Murphy', 1, '12696a87c2ada7d364863f327144f3b16750c58a813f3244de929ee61b70e4af', 'BA.Test', '¹¾µ8ÖlÞVs(Êg²üe¢\\6þA°¾„²+tï¥'),
('MurphySandra2', 'Sandra Murphy', 1, '2da7ab0496bcf6408f56c168044af8c644ddf3ae73420f7ee7de1e40e25e6732', 'BA.Test', 'Í$™±‡-6²a±·Åì`D*Ç‰dW‹mQKµ}”'),
('SharpAmy90', 'Amy Sharp', 1, '19ae7f713e2276047ac4a018b0ace82b801b8c0257e79ddd5c505c09ece4ee3c', 'BA.Test', 'g‚Î''¹ƒß‘\r&2ÅØ¹î7u,;øâr5•§!C'),
('SharpBob139', 'Bob Sharp', 1, '46b5a4f7f51d41c30daceba205eaec4976e5995333b4997189134ad68a5d3490', 'BA.Test', '™çöö™«Ü’cföž‚œœÓØ¶P—P¾ÕhéµpÍw·´'),
('SharpBob82', 'Bob Sharp', 1, '1da38e0289d9163a508982812e4b858c7abd7de09fb7cdcfd720ddd0c9bcaafe', 'BA.Test', 'o²Ô{@TÔZT:IVPÜ ÇÂ~vÕ0· +ºÙ$ªCŽ'),
('SharpCormac74', 'Cormac Sharp', 1, 'b634b8c14617afc13c1e342e8155c605860e844f2b1d5ab93decfdf71510fe3c', 'BA.Test', 'i\r¶—^Tuwh^óüdîKÌ.ê9‰¿¡Ê>Ëš'),
('SharpCormac93', 'Cormac Sharp', 1, 'b61a34db591eb033cafb7622cae7fd01275940a2ba83ff512daae6bce4ee4d01', 'BA.Test', 'SÙ–þ¯KwTWƒ¿§(o’Z/\Z|.vn@öY^2'),
('SharpFiona195', 'Fiona Sharp', 1, '161d6a543748b141a838a51f06589e42bc85438be9baabe1344b44b267b135fd', 'BA.Test', '\rµ9§ÌY#÷Š!|ÑïB Ø''þs  |ýÿ\\/f?”'),
('SharpFiona27', 'Fiona Sharp', 1, '4d9e3a7ab97c55ed87d6852b02b5a37107cf2cfcff1ba6ad3d26957ace4faaa8', 'BA.Test', '²›Wo\Zs·X¯ë0  Ùï\r¯î¼wÌüí>`i÷Êõ'),
('SharpJudas111', 'Judas Sharp', 1, 'e7e580a81e9f0ecd1ddbe91630edd395d028a363c8ec286ea1a05992e53c40c3', 'BA.Test', '°ƒúÔ;ÇF\nÉè¢Üˆ5“þKÁg²b\0í‚9xÊ'),
('SharpKate55', 'Kate Sharp', 1, 'f436a7831023faae1888e568c41fdea9e67b82b53a4ec69e108c410aac9a2367', 'BA.Test', 'ö=³×ùª¥Jlš™µµçqÍÆî\0î«!03VZ^W'),
('SharpMiranda157', 'Miranda Sharp', 1, '9fe170a5dde1e024d23333aafa888c92ad4a0ba4b00d1ea230bcfcc14510330f', 'BA.Test', '$ý½Vá\r}"é”¯Å6 ¥gˆ",é…‡¦UîƒC'),
('SharpSam1', 'Sam Sharp', 1, '66de3ec16a49d972dc0d51230d582fed81d40a89ed03d2d63211a489c535c0a5', 'BA.Test', '™™šÉb†Q\0(EÙl}XlªJùz<1Ó,R„æ¼k'),
('SharpTim14', 'Tim Sharp', 1, 'b54f7baad68ac3ae00faa3142e3ee1ba32dcaa7742670689e00bf96f0be34176', 'BA.Test', 'ÝÙõ^-L®Dž¥û(n§òIçUƒl¥—f©Ã‘ˆ´'),
('SharpZeus60', 'Zeus Sharp', 1, '4913bdc795b93263d2467e7c020f81b173734219cc1702c7579b16af33f4175b', 'BA.Test', 'ZÓ·ÑÎ±ÔÌú²ò ìe‹h]vÎ<¦ZøÿcËåæŸ3'),
('StalinFiona10', 'Fiona Stalin', 1, 'ed3abf0f06133f5d83b1f154244609afc8257bd58b88adb8a785fca8ddfb4fea', 'BA.Test', '´q;Â†!ZYþ¼©P¶)jÐéØçn÷¤°¢8Ö'),
('StalinJack99', 'Jack Stalin', 1, '6583d71aca1fb5c9e74ac4793280ca16b3765af48ea9553d3f4671cf18d6f651', 'BA.Test', '®í¾…Ç¾+äwéFdì˜¹¥M‚ÖAßžÈŒ–Á×X'),
('StalinMary66', 'Mary Stalin', 1, '81b7620560365f01607ee511b69465c05dbf879dc6c595a4b7e56c98e17600d7', 'BA.Test', 'v†ì:-\n"ÿ3ìNÈm¨Òëu¾ËµžŠÛQ9÷'),
('StalinMiranda106', 'Miranda Stalin', 1, 'ecf5298c6ed2f3b6cb2c9e346818fb0b84e9f5d4b6f2defb9bbd4fcac16304e0', 'BA.Test', 'ñ¿aðãFÁ:ja\Z)Wç^$>„Èržu³|U®=ã'),
('StalinMiranda143', 'Miranda Stalin', 1, '27f0205dc49a6b6df3c634afbf2839e3ea07bfae1a3ce58f6cf6611d09678a9e', 'BA.Test', 'xÅ>´kïß¡sZbA¯ê”ö³»ûï–$ó{i›I[÷'),
('StalinPaul83', 'Paul Stalin', 1, 'e44b7e7deb5ede42b92cbe37f41818b0ff252cb64a3d29fc65e06103319087ac', 'BA.Test', '°¤Kg$ÜM@''}.._ÇÌN“rKt{uIÆ'),
('StalinSam18', 'Sam Stalin', 1, '7a739f2c7db87dc8e45e2b0ed22f1261523af20726adc2af815dac7c9f27df73', 'BA.Test', '\\“¯Äˆë¶CÙ=©Év¨–³&k})©³#X'),
('StalinSam85', 'Sam Stalin', 1, 'd959f5af67b27d89b0d8c813b43d911515a88d74bd3e1ec345de8d3469ed07dc', 'BA.Test', 'Ûµ5lœ~C¬c Á4“n4#,e\rÒ¯äÊ¥8î1'),
('StallmanCormac133', 'Cormac Stallman', 1, '204af85fa842c9008b373f6c3754fabdfdb5d8aff50961fae4f2a5db5d308f80', 'BA.Test', '&Lä\nüû¼I¤íÕ}sý×˜œÞLo,ü†¿LR>½ó'),
('StallmanKate145', 'Kate Stallman', 1, 'e841615f54655728e7e1e40cb459a2ce54c3797f726653e003c15adfa5e1480e', 'BA.Test', '¯y''|-u  q¥Ëmöâ‚-yBmQ-ðrdVç''½ã'),
('StallmanKate47', 'Kate Stallman', 1, 'f64efa2840de666a8407d3b62bac7b7393448a48183fe561ba9d915a57791974', 'BA.Test', 'ažÍÃaúd§j¬¶a‡ÒhÒ)2ÀUØLÔC}®Ö'),
('StallmanMary65', 'Mary Stallman', 1, '17aaab01fb75616285b6253e21f96a551e0f5ebbbf09714637b72c4767d293ee', 'BA.Test', '±MÑæUz½xÀ_/¥È0R¯Â[Ø3‹îDU#'),
('StallmanMiranda119', 'Miranda Stallman', 1, '1c3d6c6dac71b80666b3d2f2536458eb99b540a734361d0c681021e038f6d700', 'BA.Test', 'µ…ó”ÂÆ&]®Â îlQ7M4ÅpI41èÓ’}À'),
('StallmanMiranda44', 'Miranda Stallman', 1, '7b0c060c85db819edb702aea873935ba27b56c5319966e7c5c78e5b54be0a6ac', 'BA.Test', 'ONû}¡…˜R!¶êvx({Mh"¸wŽÄVP^*6g'),
('StallmanPaul22', 'Paul Stallman', 1, '6a15e90d0360b17181be20a94516d8988b0dcc100cef879354570b9a161cbbc3', 'BA.Test', 'O$š`¸ÀßFìœö."hýÏŽÀ÷AÈ‚L'''),
('StallmanRichard49', 'Richard Stallman', 1, '7ff8edc7c01c7f47c6d9811d2f110aa6ed3dc4382b4fb8e581b09aa98fac87aa', 'BA.Test', '72-Ñ8c”¨SŠ«Lâq"…{e»¼@G‘›»k5'),
('StallmanSam180', 'Sam Stallman', 1, 'a4612c2a6bba2b65dd7a1137c818f78bc5a719426568eac0ad8c67e6885036a9', 'BA.Test', 'Lþÿ\ZV\n˜  dÛ©uô¯ÕM¹™ÒŸ~Ä•&û'),
('StallmanTim17', 'Tim Stallman', 1, 'f35b6c81c864a08612d2384f854951d35eebc108cb349fd82a2492be6b595325', 'BA.Test', '¶pŽY €'' ›LXMå9ª;ýœØÉ.©ø\\~ÑW'),
('StallmanTim35', 'Tim Stallman', 1, 'c2106a9ebe0e6f1b2036ead617ec4632ea6e50157c51d725e444c091a6c7798c', 'BA.Test', 'Þj©‘öw@«Š>Ô¸lÚ"‘‰]Å{#î•0ü« µ'),
('StallmanTim86', 'Tim Stallman', 1, '8edbddc5337a5fedc390b8fabb540f4c391d0e26a4bb246d91f09d5ec7a34549', 'BA.Test', 'Aéè2BÙ€ÉbÁ”Žª/éBÜa<i_wÝ ³^‡@j'),
('TrotsyAmy187', 'Amy Trotsy', 1, '37f7cfca648984fffe8427e141ca2ff1adb98cd1b2bb7291950b4a22589c5fbc', 'BA.Test', 'Wá­Â¡Ð¨D÷A5Ù3=Š™#Ïûó¼¢õêYPÇIÎ'),
('TrotsyEmma103', 'Emma Trotsy', 1, 'ce72135571672011ee4f17505a3070a468dfbae69dab373eadf69ee1aa7b1f73', 'BA.Test', '×›4’ž}#¾²‹"Wì‡ðOÿüB\08ÿZ\0Ç'),
('TrotsyEmma144', 'Emma Trotsy', 1, 'cc19b69fd3e1622baa56517ae15e7a839727014320cade14b0f863e20a7100c2', 'BA.Test', 'ãö¯t+Ö…†ÚÈ––4^M''^Ã¡PÖL bÙñM'),
('TrotsyFiona135', 'Fiona Trotsy', 1, 'f6d29cac22424d5d5ac5b7749ab446e9ed3a37e486353e4781dada69aaf89743', 'BA.Test', 'Q3¬säXmò·D‡¶ö§à-Å¨ÝóóZG0q,7EÙ'),
('TrotsyFiona24', 'Fiona Trotsy', 1, 'da2d78da1ecb92aca3f055302707cae87beee12a1a8304050f5a6e119189888f', 'BA.Test', 'µã"árŽd>xrâKZ™XdÐuV(«|¢·¾'),
('TrotsyGlenn132', 'Glenn Trotsy', 1, '428f51d8acdbabc2376d9be02ab4959b7f6fc7afb3155dcddffa1d29912c5c45', 'BA.Test', '$zvÆ° ËNVÆuaQ+n¥$8Ç}]ïšA>ƒÙ¨J'),
('TrotsyMary58', 'Mary Trotsy', 1, '581757a174a5f18643ab35da6c6ce89e02b7e6d0cfad4b25a0767f9d3947bb0c', 'BA.Test', '.pµšÃ.ˆbfYÆQvÏ×¹\Zùìþ\Z»ì¡Cç‚'),
('TrotsyMiranda62', 'Miranda Trotsy', 1, '0006a16cc16995686f8e15945d42175f8e6c38aea7cf5ce5f541bbc63e7c100b', 'BA.Test', 'ºÏm¶g¾Ìs>;’&,`ÖóÊ˜Ø¿RºÊQíor>'),
('TrotsySam155', 'Sam Trotsy', 1, 'd9f1589277e1a4bad4100153e0a9b9a03d60b8429008db1bc0f52d4134ba3733', 'BA.Test', 'b.†ìk+dÙ\Z_ž\Zh  9oGÂÈsøNªõ-n'),
('TrotsyZeus134', 'Zeus Trotsy', 1, '48b0aa544359bd6c9bf9e6bf0ebff09227625b079f1fde1267d2a607b0a90683', 'BA.Test', '@qiOóøY~¥Ã=%‰=¸2C:ïáŸÅÚAš]j'),
('TrotsyZeus137', 'Zeus Trotsy', 1, '9bd7aa31d777765ea8036f6665d50a36f33fe9185200865b996582d2ec635726', 'BA.Test', '¥$8°ý~ö³G¨IS©\r®FJæÞêõ\0ûìæƒ');

-- --------------------------------------------------------

--
-- Table structure for table `user_groups`
--

CREATE TABLE `user_groups` (
  `user_id` varchar(64) NOT NULL,
  `group_id` int(11) NOT NULL,
  `owner` tinyint(1) NOT NULL COMMENT 'The person who created the group',
  PRIMARY KEY (`user_id`,`group_id`),
  KEY `group_id` (`group_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user_groups`
--

INSERT INTO `user_groups` (`user_id`, `group_id`, `owner`) VALUES
('BannerKate131', 3, 1),
('BannerKate131', 4, 1);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bookings`
--
ALTER TABLE `bookings`
  ADD CONSTRAINT `bookings_ibfk_10` FOREIGN KEY (`user`) REFERENCES `users` (`username`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `bookings_ibfk_8` FOREIGN KEY (`area`) REFERENCES `areas` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `bookings_ibfk_9` FOREIGN KEY (`room`) REFERENCES `rooms` (`number`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `rooms`
--
ALTER TABLE `rooms`
  ADD CONSTRAINT `rooms_ibfk_1` FOREIGN KEY (`area_number`) REFERENCES `areas` (`ID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `user_groups`
--
ALTER TABLE `user_groups`
  ADD CONSTRAINT `user_groups_ibfk_1` FOREIGN KEY (`group_id`) REFERENCES `groups` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `user_groups_ibfk_2` FOREIGN KEY (`user_id`) REFERENCES `users` (`username`) ON DELETE NO ACTION ON UPDATE NO ACTION;
