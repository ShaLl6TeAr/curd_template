package com.hym.devtool.generator;

import com.hym.devtool.util.Utils;
import freemarker.cache.ClassTemplateLoader;
import freemarker.cache.NullCacheStorage;
import freemarker.template.Configuration;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import freemarker.template.TemplateExceptionHandler;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.sql.*;
import java.util.*;

public class RpcGen {

    private static final String DISK_PATH = GenProperties.getDiskPath();
    private static final String SERVICE_PATH = GenProperties.getServicePath();
    private static final String DAO_PATH = GenProperties.getDaoPath();
    private static final String MAPPER_PATH = GenProperties.getMapperPath();
    private static final String MODEL_PATH = GenProperties.getModelPath();
    private static final String TEST_PATH = GenProperties.getTestPath();
    private static final String PACKAGE_PREFIX = GenProperties.getPackagePrefix();
    private static final String API_RESULT = GenProperties.getApiResultPath();
    private static final String PAGE_LIST = GenProperties.getPageListPath();
    private static final String TEST_UTIL = GenProperties.getTestUtilPath();
    private static final String MAIN_CLASS = GenProperties.getMainClass();
    private static final String SPRING_ACTIVE = GenProperties.getSpringPropertiesActive();

    private static final String URL = DBProperties.getUrl();
    private static final String USERNAME = DBProperties.getUsername();
    private static final String PASSWORD = DBProperties.getPassword();
    private static final String DRIVER = DBProperties.getDriver();

    private static final int GEN_TYPE_CONTROLLER = 1;
    private static final int GEN_TYPE_SERVICE = 2;
    private static final int GEN_TYPE_TEST = 3;
    private static final int GEN_TYPE_CURD_CONTROLLER = 4;
    private static final int GEN_TYPE_CURD_TEST = 5;
    private static final int GEN_TYPE_CURD_SERVICE = 6;
    private static final int GEN_TYPE_MODEL = 7;
    private static final int GEN_TYPE_MAPPER = 8;
    private static final int GEN_TYPE_DAO = 9;
    private static final int GEN_TYPE_VO = 10;
    private static final int GEN_TYPE_DTO = 11;
    private static final int GEN_TYPE_EXCEPTION = 12;
    private static final int GEN_TYPE_MODEL_DTO = 13;

    private static String packageName;
    private static String controllerName = "";
    private static String module = "";
    private static String model = "";
    private static String tableName = "";
    private static String tableAnnotation = "";

    private static final String LIST = "list";
    private static final String ADD = "add";
    private static final String BATCH_ADD = "batchAdd";
    private static final String UPDATE = "update";
    private static final String GET = "get";
    private static final String FIND = "find";
    private static final String DEL = "del";
    private static final String EXIT = "exit";
    private static final String RPC = "rpc";
    private static final String CURD = "curd";
    private static final String SERVICE = "service";
    private static final String CREATE_MODEL = "createModel";
    private static final String UPDATE_MODEL = "updateModel";
    private static final String MODULE_C = "-m";
    private static final String CONTROLLER_C = "-c";

    private static final String HELP = " -m: 跳转module输入; " +
            "model + 名称：生成model, dao, mapper, controller, service, test, curd基本接口" +
            "curd + 名称: 生成list, add, update, get; " +
            "service + 名称: 生成service; " +
            "dao + 名称: 生成dao; " +
            "rpc + 名称: 生成controller接口; " +
            "exit: 退出;";

    private static boolean genModel = false;

    private static List<DBColumn> columnList;

