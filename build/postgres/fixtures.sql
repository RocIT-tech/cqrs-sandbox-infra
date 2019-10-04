-- TRUNCATE
TRUNCATE TABLE identity.user CASCADE;
TRUNCATE TABLE accommodation.accommodation_special_charges CASCADE;
TRUNCATE TABLE accommodation.tenant_accommodation CASCADE;
TRUNCATE TABLE accommodation.special_charges CASCADE;
TRUNCATE TABLE accommodation.accommodation CASCADE;
TRUNCATE TABLE accommodation.residence CASCADE;
TRUNCATE TABLE accommodation.tenant CASCADE;

-- INSERT
INSERT INTO identity.user (id, idp_id)
    VALUES
        ('c2ad97af-844d-4487-91ab-c4d29fba4abb', 'auth0|5d1b47d4114b3f0ebbaf3468')
;

INSERT INTO accommodation.tenant (id, name, address, identity_user_id)
    VALUES
        ('1', 'LAGRANGE Mathieu', '135 rue du Théatre, 75015 PARIS', NULL),
        ('2', 'MIRONNEAU Noémie', '135 rue du Théatre, 75015 PARIS', NULL),
        ('3', 'ROCHES Adrien', 'Château Le Tap, 24240 SAUSSIGNAC', 'c2ad97af-844d-4487-91ab-c4d29fba4abb'),
        ('4', 'LECOMTE Elodie', '22 avenue Gaston Cabanes, 33560 CARBON-BLANC', NULL),
        ('5', 'VERGE Michaël', '52 Rue Laennec, 33140 VILLENAVE D''ORNON', NULL),
        ('6', 'SCI LV INVEST', '13 Les Bournets, 33220 PINEUILH', NULL),
        ('7', 'DELFOSSE Gaël', '15 rue Edouard Branly, 33700 MERIGNAC', NULL),
        ('8', 'SCHUSTER Axel', 'AM Sägewerk 3, 40885 RATINGEN (Allemagne)', NULL),
        ('9', 'THEBAULT Raphaël', '6 Boulevard Jourdan, 75014 PARIS', NULL),
        ('10', 'SEILLERY Sophie', '13 Les Bournets, 33220 PINEUILH', NULL),
        ('11', 'THURIERE Aurélie', '1 allée des Platanes, 33600 PESSAC', NULL)
;

INSERT INTO accommodation.residence (id, address, owner_tenant_id, name, total_parts)
    VALUES
    ('c3d52944-7b4b-43e7-bcbe-5b95b275f75b', '22 avenue Gaston Cabanes, 33560 CARBON-BLANC', NULL, 'Le Clos d''Amélia', 10000);

