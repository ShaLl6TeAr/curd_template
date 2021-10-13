package ${modelPath}${module}.entity;

import java.time.LocalDateTime;

public class ${Model}Base {

    public static final String DB_TABLE_NAME = "${tableName}";
<#if columnList?exists>
    <#list columnList as column>
    public static final String DB_${column.name?upper_case} = "${column.name}";
    </#list>
</#if>
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
    public String toString() {
        return "{"
<#if columnList?exists>
    <#list columnList as column>
        + "${column.field}" + ": " + this.${column.field} + ", "
    </#list>
</#if>
        + "}";
    }
}