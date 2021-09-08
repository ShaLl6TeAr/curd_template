package com.hym.devtool.generator;

import com.hym.devtool.util.Utils;
import freemarker.template.Template;
import freemarker.template.TemplateException;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;

public class RpcGen {

    private static final String DISK_PATH = GenConfig.getDiskPath();
    private static final String SERVICE_PATH = GenConfig.getServicePath();
    private static final String DAO_PATH = GenConfig.getDaoPath();
    private static final String PACKAGE_PREFIX = GenConfig.getPackagePrefix();
    private static final String API_RESULT = GenConfig.getApiResultPath();
    private static final String PAGE_LIST = GenConfig.getPageListPath();

    private static final int GEN_TYPE_CONTROLLER = 1;
    private static final int GEN_TYPE_SERVICE = 2;
    private static final int GEN_TYPE_TEST = 3;
    private static final int GEN_TYPE_CURD_CONTROLLER = 4;
    private static final int GEN_TYPE_CURD_TEST = 5;
    private static final int GEN_TYPE_CURD_SERVICE = 6;

    private static String packageName;
    private static String module = "";
    private static String controllerName = "";
    private static String model = "";

    private static final String LIST = "list";
    private static final String ADD = "add";
    private static final String UPDATE = "update";
    private static final String GET = "get";
    private static final String Find = "find";
    private static final String DEL = "del";
    private static final String EXIT = "exit";
    private static final String RPC = "rpc";
    private static final String CURD = "curd";
    private static final String SERVICE = "service";
    private static final String DAO = "dao";
    private static final String MODULE_C = "-m";
    private static final String CONTROLLER_C = "-c";

