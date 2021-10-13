package ${daoPath}${module}.dao;

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Mapper;

import ${modelPath}${module}.entity.${Model};
import ${modelPath}${module}.dto.${Model}DTO;
import ${sqlBuilder};

import java.util.List;

@Mapper
public interface ${Model}BaseDAO {

    int add${Model}(@Param("${model}") ${Model} ${model});

    int batchAdd${Model}(@Param("${model}List") List<${Model}> ${Model}List);

    int update${Model}(@Param("${model}") ${Model} ${model});

    int updateAll${Model}(@Param("${model}") ${Model} ${model});

    ${Model} find${Model}(@Param("${model}") ${Model}DTO dto);

    List<${Model}> list${Model}(@Param("${model}") ${Model}DTO dto);

    int softDel${Model}(@Param("${model}") ${Model}DTO dto);

    List<${Model}> selectSqlBuilder(@Param("operation") SqlBuilder.Operation operation);

    int updateSqlBuilder(@Param("testGtflChildDevice") TestGtflChildDevice model, @Param("operation") SqlBuilder.Operation operation);
}