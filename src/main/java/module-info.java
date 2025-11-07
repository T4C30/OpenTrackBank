module org.taulyd.otb {
    requires javafx.controls;
    requires javafx.fxml;
    requires javafx.base;
    requires javafx.graphics;
    requires com.fasterxml.jackson.annotation;
    requires com.fasterxml.jackson.core;
    requires com.fasterxml.jackson.databind;

    requires java.net.http;

    opens org.taulyd.otb to javafx.fxml, javafx.base, javafx.controls,javafx.graphics;
    //opens org.taulyd.otb.database to com.fasterxml.jackson.annotation, com.fasterxml.jackson.core, com.fasterxml.jackson.databind;
    //opens org.taulyd.otb.fronted to javafx.fxml, javafx.base, javafx.controls,javafx.graphics;

    exports org.taulyd.otb;
    //exports org.taulyd.otb.database to com.fasterxml.jackson.annotation, com.fasterxml.jackson.core, com.fasterxml.jackson.databind;
    //exports org.taulyd.otb.fronted to javafx.fxml, javafx.base, javafx.controls,javafx.graphics;
}
