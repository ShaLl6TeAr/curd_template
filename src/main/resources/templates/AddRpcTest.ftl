
    @Test
    public void test${Name} {
        ${Name}DTO dto = TestUtil.randomInit(${Name}DTO.class);
        ApiResult<${Name}VO> gt result = ${controllerName}Controller.${name}(dto);
        TestUtil.testCheck(result);
<#--        ${TestUtilName}.testCheck(vo);-->
    }