INSERT INTO accommodation.accommodation (id, number, usage, proportional_parts, residence_id)
    VALUES
        ('1', 1, 'Villa', 480, 'c3d52944-7b4b-43e7-bcbe-5b95b275f75b'),
        ('2', 2, 'Villa', 494, 'c3d52944-7b4b-43e7-bcbe-5b95b275f75b'),
        ('3', 3, 'Villa', 675, 'c3d52944-7b4b-43e7-bcbe-5b95b275f75b'),
        ('4', 4, 'Villa', 675, 'c3d52944-7b4b-43e7-bcbe-5b95b275f75b'),
        ('5', 5, 'Villa', 681, 'c3d52944-7b4b-43e7-bcbe-5b95b275f75b'),
        ('6', 6, 'Villa', 748, 'c3d52944-7b4b-43e7-bcbe-5b95b275f75b'),
        ('7', 7, 'Villa', 468, 'c3d52944-7b4b-43e7-bcbe-5b95b275f75b'),
        ('8', 8, 'Villa', 472, 'c3d52944-7b4b-43e7-bcbe-5b95b275f75b'),
        ('9', 9, 'Villa', 674, 'c3d52944-7b4b-43e7-bcbe-5b95b275f75b'),
        ('10', 10, 'Villa', 674, 'c3d52944-7b4b-43e7-bcbe-5b95b275f75b'),
        ('11', 11, 'Villa', 674, 'c3d52944-7b4b-43e7-bcbe-5b95b275f75b'),
        ('12', 12, 'Villa', 674, 'c3d52944-7b4b-43e7-bcbe-5b95b275f75b'),
        ('13', 13, 'Villa', 681, 'c3d52944-7b4b-43e7-bcbe-5b95b275f75b'),
        ('14', 14, 'Villa', 674, 'c3d52944-7b4b-43e7-bcbe-5b95b275f75b'),
        ('15', 15, 'Villa', 716, 'c3d52944-7b4b-43e7-bcbe-5b95b275f75b'),
        ('16', 16, 'Parking', 18, 'c3d52944-7b4b-43e7-bcbe-5b95b275f75b'),
        ('17', 17, 'Parking', 18, 'c3d52944-7b4b-43e7-bcbe-5b95b275f75b'),
        ('18', 18, 'Parking', 18, 'c3d52944-7b4b-43e7-bcbe-5b95b275f75b'),
        ('19', 19, 'Parking', 18, 'c3d52944-7b4b-43e7-bcbe-5b95b275f75b'),
        ('20', 20, 'Parking', 18, 'c3d52944-7b4b-43e7-bcbe-5b95b275f75b'),
        ('21', 21, 'Parking', 18, 'c3d52944-7b4b-43e7-bcbe-5b95b275f75b'),
        ('22', 22, 'Parking', 18, 'c3d52944-7b4b-43e7-bcbe-5b95b275f75b'),
        ('23', 23, 'Parking', 18, 'c3d52944-7b4b-43e7-bcbe-5b95b275f75b'),
        ('24', 24, 'Parking', 18, 'c3d52944-7b4b-43e7-bcbe-5b95b275f75b'),
        ('25', 25, 'Parking', 18, 'c3d52944-7b4b-43e7-bcbe-5b95b275f75b'),
        ('26', 26, 'Parking', 18, 'c3d52944-7b4b-43e7-bcbe-5b95b275f75b'),
        ('27', 27, 'Parking', 18, 'c3d52944-7b4b-43e7-bcbe-5b95b275f75b'),
        ('28', 28, 'Parking', 18, 'c3d52944-7b4b-43e7-bcbe-5b95b275f75b'),
        ('29', 29, 'Parking', 18, 'c3d52944-7b4b-43e7-bcbe-5b95b275f75b'),
        ('30', 30, 'Parking', 18, 'c3d52944-7b4b-43e7-bcbe-5b95b275f75b'),
        ('31', 31, 'Parking', 18, 'c3d52944-7b4b-43e7-bcbe-5b95b275f75b'),
        ('32', 32, 'Parking', 18, 'c3d52944-7b4b-43e7-bcbe-5b95b275f75b'),
        ('33', 33, 'Parking', 18, 'c3d52944-7b4b-43e7-bcbe-5b95b275f75b'),
        ('34', 34, 'Parking', 18, 'c3d52944-7b4b-43e7-bcbe-5b95b275f75b'),
        ('35', 35, 'Parking', 18, 'c3d52944-7b4b-43e7-bcbe-5b95b275f75b'),
        ('36', 36, 'Parking', 18, 'c3d52944-7b4b-43e7-bcbe-5b95b275f75b'),
        ('37', 37, 'Parking', 18, 'c3d52944-7b4b-43e7-bcbe-5b95b275f75b'),
        ('38', 38, 'Parking', 18, 'c3d52944-7b4b-43e7-bcbe-5b95b275f75b'),
        ('39', 39, 'Parking', 18, 'c3d52944-7b4b-43e7-bcbe-5b95b275f75b'),
        ('40', 40, 'Parking', 18, 'c3d52944-7b4b-43e7-bcbe-5b95b275f75b'),
        ('41', 41, 'Parking', 18, 'c3d52944-7b4b-43e7-bcbe-5b95b275f75b'),
        ('42', 42, 'Parking', 18, 'c3d52944-7b4b-43e7-bcbe-5b95b275f75b'),
        ('43', 43, 'Parking', 18, 'c3d52944-7b4b-43e7-bcbe-5b95b275f75b'),
        ('44', 44, 'Parking', 18, 'c3d52944-7b4b-43e7-bcbe-5b95b275f75b'),
        ('45', 45, 'Parking', 18, 'c3d52944-7b4b-43e7-bcbe-5b95b275f75b')
