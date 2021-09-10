package ${packageName}.dto;

public class ${Name}DTO {

    <#if (type = 'get' || type = 'del' || type = 'update') || type = 'find'>
    private String ${name}Id;

    public void set${Model}Id(String ${name}Id) {
        this.${name}Id = ${name}Id;
    }

    public String get${Name}Id() {
        return this.${name}Id;
    }
    <#if (type = 'update')>

    public void update${Model}(${Model} ${model}) {
    }
    </#if>
    </#if>
    <#if (type = 'add')>

    public ${Model} init${Model}() {
        ${Model} ${model} = new ${Model}();
        return ${model};
    }
    </#if>
}