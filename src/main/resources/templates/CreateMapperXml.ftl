<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "${"http://mybatis.org/dtd/mybatis-3-mapper.dtd"}" >
<mapper namespace="${daoPath}${module}.dao.${Model}DAO">

    <resultMap id="${Model}" type="${modelPath}${module}.entity.${Model}">
    <#if columnList?exists>
        <#list columnList as column>
            <#if (column.name = 'id' || column.name = 'c_id')>
        <id column="${column.name}" property="${column.field}" />
        <#else>
        <result column="${column.name}" property="${column.field}" />
            </#if>
        </#list>
    </#if>
    </resultMap>

    <sql id="selectAll">
        select
        <#if columnList?exists>
        <#list columnList as column>
        <#if (column.name = 'id' || column.name = 'c_id')>
            ${column.name}
        <#else>
            ,${column.name}
        </#if>
        </#list>
        </#if>
        from ${tableName}
    </sql>

    <sql id="insert">
        insert into ${tableName}
        (`create_time`, `update_time`, `delete_flag`
        <#list columnList as column>
            <#if (column.name != 'create_time' &&
            column.name != 'update_time' &&
            column.name != 'delete_time' &&
            column.name != 'update_version' &&
            column.name != 'delete_flag')>
                ,`${column.name}`
            </#if>
        </#list>
        )
        values
        (now(), now(), 0
        <#list columnList as column>
            <#if (column.name != 'create_time' &&
            column.name != 'update_time' &&
            column.name != 'delete_time' &&
            column.name != 'update_version' &&
            column.name != 'delete_flag')>
                ,${r"#{"}${model}.${column.field}${"}"}
            </#if>
        </#list> )
    </sql>

    <sql id="batchInsert">
        insert into ${tableName}
        (`create_time`, `update_time`, `delete_flag`
        <#list columnList as column>
            <#if (column.name != 'create_time' &&
            column.name != 'update_time' &&
            column.name != 'delete_time' &&
            column.name != 'update_version' &&
            column.name != 'delete_flag')>
                ,`${column.field}`
            </#if>
        </#list>
        )
        values
        <foreach collection="modelList" index="collections" item="model" open="(" close=")" separator="," >
            now(), now(), 0
            <#list columnList as column>
                <#if (column.name != 'create_time' &&
                column.name != 'update_time' &&
                column.name != 'delete_time' &&
                column.name != 'update_version' &&
                column.name != 'delete_flag')>
                    ,${r"#{"}${model}.${column.name}${"}"}
                </#if>
            </#list>
        </foreach>
    </sql>

    <sql id="updateAll">
        update ${tableName}
        set `update_time` = now()
        <#list columnList as column>
            <#if (column.name != 'create_time' &&
            column.name != 'update_time' &&
            column.name != 'delete_time' &&
            column.name != 'id' &&
            column.name != 'c_id' &&
            column.name != 'delete_flag')>
                ,`${column.name}` = ${r"#{"}${model}.${column.field}${"}"}
            </#if>
        </#list>
    </sql>

    <sql id="update">
        update ${tableName}
        set `update_time` = now()
        <#list columnList as column>
            <#if (column.name != 'create_time' &&
            column.name != 'update_time' &&
            column.name != 'delete_time' &&
            column.name != 'id' &&
            column.name != 'c_id' &&
            column.name != 'delete_flag')>
                <if test="${model}.${column.field} != null">
                    ,`${column.name}` = ${r"#{"}${model}.${column.field}${"}"}
                </if>
            </#if>
        </#list>
    </sql>

    <sql id="filter">
        <#list columnList as column>
        <#if (column.type = 'String')>
        <if test="${model}.${column.field} != null and ${model}.${column.field} != ''">
        <#else>
        <if test="${model}.${column.field} != null">
        </#if>
            and ${column.name} = ${r"#{"}${model}.${column.field}${"}"}
        </if>
        </#list>
    </sql>

    <insert id="add${Model}">
        <include refid="insert"/>
    </insert>

    <insert id="batchAdd${Model}">
        <include refid="batchInsert"/>
    </insert>

    <select id="find${Model}" resultMap="${Model}">
        <include refid="selectAll"/>
        where `delete_flag` = 0
        and `id` = ${r"#{"}${model}.id${"}"}
        <include refid="filter"/>

        limit 0,1;
    </select>

    <select id="list${Model}" resultMap="${Model}">
        <include refid="selectAll"/>
        where `delete_flag` = 0
        <include refid="filter"/>
    </select>

    <update id="updateAll${Model}">
        <include refid="updateAll"/>

        where `delete_flag` = 0
        and `id` = ${r"#{"}${model}.id${"}"}
        limit 1;
    </update>

    <update id="update${Model}">
        <include refid="update"/>

        where `delete_flag` = 0
        and `id` = ${r"#{"}${model}.id${"}"}
        limit 1;
    </update>

    <update id="softDel${Model}">
        update ${tableName}
        set `delete_flag` = 1, `delete_time` = now()
        where `delete_flag` = 0
        and `id` = ${r"#{"}${model}.id${"}"}

        limit 1;
    </update>

</mapper>