
    int add${Model}(${Model} ${model});

    int batchAdd${Model}(List<${Model}> ${model}List);

    int insertOrReplace${Model}(${Model} ${model});

    int batchInsertOrReplace${Model}(List<${Model}> ${model}List);

    ${Model} get${Model}(${Model}DTO ${model}) throws ${Model}NotFoundException;

    ${Model} find${Model}(${Model}DTO ${model});
    
    List${"\l"}${Model}${"\g"} list${Model}(${Model}DTO ${model});

    int update${Model}(${Model} ${model}) throws ${Model}NotFoundException;

    int updateAll${Model}(${Model} ${model}) throws ${Model}NotFoundException;

    int softDel${Model}(String id);

    List<${Model}> selectSqlBuilder(SqlBuilder.Operation operation);

    int updateSqlBuilder(${Model} ${model}, SqlBuilder.Operation operation);
