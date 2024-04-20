package com.bibliotheque.bibliotheque;

import javafx.application.Application;
import javafx.fxml.FXMLLoader;
import javafx.geometry.Pos;
import javafx.scene.Scene;
import javafx.scene.control.Button;
import javafx.scene.control.TextArea;
import javafx.scene.layout.HBox;
import javafx.scene.layout.VBox;
import javafx.scene.shape.Line;
import javafx.scene.text.Font;
import javafx.scene.text.Text;
import javafx.stage.Stage;
import java.sql.*;

import java.io.IOException;

import static java.lang.System.exit;

public class HelloApplication extends Application {
    @Override
    public void start(Stage stage) throws IOException {
        var titr = new Text("Bibliothèque");
        titr.setFont(Font.font(35));

        Button b1 = new Button("Question 1");
        Button b2 = new Button("Question 2");
        Button b3 = new Button("Question 3");
        Button b4 = new Button("Question 4");

        var aonhsant = new TextArea("haawa");


        VBox qqqq = new VBox(b1, b2, b3, b4);
        var tooo = new HBox(qqqq, aonhsant);
        var truc = new VBox(titr, tooo);
        truc.setAlignment(Pos.CENTER);



        Scene scene = new Scene(truc, 800, 600);
        stage.setTitle("Bibliothèque");
        stage.setScene(scene);
        stage.show();
    }

    public static void main(String[] args) {
        System.out.println("Hello world!");
        launch(args);
        exit(0);
    }
}