    public static void genRpc() throws Exception {

        Scanner sc = new Scanner(System.in);

        System.out.println("请输入module: ");
        String module = sc.nextLine();
        controllerName = module;

        if (EXIT.equals(module)) {
            System.out.println("退出");
            return;
        }

        while (true) {
            System.out.println("请输入命令: ");
            String s = sc.nextLine();
            if (EXIT.equals(s)) {
                System.out.println("退出");
                break;
            }
            if (MODULE_C.equals(s)) {
                System.out.println("请输入module: ");
                module = sc.nextLine();
                controllerName = module;
                continue;
            }
            if (CONTROLLER_C.equals(s)) {
                System.out.println("请输入controller: ");
                controllerName = sc.nextLine();
                continue;
            }
            RpcGen.module = module;
            packageName = PACKAGE_PREFIX + module;

            String[] commands = s.split(" ");

            if (commands.length == 0) {
                continue;
            }
            String type = commands[0];

            for (int i = 1; i < commands.length; i++) {
                if (Utils.isEqual(type, CURD)) {
                    genCurd(commands[i]);
                } else if (Utils.isEqual(type, SERVICE)) {
                    genService(commands[i]);
                } else if (Utils.isEqual(type, CREATE_MODEL)) {
                    genCreateModel(commands[i]);
                } else if (Utils.isEqual(type, UPDATE_MODEL)) {
                    genUpdateModel(commands[i]);
                }else if (Utils.isEqual(type, RPC)) {
                    String name = commands[i];
                    genRpc(name);
                } else {
                    System.out.println("命令错误，请输入命令");
                    System.out.println("帮助：" + HELP);
                    break;
                }
            }
        }
    }

    private static void genUpdateModel(String name) throws Exception {
        tableName = name;
        name = camelCase2SnakeCase(name);
        model = name;
        genModel = true;
        columnList = getDBColumn();
//        GenConf createModel = new GenConf(name, ".java", "CreateModel.ftl", null, "entity", GEN_TYPE_MODEL);
//        create(createModel);
        GenConf createBaseModel = new GenConf(name, "Base.java", "CreateModelBase.ftl", null, "entity", GEN_TYPE_MODEL);
        createBaseModel.setNew(true);
        create(createBaseModel);
//        GenConf dao = new GenConf(name, "DAO.java", "CreateModelDAO.ftl", null, "dao", GEN_TYPE_DAO);
//        create(dao);
        GenConf baseMapper = new GenConf(name, "BaseMapper.xml", "CreateBaseMapperXml.ftl", null, "mappers", GEN_TYPE_MAPPER);
        baseMapper.setNew(true);
        create(baseMapper);
        GenConf baseDao = new GenConf(name, "BaseDAO.java", "CreateModelBaseDAO.ftl", null, "dao", GEN_TYPE_DAO);
        baseDao.setNew(true);
        create(baseDao);
        genModel = false;
        model = null;
    }

    private static void genCreateModel(String name) throws Exception {
        tableName = name;
        name = camelCase2SnakeCase(name);
        model = name;
        genModel = true;
        columnList = getDBColumn();
        GenConf createModel = new GenConf(name, ".java", "CreateModel.ftl", null, "entity", GEN_TYPE_MODEL);
        create(createModel);
        GenConf createBaseModel = new GenConf(name, "Base.java", "CreateModelBase.ftl", null, "entity", GEN_TYPE_MODEL);
        create(createBaseModel);
        GenConf dao = new GenConf(name, "DAO.java", "CreateModelDAO.ftl", null, "dao", GEN_TYPE_DAO);
        create(dao);
        GenConf baseDao = new GenConf(name, "BaseDAO.java", "CreateModelBaseDAO.ftl", null, "dao", GEN_TYPE_DAO);
        create(baseDao);
        GenConf mapper = new GenConf(name, "Mapper.xml", "CreateMapperXml.ftl", null, "mappers", GEN_TYPE_MAPPER);
        create(mapper);
        GenConf baseMapper = new GenConf(name, "BaseMapper.xml", "CreateBaseMapperXml.ftl", null, "mappers", GEN_TYPE_MAPPER);
        create(baseMapper);
        genCurd(name);
        genModel = false;
        GenConf createModelDTO = new GenConf(name, "DTO.java", "CreateModelDTO.ftl", null, "dto", GEN_TYPE_MODEL_DTO);
        create(createModelDTO);
        model = null;
    }

