SELECT F.NOMFOURNISSEUR
FROM PRODUIT P , Referencer R, Fournisseur F
WHERE libelleProduit ='AMD Ryzen 7 9800X3D 4,7/5,2 GHz'
AND R.idProduit = P.idProduit
AND F.idFournisseur = R.idFournisseur;


SELECT P.idProduit, P.libelleProduit, SUM(CO.quantite) AS quantiteTotale
FROM Commande C, Contenir CO, Produit P
WHERE C.idClient = '2458'
AND C.uneDate >= '01/01/2024' AND C.uneDate <= '31/12/2024'
AND C.idCommande = CO.idCommande
AND CO.idProduit = P.idProduit
GROUP BY P.idProduit, P.libelleProduit
ORDER BY P.idProduit;


SELECT libelleMarque
FROM Marque
ORDER BY libelleMarque ASC;


SELECT AVG(P.prixHT) AS prixHTMoyen
FROM Produit P, CategorieProduit C
WHERE P.idCategorieProduits = C.idCategorieProduits
AND C.libelleCategorieProduit = 'processeurs';


SELECT nomCommune
FROM Ville
WHERE codePostal = 81100
ORDER BY nomCommune ASC;


SELECT DISTINCT IM.urlImageProduit, I.positionImage
FROM Produit P, Illustrer I, ImagesProduits IM
WHERE P.idProduit = I.idProduit
AND I.idImage = IM.idImage
AND P.libelleProduit = 'AMD Ryzen 7 9800X3D 4,7/5,2 GHz'
ORDER BY I.positionImage ASC;


-- Donner la liste des produits dont le prix HT est inférieur à 500€
SELECT libelleProduit, prixHT
FROM Produit
WHERE prixHT < 500;

-- Donner la liste des client qui ont une adresse a Castres 
SELECT DISTINCT nomClient, prenomClient
FROM Client C, Adresse A, Ville V
WHERE C.idClient = A.idClient
AND A.idVille = V.idVille
AND V.nomCommune = 'Castres';
