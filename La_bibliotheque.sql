begin transaction;

drop schema if exists bibliotheque  cascade;
create schema bibliotheque;
set search_path to bibliotheque;

create type typeGenre as enum ('Roman policier', 'Science-fiction', 'Fantastique', 'Thriller', 'Romance', 'Fiction historique', 'Littérature classique', 'Biographie', 'Essai', 'Littérature jeunesse');
create type typeStatut as enum('Honorée', 'Annulée', 'En cours');
create type typeStatutEmprunt as enum ('En cours', 'Retourné', 'En retard');

create table Livre (
	ISBN varchar(13) not null,
	titre varchar(50) not null,
	anneePub int,
	edition varchar(50),
	langue varchar(20),
	genre typeGenre,
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
	noTel int not null,
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

insert into Livre values 
	('7839567285016', 'Fondation', 1954, 'Larousse', 'Francais', 'Science-fiction'),
	('6545654565555', 'La vie devant soi', 1971, 'Larousse', 'Francais', 'Drame'),
	('5555555555555', 'La Comédie Humaine', 1842, 'folio', 'Francais', 'Comédie'),
	('1232123212321', 'Mario et la Brosse', 1982, 'Dupuis', 'Japonais', 'Fiction historique'),
	('6787678767876', '1984', 1984, 'folio', 'Anglais', 'Essai')
	('1111111111111', 'LÉtranger', 1942, 'Gallimard', 'Francais', 'Litterature classique'),
    ('2222222222222', 'Le Père Goriot', 1835, 'Larousse', 'Francais', 'Fiction  historique'),
    ('3333333333333', 'Les Aventures dArthur Gordon Pym', 1838, 'Penguin', 'Francais', 'Thriller'),
    ('4444444444444', 'Soumission', 2015, 'Flammarion', 'Francais', 'Science-fiction'),
    ('5555555555555', 'La Divine Comédie', 1320, 'Folio', 'Italien', 'Poésie');
	
-- Auteur(AuteurID, Prénom, Nom, Nationalité, DateNaissance)
insert into Auteur values
	(1, 'Albert', 'Camus', 'Francais', '1913-11-07' ),
	(2, 'de Balzac', 'Honoré', 'Français', '1799-05-20'),
	(3, 'Allan Poe', 'Edgar', 'Americain', '1809-01-19'),
	(4, 'Houellebecq', 'Michel', 'Francais', '1956-02-26'),
	(5, 'Gary', 'Romain', 'Russe', '1914-05-21'),
	(6, 'Ajar', 'Émile', 'Francais', '1914-05-21'),
	(7, 'Asimov', 'Isaac', 'American', '1920-01-02'),
	(8, 'Kurosaka', 'Bob', 'Japonais', '1953-06-30'),
	(9, 'Orwell', 'George', 'Anglais', '1903-06-25'),
	(10, 'Druon', 'Maurice', 'Francais', '1918-04-23');
	
-- Écrit(#ISBN, #AuteurID)
insert into Ecrit values
	
	
	
