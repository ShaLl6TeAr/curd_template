
    @Test
    public void test${Model}() {
        testAdd${Model}();
        testList${Model}();
        testGet${Model}();
        testUpdate${Model}();
        testDel${Model}();
    }

    private String new${Model}Id;

    @Test
    public void testAdd${Model}() {
        Add${Name}DTO dto = TestUtil.randomInit(Add${Name}DTO.class);
        TestUtil.showJSON(dto);
        ApiResult${"\l"}Add${Name}VO${"\g"} result = ${controllerName}Controller.add${Name}(dto);
        new${Model}Id = result.getResult().getId();
        TestUtil.showJSON(result);
        assertEquals(result.getResult().getAddCount(), Optional.of(1).get());
    }

    @Test
    public void testList${Model}() {
        List${Name}DTO dto = new List${Name}DTO();
        TestUtil.showJSON(dto);
        ApiResult${"\l"}PageList.PageData${"\l"}List${Name}VO${"\g"}${"\g"} result = ${controllerName}Controller.list${Name}(dto);
        TestUtil.showJSON(result);
    }

    @Test
    public void testGet${Model}() {
        Get${Name}DTO dto = new Get${Name}DTO();
        dto.set${Name}Id(new${Model}Id);
        TestUtil.showJSON(dto);
        ApiResult${"\l"}Get${Name}VO${"\g"} result = ${controllerName}Controller.get${Name}(dto);
        TestUtil.showJSON(result);
    }

    @Test
    public void testUpdate${Model}() {
        Update${Name}DTO dto = TestUtil.randomInit(Update${Name}DTO.class);
        dto.setUpdate${Name}Id(new${Model}Id);
        TestUtil.showJSON(dto);
        ApiResult${"\l"}Update${Name}VO${"\g"} result = ${controllerName}Controller.update${Name}(dto);
        TestUtil.showJSON(result);
        assertEquals(result.getResult().getUpdateCount(), Optional.of(1).get());
    }

    @Test
    public void testDel${Model}() {
        Del${Name}DTO dto = new Del${Name}DTO();
        dto.setDel${Name}Id(new${Model}Id);
        TestUtil.showJSON(dto);
        ApiResult${"\l"}Del${Name}VO${"\g"} result = ${controllerName}Controller.del${Name}(dto);
        TestUtil.showJSON(result);
        assertEquals(result.getResult().getDelCount(), Optional.of(1).get());
    }