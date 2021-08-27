package com.hym.devtool;

import com.hym.devtool.generator.RpcGen;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class DevtoolApplication {

    private static final String METHOD = "method";
    private static final String GEN_RPC = "genRpc";

    public static void main(String[] args) throws Exception {
        SpringApplication.run(DevtoolApplication.class, args);

        String method = System.getProperty(METHOD);

        switch (method) {
            case GEN_RPC:
                RpcGen.genRpc();
                break;
            default:
                System.out.println("can not find any method: " + method);
        }
    }

}
