package ${packageName}.dto;

public class ${Name}DTO {

    <#if (type = 'get' || type = 'del' || type = 'update')>
    private String id;

    public void setId(String id) {
        this.id = id;
    }

    public String getId() {
        return this.id;
    }
    </#if>

}