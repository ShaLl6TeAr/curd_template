package ${packageName}.service;

import org.springframework.stereotype.Service;

<#if model?exists>
import ${modelPath}${module}.entity.${Model};
import ${modelPath}${module}.dao.${Model}DAO;
import ${modelPath}${module}.exception.${Model}NotFoundException;
</#if>

import javax.annotation.Resource;
import java.util.List;

@Service
public class ${Module}Service {
}