    private static void genCurd(String name) throws Exception {
        name = camelCase2SnakeCase(name);
        model = name;
        String uName = upCaseFirstChar(name);
        generateRpcDTO("add" + uName);
        generateRpcDTO("batchAdd" + uName);
        generateRpcDTO("get" + uName);
        generateRpcDTO("find" + uName);
        generateRpcDTO("update" + uName);
        generateRpcDTO("del" + uName);
        generateRpcDTO("list" + uName);
        generateRpcVO("add" + uName);
        generateRpcVO("batchAdd" + uName);
        generateRpcVO("get" + uName);
        generateRpcVO("find" + uName);
        generateRpcVO("update" + uName);
        generateRpcVO("del" + uName);
        generateRpcVO("list" + uName);
        GenConf controller = new GenConf(name, "Controller.java", "CreateController.ftl", "AddCurdController.ftl", "controller", GEN_TYPE_CONTROLLER);
        createAndAdd(controller);
        GenConf service = new GenConf(name,"Service.java", "CreateService.ftl", "AddCurdService.ftl", "service", GEN_TYPE_SERVICE);
        createAndAdd(service);
        GenConf test = new GenConf(name, "Test.java", "CreateTest.ftl", "AddCurdTest.ftl", "test", GEN_TYPE_TEST);
        createAndAdd(test);
        GenConf exception = new GenConf(name, "NotFoundException.java", "CreateNotFoundException.ftl", null, "exception", GEN_TYPE_EXCEPTION);
        create(exception);
    }

    private static void genRpc(String name) throws Exception {
        generateRpc(name);
        generateRpcDTO(name);
        generateRpcVO(name);
        genService(name);
        genTest(name);
    }

    private static void genTest(String name) throws Exception {
        generateTest(name);
    }

    private static void genService(String name) throws Exception {
        generateService(name);
    }

    private static void generateTest(String name) throws Exception {
        GenConf test = new GenConf(name, "Test.java", "CreateTest.ftl",
                "AddTest.ftl", "test", GEN_TYPE_TEST);
        createAndAdd(test);
    }

    private static void generateRpc(String name) throws Exception {
        GenConf controller = new GenConf(name, "Controller.java",
                "CreateController.ftl",
                "AddController.ftl",
                "controller", GEN_TYPE_CONTROLLER);
        createAndAdd(controller);
    }

    private static void generateListRpc(String name) throws Exception {
        GenConf listController = new GenConf(name, "Controller.java", "CreateController.ftl",
                "AddListController.ftl", "controller", GEN_TYPE_CONTROLLER);
        createAndAdd(listController);
    }

    private static void generateRpcDTO(String name) throws Exception {
        GenConf dto = new GenConf(name, "DTO.java", "CreateDTO.ftl", null, "dto", GEN_TYPE_DTO);
        create(dto);
    }

    private static void generateListRpcDTO(String name) throws Exception {
        GenConf dto = new GenConf(name, "DTO.java", "CreateListDTO.ftl", null, "dto", GEN_TYPE_DTO);
        create(dto);
    }

    private static void generateRpcVO(String name) throws Exception {
        GenConf vo = new GenConf(name, "VO.java", "CreateVO.ftl", null, "vo", GEN_TYPE_VO);
        create(vo);
    }

    private static void generateService(String name) throws Exception {
        GenConf service = new GenConf(name,"Service.java", "CreateService.ftl", "AddService.ftl", "service", GEN_TYPE_SERVICE);
        createAndAdd(service);
    }

    private static boolean gen(String name, String path, String templateName, boolean isNew) throws IOException, TemplateException {
        File file = new File(path);
        if (!file.exists()) {
            if (!file.createNewFile()) {
                throw new RuntimeException(path + " mkdir error");
            }
        } else {
            if (isNew) {
                if (!file.delete()) {
                    throw new RuntimeException("file delete error, file: " + path);
                }
                if (!file.createNewFile()) {
                    throw new RuntimeException(path + " mkdir error");
                }
            } else {
                return false;
            }
        }
        try (FileOutputStream fos = new FileOutputStream(file)) {
            freeMarkerProcess(name, templateName, fos);
        }
        return true;
    }

