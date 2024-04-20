package com.bibliotheque.bibliotheque;
import java.sql.*;
//import org.apache.ibatis.jdbc.ScriptRunner;
//import com.ibatis.common.jdbc.ScriptRunner;
//package org.apache.ibatis.jdbc;




public class BiblioConnexion {
    Connection connection;

    BiblioConnexion() {

        String dbUrl = "jdbc:postgresql://localhost:5432/La_bibliotheque";
        String username = "postgres";
        String password = "Data45wer!";

        //       ScriptRunner scriptRunner = new ScriptRunner;


        try {
            connection = DriverManager.getConnection(dbUrl, username, password);
            if (connection != null) {
                System.out.println("connection established \n");
            }

            String setSchema = "Set search_path to bibliotheque";
            String select1 = "Select * from livre";
            Statement statement = connection.createStatement();
            statement.execute(setSchema);
            ResultSet result = statement.executeQuery(select1);

            // System.out.println("\n ISBN et noms des livres:");
            while (result.next()) {
                String ISBN = result.getString("ISBN");
                String titre = result.getString("titre");
                int anneePub = result.getInt("anneePub");
                String edition = result.getString("edition");
                String langue = result.getString("langue");
                String genre = result.getString("genre");

                //    System.out.println(ISBN + " " + titre);
            }

            // System.out.println(" \n Copies disponibles:");
            String viewLivreDispo = "select * from LivreDispo";
            ResultSet livreDispo = connection.createStatement().executeQuery(viewLivreDispo);

            while (livreDispo.next()) {
                String ISBN = livreDispo.getString("ISBN");
                int copiesDispo = livreDispo.getInt("copiesDispo");

                //     System.out.println(ISBN + " " + copiesDispo);
            }

            connection.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }



    }

    public String q1Requete() {

        String result = new String();

        try {
            String viewSienceFiction = "select * from scienceFiction";
            ResultSet scienceFiction = connection.createStatement().executeQuery(viewSienceFiction);

            while (scienceFiction.next()) {
                String titre = scienceFiction.getString("Titre");
                String prenom = scienceFiction.getString("Prenom");
                String nom = scienceFiction.getString("Nom");

                result += titre +" " + prenom + " " +  nom + "\n";
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return result;
    }

    public String q2Requete() {
        String result = new String();

        try {
            String viewLivreDispo = "select * from livreDispo";
            ResultSet livreDispo = connection.createStatement().executeQuery(viewLivreDispo);

            while (livreDispo.next()) {
                String ISBN = livreDispo.getString("ISBN");
                int copiesDispo = livreDispo.getInt("copiesDispo");

                result += ISBN + " " + copiesDispo + "\n";
            } ;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    public String q3Requete() {
        String result = new String();
        try {
            String viewEmpruntRetard = "select * from empruntRetard_view";
            ResultSet empruntRetard = connection.createStatement().executeQuery(viewEmpruntRetard);

            while (empruntRetard.next()) {
                String titre = empruntRetard.getString("Titre");
                String nom = empruntRetard.getString("Nom");
                String prenom = empruntRetard.getString("Prenom");
                result += titre + " " + nom + " " +  prenom + "\n";
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }

    public String q4Requete() {
        String result = new String();
        try {
            String viewCommandesEnCours = "select * from commandesEnCours";
            ResultSet commandesEnCours = connection.createStatement().executeQuery(viewCommandesEnCours);

            while (commandesEnCours.next()) {
                String titre = commandesEnCours.getString("Titre");
                result += titre + "\n";
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }
        return result;
    }



}

// https://www.youtube.com/watch?v=OLmAZmBSwMo&ab_channel=CodeJava