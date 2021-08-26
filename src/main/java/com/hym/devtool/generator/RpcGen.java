package com.hym.devtool.generator;

import com.hym.devtool.util.Utils;
import freemarker.template.Template;
import freemarker.template.TemplateException;
import org.springframework.stereotype.Component;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;

public class RpcGen {

    private static final String diskPath = GenConfig.getDiskPath();
    private static final String packagePrefix = GenConfig.getPackagePrefix();
    private static final String apiResult = GenConfig.getApiResultPath();
    private static final String pageList = GenConfig.getPageListPath();
    private static String packageName;

    private static String module = "";

    public static void genRpc() throws Exception {

        Scanner sc = new Scanner(System.in);

        while (true) {
            System.out.println("请输入module: ");
            String module = sc.next();
            if ("exit".equals(module)) {
                System.out.println("退出");
                break;
            }
            System.out.println("请输入接口名: ");
            String rpc = sc.next();
            if ("exit".equals(rpc)) {
                System.out.println("退出");
                break;
            }
//            String rpc = "find";
//        rpc = System.getProperty("rpc");
//            String module = "gtfs";
//        module = System.getProperty("module");
            RpcGen.module = module;
            packageName = packagePrefix + module;
//        String method = System.getProperty("method");
            if (rpc.contains("list")) {
                genList(rpc);
            } else {
                genRpc(rpc);
            }
        }
    }

    public static void genList(String rpc) throws Exception {
        generateListRpc(rpc);
        generateListRpcDTO(rpc);
        generateRpcVO(rpc);
    }

    private static void genRpc(String rpc) throws Exception {
        generateRpc(rpc);
        generateRpcDTO(rpc);
        generateRpcVO(rpc);
    }

    private static void generateRpc(String rpc) throws Exception {
        System.out.println("gen controller");
        final String suffix = "Controller.java";
        final String templateName = "RpcController.ftl";
        String filePath = checkFile("");
        String moduleName = upcaseFirstChar(module);
        filePath = filePath + moduleName + suffix;
        if (!gen(rpc, filePath, templateName)) {
            String add = add(rpc);
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
                        writer.write("}");
                    }
                } else {
                    throw new RuntimeException("rpc gen nothing");
                }
            }
        }
    }

    private static void generateListRpc(String rpc) throws Exception {
        System.out.println("gen list controller");
        final String suffix = "Controller.java";
        final String templateName = "ListRpcController.ftl";
        String filePath = checkFile("");
        String moduleName = upcaseFirstChar(module);
        filePath = filePath + moduleName + suffix;
        if (!gen(rpc, filePath, templateName)) {
            String add = add(rpc);
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
                        writer.write("}");
                    }
                } else {
                    throw new RuntimeException("rpc gen nothing");
                }
            }
        }
    }

    private static void generateRpcDTO(String rpc) throws Exception {
        System.out.println("gen dto");
        final String suffix = "DTO.java";
        final String templateName = "RpcDTO.ftl";
        String filePath = checkFile("dto");
        filePath = getPath(filePath, rpc + suffix);
        if (!gen(rpc, filePath, templateName)) {
            System.out.println("dto file exists, path : " + filePath);
        }
    }

    private static void generateListRpcDTO(String rpc) throws Exception {
        System.out.println("gen list dto");
        final String suffix = "DTO.java";
        final String templateName = "ListRpcDTO.ftl";
        String filePath = checkFile("dto");
        filePath = getPath(filePath, rpc + suffix);
        if (!gen(rpc, filePath, templateName)) {
            System.out.println("dto file exists, path : " + filePath);
        }
    }


    private static void generateRpcVO(String rpc) throws Exception {
        System.out.println("gen vo");
        final String suffix = "VO.java";
        final String templateName = "RpcVO.ftl";
        String filePath = checkFile( "vo");
        filePath = getPath(filePath, rpc + suffix);
        if (!gen(rpc, filePath, templateName)) {
            System.out.println("vo file exists, path : " + filePath);
        }
    }

    private static boolean gen(String rpc, String path, String templateName) throws IOException, TemplateException {
        File mapperFile = new File(path);
        if (!mapperFile.exists()) {
            if (!mapperFile.createNewFile()) {
                throw new RuntimeException(path + " mkdir error");
            }
        } else {
            return false;
        }
        try (FileOutputStream fos = new FileOutputStream(mapperFile)) {
            freeMarkerProcess(rpc, templateName, fos);
        }
        return true;
    }

    private static String add(String rpc) throws TemplateException, IOException {
        try (ByteArrayOutputStream bos = new ByteArrayOutputStream()) {
            freeMarkerProcess(rpc, "AddRpc.ftl", bos);
            String add = bos.toString();
            System.out.println(add);
            return add;
        }
    }

    private static void freeMarkerProcess(String rpc, String templateName, OutputStream fos) throws IOException, TemplateException {
        String rpcName = upcaseFirstChar(rpc);
        Map<String, String> dataMap = new HashMap<>();
        Template template = FreeMarkerTemplateUtils.getTemplate(templateName);
        dataMap.put("rpc", rpc);
        dataMap.put("Rpc", rpcName);
        dataMap.put("packageName", packageName);
        dataMap.put("module", RpcGen.module);
        dataMap.put("Module", upcaseFirstChar(RpcGen.module));
        dataMap.put("ApiResult", apiResult);
        dataMap.put("PageList", pageList);
        template.process(dataMap, new BufferedWriter(new OutputStreamWriter(fos, StandardCharsets.UTF_8), 10240));
    }

    private static String checkFile(String type) {
        if (Utils.isNull(type)) {
            type = "";
        } else {
            type = type + "/";
        }
        final String path = diskPath + module + "/" + type;
        File moduleFile = new File(path);
        if (!moduleFile.exists()) {
            moduleFile.mkdirs();
        }
        return path;
    }

    private static String getPath(String path, String suffix) {
        String rpcName = upcaseFirstChar(suffix);
        return path + rpcName;
    }

    private static String upcaseFirstChar(String name) {
        char[] uRpc = name.toCharArray();
        uRpc[0] = Utils.charUppercase(uRpc[0]);
        return String.valueOf(uRpc);
    }

}
