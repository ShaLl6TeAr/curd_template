package ${packageName}.dto;
<#if (model?exists && (type = 'add' || type = 'update' || type = 'batchAdd'))>

import ${modelPath}${module}.entity.${Model};
</#if>
<#if (type = 'update' || type = 'get' || type = 'del')>

import javax.validation.constraints.NotNull;
</#if>
<#if (type = 'batchAdd')>

import java.util.List;
import java.util.stream.Collectors;
</#if>

<#if (type = 'list')>
import ${PageList};

public class ${Name}DTO extends PageList {
<#else>
public class ${Name}DTO {
</#if>

<#if (type = 'batchAdd')>
    private List${"\l"}Add${Model}DTO${"\g"} ${model}List;

</#if>
<#if (type = 'add' || type = 'update' || type = 'find' || type = 'list')>
    <#if model?exists>
        <#if columnList?exists>
            <#list columnList as column>
                <#if column.field != 'deleteTime'
                && column.field != 'deleteFlag'
                && column.field != 'createTime'
                && column.field != 'creator'
                && column.field != 'updateTime'>
                    <#if !(column.field = 'id' && type = 'add')>
                    <#if (column.field = 'id' && type = 'update' && type = 'get' && type = 'del')>
    @NotNull
                    </#if>
    // ${column.comment}
    private ${column.type} ${column.field};

                    </#if>
                </#if>
            </#list>
        </#if>
    </#if>
<#elseIf (type = 'get' || type = 'del')>
    @NotNull
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
<#if (type = 'batchAdd')>
    public List<${Model}> init${Model}List() {
        return this.${model}List.stream().map(Add${Model}DTO::init${Model}).collect(Collectors.toList());
    }

    public void set${Model}List(List${"\l"}Add${Model}DTO${"\g"} ${model}List) {
        this.${model}List = ${model}List;
    }
</#if>
<#if (type = 'add' || type = 'update' || type = 'list' || type = 'find')>
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