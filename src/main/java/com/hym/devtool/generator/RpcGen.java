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

    private static final int ADD_TYPE_CONTROLLER = 1;
    private static final int ADD_TYPE_SERVICE = 2;

    private static final int GEN_TYPE_CONTROLLER = 1;
    private static final int GEN_TYPE_SERVICE = 2;

    private static String packageName;

    private static String module = "";

    private static final String LIST = "list";
    private static final String ADD = "add";
    private static final String UPDATE = "update";
    private static final String GET = "get";
    private static final String DEL = "del";
    private static final String EXIT = "exit";
    private static final String RPC = "rpc";
    private static final String GEN_ALL = "genall";
    private static final String SERVICE = "service";
    private static final String DAO = "dao";
    private static final String MODULE = "-m";

    private static final String HELP = " -m: 跳转module输入; " +
            "genall + 名称: 生成list, add, update, get; " +
            "service + 名称: 生成service; " +
            "dao + 名称: 生成dao; " +
            "rpc + 名称: 生成controller接口; " +
            "exit: 退出;";


    public static void genRpc() throws Exception {

        Scanner sc = new Scanner(System.in);

        System.out.println("请输入module: ");
        String module = sc.nextLine();

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
            if (MODULE.equals(s)) {
                System.out.println("请输入module: ");
                module = sc.next();
                continue;
            }
            RpcGen.module = module;
            packageName = PACKAGE_PREFIX + module;

            String[] commands = s.split(" ");

            if (commands.length == 0) {
                System.out.println("命令错误，请输入命令");
                System.out.println("帮助：" + HELP);
                continue;
            }
            String type = commands[0];

            for (int i = 1; i < commands.length; i++) {
                if (Utils.isEqual(type, GEN_ALL)) {
                    genAll(commands[i]);
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

    public static void genAll(String name) throws Exception {
        genListRpc(LIST + name);
        genRpc(ADD + name);
        genRpc(GET + name);
        genRpc(UPDATE + name);
    }

    public static void genListRpc(String name) throws Exception {
        generateListRpc(name);
        generateListRpcDTO(name);
        generateRpcVO(name);
        genService(name);
    }

    private static void genRpc(String name) throws Exception {
        generateRpc(name);
        generateRpcDTO(name);
        generateRpcVO(name);
        genService(name);
    }

    private static void genService(String name) throws Exception {
        generateService(name);
    }

    private static void generateRpc(String name) throws Exception {
        Fun listController = new Fun("Controller.java", "RpcController.ftl", "controller");
        createOrAdd(listController, name, GEN_TYPE_CONTROLLER);
    }

    private static void generateListRpc(String name) throws Exception {
        Fun listController = new Fun("Controller.java", "ListRpcController.ftl", "controller");
        createOrAdd(listController, name, GEN_TYPE_CONTROLLER);
    }

    private static void generateRpcDTO(String name) throws Exception {
        Fun dto = new Fun("DTO.java", "RpcDTO.ftl", "dto");
        create(dto, name);
    }

    private static void generateListRpcDTO(String name) throws Exception {
        Fun dto = new Fun("DTO.java", "ListRpcDTO.ftl", "dto");
        create(dto, name);
    }

    private static void generateRpcVO(String name) throws Exception {
        Fun vo = new Fun("VO.java", "RpcVO.ftl", "vo");
        create(vo, name);
    }

    private static void generateService(String name) throws Exception {
        Fun service = new Fun("Service.java", "Service.ftl", "service");
        createOrAdd(service, name, GEN_TYPE_SERVICE);
    }

    private static void generateServiceInterface(String name) throws Exception {
        Fun service = new Fun("Service.java", "ServiceInterface.ftl", "service");
        createOrAdd(service, name, GEN_TYPE_SERVICE);
        Fun impl = new Fun("ServiceImpl.java", "ServiceImpl.ftl", "service");
        createOrAdd(impl, name, GEN_TYPE_SERVICE);
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

    private static void create(Fun fun, String name) throws TemplateException, IOException {
        System.out.println("gen " + fun.getType());
        final String suffix = fun.getSuffix();
        final String templateName = fun.getTemplateName();
        String filePath = checkFile(fun.getType());
        filePath = getPath(filePath, name + suffix);
        if (!gen(name, filePath, templateName)) {
            System.out.println(fun.getType() + " file exists, path : " + filePath);
        }
    }

    private static void createOrAdd(Fun fun, String name, int genType) throws TemplateException, IOException {
        System.out.println("gen " + fun.getType());
        final String suffix = fun.getSuffix();
        final String templateName = fun.getTemplateName();
        String filePath = checkFile( fun.getType());
        filePath = getPath(filePath, module + suffix);
        if (!gen(name, filePath, templateName)) {
            String add = "";
            switch (genType) {
                case GEN_TYPE_CONTROLLER:
                    add = addController(name);
                    break;
                case GEN_TYPE_SERVICE:
                    add = addService(name);
                    break;
                default:
                    throw new RuntimeException("gen type error");
            }
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
                        System.out.println(tempStr);
                    }
                    count++;
                }
                reader.close();
                if (count > 0) {
                    try (BufferedWriter writer = new BufferedWriter(new FileWriter(rpcFile))) {
                        System.out.println(add);
                        writer.write(String.valueOf(old));
                        writer.append(add);
                        writer.write("\r\n}");
                    }
                } else {
                    throw new RuntimeException(name + " gen nothing");
                }
            }
        }
    }

    private static String addController(String name) throws TemplateException, IOException {
        return getString(name, ADD_TYPE_CONTROLLER);
    }

    private static String addService(String name) throws TemplateException, IOException {
        return getString(name, ADD_TYPE_SERVICE);
    }

    private static String getString(String name, int addType) throws IOException, TemplateException {
        try (ByteArrayOutputStream bos = new ByteArrayOutputStream()) {
            switch (addType) {
                case ADD_TYPE_CONTROLLER:
                    if (name.contains(LIST)) {
                        freeMarkerProcess(name, "AddListRpc.ftl", bos);
                    } else {
                        freeMarkerProcess(name, "AddRpc.ftl", bos);
                    }
                    break;
                case ADD_TYPE_SERVICE:
                    freeMarkerProcess(name, "AddService.ftl", bos);
                    break;
                default:
                    throw new RuntimeException("add type error");
            }

            String add = bos.toString();
            System.out.println(add);
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
        dataMap.put("Name", upcaseFirstChar(name));
        dataMap.put("packageName", packageName);
        dataMap.put("module", RpcGen.module);
        dataMap.put("Module", upcaseFirstChar(RpcGen.module));
        dataMap.put("ApiResult", API_RESULT);
        dataMap.put("PageList", PAGE_LIST);
        dataMap.put("type", type);
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
            moduleFile.mkdirs();
        }
        return path;
    }

    private static String getPath(String path, String suffix) {
        String name = upcaseFirstChar(suffix);
        return path + name;
    }

    private static String upcaseFirstChar(String name) {
        char[] uRpc = name.toCharArray();
        uRpc[0] = Utils.charUppercase(uRpc[0]);
        return String.valueOf(uRpc);
    }

}
