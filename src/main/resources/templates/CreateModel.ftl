package ${modelPath}${module}.entity;

public class ${Model} {

<#if columnList?exists>
    <#list columnList as column>
    // ${column.comment}
    private ${column.type} ${column.field};

    </#list>
</#if>
<#if columnList?exists>
    <#list columnList as column>
    public ${column.type} get${column.field?cap_first}() {
        return this.${column.field};
    }

    public void set${column.field?cap_first}(${column.type} ${column.field}) {
        this.${column.field} = ${column.field};
    }

    </#list>
</#if>
}