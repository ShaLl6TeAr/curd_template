package com.hym.devtool.generator;

import lombok.Getter;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

@ConfigurationProperties(prefix = "generate")
@Component
@Getter
public class GenProperties {

    private static String packagePrefix;
    private static String diskPath;
    private static String pageListPath;
    private static String apiResultPath;
    private static String testUtilPath;
    private static String servicePath;
    private static String daoPath;
    private static String testPath;

    private static String mainClass;
    private static String springPropertiesActive;

    public void setPackagePrefix(String packagePrefix) {
        if (GenProperties.packagePrefix != null) {
            return;
        }
        GenProperties.packagePrefix = packagePrefix;
    }

    public void setDiskPath(String diskPath) {
        if (GenProperties.diskPath != null) {
            return;
        }
        GenProperties.diskPath = diskPath;
    }

    public void setPageListPath(String pageListPath) {
        if (GenProperties.pageListPath != null) {
            return;
        }
        GenProperties.pageListPath = pageListPath;
    }

    public void setApiResultPath(String apiResultPath) {
        if (GenProperties.apiResultPath != null) {
            return;
        }
        GenProperties.apiResultPath = apiResultPath;
    }

    public void setServicePath(String servicePath) {
        if (GenProperties.servicePath != null) {
            return;
        }
        GenProperties.servicePath = servicePath;
    }

    public static void setDaoPath(String daoPath) {
        if (GenProperties.daoPath != null) {
            return;
        }
        GenProperties.daoPath = daoPath;
    }

    public void setTestUtilPath(String testUtilPath) {
        GenProperties.testUtilPath = testUtilPath;
    }

    public void setTestPath(String testPath) {
        GenProperties.testPath = testPath;
    }

    public void setMainClass(String mainClass) {
        GenProperties.mainClass = mainClass;
    }

    public void setSpringPropertiesActive(String springPropertiesActive) {
        GenProperties.springPropertiesActive = springPropertiesActive;
    }

    public static String getPackagePrefix() {
        return packagePrefix;
    }

    public static String getDiskPath() {
        return diskPath;
    }

    public static String getPageListPath() {
        return pageListPath;
    }

    public static String getApiResultPath() {
        return apiResultPath;
    }

    public static String getServicePath() {
        return servicePath;
    }

    public static String getDaoPath() {
        return daoPath;
    }

    public static String getMainClass() {
        return mainClass;
    }

    public static String getSpringPropertiesActive() {
        return springPropertiesActive;
    }

    public static String getTestUtilPath() {
        return testUtilPath;
    }

    public static String getTestPath() {
        return testPath;
    }
}
