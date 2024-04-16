begin transaction;

drop schema if exists bibliotheque  cascade;
create schema bibliotheque;
set search_path to bibliotheque;

create type typeGenre as enum ('Roman policier', 'Science-fiction', 'Fantastique', 'Thriller', 'Romance', 'Fiction historique', 'Littérature classique', 'Biographie', 'Essai', 'Littérature jeunesse', 'Drame', 'Comédie', 'Poésie');
create type typeStatut as enum('Honorée', 'Annulée', 'En cours');
create type typeStatutEmprunt as enum ('En cours', 'Retourné', 'En retard');

create table Livre (
        ISBN varchar(13) not null,
        titre varchar(50) not null,
        anneePub int,
        edition varchar(50),
        langue varchar(20),
        genre typeGenre,
        nbCopies int,
        primary key (ISBN)
        );
        
create table Auteur(
        auteurID int not null,
        prenom varchar(20) not null,
        nom varchar(20) not null,
        nationalite varchar(20),
        date_naiss date,
        primary key (auteurID)
);

create table Ecrit(
        ISBN varchar(13) not null,
        auteurID int not null,
        primary key (ISBN, auteurID),
        foreign key (ISBN) references Livre(ISBN),
        foreign key (auteurID) references Auteur(auteurID)
);

create table Disponible(
        ISBN varchar(13) not null,
        noCopie int not null,
        booldisponible boolean not null,
        primary key (ISBN, noCopie),
        foreign key (ISBN) references Livre(ISBN)
);

create table Adresse(
        idAdresse int not null,
        noCivique int not null,
        rue varchar(30) not null,
        ville varchar(30) not null,
        codePostal varchar(6) not null,
        pays varchar(30) not null,
        primary key (idAdresse)
);

create table Adherent(
        noAdherent varchar(13) not null,
        prenom varchar(20) not null,
        nom varchar(20) not null,
        idAdresse int,
        nbLivreCommand int not null,
        noTel varchar(10) not null,
        primary key (noAdherent),
        foreign key (idAdresse) references Adresse(idAdresse)
);



create table Emprunt(
        idEmprunt int not null,
        ISBN varchar(13) not null,
        noCopie int not null,
        noAdherent varchar(13) not null,
        dateDebut date not null,
        dateFin date,
        statutEmprunt typeStatutEmprunt not null,
        primary key (idEmprunt),
        foreign key (ISBN, noCopie) references Disponible(ISBN, noCopie),
        foreign key (noAdherent) references Adherent(noAdherent)
);

create table Commande(
        idCommande int not null,
        ISBN varchar(13) not null,
        noCopie int not null,
        noAdherent varchar(13) not null,
        statut typeStatut not null,
        primary key (idCommande),
        foreign key (ISBN, noCopie) references Disponible(ISBN, noCopie),
        foreign key (noAdherent) references Adherent(noAdherent)
);

commit;

begin transaction;

