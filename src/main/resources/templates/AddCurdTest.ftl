
    @Test
    public void test${Model}() {
        testAdd${Model}();
        testBatchAdd${Model}();
        testList${Model}();
        testGet${Model}();
        testUpdate${Model}();
        testDel${Model}();
    }

    private String new${Model}Id;

    @Test
    public void testAdd${Model}() {
        Add${Model}DTO dto = TestUtil.randomInit(Add${Model}DTO.class);
        TestUtil.showJSON(dto);
        ApiResult${"\l"}Add${Model}VO${"\g"} result = ${controllerName}Controller.add${Model}(dto);
        new${Model}Id = result.getResult().getId();
        TestUtil.showJSON(result);
        assertEquals(result.getResult().getAddCount(), Optional.of(1).get());
    }

    @Test
    public void testBatchAdd${Model}() {
        int addCount = 3;
        List${"\l"}Add${Model}DTO${"\g"} ${model}List = new ArrayList<>();
        for (int i = 0; i < addCount; i++) {
            ${model}List.add(TestUtil.randomInit(Add${Model}DTO.class));
        }
        BatchAdd${Model}DTO dto = new BatchAdd${Model}DTO();
        dto.set${Model}List(${model}List);
        TestUtil.showJSON(dto.init${Model}List());
        ApiResult${"\l"}BatchAdd${Model}VO${"\g"} result = ${controllerName}Controller.batchAdd${Model}(dto);
        TestUtil.showJSON(result);
        assertEquals(result.getResult().getAddCount(), Optional.of(addCount).get());
    }

    @Test
    public void testList${Model}() {
        List${Model}DTO dto = new List${Model}DTO();
        TestUtil.showJSON(dto);
        ApiResult${"\l"}PageList.PageData${"\l"}List${Model}VO${"\g"}${"\g"} result = ${controllerName}Controller.list${Model}(dto);
        TestUtil.showJSON(result);
    }

    @Test
    public void testGet${Model}() {
        Get${Model}DTO dto = new Get${Model}DTO();
        dto.set${Model}Id(new${Model}Id);
        TestUtil.showJSON(dto);
        ApiResult${"\l"}Get${Model}VO${"\g"} result = ${controllerName}Controller.get${Model}(dto);
        TestUtil.showJSON(result);
    }

    @Test
    public void testUpdate${Model}() {
        Update${Model}DTO dto = TestUtil.randomInit(Update${Model}DTO.class);
        dto.setId(new${Model}Id);
        TestUtil.showJSON(dto);
        ApiResult${"\l"}Update${Model}VO${"\g"} result = ${controllerName}Controller.update${Model}(dto);
        TestUtil.showJSON(result);
        assertEquals(result.getResult().getUpdateCount(), Optional.of(1).get());
    }

    @Test
    public void testDel${Model}() {
        Del${Model}DTO dto = new Del${Model}DTO();
        dto.set${Model}Id(new${Model}Id);
        TestUtil.showJSON(dto);
        ApiResult${"\l"}Del${Model}VO${"\g"} result = ${controllerName}Controller.del${Model}(dto);
        TestUtil.showJSON(result);
        assertEquals(result.getResult().getDelCount(), Optional.of(1).get());
    }