    private static void create(GenConf genConf) throws TemplateException, IOException {
        final String suffix = genConf.getSuffix();
        final String templateName = genConf.getCreateTemplateName();
        final String name = genConf.getName();
        final int genType = genConf.getGenType();
        String filePath;
        switch (genType) {
            case GEN_TYPE_CONTROLLER:
            case GEN_TYPE_CURD_CONTROLLER:
                filePath = checkPath(DISK_PATH + module + "/", controllerName + suffix);
                break;
            case GEN_TYPE_SERVICE:
            case GEN_TYPE_CURD_SERVICE:
                filePath = checkPath(SERVICE_PATH + module + "/service/", module + suffix);
                break;
            case GEN_TYPE_TEST:
            case GEN_TYPE_CURD_TEST:
                filePath = checkPath(TEST_PATH + module + "/", module + suffix);
                break;
            case GEN_TYPE_MODEL:
                filePath = checkPath(MODEL_PATH + module + "/entity/", model + suffix);
                break;
            case GEN_TYPE_MAPPER:
                filePath = checkPath(MAPPER_PATH + "mappers/", model + suffix);
                break;
            case GEN_TYPE_DAO:
                filePath = checkPath(DAO_PATH + module + "/dao/", model + suffix);
                break;
            case GEN_TYPE_VO:
                filePath = checkPath(DISK_PATH + module + "/vo/", name + suffix);
                break;
            case GEN_TYPE_DTO:
                filePath = checkPath(DISK_PATH + module + "/dto/", name + suffix);
                break;
            case GEN_TYPE_EXCEPTION:
                filePath = checkPath(MODEL_PATH + module + "/exception/", name + suffix);
                break;
            case GEN_TYPE_MODEL_DTO:
                filePath = checkPath(MODEL_PATH + module + "/dto/", name + suffix);
                break;
            default:
                throw new RuntimeException("gen type error");
        }
        genConf.setFilePath(filePath);
        if (!gen(name, filePath, templateName, genConf.isNew())) {
            System.out.println(genConf.getType() + " file exists, path : " + filePath);
        }
        System.out.println("gen " + genConf.getName() + " " + genConf.getType());
    }

    private static void createAndAdd(GenConf genConf) throws TemplateException, IOException {
        create(genConf);
        String name = genConf.getName();
        String add = getAddString(genConf.getName(), genConf.getAddTemplateName());
        File rpcFile = new File(genConf.getFilePath());
        try (BufferedReader reader = new BufferedReader(new FileReader(rpcFile))) {
            String tempStr;
            int count = 0;
            StringBuilder old = new StringBuilder();
            while ((tempStr = reader.readLine()) != null) {
                if (Utils.isEqual("}", tempStr)) {
                    break;
                } else {
                    old.append(tempStr).append("\r\n");
//                    System.out.println(tempStr);
                }
                count++;
            }
            reader.close();
            if (count > 0) {
                try (BufferedWriter writer = new BufferedWriter(new FileWriter(rpcFile))) {
//                    System.out.println(old);
                    writer.write(old.toString());
//                    System.out.println(add);
                    writer.append(add);
                    writer.write("\r\n}");
                    writer.flush();
//                    System.out.println("}");
                }
            } else {
                throw new RuntimeException(name + " gen nothing");
            }
            System.out.println("add " + genConf.getType() + ": " + genConf.getName());
        }
    }

    private static String getAddString(String name, String templateName) throws IOException, TemplateException {
        try (ByteArrayOutputStream bos = new ByteArrayOutputStream()) {
            freeMarkerProcess(name, templateName, bos);
            String add = bos.toString();
//            System.out.println(add);
            return add;
        }
    }

