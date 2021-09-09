

    @PostMapping(value = "/${name}")
    public ApiResult${r"<PageList.PageData<List"}${Model}${r"VO>>"} ${name}(@Validated ${Name}DTO dto) {
        return new ApiResult<>(
            result.setResult(PageList.pageList(dto,
            () -> service.${name}(),
            List${Model}VO::new)));
    }