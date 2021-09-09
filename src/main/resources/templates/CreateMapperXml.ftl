<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "${"http://mybatis.org/dtd/mybatis-3-mapper.dtd"}" >
<mapper namespace="">

    <resultMap id="${Model}" type="">
        <id column="id" property="id"/>
        <#if columnList?exists>
        <#list columnList as column>
            <#if (column.name != 'id')>
                <result column="${column.name}" property="${column.field}" />
            </#if>
        </#list>
        </#if>
    </resultMap>

    <sql id="selectAll">
        select id
        <#if columnList?exists>
        <#list columnList as column>
        <#if (column.name != 'id')>
            ,${column.name}
        </#if>
        </#list>
        </#if>
        from ${tableName}
    </sql>

    <sql id="condition">
        <#list columnList as column>
        <#if (column.type = 'String')>
        <if test="${column.field} != null and ${column.field} != ''">
        <#else>
        <if test="${column.field} != null">
        </#if>
            and ${column.name} = ${r"#{"}${column.field}${"}"}
        </if>
        </#list>
    </sql>

    <insert id="add${Model}">
        insert into ${tableName}
        (`create_time`, `update_time`, `delete_time`, `delete_flag`)
        values
        (now(), now(), 0, 0)
    </insert>

    <select id="find${Model}" resultMap="${Model}">
        <include refid="selectAll"/>
        where `delete_flag` = 0
        and `id` = ${r"#{"}${model}.id${"}"}
        <include refid="condition"/>

        limtit 0, 1;
    </select>

    <select id="list${Model}" resultMap="${Model}">
        <include refid="selectAll"/>
        where `delete_flag` = 0
        <include refid="condition"/>
    </select>

    <update id="update${Model}">
        update ${tableName}
        set `update_time` = now()
        where `delete_flag` = 0
        and `id` = ${r"#{"}${model}.id${"}"}

        limit 0, 1;
    </update>

    <update id="softDel${Model}">
        update ${tableName}
        set `delete_flag` = 1, `delete_time` = now()
        where `delete_flag` = 0
        and `id` = ${r"#{"}${model}.id${"}"}

        limit 0, 1;
    </update>

</mapper>