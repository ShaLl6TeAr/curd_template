package ${daoPath}${module};

import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Mapper;

import ${modelPath}${module}.entity.${Model};
import ${modelPath}${module}.dto.${Model}DTO;

import java.util.List;

@Mapper
public interface ${Model}${daoName} extends ${Model}Base${daoName} {

}