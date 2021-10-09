package ${daoPath}${module}.dao;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Mapper;

import ${modelPath}${module}.entity.${Model};
import ${modelPath}${module}.dto.${Model}DTO;

import java.util.List;

@Mapper
public interface ${Model}BaseDAO {

    int add${Model}(@Param("${model}") ${Model} ${Model});

    int batchAdd${Model}(@Param("${model}List") List<${Model}> ${Model}List);

    int update${Model}(@Param("${model}") ${Model} ${Model});

    int updateAll${Model}(@Param("${model}") ${Model} ${Model});

    ${Model} find${Model}(@Param("${model}") ${Model}DTO dto);

    List<${Model}> list${Model}(@Param("${model}") ${Model}DTO dto);

    int softDel${Model}(@Param("${model}") ${Model}DTO dto);

}