--Livre(ISBN, Titre, Année_de_publication, Édition, Langue, #Genre)
insert into Livre values 
        ('7839567285016', 'Fondation', 1954, 'Larousse', 'Francais', 'Science-fiction', 2),
        ('6545654565555', 'La vie devant soi', 1971, 'Larousse', 'Francais', 'Drame', 1),
        ('7381983746272', 'La Comédie Humaine', 1842, 'folio', 'Francais', 'Comédie', 3),
        ('1232123212321', 'Mario et la Brosse', 1982, 'Dupuis', 'Japonais', 'Fiction historique', 1),
        ('6787678767876', '1984', 1984, 'folio', 'Anglais', 'Essai', 4),
        ('1111111111111', 'LÉtranger', 1942, 'Gallimard', 'Francais', 'Littérature classique', 2),
    ('2222222222222', 'Le Père Goriot', 1835, 'Larousse', 'Francais', 'Fiction historique', 1),
    ('3333333333333', 'Les Aventures dArthur Gordon Pym', 1838, 'Penguin', 'Francais', 'Thriller', 1),
    ('4444444444444', 'Soumission', 2015, 'Flammarion', 'Francais', 'Science-fiction', 2),
    ('5555555555555', 'La Divine Comédie', 1320, 'Folio', 'Italien', 'Poésie',1);
        
-- Auteur(AuteurID, Prénom, Nom, Nationalité, DateNaissance)
insert into Auteur values
        (1, 'Albert', 'Camus', 'Francais', '1913-11-07' ),
        (2, 'de Balzac', 'Honoré', 'Français', '1799-05-20'),
        (3, 'Allan Poe', 'Edgar', 'Americain', '1809-01-19'),
        (4, 'Houellebecq', 'Michel', 'Francais', '1956-02-26'),
        (5, 'Gary', 'Romain', 'Russe', '1914-05-21'),
        (6, 'Ajar', 'Émile', 'Francais', '1914-05-21'),
        (7, 'Asimov', 'Isaac', 'Americain', '1920-01-02'),
        (8, 'Kurosaka', 'Bob', 'Japonais', '1953-06-30'),
        (9, 'Orwell', 'George', 'Anglais', '1903-06-25'),
        (10, 'Druon', 'Maurice', 'Francais', '1918-04-23');
        
-- Écrit(#ISBN, #AuteurID)
insert into Ecrit values
        ('7839567285016', 7),
        ('6545654565555', 5),
        ('7381983746272', 2),
        ('1232123212321', 8),
        ('1232123212321', 10),
        ('6787678767876', 9),
        ('1111111111111', 1),
    ('2222222222222', 2),
    ('3333333333333', 3),
    ('4444444444444', 4),
    ('5555555555555', 8);


-- Disponible(#ISBN, NoCopie, disponible)
insert into Disponible values 
        ('7839567285016', 1, false),
        ('7839567285016', 2, true),
        ('6545654565555', 1, false),
        ('7381983746272', 1, false),
        ('7381983746272', 2, false),
        ('7381983746272', 3, false),
        ('1232123212321', 1, true),
        ('6787678767876', 1, false),
        ('6787678767876', 2, true),
        ('6787678767876', 3, true),
        ('6787678767876', 4, true),
        ('1111111111111', 1, false),
        ('1111111111111', 2, false),
    ('2222222222222', 1, false),
    ('3333333333333', 1, true),
    ('4444444444444', 1, false),
        ('4444444444444', 2, false),
    ('5555555555555', 1, true);

insert into Adresse values
        (1, 2284, 'Bellevue', 'Montréal', '0H0H0H', 'Canada'),
        (2, 2425, 'Crimson', 'Drummondville', 'H4R7T2', 'Canada'),
        (3, 1, 'Unité', 'Sydney', 'I1I1I1', 'Nouvelle-Zélande'),
        (4, 42, 'Réponse', 'Miami', '056273', 'États-Unis'),
        (5, 1600, 'Pennsylvania', 'Washington DC', '20500', 'États-Unis'),
        (6, 44, 'Sylviot', 'Montréal', 'H3J8L3', 'Canada'),
        (7, 50, 'Neutralité', 'Berne', 'CH1228', 'Suisse'),
        (8, 123321, 'Kayak', 'Montréal', 'H4H4H4', 'Canada'),
        (9, 1640, 'Riverside', 'Hill Valley', 'CAFADA', 'États-Unis'),
        (10, 124, 'Conch', 'Bikini Bottom', 'PACFIC', 'États-Unis'),
        (11, 909, 'Perle Noire', 'Zurich', 'BLKPRL', 'Suisse'),
        (12, 1, 'Bag-ends', 'Shire', 'MDLERT', 'Nouvelle-Zélande');

--Adhérent (NoAdhérent, Prénom, Nom, #idAdresse, nbLivreCommandé, noTéléphone)
insert into Adherent values 
        (1, 'Sparrow', 'Jack', 011, 2, '5147895134'),
        (2, 'Solo', 'Han', 02, 0, '4536829876'),
        (3, 'Brown', 'Emmett', 09, 3, '1112223333'),
        (4, 'Everdeen', 'Katniss', 04, 0, '6785436767'),
        (5, 'Chigurh', 'Anton', 05, 0, '7895671234'),
        (6, 'Balboa', 'Robert', 06, 1, '8673476925'),
        (7, 'Corleone', 'Vito', 07, 2, '6471433654'),
        (8, 'Poulain', 'Amélie', 08, 0, '5468249087'),
        (9, 'Finch', 'Atticus', 03, 1, '5268549023'),
        (10, 'Bateman', 'Patrick', 010, 2, '6471438945'),
        (11, 'Baggins', 'Bilbo', 012, 3, '8902749103'),
        (12, 'Gunderson', 'Marge', 01, 1, '8902738945');

insert into Emprunt values
        (1, '7839567285016', 1, 1, '2024-04-01', '2024-04-15', 'En cours'),
        (2, '1232123212321', 1, 3, '2024-04-02', '2024-04-16', 'Retourné'),
        (3, '2222222222222', 1, 6, '2024-04-03', '2024-04-17', 'En retard'),
        (4, '4444444444444', 2, 7, '2024-04-04', '2024-04-18','En cours'),
        (5, '6787678767876', 1, 9, '2024-04-05', '2024-04-19','En cours'),
        (6, '5555555555555', 1, 11, '2024-04-06', '2024-04-20','Retourné'),
        (7, '3333333333333', 1, 4, '2024-04-07', '2024-04-21', 'Retourné'),
        (8, '6545654565555', 1, 10, '2024-04-08', '2024-04-22','En cours'),
        (9, '1111111111111', 1, 5, '2024-04-09', '2024-04-23', 'En retard'),
        (10, '7381983746272', 1, 2, '2024-04-10', '2024-04-24', 'En retard'),
        (11, '4444444444444', 1, 1, '2024-04-11', '2024-04-25','En retard'),
        (12, '7381983746272', 2, 4, '2024-04-11', '2024-04-25', 'En cours'),
        (13, '7381983746272', 3, 7, '2024-04-11', '2024-04-25', 'En retard'),
        (14, '1111111111111', 2, 2, '2024-04-12', '2024-04-26', 'En cours');



insert into Commande values 
        (1, '1232123212321', 1, 4, 'En cours'),
        (2, '5555555555555', 1, 8, 'Honorée'),
        (3, '4444444444444', 2, 5, 'Honorée'),
        (4, '3333333333333', 1, 3, 'Honorée'),
        (5, '6545654565555', 1, 6, 'En cours'),
        (6, '1111111111111', 1, 2, 'Annulée'),
        (7, '7381983746272', 1, 9, 'En cours'),
        (8, '6787678767876', 2, 10, 'Honorée'),
        (9, '2222222222222', 1, 7, 'En cours'),
        (10, '7839567285016', 2, 1, 'Annulée');
        

        
commit; 

select * from livre;

-- Les titres et les auteurs de livres de science-fiction écrits par des auteurs américains 
WITH r1 AS (
  SELECT a.nom, a.prenom, e.ISBN 
  FROM (SELECT * FROM Auteur a WHERE a.nationalite = 'Americain') as a
  JOIN Ecrit e ON a.auteurID = e.auteurID
),
r2 AS (
  SELECT titre, ISBN 
  FROM Livre 
  WHERE genre = 'Science-fiction'
)
SELECT r2.titre, r1.prenom, r1.nom 
FROM r1 
JOIN r2 ON r1.ISBN = r2.ISBN;

-- Voir si un certain livre (ex: 1984) est disponible & le nombre de copies disponibles
WITH r1 AS (
        SELECT * FROM Livre l where l.titre = '1984'
),
r2 AS (
        SELECT * FROM Disponible d WHERE d.booldisponible = true
)
SELECT titre, count(NoCopie) as copies_dispo 
FROM (r1 JOIN r2 ON r1.ISBN = r2.ISBN)
GROUP BY titre;

-- Vues, fonctions & triggers
CREATE VIEW placerCommande AS 
        SELECT ISBN, noAdherent FROM Commande; 

-- Vue pour voir le nombre de copies dispo pour chaque ouvrage 
CREATE VIEW LivreDispo AS
SELECT Livre.ISBN, COALESCE(copiesDispo, 0) AS copiesDispo
FROM Livre
LEFT JOIN (
    SELECT ISBN, COUNT(noCopie) AS copiesDispo 
    FROM disponible 
    WHERE booldisponible = true
    GROUP BY ISBN
) AS available_copies ON Livre.ISBN = available_copies.ISBN;

-- Ce qui se passe lorsqu'on fait un emprunt
CREATE OR REPLACE FUNCTION emprunterLivre() 
        RETURNS TRIGGER AS
        $$BEGIN 
        -- mettre à false la copie empruntée du livre
        UPDATE disponible SET booldisponible = false 
                                                   WHERE (nocopie = NEW.nocopie AND isbn = NEW.isbn);
        RETURN NEW;
        END;
        $$ language plpgsql;

CREATE TRIGGER nouveau_emprunt
        BEFORE INSERT ON emprunt 
        FOR EACH ROW
        EXECUTE PROCEDURE emprunterLivre();

-- Ce qui se passe lorsqu'on fait un retour
CREATE OR REPLACE FUNCTION retour()
        RETURNS TRIGGER AS
        $$BEGIN 
        UPDATE disponible SET booldisponible = true 
                WHERE (noCopie = NEW.noCopie AND ISBN = NEW.ISBN);
        RETURN NEW;
        END;
        $$ language plpgsql;

CREATE TRIGGER update_emprunt
        BEFORE update ON emprunt 
        FOR EACH ROW
        EXECUTE PROCEDURE retour();

-- Ce qui se passe quand on ajoute un livre a la bibli
CREATE OR REPLACE FUNCTION nouveau_livre() 
    RETURNS TRIGGER AS $$
    DECLARE 
        i INT;
        nbCopies INT;
    BEGIN
        nbCopies := NEW.nbCopies;
        FOR i IN 1 .. nbCopies LOOP
            INSERT INTO disponible (isbn, nocopie, booldisponible)
            VALUES (NEW.ISBN, i, true);
        END LOOP;
        RETURN NEW;
    END;
$$ LANGUAGE plpgsql;
                

CREATE TRIGGER add_livre
        AFTER INSERT ON Livre 
        FOR EACH ROW
        EXECUTE PROCEDURE nouveau_livre();

-- Insertions pour tester triggers 
INSERT INTO Emprunt (idemprunt, isbn, nocopie, noadherent, datedebut, datefin, statutemprunt)
VALUES (15, '7839567285016', 2, 2, '2024-09-23', '2024-10-23', 'En cours' );

UPDATE emprunt SET statutEmprunt = 'Retourné' WHERE isbn = '4444444444444' AND noCopie = 1;

INSERT INTO Livre values ('6767676767676', 'Fondation', 1954, 'Larousse', 'Francais', 'Science-fiction', 2);

select * from disponible -- vérifier que les triggers ont marché 


