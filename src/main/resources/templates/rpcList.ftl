public class ${Name}DTO extend PageList {

}

public class ${Name}VO {

}

@RequestMapping(value = "/${name}")
public ApiResult<${Name}VO> ${name}(@Validated ${Name}DTO dto) {
    return new ApiResult<>(PageList.pageList(dto,
        () -> , );
}