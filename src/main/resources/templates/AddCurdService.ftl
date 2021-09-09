
    @Resource
    private ${Model}Mapper ${model}Mapper;

    public int add${Model}(${Model} ${model}) {
        ${model}.setId();
        return ${model}mapper.add${Model}(${model});
    }

    public ${Model} get${Model}(${Model}DTO dto) throw ${Model}NotFoundException {
        ${Model} ${model} = find${Model}(dto);
        if (${model} == null} {
            throw new ${Model}NotFoundException(dto.getId());
        }
        return ${model};
    }

    public ${Model} find${Model}(${Model}DTO dto) {
        return ${model}mapper.find${Model}(dto);
    }

    public ${Model} list${Model}(${Model}DTO dto) {
        return ${model}mapper.list${Model}(dto);
    }

    public int update${Model}(${Model} ${model}) throw ${Model}NotFoundException {
<#--        try {-->
<#--            get${Model}(${model}.getId());-->
<#--        } catch (${Model}NotFoundException e) {-->
<#--            throw new BusinessException(e.getMessage());-->
<#--        }-->
        return ${model}mapper.update${Model}(${model});
    }

    public int softDel${Model}(String id) throw ${Model}NotFoundException {
        ${Model} ${model} = new ${Model}();
        ${model}.setId(id);
        try {
            get${Model}(${model});
        } catch (${Model}NotFoundException e) {
            throw new BusinessException(e.getMessage());
        }
        return ${model}mapper.softDel${Model}(${model});
    }