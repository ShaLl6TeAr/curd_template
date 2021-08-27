package com.hym.devtool.generator;

import lombok.Data;

@Data
public class Fun {

    private String suffix;
    private String templateName;
    private String type;

    public Fun(String suffix, String templateName, String type) {
        this.suffix = suffix;
        this.templateName = templateName;
        this.type = type;
    }
}