    private static final String HELP = " -m: 跳转module输入; " +
            "curd + 名称: 生成list, add, update, get; " +
            "service + 名称: 生成service; " +
            "dao + 名称: 生成dao; " +
            "rpc + 名称: 生成controller接口; " +
            "exit: 退出;";

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
                    curd(commands[i]);
                } else if (Utils.isEqual(type, SERVICE)) {
                    genService(commands[i]);
                } else if (Utils.isEqual(type, DAO)) {
//                genDAO(upcaseFirstChar(s.replace(DAO, "")));
                } else if (Utils.isEqual(type, RPC)) {
                    String name = commands[i];
                    if (name.contains(LIST)) {
                        genListRpc(name);
                    } else {
                        genRpc(name);
                    }
                } else {
                    System.out.println("命令错误，请输入命令");
                    System.out.println("帮助：" + HELP);
                    break;
                }
            }
        }
    }

    public static void curd(String name) throws Exception {
        model = name;
        String uName = upCaseFirstChar(name);
        generateRpcDTO("add" + uName);
        generateRpcDTO("get" + uName);
        generateRpcDTO("find" + uName);
        generateRpcDTO("update" + uName);
        generateRpcDTO("del" + uName);
        generateListRpcDTO("list" + uName);
        generateRpcVO("add" + uName);
        generateRpcVO("get" + uName);
        generateRpcVO("find" + uName);
        generateRpcVO("update" + uName);
        generateRpcVO("del" + uName);
        generateRpcVO("list" + uName);
        Fun controller = new Fun(name, "Controller.java", "RpcController.ftl", "AddCurdRpc.ftl", "controller", GEN_TYPE_CONTROLLER);
        createAndAdd(controller);
        Fun service = new Fun(name,"Service.java", "Service.ftl", "AddCurdService.ftl", "service", GEN_TYPE_SERVICE);
//        if (name.contains(GET) || name.contains(DEL) || name.contains(UPDATE)) {
//        createAndAdd(service);
        genService(name);
//        }
        Fun test = new Fun(name, "Test.java", "RpcTest.ftl", "AddCurdTest.ftl", "test", GEN_TYPE_TEST);
        createAndAdd(test);
    }

    public static void genListRpc(String name) throws Exception {
        generateListRpc(name);
        generateListRpcDTO(name);
        generateRpcVO(name);
        genService(name);
        genTest(name);
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
        Fun test = new Fun(name, "Test.java", "RpcTest.ftl",
                "AddRpcTest.ftl", "test", GEN_TYPE_TEST);
        createAndAdd(test);
    }

    private static void generateRpc(String name) throws Exception {
        Fun controller = new Fun(name, "Controller.java",
                "RpcController.ftl",
                "AddRpc.ftl",
                "controller", GEN_TYPE_CONTROLLER);
        createAndAdd(controller);
    }

    private static void generateListRpc(String name) throws Exception {
        Fun listController = new Fun(name, "Controller.java", "ListRpcController.ftl",
                "AddListRpc.ftl", "controller", GEN_TYPE_CONTROLLER);
        createAndAdd(listController);
    }

    private static void generateRpcDTO(String name) throws Exception {
        Fun dto = new Fun(name, "DTO.java", "RpcDTO.ftl", null, "dto", null);
        create(dto);
    }

    private static void generateListRpcDTO(String name) throws Exception {
        Fun dto = new Fun(name, "DTO.java", "ListRpcDTO.ftl", null, "dto", null);
        create(dto);
    }

    private static void generateRpcVO(String name) throws Exception {
        Fun vo = new Fun(name, "VO.java", "RpcVO.ftl", null, "vo", null);
        create(vo);
    }

    private static void generateService(String name) throws Exception {
        Fun service = new Fun(name,"Service.java", "Service.ftl", "AddService.ftl", "service", GEN_TYPE_SERVICE);
        createAndAdd(service);
    }

    private static boolean gen(String name, String path, String templateName) throws IOException, TemplateException {
        File mapperFile = new File(path);
        if (!mapperFile.exists()) {
            if (!mapperFile.createNewFile()) {
                throw new RuntimeException(path + " mkdir error");
            }
        } else {
            return false;
        }
        try (FileOutputStream fos = new FileOutputStream(mapperFile)) {
            freeMarkerProcess(name, templateName, fos);
        }
        return true;
    }

    private static void create(Fun fun) throws TemplateException, IOException {
        final String suffix = fun.getSuffix();
        final String templateName = fun.getCreateTemplateName();
        final String name = fun.getName();
        String filePath = checkFile(fun.getType());
        filePath = getPath(filePath, name + suffix);
        if (!gen(name, filePath, templateName)) {
            System.out.println(fun.getType() + " file exists, path : " + filePath);
        }
        System.out.println("gen " + fun.getName() + " " + fun.getType());
    }

    private static void createAndAdd(Fun fun) throws TemplateException, IOException {
        final String suffix = fun.getSuffix();
        final String name = fun.getName();
        final int genType = fun.getGenAddType();
        String filePath = checkFile( fun.getType());

        switch (genType) {
            case GEN_TYPE_CONTROLLER:
            case GEN_TYPE_CURD_CONTROLLER:
                filePath = getPath(filePath, controllerName + suffix);
                break;
            case GEN_TYPE_SERVICE:
            case GEN_TYPE_CURD_SERVICE:
            case GEN_TYPE_TEST:
            case GEN_TYPE_CURD_TEST:
                filePath = getPath(filePath, module + suffix);
                break;
            default:
                throw new RuntimeException("gen type error");
        }
        if (!gen(name, filePath, fun.getCreateTemplateName())) {
            System.out.println(filePath + " has created");
        }
        System.out.println("gen " + fun.getName() + " " + fun.getType());

        String add = getString(name, fun.getAddTemplateName());
        File rpcFile = new File(filePath);
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
//                    System.out.println("}");
                }
            } else {
                throw new RuntimeException(name + " gen nothing");
            }
            System.out.println("add " + fun.getType() + ": " + fun.getName());
        }
    }

    private static String getString(String name, String templateName) throws IOException, TemplateException {
        try (ByteArrayOutputStream bos = new ByteArrayOutputStream()) {
            freeMarkerProcess(name, templateName, bos);
            String add = bos.toString();
//            System.out.println(add);
            return add;
        }
    }

    private static void freeMarkerProcess(String name, String templateName, OutputStream fos) throws IOException, TemplateException {
        Map<String, String> dataMap = new HashMap<>();
        Template template = FreeMarkerTemplateUtils.getTemplate(templateName);
        String type = "";
        if (name.contains(ADD)) {
            type = ADD;
        } else if (name.contains(UPDATE)) {
            type = UPDATE;
        } else if (name.contains(GET)) {
            type = GET;
        } else if (name.contains(LIST)) {
            type = LIST;
        } else if (name.contains(DEL)) {
            type = DEL;
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
        dataMap.put("ApiResult", API_RESULT);
        dataMap.put("PageList", PAGE_LIST);
        dataMap.put("type", type);
        if (Utils.isNotNull(type)) {
            dataMap.put("Type", upCaseFirstChar(type));
        }
        dataMap.put("controllerName", controllerName);
        dataMap.put("ControllerName", upCaseFirstChar(controllerName));
        template.process(dataMap, new BufferedWriter(new OutputStreamWriter(fos, StandardCharsets.UTF_8), 10240));
    }

    private static String checkFile(String type) {
        if (Utils.isNull(type) || Utils.isEqual("controller", type)) {
            type = "";
        } else {
            type = type + "/";
        }
        final String path = DISK_PATH + module + "/" + type;
        File moduleFile = new File(path);
        if (!moduleFile.exists()) {
            if (!moduleFile.mkdirs()) {
                throw new RuntimeException(path + " create error ");
            }
        }
        return path;
    }

    private static String getPath(String path, String suffix) {
        String name = upCaseFirstChar(suffix);
        return path + name;
    }

    private static String upCaseFirstChar(String name) {
        char[] uName = name.toCharArray();
        uName[0] = Utils.charUppercase(uName[0]);
        return String.valueOf(uName);
    }

}
