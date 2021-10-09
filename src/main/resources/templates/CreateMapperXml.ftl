<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "${"http://mybatis.org/dtd/mybatis-3-mapper.dtd"}" >
<mapper namespace="${daoPath}${module}.dao.${Model}DAO">

    <insert id="add${Model}">
        <include refid="${daoPath}${module}.dao.${Model}BaseDAO.add${Model}"/>
    </insert>

    <insert id="batchAdd${Model}">
        <include refid="${daoPath}${module}.dao.${Model}BaseDAO.batchAdd${Model}"/>
    </insert>

    <select id="find${Model}" resultMap="${daoPath}${module}.dao.${Model}BaseDAO.${Model}">
        <include refid="${daoPath}${module}.dao.${Model}BaseDAO.find${Model}"/>
    </select>

    <select id="list${Model}" resultMap="${daoPath}${module}.dao.${Model}BaseDAO.${Model}">
        <include refid="${daoPath}${module}.dao.${Model}BaseDAO.list${Model}"/>
    </select>

    <update id="updateAll${Model}">
        <include refid="${daoPath}${module}.dao.${Model}BaseDAO.updateAll${Model}"/>
    </update>

    <update id="update${Model}">
        <include refid="${daoPath}${module}.dao.${Model}BaseDAO.update${Model}"/>
    </update>

    <update id="softDel${Model}">
        <include refid="${daoPath}${module}.dao.${Model}BaseDAO.softDel${Model}"/>
    </update>

</mapper>