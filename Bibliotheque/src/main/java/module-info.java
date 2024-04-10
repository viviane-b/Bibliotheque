module com.bibliotheque.bibliotheque {
    requires javafx.controls;
    requires javafx.fxml;
    requires java.sql;


    opens com.bibliotheque.bibliotheque to javafx.fxml;
    exports com.bibliotheque.bibliotheque;
}