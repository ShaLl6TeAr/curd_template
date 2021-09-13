package ${packageName}.dto;
<#if (model?exists && (type = 'add' || type = 'update'))>

    import ${modelPath}${module}.entity.${Model};
</#if>

import ${PageList};

public class ${Name}DTO extends PageList {

}