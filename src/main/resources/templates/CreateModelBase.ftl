package ${modelPath}${module}.entity;

import java.time.LocalDateTime;

public class ${Model}Base {

<#if columnList?exists>
    <#list columnList as column>
    // ${column.comment}
    protected ${column.type} ${column.field};

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