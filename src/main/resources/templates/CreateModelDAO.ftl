package ${daoPath}${daoName}.${module};

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Mapper;

import ${modelPath}${module}.entity.${Model};
import ${modelPath}${module}.dto.${Model}DTO;

import java.util.List;

@Mapper
public interface ${Model}${daoName?upper_case} extends ${Model}Base${daoName?upper_case} {

}