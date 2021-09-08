

    @PostMapping(value = "/${name}")
    public ApiResult<PageList.PageData<${Name}VO>> ${name}(@Validated ${Name}DTO dto) {
        return new ApiResult<>(
            result.setResult(PageList.pageList(dto,
            () -> service.${name}(),
            List${Model}VO::new)));
    }