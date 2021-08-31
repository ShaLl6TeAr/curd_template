

    @PostMapping(value = "/${name}")
    public ApiResult<${Name}VO> ${name}(@Validated ${Name}DTO dto) {
        ApiResult<${Name}VO> result = new ApiResult<>();
        result.setResult(PageList.pageList(dto,
            () -> service.${name}(),
            ${Name}VO::new));
        return result;
    }