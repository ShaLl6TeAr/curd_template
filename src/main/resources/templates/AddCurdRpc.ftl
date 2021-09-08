
    @Resource
    private ${Model}Service ${model}Service;

    @PostMapping(value = "/add${Model}")
    public ApiResult<Add${Model}VO> add${Model}(@Validated @RequestBody Add${Model}DTO dto) {
        ApiResult<Add${Model}VO> result = new ApiResult<>();
        ${Model} ${model} = dto.init${Model}();
        int addCount = ${model}Service.add${Model}(${model});
        result.setResult(new Add${Model}VO(addCount, ${model}.getId()));
        return result;
    }

    @PostMapping(value = "/list${Model}")
    public ApiResult<PageList.PageData<List${Model}VO>> list${Model}(@Validated List${Model}DTO dto) {
        ApiResult<PageList.PageData<List${Model}VO>> result = new ApiResult<>();
        result.setResult(PageList.pageList(dto,
                    () -> ${model}Service.list${Model}(),
                    List${Model}VO::new));
        return result;
    }

    @PostMapping(value = "/get${Model}")
    public ApiResult<Get${Model}VO> get${Model}(@Validated Get${Model}DTO dto) {
        ApiResult<Get${Model}VO> result = new ApiResult<>();
        Get${Model}VO vo = new Get${Model}VO(${model}Service.get${Model}());
        result.setResult(vo);
        return result;
    }

    @PostMapping(value = "/find${Model}")
    public ApiResult<Find${Model}VO> find${Model}(@Validated Find${Model}DTO dto) {
        ApiResult<Find${Model}VO> result = new ApiResult<>();
        Find${Model}VO vo = new Find${Model}VO(${model}Service.get${Model}());
        result.setResult(vo);
        return result;
    }

    @PostMapping(value = "/update${Model}")
    public ApiResult<Update${Model}VO> update${Model}(@Validated @RequestBody Update${Model}DTO dto) {
        ApiResult<Update${Model}VO> result = new ApiResult<>();
        ${Model} ${model} = ${model}Service.get${Model}(dto.getUpdate${Model}Id());
        dto.update${Model}(${model});
        int updateCount = ${model}Service.update${Model}(${model});
        result.setResult(new Update${Model}VO(updateCount, ${model}.getId()));
        return result;
    }

    @PostMapping(value = "/del${Model}")
    public ApiResult<Del${Model}VO> del${Model}(@Validated Del${Model}DTO dto) {
        ApiResult<Del${Model}VO> result = new ApiResult<>();
        result.setResult(new Del${Model}VO(${model}Service.del${Model}(dto.getId())));
        return result;
    }
