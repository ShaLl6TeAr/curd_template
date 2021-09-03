
    @PostMapping(value = "/${name}")
    <#if (type = 'add' || type = 'update')>
    public ApiResult<${Name}VO> ${name}(@Validated @RequestBody ${Name}DTO dto) {
        ApiResult<${Name}VO> result = new ApiResult<>();

        Po po = dto.initPO();
        int addCount = service.${name}(po);
        result.setResult(new ${Name}VO(addCount, po.getId()));
    <#else>
    public ApiResult<${Name}VO> ${name}(@Validated ${Name}DTO dto) {
        ApiResult<${Name}VO> result = new ApiResult<>();
    </#if>

        return result;
    }