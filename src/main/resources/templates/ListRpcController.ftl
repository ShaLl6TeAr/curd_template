package ${packageName};

import ${packageName}.service.${Module}Service;
import ${packageName}.dto.*;
import ${packageName}.vo.*;
import ${ApiResult};
import ${PageList};
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.annotation.Resource;

@RestController
@RequestMapping("/${module}")
public class ${Module}Controller {

    @Resource
    private ${Module}Service ${module}Service;

    @PostMapping(value = "/${name}")
    public ApiResult<${Name}VO> ${name}(@Validated ${Name}DTO dto) {
        ApiResult<${Name}VO> result = new ApiResult<>();
        result.setResult(PageList.pageList(dto,
        () -> service.${name}(),
        ${Name}VO::new));
        return result;
    }
}
