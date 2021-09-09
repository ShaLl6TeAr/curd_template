
    @Test
    public void test${Name}() {
        ${Name}DTO dto = TestUtil.randomInit(${Name}DTO.class);
        ApiResult${"\l"}${Name}VO${"\g"} result = ${controllerName}Controller.${name}(dto);
        TestUtil.testCheck(result);
    }