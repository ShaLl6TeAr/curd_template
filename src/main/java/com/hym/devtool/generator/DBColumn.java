package com.hym.devtool.generator;

public class DBColumn {

    /** 数据库字段名称 **/
    private String name;
    /** 数据库字段类型 **/
    private String type;
    /** 数据库字段首字母小写且去掉下划线字符串 **/
    private String field;
    /** 数据库字段注释 **/
    private String comment;

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        String javaType;
        switch (type.toLowerCase()) {
            case "int":
            case "tinyint":
            case "smallint":
                javaType = "Integer";
                break;
            case "bigint":
                javaType = "BigDecimal";
                break;
            case "datetime":
                javaType ="LocalDateTime";
                break;
            case "date":
                javaType = "LocalDate";
                break;
            case "time":
                javaType = "LocalTime";
                break;
            case "double":
                javaType = "Double";
                break;
            case "float":
                javaType = "Float";
                break;
            case "bit":
            case "bool":
                javaType = "Boolean";
                break;
            case "varchar":
            case "test":
            default:
                javaType = "String";
        }
        this.type = javaType;
    }

    public String getField() {
        return field;
    }

    public void setField(String field) {
        this.field = field;
    }
}