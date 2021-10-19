<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "${"http://mybatis.org/dtd/mybatis-3-mapper.dtd"}" >
<mapper namespace="${daoPath}${module}.${Model}Base${daoName}">

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
        <if test="true"/>
        into ${tableName}
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
        <if test="true"/>
        into ${tableName}
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

    <sql id="sqlBuilderCondition">
        <if test="operation.conditions != null">
            <foreach collection="operation.conditions" index="idx" item="condition">
                <choose>
                    <when test="condition.condition == 'between'">
                        and ${r"${condition.field}"} between ${r"#{condition.valueBegin}"} and ${r"#{condition.valueEnd}"}
                    </when>
                    <when test="condition.condition == 'like'">
                        and ${r"${condition.field}"} like concat('%', ${r"#{condition.value}"}, '%')
                    </when>
                    <when test="condition.condition == 'or'">
                        and
                        <trim prefix="(" suffix=")" prefixOverrides="or">
                            <foreach collection="condition.orList" index="idx" item="c">
                                <choose>
                                    <when test="c.condition == 'between'">
                                        or ${r"${c.field}"} between ${r"#{c.valueBegin}"} and ${r"#{c.valueEnd}"}
                                    </when>
                                    <when test="c.condition == 'like'">
                                        or ${r"${c.field}"} like concat('%', ${r"#{c.value}"}, '%')
                                    </when>
                                    <otherwise>
                                        or ${r"${c.field}"} ${r"${c.condition}"} ${r"#{c.value}"}
                                    </otherwise>
                                </choose>
                            </foreach>
                        </trim>
                    </when>
                    <otherwise>
                        and ${r"${condition.field}"} ${r"${condition.condition}"} ${r"#{condition.value}"}
                    </otherwise>
                </choose>
            </foreach>
        </if>
    </sql>

    <select id="selectSqlBuilder" resultMap="${Model}">
        <choose>
            <when test="operation.fields != null and operation.fields != ''">
                select ${r"${operation.fields}"} from ${tableName}
            </when>
            <otherwise>
                <include refid="selectAll"/>
            </otherwise>
        </choose>
        where `delete_flag` = 0
<#--        <trim prefix="where" prefixOverrides="and">-->
        <include refid="sqlBuilderCondition"/>
<#--        </trim>-->
        <if test="operation.group != null and operation.group != ''">
            group by ${r"${operation.group}"}
        </if>
        <if test="operation.order != null and operation.order != ''">
            order by ${r"${operation.order}"}
        </if>
        <if test="operation.limit != null">
            limit ${r"${operation.limit.offset},${operation.limit.limit}"}
        </if>
    </select>

    <update id="updateSqlBuilder">
        <include refid="update"/>
        where `delete_flag` = 0
<#--        <trim prefixOverrides="and">-->
        <include refid="sqlBuilderCondition"/>
<#--        </trim>-->
    </update>

    <insert id="add${Model}">
        insert
        <include refid="insert"/>
    </insert>

    <insert id="batchAdd${Model}">
        insert
        <include refid="batchInsert"/>
    </insert>

    <insert id="insertOrReplace${Model}">
        replace
        <include refid="insert"/>
    </insert>

    <insert id="batchInsertOrReplace${Model}">
        replace
        <include refid="batchInsert"/>
    </insert>

    <select id="find${Model}" resultMap="${Model}">
        <include refid="selectAll"/>
        where `delete_flag` = 0
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