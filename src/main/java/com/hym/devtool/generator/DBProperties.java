package com.hym.devtool.generator;

import lombok.Getter;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

@ConfigurationProperties(prefix = "db")
@Component
@Getter
public class DBProperties {

    private static String driver;

    private static String url;

    private static String username;

    private static String password;

    public void setDriver(String driver) {
        DBProperties.driver = driver;
    }

    public void setUrl(String url) {
        DBProperties.url = url;
    }

    public void setUsername(String username) {
        DBProperties.username = username;
    }

    public void setPassword(String password) {
        DBProperties.password = password;
    }

    public static String getDriver() {
        return driver;
    }

    public static String getUrl() {
        return url;
    }

    public static String getUsername() {
        return username;
    }

    public static String getPassword() {
        return password;
    }
}
