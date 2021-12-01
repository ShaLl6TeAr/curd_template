
    @Test
    public void test${Name}() {
        ${Name}DTO dto = TestUtil.randomInit(${Name}DTO.class);
        TestUtil.showJSON(dto);
        ApiResult${"\l"}${Name}VO${"\g"} result = ${controllerName}Controller.${name}(dto);
        TestUtil.showJSON(result);
    }