    private static void freeMarkerProcess(String name, String templateName, OutputStream fos) throws IOException, TemplateException {
        Map<String, Object> dataMap = new HashMap<>();
        Template template = getTemplate(templateName);
        String type = "";
        if (name.contains(ADD)) {
            type = ADD;
        } else if (name.contains(BATCH_ADD)) {
            type = BATCH_ADD;
        } else if (name.contains(UPDATE)) {
            type = UPDATE;
        } else if (name.contains(GET)) {
            type = GET;
        } else if (name.contains(FIND)) {
            type = FIND;
        }else if (name.contains(LIST)) {
            type = LIST;
        } else if (name.contains(DEL)) {
            type = DEL;
        }
        if (genModel) {
            dataMap.put("columnList", columnList);
        }

        dataMap.put("name", name);
        dataMap.put("Name", upCaseFirstChar(name));
        dataMap.put("packageName", packageName);
        dataMap.put("module", RpcGen.module);
        dataMap.put("Module", upCaseFirstChar(RpcGen.module));
        if (Utils.isNotNull(model)) {
            dataMap.put("model", model);
            dataMap.put("Model", upCaseFirstChar(model));
        }
        dataMap.put("type", type);
        if (Utils.isNotNull(type)) {
            dataMap.put("Type", upCaseFirstChar(type));
        }
        dataMap.put("controllerName", controllerName);
        dataMap.put("ControllerName", upCaseFirstChar(controllerName));
        dataMap.put("MainClass", MAIN_CLASS);
        dataMap.put("springActive", SPRING_ACTIVE);
        dataMap.put("tableName", tableName);

        dataMap.put("ApiResult", API_RESULT);
        dataMap.put("PageList", PAGE_LIST);
        dataMap.put("TestUtil", TEST_UTIL);

        dataMap.put("servicePath", setPath(SERVICE_PATH));
        dataMap.put("daoPath", setPath(DAO_PATH));
        dataMap.put("modelPath", setPath(MODEL_PATH));
        dataMap.put("testPath", setPath(TEST_PATH));

        template.process(dataMap, new BufferedWriter(new OutputStreamWriter(fos, StandardCharsets.UTF_8), 10240));
    }

    private static String setPath(String path) {
        return path.replace("../ecomonitor-dao/", "")
                .replace("../ecomonitor/", "")
                .replace("/", ".")
                .replace("src.test.java.", "")
                .replace("src.main.java.", "");
    }

    private static List<DBColumn> getDBColumn() throws SQLException, ClassNotFoundException {
        Class.forName(DRIVER);
        Connection connection = DriverManager.getConnection(URL, USERNAME, PASSWORD);
        DatabaseMetaData databaseMetaData = connection.getMetaData();
//        ResultSet tables = databaseMetaData.getTables(null, "%", tableName, null);
        ResultSet resultSet = databaseMetaData.getColumns(null, "%", tableName, "%");
        connection.close();
        List<DBColumn> columnList = new ArrayList<>();
        Set<String> columnSet = new HashSet<>();
        while (resultSet.next()) {
            DBColumn column = new DBColumn();
//            if (resultSet.getString("COLUMN_NAME").equals("id")) continue;
            column.setName(resultSet.getString("COLUMN_NAME"));
            column.setType(resultSet.getString("TYPE_NAME"));
            column.setComment(resultSet.getString("REMARKS"));
            column.setField(camelCase2SnakeCase(resultSet.getString("COLUMN_NAME")));
            if (!columnSet.contains(column.getName())) {
                columnList.add(column);
                columnSet.add(column.getName());
            }
        }
        return columnList;
    }

    private static String checkPath(String path, String suffix) {
        File file = new File(path);
        if (!file.exists()) {
            if (!file.mkdirs()) {
                throw new RuntimeException(path + " crate error");
            }
        }
        String name = upCaseFirstChar(suffix);
        return path + name;
    }

    private static String upCaseFirstChar(String name) {
        char[] uName = name.toCharArray();
        uName[0] = Utils.charUppercase(uName[0]);
        return String.valueOf(uName);
    }

    private static String camelCase2SnakeCase(String name) {
        char[] uName = name.toCharArray();
        for (int i = 0; i < uName.length; i++) {
            if (uName[i] == '_' && i + 1 < uName.length) {
                uName[i+1] = Utils.charUppercase(uName[i+1]);
            }
        }
        return String.valueOf(uName).replace("_", "");
    }

    private static final Configuration CONFIGURATION = new Configuration(Configuration.VERSION_2_3_22);

    static{
        //这里比较重要，用来指定加载模板所在的路径
        CONFIGURATION.setTemplateLoader(new ClassTemplateLoader(RpcGen.class, "/templates"));
        CONFIGURATION.setDefaultEncoding("UTF-8");
        CONFIGURATION.setTemplateExceptionHandler(TemplateExceptionHandler.RETHROW_HANDLER);
        CONFIGURATION.setCacheStorage(NullCacheStorage.INSTANCE);
    }

    private static Template getTemplate(String templateName) throws IOException {
        return CONFIGURATION.getTemplate(templateName);
    }

//    private static void clearCache() {
//        CONFIGURATION.clearTemplateCache();
//    }

}
