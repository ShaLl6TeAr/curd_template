
    @PostMapping(value = "/${name}")
    public ApiResult<${Name}VO> ${name}(@Validated ${Name}DTO dto) {
        ApiResult<${Name}VO> result = new ApiResult<>();

        return result;
    }