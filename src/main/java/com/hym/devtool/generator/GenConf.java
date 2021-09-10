package com.hym.devtool.generator;

import lombok.Getter;

@Getter
public class GenConf {

    private final String name;
    private final String suffix;
    private final String createTemplateName;
    private final String addTemplateName;
    private final String type;
    private final Integer genType;

    private String filePath;

    public GenConf(String name, String suffix, String createTemplateName, String addTemplateName, String type, Integer genType) {
        this.name = name;
        this.suffix = suffix;
        this.createTemplateName = createTemplateName;
        this.addTemplateName = addTemplateName;
        this.type = type;
        this.genType = genType;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }
}
