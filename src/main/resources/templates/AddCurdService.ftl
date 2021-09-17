
    @Resource
    private ${Model}DAO ${model}DAO;

    public int add${Model}(${Model} ${model}) {
        ${model}.setId("");
        return ${model}DAO.add${Model}(${model});
    }

    public int batchAdd${Model}(List<${Model}> ${model}List) {
        ${model}List.forEach(d -> d.setId(""));
        return ${model}DAO.batchAdd${Model}(${model}List);
    }

    public ${Model} get${Model}(${Model}DTO ${model}) throws ${Model}NotFoundException {
        ${Model} result = find${Model}(${model});
        if (${model} == null) {
            throw new ${Model}NotFoundException(${model}.getId());
        }
        return result;
    }

    public ${Model} find${Model}(${Model}DTO ${model}) {
        return ${model}DAO.find${Model}(${model});
    }

    public List${"\l"}${Model}${"\g"} list${Model}(${Model}DTO ${model}) {
        return ${model}DAO.list${Model}(${model});
    }

    public int update${Model}(${Model} ${model}) throws ${Model}NotFoundException {
        ${Model}DTO get = new ${Model}DTO();
        get.setId(${model}.getId());
        get${Model}(get);
        return ${model}DAO.update${Model}(${model});
    }

    public int updateAll${Model}(${Model} ${model}) throws ${Model}NotFoundException {
        ${Model}DTO get = new ${Model}DTO();
        get.setId(${model}.getId());
        get${Model}(get);
        return ${model}DAO.update${Model}(${model});
    }

    public int softDel${Model}(String id) {
        ${Model}DTO ${model} = new ${Model}DTO();
        ${model}.setId(id);
        return ${model}DAO.softDel${Model}(${model});
    }