package ${servicePath};

import org.springframework.stereotype.Service;

<#if model?exists>
import ${modelPath}${module}.entity.${Model};
import ${modelPath}${module}.dto.${Model}DTO;
import ${daoPath}${module}.${Model}${daoName};
import ${modelPath}${module}.exception.${Model}NotFoundException;
import ${sqlBuilder};
</#if>

import javax.annotation.Resource;
import java.util.List;

@Service
public interface ${Module}Service {
}