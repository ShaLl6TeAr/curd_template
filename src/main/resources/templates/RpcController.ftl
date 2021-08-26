package ${packageName};

import ${packageName}.dto.*;
import ${packageName}.vo.*;
import ${ApiResult};
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/${module}")
public class ${Module}Controller {

    @PostMapping(value = "/${rpc}")
    public ApiResult<${Rpc}VO> ${rpc}(@Validated ${Rpc}DTO dto) {
        ApiResult<${Rpc}VO> result = new ApiResult<>();

        return result;
    }
}
