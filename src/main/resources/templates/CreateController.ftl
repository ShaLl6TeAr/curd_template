package ${packageName};

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import ${packageName}.service.${Module}Service;
import ${packageName}.dto.*;
import ${packageName}.vo.*;
import ${ApiResult};
import ${PageList};
<#if model?exists>
import ${modelPath}${module}.entity.${Model};
import ${modelPath}${module}.dto.${Model}DTO;
import ${modelPath}${module}.exception.${Model}NotFoundException;
</#if>

import javax.annotation.Resource;

@RestController
@RequestMapping("/${module}")
public class ${ControllerName}Controller {

    @Resource
    private ${Module}Service ${module}Service;
}