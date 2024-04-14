-- Création d'une fonction qui met à jour, dans la relation disponibilité, l'attribut booldisponibilite
-- dès qu'on met à jour une valeur de l'attribut statutemprunt dans la relation emprunt

BEGIN TRANSACTION;

CREATE OR REPLACE FUNCTION update_disponibilite() RETURNS TRIGGER AS $$
BEGIN
	IF OLD.statutemprunt = 'En cours' AND NEW.statutemprunt = 'Retourné' THEN	
		UPDATE bibliotheque.disponible
		SET booldisponible = true
		WHERE ISBN = NEW.ISBN AND nocopie = NEW.nocopie;
		
	ELSIF OLD.statutemprunt = 'En retard' AND NEW.statutemprunt = 'Retourné' THEN	
		UPDATE bibliotheque.disponible
		SET booldisponible = true
		WHERE ISBN = NEW.ISBN AND nocopie = NEW.nocopie;
		
	ELSIF OLD.statutemprunt = 'Retourné' AND NEW.statutemprunt = 'En cours' THEN	
		UPDATE bibliotheque.disponible
		SET booldisponible = false
		WHERE ISBN = NEW.ISBN AND nocopie = NEW.nocopie;
		
	ELSIF OLD.statutemprunt = 'En cours' AND NEW.statutemprunt = 'En retard' THEN	
		UPDATE bibliotheque.disponible
		SET booldisponible = false
		WHERE ISBN = NEW.ISBN AND nocopie = NEW.nocopie;
	
	END IF;
	RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER after_update_statutemprunt
AFTER UPDATE OF statutemprunt ON bibliotheque.emprunt
FOR EACH ROW
WHEN (OLD.statutemprunt IS DISTINCT FROM NEW.statutemprunt)
EXECUTE FUNCTION update_disponibilite();

COMMIT;

-- Exemple de test pour voir les effets de update_disponibilite()
UPDATE bibliotheque.emprunt 
SET statutemprunt = 'Retourné'
WHERE idemprunt = '7';

select * from bibliotheque.disponible natural join bibliotheque.emprunt
