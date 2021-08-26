public class ${Rpc}DTO extend PageList {

}

public class ${Rpc}VO {

}

@RequestMapping(value = "/${rpc}")
public ApiResult<${Rpc}VO> ${rpc}(@Validated ${Rpc}DTO dto) {
    return new ApiResult<>(PageList.pageList(dto,
        () -> , );
}