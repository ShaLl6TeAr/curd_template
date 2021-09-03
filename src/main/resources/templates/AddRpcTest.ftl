
    @Test
    public void test${Name} {
    <#if (type = 'add' || type = 'update')>
        ${Name}DTO dto = TestUtil.randomInit(${Name}DTO.class);
<#--        ${Name}DTO dto = ${TestUtilName}.randomInit(${Name}DTO.class);-->
    <#else>
        ${Name}DTO dto = new ${Name}DTO(); 
    </#if>
        ApiResult<${Name}VO> vo = ${controllerName}Controller.${name}(dto);
        TestUtil.testCheck(vo);
<#--        ${TestUtilName}.testCheck(vo);-->
    <#if (type = 'add' || type = 'update' || type = 'del')>
        assertEquals(vo.getResult().get${Type}Count(), java.util.Optional.of(1).get());
    </#if>
    }