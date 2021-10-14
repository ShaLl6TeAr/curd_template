
    @Resource
    private ${Model}DAO ${model}DAO;

    public int add${Model}(${Model} ${model}) {
        ${model}.setId(EcoUtil.uuid());
        return ${model}DAO.add${Model}(${model});
    }

    public int batchAdd${Model}(List<${Model}> ${model}List) {
        ${model}List.forEach(d -> d.setId(EcoUtil.uuid()));
        return ${model}DAO.batchAdd${Model}(${model}List);
    }

    public int insertOrReplace${Model}(${Model} ${model}) {
        ${model}.setId(EcoUtil.uuid());
        return ${model}DAO.insertOrReplace${Model}(${model});
    }

    public int batchInsertOrReplace${Model}(List<${Model}> ${model}List) {
        ${model}List.forEach(d -> d.setId(EcoUtil.uuid()));
        return ${model}DAO.batchInsertOrReplace${Model}(${model}List);
    }

    public ${Model} get${Model}(${Model}DTO ${model}) throws ${Model}NotFoundException {
        ${Model} result = find${Model}(${model});
        if (result == null) {
            throw new ${Model}NotFoundException(${model}.toString());
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

    public List<${Model}> selectSqlBuilder(SqlBuilder.Operation operation) {
        return ${model}DAO.selectSqlBuilder(operation);
    }

    public int updateSqlBuilder(${Model} ${model}, SqlBuilder.Operation operation) {
        return ${model}DAO.updateSqlBuilder(${model}, operation);
    }
