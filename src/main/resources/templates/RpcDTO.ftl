package ${packageName}.dto;

public class ${Name}DTO {

    <#if (type = 'get' || type = 'del' || type = 'update') || type = 'find'>
    private String ${name}Id;

    public void set${Name}Id(String ${name}Id) {
        this.${name}Id = ${name}Id;
    }

    public String get${Name}Id() {
        return this.${name}Id;
    }
    </#if>

}