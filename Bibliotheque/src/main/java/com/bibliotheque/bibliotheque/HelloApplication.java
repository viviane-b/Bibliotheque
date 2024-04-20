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

        var text = new TextArea();
        text.setEditable(false);

        b1.setOnAction(x -> {
            text.setText(q1Requete());
        });
        b2.setOnAction(x -> {
            text.setText(q2Requete());
        });
        b3.setOnAction(x -> {
            text.setText(q3Requete());
        });
        b4.setOnAction(x -> {
            text.setText(q4Requete());
        });




        VBox qqqq = new VBox(b1, b2, b3, b4);
        qqqq.setAlignment(Pos.CENTER);
        qqqq.setSpacing(10);
        var tooo = new HBox(qqqq, text);
        tooo.setAlignment(Pos.CENTER);
        tooo.setSpacing(10);
        var truc = new VBox(titr, tooo);
        truc.setAlignment(Pos.CENTER);



        Scene scene = new Scene(truc, 600, 300);
        stage.setTitle("Bibliothèque");
        stage.setScene(scene);
        stage.show();
    }

    public static void main(String[] args) {
        System.out.println("Hello world!");
        launch(args);
        exit(0);
    }

    private String q1Requete() {
        return null;
    }
    private String q2Requete() {
        return null;
    }
    private String q3Requete() {
        return null;
    }
    private String q4Requete() {
        return null;
    }

}