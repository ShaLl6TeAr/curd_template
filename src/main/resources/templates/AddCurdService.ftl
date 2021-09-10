
    @Resource
    private ${Model}DAO ${model}DAO;

    public int add${Model}(${Model} ${model}) {
        ${model}.setId("");
        return ${model}DAO.add${Model}(${model});
    }

    public ${Model} get${Model}(${Model} ${model}) throws ${Model}NotFoundException {
        ${Model} ${model} = find${Model}(${model});
        if (${model} == null) {
            throw new ${Model}NotFoundException(${model}.getId());
        }
        return ${model};
    }

    public ${Model} find${Model}(${Model} ${model}) {
        return ${model}DAO.find${Model}(${model});
    }

    public List${"\l"}${Model}${"\g"} list${Model}(${Model} ${model}) {
        return ${model}DAO.list${Model}(${model});
    }

    public int update${Model}(${Model} ${model}) throws ${Model}NotFoundException {
<#--        try {-->
<#--            get${Model}(${model}.getId());-->
<#--        } catch (${Model}NotFoundException e) {-->
<#--            throw new BusinessException(e.getMessage());-->
<#--        }-->
        return ${model}DAO.update${Model}(${model});
    }

    public int softDel${Model}(String id) throws ${Model}NotFoundException {
        ${Model} ${model} = new ${Model}();
        ${model}.setId(id);
        get${Model}(${model});
        REturn ${model}DAO.softDel${Model}(${model});
    }