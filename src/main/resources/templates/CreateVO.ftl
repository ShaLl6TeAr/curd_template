package ${packageName}.vo;
<#if model?exists && (type = 'list' || type = 'get' || type = 'find' || type = 'batchAdd')>

import ${modelPath}${module}.entity.${Model};
</#if>
<#if (type = 'batchAdd')>

import ${modelPath}${module}.dto.${Model}DTO;
import java.util.stream.Collectors;

import java.util.List;
</#if>
import com.fasterxml.jackson.annotation.JsonFormat;
import java.time.LocalDateTime;

public class ${Name}VO {

<#switch type>
    <#case 'add'>
        private Integer addCount;

        private String id;

        public ${Name}VO(Integer count, String id) {
        this.addCount = count;
        this.id = id;
        }

        public Integer getAddCount() {
        return this.addCount;
        }

        public String getId() {
        return this.id;
        }
        <#break>
    <#case 'batchAdd'>
    private Integer addCount;

    private List${"\l"}String${"\g"} idList;

    public ${Name}VO(Integer count, List${"\l"}${Model}${"\g"} ${model}List) {
        this.addCount = count;
        this.idList = ${model}List.stream().map(${Model}::getId).collect(Collectors.toList());
    }

    public Integer getAddCount() {
        return this.addCount;
    }

    public List${"\l"}String${"\g"} getIdList() {
        return this.idList;
    }
    <#break>
    <#case 'update'>
    private Integer updateCount;

    private String id;

    public ${Name}VO(Integer count, String id) {
        this.updateCount = count;
        this.id = id;
    }

    public Integer getUpdateCount() {
        return this.updateCount;
    }

    public String getId() {
        return this.id;
    }
    <#break>
    <#case 'del'>
    private Integer delCount;

    private String id;

    public ${Name}VO(Integer count, String id) {
        this.delCount = count;
        this.id = id;
    }

    public Integer getDelCount() {
        return this.delCount;
    }

    public String getId() {
        return this.id;
    }
    <#break>
    <#case 'list'>
    <#case 'get'>
    <#case 'find'>
    <#if model?exists>
    <#if columnList?exists>
        <#list columnList as column>
        <#if column.field != 'deleteTime'
            && column.field != 'deleteFlag'>
    <#if (column.field = 'createTime' || column.field = 'updateTime')>
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+08:00")
    </#if>
    // ${column.comment}
    private ${column.type} ${column.field};

        </#if>
        </#list>
    </#if>
    public ${Name}VO(${Model} ${model}) {
    <#if columnList?exists>
        <#list columnList as column>
            <#if column.field != 'deleteTime'
            && column.field != 'deleteFlag'>
        this.${column.field} = ${model}.get${column.field?cap_first}();
            </#if>
        </#list>
    </#if>
    }
    <#if columnList?exists>
        <#list columnList as column>
            <#if column.field != 'deleteTime'
            && column.field != 'deleteFlag'>
    public ${column.type} get${column.field?cap_first}() {
        return this.${column.field};
    }

    public void set${column.field?cap_first}(${column.type} ${column.field}) {
        this.${column.field} = ${column.field};
    }

            </#if>
        </#list>
    </#if>
    </#if>
    <#break>
</#switch>

}
