<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "${"http://mybatis.org/dtd/mybatis-3-mapper.dtd"}" >
<mapper namespace="${daoPath}${module}.dao.${Model}BaseDAO">

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
                ,`${column.name}`
            </#if>
        </#list>
        )
        values
        <foreach collection="${model}List" index="collections" item="${model}" separator="," >
            (now(), now(), 0
            <#list columnList as column>
                <#if (column.name != 'create_time' &&
                column.name != 'update_time' &&
                column.name != 'delete_time' &&
                column.name != 'update_version' &&
                column.name != 'delete_flag')>
                    ,${r"#{"}${model}.${column.field}${"}"}
                </#if>
            </#list>
            )
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

    <sql id="add${Model}">
        <include refid="insert"/>
    </sql>

    <sql id="batchAdd${Model}">
        <include refid="batchInsert"/>
    </sql>

    <sql id="find${Model}">
        <include refid="selectAll"/>
        where `delete_flag` = 0
        and `id` = ${r"#{"}${model}.id${"}"}
        <include refid="filter"/>

        limit 0,1;
    </sql>

    <sql id="list${Model}">
        <include refid="selectAll"/>
        where `delete_flag` = 0
        <include refid="filter"/>
    </sql>

    <sql id="updateAll${Model}">
        <include refid="updateAll"/>

        where `delete_flag` = 0
        and `id` = ${r"#{"}${model}.id${"}"}
        limit 1;
    </sql>

    <sql id="update${Model}">
        <include refid="update"/>

        where `delete_flag` = 0
        and `id` = ${r"#{"}${model}.id${"}"}
        limit 1;
    </sql>

    <sql id="softDel${Model}">
        update ${tableName}
        set `delete_flag` = 1, `delete_time` = now()
        where `delete_flag` = 0
        and `id` = ${r"#{"}${model}.id${"}"}

        limit 1;
    </sql>

    <insert id="add${Model}">
        <include refid="add${Model}"/>
    </insert>

    <insert id="batchAdd${Model}">
        <include refid="batchAdd${Model}"/>
    </insert>

    <select id="find${Model}" resultMap="${Model}">
        <include refid="find${Model}"/>
    </select>

    <select id="list${Model}" resultMap="${Model}">
        <include refid="list${Model}"/>
    </select>

    <update id="updateAll${Model}">
        <include refid="updateAll${Model}"/>
    </update>

    <update id="update${Model}">
        <include refid="update${Model}"/>
    </update>

    <update id="softDel${Model}">
        <include refid="softDel${Model}"/>
    </update>

</mapper>