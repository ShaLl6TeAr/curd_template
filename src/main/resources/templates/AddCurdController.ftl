
    @PostMapping(value = "/add${Model}")
    public ApiResult${"\l"}Add${Model}VO${"\g"} add${Model}(@Validated @RequestBody Add${Model}DTO dto) {
        ApiResult${"\l"}Add${Model}VO${"\g"} result = new ApiResult${"\l"}${"\g"}();
        ${Model} ${model} = dto.init${Model}();
        int addCount = ${module}Service.add${Model}(${model});
        result.setResult(new Add${Model}VO(addCount, ${model}.getId()));
        return result;
    }

    @PostMapping(value = "/batchAdd${Model}")
    public ApiResult${"\l"}BatchAdd${Model}VO${"\g"} add${Model}(@Validated @RequestBody BatchAdd${Model}DTO dto) {
        ApiResult${"\l"}BatchAdd${Model}VO${"\g"} result = new ApiResult${"\l"}${"\g"}();
        List<${Model}> ${model}List = dto.init${Model}List();
        int addCount = ${module}Service.batchAdd${Model}(${model}List);
        result.setResult(new BatchAdd${Model}VO(addCount, ${model}List);
        return result;
    }

    @GetMapping(value = "/list${Model}")
    public ApiResult${r"<PageList.PageData<List"}${Model}${r"VO>>"} list${Model}(@Validated List${Model}DTO dto) {
        ApiResult${r"<PageList.PageData<List"}${Model}${r"VO>>"} result = new ApiResult${"\l"}${"\g"}();
        ${Model}DTO ${model} = new ${Model}DTO();
        result.setResult(PageList.pageList(dto,
                    () -${"\g"} ${module}Service.list${Model}(${model}),
                    List${Model}VO::new));
        return result;
    }

    @GetMapping(value = "/get${Model}")
    public ApiResult${"\l"}Get${Model}VO${"\g"} get${Model}(@Validated Get${Model}DTO dto) {
        ApiResult${"\l"}Get${Model}VO${"\g"} result = new ApiResult${"\l"}${"\g"}();
        ${Model}DTO ${model} = new ${Model}DTO();
        ${model}.setId(dto.getGet${Model}Id());
        try {
            Get${Model}VO vo = new Get${Model}VO(${module}Service.get${Model}(${model}));
            result.setResult(vo);
        } catch (${Model}NotFoundException e) {
            throw new RuntimeException(e.getMessage());
        }
        return result;
    }

    @GetMapping(value = "/find${Model}")
    public ApiResult${"\l"}Find${Model}VO${"\g"} find${Model}(@Validated Find${Model}DTO dto) {
        ApiResult${"\l"}Find${Model}VO${"\g"} result = new ApiResult${"\l"}${"\g"}();
        ${Model}DTO ${model} = new ${Model}DTO();
        Find${Model}VO vo = new Find${Model}VO(${module}Service.find${Model}(${model}));
        result.setResult(vo);
        return result;
    }

    @PostMapping(value = "/update${Model}")
    public ApiResult${"\l"}Update${Model}VO${"\g"} update${Model}(@Validated @RequestBody Update${Model}DTO dto) {
        ApiResult${"\l"}Update${Model}VO${"\g"} result = new ApiResult${"\l"}${"\g"}();
        try {
            ${Model}DTO ${model} = new ${Model}DTO();
            ${model}.setId(dto.getId());
            ${Model} old = ${module}Service.get${Model}(${model});
            dto.update${Model}(old);
            int updateCount = ${module}Service.update${Model}(old);
            result.setResult(new Update${Model}VO(updateCount, ${model}.getId()));
        } catch (${Model}NotFoundException e) {
            throw new RuntimeException(e.getMessage());
        }
        return result;
    }

    @PostMapping(value = "/del${Model}")
    public ApiResult${"\l"}Del${Model}VO${"\g"} del${Model}(@Validated Del${Model}DTO dto) {
        ApiResult${"\l"}Del${Model}VO${"\g"} result = new ApiResult${"\l"}${"\g"}();
        result.setResult(new Del${Model}VO(${module}Service.softDel${Model}(dto.getDel${Model}Id()), dto.getDel${Model}Id()));
        return result;
    }
