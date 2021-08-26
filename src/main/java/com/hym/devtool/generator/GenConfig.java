package com.hym.devtool.generator;

import lombok.Getter;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

@ConfigurationProperties(prefix = "generate")
@Component
@Getter
public class GenConfig {

    private static String packagePrefix;
    private static String diskPath;
    private static String pageListPath;
    private static String apiResultPath;

    public void setPackagePrefix(String packagePrefix) {
        if (GenConfig.packagePrefix != null) {
            return;
        }
        GenConfig.packagePrefix = packagePrefix;
    }

    public void setDiskPath(String diskPath) {
        if (GenConfig.diskPath != null) {
            return;
        }
        GenConfig.diskPath = diskPath;
    }

    public void setPageListPath(String pageListPath) {
        if (GenConfig.pageListPath != null) {
            return;
        }
        GenConfig.pageListPath = pageListPath;
    }

    public void setApiResultPath(String apiResultPath) {
        if (GenConfig.apiResultPath != null) {
            return;
        }
        GenConfig.apiResultPath = apiResultPath;
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
}
