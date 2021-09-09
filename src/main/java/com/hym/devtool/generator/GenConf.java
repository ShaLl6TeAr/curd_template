package com.hym.devtool.generator;

import lombok.Data;

@Data
public class GenConf {

    private String name;
    private String suffix;
    private String createTemplateName;
    private String addTemplateName;
    private String type;
    private Integer genAddType;

    public GenConf(String name, String suffix, String createTemplateName, String addTemplateName, String type, Integer genAddType) {
        this.name = name;
        this.suffix = suffix;
        this.createTemplateName = createTemplateName;
        this.addTemplateName = addTemplateName;
        this.type = type;
        this.genAddType = genAddType;
    }
}
