

    @PostMapping(value = "/${name}")
    public ApiResult<PageList.PageData<${Name}VO>> ${name}(@Validated ${Name}DTO dto) {
        ApiResult<PageList.PageData<${Name}VO>> result = new ApiResult<>();
        result.setResult(PageList.pageList(dto,
            () -> service.${name}(),
            ${Name}VO::new));
        return result;
    }