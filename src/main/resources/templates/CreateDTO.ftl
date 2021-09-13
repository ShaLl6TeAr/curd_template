package ${packageName}.dto;
<#if (model?exists && (type = 'add' || type = 'update'))>

import ${modelPath}${module}.entity.${Model};
</#if>

public class ${Name}DTO {

<#if (type = 'add' || type = 'update')>
    <#if model?exists>
        <#if columnList?exists>
            <#list columnList as column>
                <#if column.field != 'deleteTime'
                && column.field != 'deleteFlag'
                && column.field != 'createTime'
                && column.field != 'creator'
                && column.field != 'updateTime'>
                    <#if !(column.field = 'id' && type = 'add')>
    private ${column.type} ${column.field};

                    </#if>
                </#if>
            </#list>
        </#if>
    </#if>
<#elseIf (type = 'get' || type = 'del')>
    private String ${name}Id;

    public void set${Model}Id(String ${name}Id) {
        this.${name}Id = ${name}Id;
    }

    public String get${Name}Id() {
        return this.${name}Id;
    }

</#if>
<#if (type = 'update')>
    public void update${Model}(${Model} ${model}) {
    <#if model?exists>
        <#if columnList?exists>
            <#list columnList as column>
                <#if column.field != 'deleteTime'
                && column.field != 'deleteFlag'
                && column.field != 'createTime'
                && column.field != 'creator'
                && column.field != 'updateTime'>
        ${model}.set${column.field?capFirst}(this.${column.field});
                </#if>
            </#list>
        </#if>
    </#if>
    }

</#if>
<#if (type = 'add')>
    public ${Model} init${Model}() {
        ${Model} ${model} = new ${Model}();
    <#if model?exists>
        <#if columnList?exists>
            <#list columnList as column>
                <#if column.field != 'deleteTime'
                    && column.field != 'deleteFlag'
                    && column.field != 'createTime'
                    && column.field != 'creator'
                    && column.field != 'updateTime'>
                    <#if !(column.field = 'id' && type = 'add')>
        ${model}.set${column.field?capFirst}(this.${column.field});
                    </#if>
                </#if>
            </#list>
        </#if>
    </#if>
        return ${model};
    }

</#if>
<#if (type = 'add' || type = 'update')>
    <#if model?exists>
        <#if columnList?exists>
            <#list columnList as column>
                <#if column.field != 'deleteTime'
                && column.field != 'deleteFlag'
                && column.field != 'createTime'
                && column.field != 'creator'
                && column.field != 'updateTime'>
                    <#if !(column.field = 'id' && type = 'add')>
    public ${column.type} get${column.field?capFirst}() {
        return this.${column.field};
    }

    public void set${column.field?capFirst}(${column.type} ${column.field}) {
        this.${column.field} = ${column.field};
    }

                    </#if>
                </#if>
            </#list>
        </#if>
    </#if>
</#if>
}