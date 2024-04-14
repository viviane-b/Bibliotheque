package com.bibliotheque.bibliotheque;
import java.sql.*;
import java.util.Properties;


public class TestConnexion {
    public static void main(String[] args) {

        String dbUrl = "jdbc:postgresql://localhost:5432/La_bibliotheque";
        String username = "postgres";
        String password = "Data45wer!";


        try {
            Connection connection = DriverManager.getConnection(dbUrl, username, password);
            if (connection != null) {
                System.out.println("connection established");
            }

            String setSchema = "Set search_path to bibliotheque";
            String select1 = "Select * from livre";
            Statement statement = connection.createStatement();
            statement.execute(setSchema);
            ResultSet result = statement.executeQuery(select1);

            System.out.println("\n ISBN et noms des livres:");
            while (result.next()) {
                String ISBN = result.getString("ISBN");
                String titre = result.getString("titre");
                int anneePub = result.getInt("anneePub");
                String edition = result.getString("edition");
                String langue = result.getString("langue");
                String genre = result.getString("genre");

                System.out.println(ISBN + " " + titre);
            }

            System.out.println(" \n Copies disponibles:");
            String viewLivreDispo = "select * from LivreDispo";
            ResultSet livreDispo = connection.createStatement().executeQuery(viewLivreDispo);

            while (livreDispo.next()) {
                String ISBN = livreDispo.getString("ISBN");
                int copiesDispo = livreDispo.getInt("copiesDispo");

                System.out.println(ISBN + " " + copiesDispo);
            }



            connection.close();

        } catch (SQLException e) {
            e.printStackTrace();
        }



    }
}

// https://www.youtube.com/watch?v=OLmAZmBSwMo&ab_channel=CodeJava