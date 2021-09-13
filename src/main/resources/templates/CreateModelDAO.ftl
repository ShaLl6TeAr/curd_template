package ${modelPath}${module}.dao;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Mapper;

import ${modelPath}${module}.entity.${Model};

import java.util.List;

@Mapper
public interface ${Model}DAO {

    int add${Model}(@Param("${model}") ${Model} ${model});

    int update${Model}(@Param("${model}") ${Model} ${model});

    ${Model} find${Model}(@Param("${model}") ${Model} ${model});

    List<${Model}> list${Model}(@Param("${model}") ${Model} ${model});

    int softDel${Model}(@Param("${model}") ${Model} ${model});

}