;

INSERT INTO accommodation.tenant_accommodation (owner_id, accommodation_id)
    VALUES
        ('1', '1'),
        ('2', '2'),
        ('3', '3'),
        ('5', '4'),
        ('6', '5'),
        ('6', '6'),
        ('7', '7'),
        ('7', '8'),
        ('9', '9'),
        ('10', '10'),
        ('11', '11'),
        ('4', '12'),
        ('11', '13'),
        ('1', '14'),
        ('11', '15'),
        ('1', '16'),
        ('1', '17'),
        ('2', '18'),
        ('2', '19'),
        ('3', '20'),
        ('3', '21'),
        ('5', '22'),
        ('5', '23'),
        ('3', '24'),
        ('5', '25'),
        ('6', '26'),
        ('7', '27'),
        ('10', '28'),
        ('5', '29'),
        ('6', '30'),
        ('1', '31'),
        ('10', '32'),
        ('10', '33'),
        ('7', '34'),
        ('6', '35'),
        ('7', '36'),
        ('11', '37'),
        ('11', '38'),
        ('7', '39'),
        ('6', '40'),
        ('6', '41'),
        ('1', '42'),
        ('9', '43'),
        ('9', '44'),
        ('11', '45')
;

UPDATE accommodation.residence
SET
    owner_tenant_id = '1'
    WHERE
        id = 'c3d52944-7b4b-43e7-bcbe-5b95b275f75b';

INSERT INTO accommodation.special_charges (id, name, total_parts)
    VALUES
        ('c776ec2e-bbf8-44de-a141-2ff5aab56608', 'Bâtiment A', 10000),
        ('2', 'Bâtiment B', 10000),
        ('3', 'Parking', 30);

INSERT INTO accommodation.accommodation_special_charges (accommodation_id, special_charges_id, proportional_parts)
    VALUES
        ('1', 'c776ec2e-bbf8-44de-a141-2ff5aab56608', 1279),
        ('2', 'c776ec2e-bbf8-44de-a141-2ff5aab56608', 1316),
        ('3', 'c776ec2e-bbf8-44de-a141-2ff5aab56608', 1799),
        ('4', 'c776ec2e-bbf8-44de-a141-2ff5aab56608', 1799),
        ('5', 'c776ec2e-bbf8-44de-a141-2ff5aab56608', 1815),
        ('6', 'c776ec2e-bbf8-44de-a141-2ff5aab56608', 1992),
        ('7', '2', 820),
        ('8', '2', 827),
        ('9', '2', 1181),
        ('10', '2', 1181),
        ('11', '2', 1181),
        ('12', '2', 1181),
        ('13', '2', 1193),
        ('14', '2', 1181),
        ('15', '2', 1255),
        ('16', '3', 1),
        ('17', '3', 1),
        ('18', '3', 1),
        ('19', '3', 1),
        ('20', '3', 1),
        ('21', '3', 1),
        ('22', '3', 1),
        ('23', '3', 1),
        ('24', '3', 1),
        ('25', '3', 1),
        ('26', '3', 1),
        ('27', '3', 1),
        ('28', '3', 1),
        ('29', '3', 1),
        ('30', '3', 1),
        ('31', '3', 1),
        ('32', '3', 1),
        ('33', '3', 1),
        ('34', '3', 1),
        ('35', '3', 1),
        ('36', '3', 1),
        ('37', '3', 1),
        ('38', '3', 1),
        ('39', '3', 1),
        ('40', '3', 1),
        ('41', '3', 1),
        ('42', '3', 1),
        ('43', '3', 1),
        ('44', '3', 1),
        ('45', '3', 1);
