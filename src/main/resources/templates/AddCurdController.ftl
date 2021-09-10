
    @Resource
    private ${Model}Service ${model}Service;

    @PostMapping(value = "/add${Model}")
    public ApiResult${"\l"}Add${Model}VO${"\g"} add${Model}(@Validated @RequestBody Add${Model}DTO dto) {
        ApiResult${"\l"}Add${Model}VO${"\g"} result = new ApiResult${"\l"}${"\g"}();
        ${Model} ${model} = dto.init${Model}();
        int addCount = ${model}Service.add${Model}(${model});
        result.setResult(new Add${Model}VO(addCount, ${model}.getId()));
        return result;
    }

    @PostMapping(value = "/list${Model}")
    public ApiResult${r"<PageList.PageData<List"}${Model}${r"VO>>"} list${Model}(@Validated List${Model}DTO dto) {
        ApiResult${r"<PageList.PageData<List"}${Model}${r"VO>>"} result = new ApiResult${"\l"}${"\g"}();
        result.setResult(PageList.pageList(dto,
                    () -${"\g"} ${model}Service.list${Model}(),
                    List${Model}VO::new));
        return result;
    }

    @PostMapping(value = "/get${Model}")
    public ApiResult${"\l"}Get${Model}VO${"\g"} get${Model}(@Validated Get${Model}DTO dto) {
        ApiResult${"\l"}Get${Model}VO${"\g"} result = new ApiResult${"\l"}${"\g"}();
        Get${Model}VO vo = new Get${Model}VO(${model}Service.get${Model}());
        result.setResult(vo);
        return result;
    }

    @PostMapping(value = "/find${Model}")
    public ApiResult${"\l"}Find${Model}VO${"\g"} find${Model}(@Validated Find${Model}DTO dto) {
        ApiResult${"\l"}Find${Model}VO${"\g"} result = new ApiResult${"\l"}${"\g"}();
        Find${Model}VO vo = new Find${Model}VO(${model}Service.get${Model}());
        result.setResult(vo);
        return result;
    }

    @PostMapping(value = "/update${Model}")
    public ApiResult${"\l"}Update${Model}VO${"\g"} update${Model}(@Validated @RequestBody Update${Model}DTO dto) {
        ApiResult${"\l"}Update${Model}VO${"\g"} result = new ApiResult${"\l"}${"\g"}();
        ${Model} ${model};
        try {
            ${model} = ${model}Service.get${Model}(dto.getUpdate${Model}Id());
        } catch (${Model}NotFoundException e) {
            throw new RuntimeException(e.getMessage());
        }
        dto.update${Model}(${model});
        int updateCount = ${model}Service.update${Model}(${model});
        result.setResult(new Update${Model}VO(updateCount, ${model}.getId()));
        return result;
    }

    @PostMapping(value = "/del${Model}")
    public ApiResult${"\l"}Del${Model}VO${"\g"} del${Model}(@Validated Del${Model}DTO dto) {
        ApiResult${"\l"}Del${Model}VO${"\g"} result = new ApiResult${"\l"}${"\g"}();
        try {
            result.setResult(new Del${Model}VO(${model}Service.softDel${Model}(dto.getDel${Model}Id()), dto.getDel${Model}Id()));
        } catch (${Model}NotFoundException e) {
            throw new RuntimeException(e.getMessage());
        }
        return result;
    }
