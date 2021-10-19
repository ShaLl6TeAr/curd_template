
    @Resource
    private ${Model}${daoName} ${model}${daoName};

    public int add${Model}(${Model} ${model}) {
        ${model}.setId(EcoUtil.uuid());
        return ${model}${daoName}.add${Model}(${model});
    }

    public int batchAdd${Model}(List<${Model}> ${model}List) {
        ${model}List.forEach(d -> d.setId(EcoUtil.uuid()));
        return ${model}${daoName}.batchAdd${Model}(${model}List);
    }

    public int insertOrReplace${Model}(${Model} ${model}) {
        ${model}.setId(EcoUtil.uuid());
        return ${model}${daoName}.insertOrReplace${Model}(${model});
    }

    public int batchInsertOrReplace${Model}(List<${Model}> ${model}List) {
        ${model}List.forEach(d -> d.setId(EcoUtil.uuid()));
        return ${model}${daoName}.batchInsertOrReplace${Model}(${model}List);
    }

    public ${Model} get${Model}(${Model}DTO ${model}) throws ${Model}NotFoundException {
        ${Model} result = find${Model}(${model});
        if (result == null) {
            throw new ${Model}NotFoundException(${model}.toString());
        }
        return result;
    }

    public ${Model} find${Model}(${Model}DTO ${model}) {
        return ${model}${daoName}.find${Model}(${model});
    }

    public List${"\l"}${Model}${"\g"} list${Model}(${Model}DTO ${model}) {
        return ${model}${daoName}.list${Model}(${model});
    }

    public int update${Model}(${Model} ${model}) throws ${Model}NotFoundException {
        ${Model}DTO get = new ${Model}DTO();
        get.setId(${model}.getId());
        get${Model}(get);
        return ${model}${daoName}.update${Model}(${model});
    }

    public int updateAll${Model}(${Model} ${model}) throws ${Model}NotFoundException {
        ${Model}DTO get = new ${Model}DTO();
        get.setId(${model}.getId());
        get${Model}(get);
        return ${model}${daoName}.update${Model}(${model});
    }

    public int softDel${Model}(String id) {
        ${Model}DTO ${model} = new ${Model}DTO();
        ${model}.setId(id);
        return ${model}${daoName}.softDel${Model}(${model});
    }

    public List<${Model}> selectSqlBuilder(SqlBuilder.Operation operation) {
        return ${model}${daoName}.selectSqlBuilder(operation);
    }

    public int updateSqlBuilder(${Model} ${model}, SqlBuilder.Operation operation) {
        return ${model}${daoName}.updateSqlBuilder(${model}, operation);
    }
